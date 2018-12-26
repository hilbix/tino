# WTF SystemD

> This could go into Rants, hirnschiss, WTF or similar, as it is WTF Hirnschiss which deserves rants.
> But .. well stop this and get right into it.

## Control the power button with SystemD.

### Immediate Shutdown

[Stackexchange](https://unix.stackexchange.com/a/416569/23450) suggests:

    hostnamectl set-chassis vm
    
**But this does not work at all.**

There still is an unbearable long (30s) delay when shutting down KDE.
(If VMs are up 30s longer as needed can make a huge difference on bigger clouds.)

See also:
- https://www.vdr-portal.de/forum/index.php?thread/131788-ubuntu-18-04-kein-etc-acpi-powerbtn-sh-mehr/
- https://www.linuxquestions.org/questions/ubuntu-63/trying-to-make-ubuntu-18-04-shutdown-on-power-button-4175636022/#post5891544
- https://unix.stackexchange.com/a/416569/23450

Well, before SystemD on Kubuntu there was a file `/etc/acpi/powerbtn.sh`.
To change the power behavior, it was easy to just edit this small file.

For example `exec shutdown -h now` at the top of the file immediately shuts down the machine
when the power event was received by the VM.  Usually what you want.

> I think this already was far too inflexible and wrong implemented.
> Some power button framework was missing, which was able to override the power button,
> without editing some system file.  But .. well .. a extremely bad design got even worse with SystemD!

With SystemD everything is different.  Much different.  Unbearable different in this case:

- SystemD now handles the power button, not ACPI.
- And there is no documentation whatsoever on how power events are handlet by it.
- Also there is no trace whatsoever, that SystemD is not handling the power button at all.
- This control is handed over to Gnome/KDE/Whatever-runs-the-desktop with some (obscrure to me) method.

With SystemD `shutdown -h now` is called `systemctl poweroff` (which takes half a second to stop the VM, as expected).

But how to run this from the power button directly?  `systemd-logind` is configured to do so!  But it does not work.

(The culprit are inhibits which apparently cannot be overridden!)

### Other handling

I really have no idea.  `hostnamectl set-chassis vm` is some hack, hardcoded in the login area.
It perhaps works by sheer luck, but not for me.

https://unix.stackexchange.com/a/384335/23450 fails.  There is no more `apt-get install acpi-support-base` in Kubuntu 18.04,
so neither `/etc/acpi/powerbtn-acpi-support.sh` nor `/etc/acpi/handler.sh`.

https://unix.stackexchange.com/a/473626/23450 fails, too.  For unknown reason.  What I found is,
that `systemd-logind` still handles the event:

`Dec 26 03:55:14 testvm systemd-logind[420]: Power key pressed.`

SystemD suggests, to use `systemd-analyze cat-config`.  But there isn't:
```
# systemd-analyze cat-config systemd/logind.conf
Unknown operation cat-config.
```

But then I stumbled upon this:

```
# systemd-inhibit
     Who: NetworkManager (UID 0/root, PID 441/NetworkManager)
    What: sleep
     Why: NetworkManager needs to turn off networks
    Mode: delay

     Who: PowerDevil (UID 1000/test, PID 971/org_kde_powerde)
    What: handle-power-key:handle-suspend-key:handle-hibernate-key:handle-lid-switch
     Why: KDE handles power events
    Mode: block

     Who: UPower (UID 0/root, PID 860/upowerd)
    What: sleep
     Why: Pause device polling
    Mode: delay

     Who: ModemManager (UID 0/root, PID 394/ModemManager)
    What: sleep
     Why: ModemManager needs to reset devices
    Mode: delay

     Who: Unattended Upgrades Shutdown (UID 0/root, PID 493/unattended-upgr)
    What: shutdown
     Why: Stop ongoing upgrades or perform upgrades before shutdown
    Mode: delay

5 inhibitors listed.
```

WTF?  How can I inhibit such inhibitors?

(Besides: Most of the output above reads like Garbage, because it cannot be understood except you know the code
which produced this shit.  Only the "who" line seems sane, everything else is just insane horrible bullshit-bingo.)

At my side this was it:

```
vim /usr/share/dbus-1/system.d/org.freedesktop.login1.conf
```
and change
```
<allow send_destination="org.freedesktop.login1"
       send_interface="org.freedesktop.login1.Manager"
       send_member="Inhibit"/>
```
into
```
<deny send_destination="org.freedesktop.login1"
      send_interface="org.freedesktop.login1.Manager"
      send_member="Inhibit"/>
```

**Warning!** This is NOT the right thing to do.  However it works at my side:

```
# systemd-inhibit                                                                                                   
     Who: NetworkManager (UID 0/root, PID 451/NetworkManager)
    What: sleep
     Why: NetworkManager needs to turn off networks
    Mode: delay

     Who: Unattended Upgrades Shutdown (UID 0/root, PID 509/unattended-upgr)
    What: shutdown
     Why: Stop ongoing upgrades or perform upgrades before shutdown
    Mode: delay

     Who: UPower (UID 0/root, PID 865/upowerd)
    What: sleep
     Why: Pause device polling
    Mode: delay

     Who: ModemManager (UID 0/root, PID 395/ModemManager)
    What: sleep
     Why: ModemManager needs to reset devices
    Mode: delay

4 inhibitors listed.
```

> I really have no idea
