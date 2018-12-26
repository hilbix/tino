# WTF SystemD

> This could go into Rants, hirnschiss, WTF or similar, as it is WTF Hirnschiss which deserves rants.
> But .. well stop this and get right into it.

## Control the power button with SystemD.

### Immediate Shutdown

[Stackexchange](https://unix.stackexchange.com/a/416569/23450) suggests:

    hostnamectl set-chassis vm

See also:
- https://www.vdr-portal.de/forum/index.php?thread/131788-ubuntu-18-04-kein-etc-acpi-powerbtn-sh-mehr/
- https://www.linuxquestions.org/questions/ubuntu-63/trying-to-make-ubuntu-18-04-shutdown-on-power-button-4175636022/#post5891544
- https://unix.stackexchange.com/a/416569/23450

Well, before SystemD on Kubuntu there was a file `/etc/acpi/powerbtn.sh`.
To change the power behavior, it was easy to just edit this small file.

For example `exec shutdown -h now` at the top of the file immediately shut down the
when the power event was received by the VM.  Usually what you want.

> I think this already was far too inflexible and wrong implemented.
> Some power button framework was missing, which was able to override the power button,
> without editing some system file.  But .. well .. a extremely bad design got even worse with SystemD!

With SystemD everything is different.  Much different.  Unbearable different in this case:

- SystemD now handles the power button, not ACPI.
- And there is no documentation whatsoever on how power events are handlet by it.
- Also there is no trace whatsoever, that SystemD is not handling the power button at all.
- This control is handed over to Gnome/KDE/Whatever-runs-the-desktop with some (obscrure to me) method.

But thanks to [Stackexchange](https://unix.stackexchange.com/a/416569/23450) I found the bits above.

### Other handling

I really have no idea.  `hostnamectl set-chassis vm` is some hack, hardcoded in the login area.
It works just by sheer luck.  Thanks to SystemD handling all ACPI events now.

Perhaps a solution is found there: https://unix.stackexchange.com/a/384335/23450

`apt-get install acpi-support-base` and then edit either `/etc/acpi/powerbtn-acpi-support.sh` or `/etc/acpi/handler.sh`.

I just note it here just for the case I ever need it, because I stumbled upon it while tracing this down.

