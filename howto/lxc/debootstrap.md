> TL;DR.  In short:
>
> `PATH="$PATH:/usr/sbin" fakechroot fakeroot /usr/sbin/debootstrap --variant=minbase buster $TARGETDIR $URLofYourLocalDebianMirror`

# LCX and unprivileged containers

## Problems

The [documentation](https://wiki.debian.org/LXC) exposes some major issues.


### Full access from some untrusted 3rd party

> You are probably very well informed about security nightmares like DockerHub or MavenRegistry.
> However it was new to me, that such a security nightmare is also built right into LXC via [LXD](https://images.linuxcontainers.org/).
>
> **Never use `lxc -t download`**.  You have been warned.  Already the word `download` should ring all of your security warning doorbells!  Right?

In case you are allowed to use LXC but are not privileged, it is very likely that you do not have a direct network connectivity.
In that case you will see following:

```
$ lxc-create -t download -n test
Setting up the GPG keyring
ERROR: Unable to fetch GPG key from keyserver
lxc-create: test: lxccontainer.c: create_run_template: 1617 Failed to create container from template
lxc-create: test: tools/lxc_create.c: main: 327 Failed to create container test
```

As neither a keyserver nor (for some security reason) any public (the not trustworthy) [LXC container registry](https://images.linuxcontainers.org/) is available,
LXC cannot be set up as explained.


### Horrible bugs in the code

Even if [everything is setup properly](https://wiki.debian.org/LXC#Unprivileged_container) with

    sudo sh -c 'echo "kernel.unprivileged_userns_clone=1" > /etc/sysctl.d/80-lxc-userns.conf'
    sudo sysctl --system

Debian Buster currently exposes [a bug](https://github.com/lxc/lxc/issues/3121)
in the [code](https://github.com/lxc/lxc/commit/c14ea11dccbfa80021a9b169b94bd86e8b359611#diff-9308db620cfc569a9c2a7e321f741ebd):

```
$ lxc-usernsexec 
Failed to find subuid or subgid allocation
```

This bug was even hiding [something completely different](https://github.com/lxc/lxc/issues/3163).

> **WARNING!** Better don't look into the code, as it took has some very horrible design choices:
> 
> For example it is unable to properly process a file which does not end on `\n`.
> With a good design choice such unreadable neary unmaintainable code which allows such common errors would be virtually impossible.
>
> However you are in illustrious company with very bad design choices, for example POSIX took the quite other route:
>
> ```
> $ echo hello >> $'world\n'; file="`echo $'world\n'`"; cat "$file"
> cat: world: No such file or directory
> ```
>
> The correct code looks like this:
>
> ```
> $ echo hello >> $'world\n'; file="`echo $'world\n' && echo x`"; file="${file%x}"; file="${file%$'\n'}"; cat "$file"
> hello
> ```
>
> Either way, I call this horrible design choices.


## debootstrap to the rescue

