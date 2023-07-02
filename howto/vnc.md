> You cannot access the Login Page this way!
>
> For this you either need some way to get past the login/chooser or root access.
> Both is not presented here.

Corona Home Office Welcome.

VNC is nice.  However it is a PITA if it needs to be set up or the connection breaks.

# Remmina to Windows via JumpHost

> As of today the best thing I found to enable communication between 2 machines which cannot connect to each other is to use `ssh` with tunnels and JumpHosts.
> But this is a very clumsy and insecure (MitM) way and a constant source of SPoF, so in future we should get rid of them and thereby even improve security.
> I am working on this, ..

Machine D: Local machine with your Mouse and Keyboard
- Machine D has no direct connection to Machine X but can `ssh` into Machine G
- This machine is a single user machine
- You have `root` access or some way to install all needed additional packages

Machine W: Windows 11
- Machine W has no direct connection to Machine D but can `ssh` into Machine G
- Install UltraVNC onto the machine
- Full admin rights to configure windows firewall
- `machine-w-debian` running Debian with WSL 2
  - With WSL1 it is simpler, as WSL1 and Windows share the same IP stack
  - You can use Ubuntu or anything else
- Why not windows native ssh?
  - I do not think Windows ssh is worthwhile
  - Under Win 10 port forwarding did not work as expected, I never tried with Win 11

> Usually you do not want WSL2 nor the host to be reachable from the outside.
>
> Hence Machine D cannot connect to Machine W nor the VM there.  For this we do it backwards:
> - WSL2 opens a connection to Machine G and there offers a tunnel back to it's `sshd`
>   - This is more secure than opening the `ssh` port itself.
> - Machine D then uses that tunnel on Machine G to connect to the `sshd` on WSL2
>   - This connection then is used to open a connection to the VNC server running on the host
>   - This is more secure than opening the VNC server port (or some other remote management) to the public

Machine G: Gateway between D and W
- This allows incoming `ssh` connections

Preparation: Check that you can access Machine G from Machine D:

    machine-d$ ssh machine-g
    machine-g$ 

Preparation: Check that you can access Machine G from Machine W from WSL:

    machine-w-debian$ ssh machine-g
    machine-g$ 

Preparation: Check the IP addresses:

    machine-w-debian$ ip r s
    default via 172.22.64.1 dev eth0 proto kernel 
    172.22.64.0/20 dev eth0 proto kernel scope link src 172.22.67.252 

    machine-w-debian$ ping machine-w
    PING machine-w (172.22.64.1) 56(84) bytes of data.
    ^C
    --- black ping statistics ---
    3 packets transmitted, 0 received, 100% packet loss, time 2077ms

- `172.22.64.1` is the host
- `172.22.64.0/20` is the WSL subnet used
  - The IP of the VM is `172.22.67.252`, but this is allowed to change
- `machine-w` sucessfully resolves to `172.22.64.1`
- It is normal that you cannot `ping` the host IP from WSL2.

> If you see different IPs, adapt accordingly.

## Basic required configuration

### Windows `machine-w`:

- Install and start UltraVNC
- Admin Properties:
  - VNC Password: `.`
  - uncheck: none portable password
  - uncheck: Enable JavaViewer
  - uncheck: LoopbackOnly
  - for safety: check: Authentication required for server initiated connections
  - select Advanced: When Last Client Disconnects: Do Nothing
  - select Advanced: Multi viewer connections: Disconnect all existing connections
  - check Advanced: Remove Wallpaper while connected
  - check Advanced: prevent screensaver
  - deselect Advanced: File Transfer: Enable
- Properties (usually need no change)
  - check: Poll Full Screen ( Ultra Fast )

Open `wf.msc` at "Eingehende Regeln" (sorry my Windows is German, so I do not know the english terms) create "Neue Regel...":

- Allgemein:
  - Name: uVNC
  - check: Aktiviert
  - select: Aktion: Verbindung zulassen
- Programme und Dienste: (unchanged)
- Remotecomputer: (unchanged)
- Remotebenutzer: (unchanged)
- Lokale Prinzipale: (unchanged)
- Erweitert: )probably unchanged)
  - check: Domäne
  - check: Privat
  - check: Öffentlich
- Protokolle und Ports:
  - Protokilltyp: TCP
  - Lokaler Port: Bestimmte Ports: 5900
  - Remote-Port: Alle Ports
- Bereich:
  - Select: Lokale IP-Adresse: Diese IP-Adressen
  - Select: Remote IP-Adresse: Diese IP-Adressen
  - Add: Lokale IP-Adresse: Diese IP-Adresse order dieses Subnetz: `172.22.64.1` (from `ip r s` above)
  - Add: Remote IP-Adresse: Diese IP-Adresse order dieses Subnetz: `172.22.64.0/20` (from `ip r s` above)

> I do not know if this is secure or not.  But I doubt.
> - We need above settings to be able to connect from WSL 2 to uVNC
>   - Chose a secure password of uVNC
>   - However a password alone is a weak protection
> - We should restrict uVNC to the WSL interface.  But we can only restrict this to IP addresses which is less secure.
> - Also I do not grok Windows Firewall as it has gazillions of other rules and I really have not the slightest idea how it applies this rules
>   - There might be something else which I do not know to open uVNC to the public.


## `ssh` settings

```
machine-w-debian$ cat ~/.ssh/config
Include ~/.ssh/config.d/*.conf

Host machine-g
	RemoteForward 127.0.0.1:2022 127.0.0.1:22
	ServerAliveInterval 30
	ServerAliveCountMax 5
```

```
machine-d$ cat ~/.ssh/config
Include ~/.ssh/config.d/*.conf

Host machine-g
	ServerAliveInterval 30
	ServerAliveCountMax 5

Host machine-w machine-w-debian
	ProxyCommand ssh machine-g -W 127.0.0.1:2022
```


### Tests

    machine-d$ ssh machine-w
    machine-w-debian$ 
    
    machine-w-debian$ ping machine-w
    PING machine-w (172.22.64.1) 56(84) bytes of data.
    ^C
    --- black ping statistics ---
    3 packets transmitted, 0 received, 100% packet loss, time 2077ms

    machine-d$ ssh machine-w-debian -W machine-w:5900
    RFB 003.008

    machine-d$ ssh machine-w -W machine-w:5900
    RFB 003.008

It is OK that you cannot `ping` the host `machine-w` from WSL 2 `machine-w-debian`.
The important part here is, that the IP address is resolved.

### Remmina

- Name: `machine-w`
- Protocol: Remmina VNC Plugin
- Basic:
  - Server: `machine-w`
  - User password: `.`
  - Quality: Best (slowest)
- SSH Tunnel:
  - Enable SSH tunnel
  - Same server at port 22
  - Authentication type: Public key (automatic)

## Automate WSL

When WSL 2 starts, it should start a local `ssh`.  This most simply can be archived with `cron`:

`/etc/wsl.conf`:
```
[boot]
command = /etc/init.d/cron start
```

```
machine-w-debian$ sudo crontab -e <<EOF
@reboot	/etc/init.d/ssh start
EOF
```

This way `sshd` automatically starts in background when you open a WSL 2 terminal.  (So you do not need SystemD or other complex things.)

## Automate the tunnel

**Important!** After WSL starts, you must run

    machine-w-debian$ ssh -o ExitOnForwardFailure=yes machine-g

to open the `ssh` tunnel connection which is used by `machine-d` via `machine-g`.

- Do this your favorite way on the machine
  - You can try with `cron` for this, but I never tested that, because [I have my own way to automate things like that](https://github.com/hilbix/ptybuffer/blob/master/script/autostart.sh)

Also I found no good way to start WSL 2 when you start Windows, sorry.

- Note that if it fails, it should be gracefully be restarted, too.
- This incapability (of me) to (properly) autostart things on machine start is my major obstacle to use Windows as a Server
  - Note that the main obstacle is that I have to enter some credentials.  Credentials (like passwords) change quite too frequently.
  - Hence this must work independently from password changes.  I never found a way on Windows to archive that (except running without passwords at all).


# `x11vnc` via `ssh` and `ssvncviewer`

This here fully automates this in following sense:

- Gives you VNC access to your already running remote X-Window session
- Just restart the vncviewer if the connection broke.
  - You have to reinstantiate your VPN connection first, of course.
- Everything else works behind the scenes without any hassle.
  - If your `ssh` connects need a password/passphrase, you need to reenter this, too.
  - This prompt will show up somewhere.  Recommendation: Use `ssh-add -c`

Also this should be easy enough such that you can set it up yourself even with minor Linux knowledge.

Machine D: Local machine with your Mouse and Keyboard
- This machine is a single user machine
- You have `root` access or some way to install all needed additional packages

Machine X: Machine with the display you want to see
- `x11vnc` is installed or accessible
- You have `ssh` access to the machine using a public key
- X-Window session with your user logged in
- You do not need `root` access
- This machine is possibly a multi user machine

Preparation:  Check that you can access Machine X from Machine D:

    machine-d$ ssh machine-x
    machine-x$ 


## `x11vnc` connection from local machine to remote using `ssh`

On Machine D create an SSH-Wrapper to Machine X in your `~/.ssh/config` file:

```
Host vnc-x
  Hostname machine-x
# User <your.user>
# ProxyCommand ssh jumper -W %h:%p
  RemoteCommand exec x11vnc -inetd -ncache 10 -ncache_cr -display :0 2>>~/.ssh2vnc.log
  ForwardAgent yes
  Compression yes
```

This `ssh`-connection directly launches `x11vnc` as the user and uses the user's X-Credentials.
(Note that the `.ssh2vnc.log` file can be found on Machine X.)

> So this can be considered secure, as nobody else is able to do so,
> except the user and people, who can act as the user already.


Now test, that this connection works, interrupt it with Ctrl+C (`^C` below):

```
machine-d$ ssh vnc-x
RFB 003.008
^Cmachine-d$ 
```

This needs the `ssh` credentials of the user, which only belong to the user.

> So this can be considered secure as well, as nobody else is able to do so,
> except the user and people, who can act as the user already.

Possible problems:

If you do not see the `RFB 003.008` your `ssh` uses pipes and your `x11vnc` does not work with pipes.
In that case you need another workaround to transform the piped `stdin` into a `socketpair()`:
For example use something like

```
  RemoteCommand exec socat - exec:'x11vnc -inetd -ncache 10 -ncache_cr -display \:0' 2>>~/.ssh2vnc.log
```

The `\` is needed by `socat` to dequote the `:`, else you will get a weird error message.  It becomes even weirder if you want to check this from commandline:

```
machine-d$ ssh machine-x "socat - exec:'/usr/bin/x11vnc -inetd -ncache 10 -ncache_cr -display \\:0'" 2>/dev/null
RFB 003.008
^Cmachine-d$ 
```

To see all diagnostic, leave away the `2>/dev/null`.

If `x11vnc` crashes after a few seconds with "caught XIO error:" I found following workaround (so it seems to be a bug in `x11vnc`):

- Run `x11vnc` with option `-noxinerama`, like this:

  `RemoteCommand socat - exec:'/usr/bin/x11vnc -inetd -ncache 10 -ncache_cr -noxinerama -display \:0' 2>>~/.ssh2vnc.log`

- see also https://forums.freebsd.org/threads/x11vnc-does-not-work-as-it-should-after-upgrade-from-11-to-12-1-version-crashes-every-time-after-2-3-days.73400/


## `ssvncviewer` to view

All you now have to do is to run

    ssvncviewer "exec=ssh vnc-x"

This is not perfect, but works.  If you have some trouble, because you see some "crop area" below your real screen,
use (1024 must be set to the real height of your screen):

    ssvncviewer -ycrop 1024 "exec=ssh vnc-x"

This possibly needs `ssh` authorization of the user.  You can use `ssh-agent` and `ssh-add -c`.

Security warning:

**Using `ssvncviewer` is insecure** on multiuser machines, as it creates some open port on localhost.
With the right timing somebody else on the same computer can catch the VNC session instead of you.
Probably only for a short time, but just a microsecond is enough to cause a lot of harm for attackers.


## use `nc` as alternative to `ssvncviewer`: 

As the "real" `netcat` most often lacks option `-e` (for some unintelligible reason), best is to use the `busybox` variant:

    busybox nc -llp 5901 127.0.0.1 -e ssh vnc-x

Now you can use your preferred `vncviewer`:

    vncviewer 127.0.0.1::5901

Note that some `vncviewer` variants need `:5901` or `:1` instead of `::5901`.
This differs from implementation to implementation.

Security warning:

**Using `netcat` this way is insecure** as anybody, who can connect to 127.0.0.1 on Machine D,
is able to access the VNC port this way.

Note that your browser is such a beast,
as nothing prevents web pages to contain or access URL `http://127.0.0.1:5901/`.
(This is not able to open some RFB connection, but triggers the connection which might be undesireable.)
