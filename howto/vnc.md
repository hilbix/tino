> You cannot access the Login Page this way!
>
> For this you either need some way to get past the login/chooser or root access.
> Both is not presented here.

Corona Home Office Welcome.

VNC is nice.  However it is a PITA if it needs to be set up or the connection breaks.

This here fully automates this in following sense:

- Gives you VNC access to your already running remote X-Window session
- Just restart the vncviewer if the connection broke.
  - You have to reinstantiate your VPN connection first, of course.
- Everything else works behind the scenes without any hassle.
  - If your `ssh` connects need a password/passphrase, you need to reenter this, too.
  - This prompt will show up somewhere.  Recommendation: Use `ssh-add -c`

Also this should be easy enough such that you can set it up yourself even with minor Linux knowledge.


# Automatic VNC via SSH

Machine D: Local machine with your Mouse and Keyboard
- This machine is a single user machine
- You have `root` access or some way to install all needed additional packages

Machine X: Machine with the display you want to see
- x11vnc is installed or accessible
- You have `ssh` access to the machine using a public key
- X-Window session with your user logged in
- You do not need `root` access
- This machine is possibly a multi user machine

Preparation:  Check that you can access Machine X from Machine D:

    machine-d$ ssh machine-x
    machine-x$ 


## `x11vnc` on the remote machine

On Machine X create an executable script `bin/ssh2vnc.sh`:

```
machine-d$ ssh machine-x
machine-x$ mkdir ~/bin
machine-x$ cat > ~/bin/ssh2vnc.sh <<'EOF'
exec x11vnc -inetd -ncache 10 -ncache_cr -display :0 2>>~/.ssh2vnc.log
EOF
machine-x$ chmod +x ~/bin/ssh2vnc.sh
machine-x$ exit
machine-d$ 
```

This launches `x11vnc` directly as the user and uses the user's X-Credentials.

> So this can be considered secure, as nobody else is able to do so,
> except the user and people, who can act as the user already.


## RFB connection from local machine to remote using `ssh`

On Machine D create an SSH-Wrapper to Machine X in your `~/.ssh/config` file:

```
Host vnc-x
        Hostname machine-x
#       User <your.user>
#       ProxyCommand ssh jumper -W %h:%p
        RemoteCommand bin/ssh2vnc.sh
        ForwardAgent yes
        Compression yes
```

Now test, that this connection works, interrupt it with Ctrl+C (`^C` below):

```
machine-d$ ssh vnc-x
RFB 003.008
^Cmachine-d$ 
```

This needs the `ssh` credentials of the user, which only belong to the user.

> So this can be considered secure as well, as nobody else is able to do so,
> except the user and people, who can act as the user already.


## `ssvncviewer` to view

All you now have to do is to run

    ssvncviewer "exec=ssh vnc-x"

This is not perfect, but works.  If you have some trouble, because you see some "crop area" below your real screen,
use (1024 must be set to the real height of your screen):

    ssvncviewer -ycrop 1024 "exec=ssh vnc-x"

This possibly needs `ssh` authorization of the user.  You can use `ssh-agent` and `ssh-add -c`.


## use `nc` as alternative to `ssvncviewer`: 

As the "real" `netcat` most often lacks option `-e` (for some unintelligible reason), best is to use the `busybox` variant:

    busybox nc -llp 5901 127.0.0.1 ssh vnc-x

Now you can use your preferred `vncviewer`:

    vncviewer 127.0.0.1::5901

Note that some `vncviewer` variants need `:5901` or `:1` instead of `::5901`.
This differs from implementation to implementation.

Security warning:

Using `netcat` this way **is not very secure** as anybody, who can connect to 127.0.0.1 on Machine D,
is able to access the VNC port this way.  Note that your browser is such a beast,
as nothing prevents web pages to contain or access URL `http://127.0.0.1:5901/`.
(This is not able to open some RFB connection, but triggers the connection which might be undesireable.)

