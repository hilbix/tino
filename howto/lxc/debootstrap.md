> TL;DR.  In short:
>
> `PATH="$PATH:/usr/sbin" fakechroot fakeroot /usr/sbin/debootstrap --variant=minbase buster $TARGETDIR $URLofYourLocalDebianMirror`
>
> or use `mmdebstrap` ([I an preparing a repo for this](https://github.com/hilbix/LXC))

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

With following command you are able to bootstrap some Linux:

	PATH="$PATH:/usr/sbin" fakechroot fakeroot /usr/sbin/debootstrap --variant=minbase buster $TARGETDIR $URLofYourLocalDebianMirror

However this is clumsy, as the filesystem information is gone after `fakeroot` returns

- Use `fakeroot -s SAVEFILE1.perms` to save the permissions
- Use `fakeroot -l SAVEFILE1.perms -s SAVEFILE2.perms` and so on afterwards to read in the old permissions and save the new ones

However I never managed to setup a fully functional LXC container this way until I discovered another tool: `mmdebstrap`

## Better use `mmedbstrap`

On Ubuntu 20.04 this creates a `.tar` file which contains a root filesystem for Ubuntu 20.04:

	mmdebstrap focal focal.tar http://archive.ubuntu.com/ubuntu/

Note that this does not require root permission!  To fill it with things LXC needs you need something like:

	mmdebstrap --include=ifupdown,systemd-sysv focal focal.tar http://archive.ubuntu.com/ubuntu/

However if you want to create Debian containers from Ubuntu you will hit a problem:

```
$ mmdebstrap buster buster.tar 
I: automatically chosen mode: unshare
I: chroot architecture amd64 is equal to the host's architecture
I: using /tmp/mmdebstrap.FaZqrpnifm as tempdir
I: running apt-get update...
done
Get:1 http://deb.debian.org/debian buster InRelease [122 kB]
Err:1 http://deb.debian.org/debian buster InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY EF0F382A1A7B6500 NO_PUBKEY DCC9EFBF77E11517
Reading package lists...
W: GPG error: http://deb.debian.org/debian buster InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY EF0F382A1A7B6500 NO_PUBKEY DCC9EFBF77E11517
E: The repository 'http://deb.debian.org/debian buster InRelease' is not signed.
E: apt-get update -oAPT::Status-Fd=<$fd> -oDpkg::Use-Pty=false failed
I: removing tempdir /tmp/mmdebstrap.FaZqrpnifm...
```

You can fix this:

	sudo install debian-archive-keyring
	
	mkdir debian.trust
	ln -s /usr/share/keyrings/debian-archive-keyring.gpg debian.trust
	
	mmdebstrap --include=ifupdown,systemd-sysv --aptopt=Dir::Etc::TrustedParts "\"$(readlink -e debian.trust)/\";") buster buster.tar

This trick also works for other distributions like Devuan, the only question is, where to find the right key?

> You do not want to take unverifiable keys from unsecured websites, right?\
> And no, HTTPs is not authenticating what you download, it only protects the transport which is not needed for public key information at all,
> as you need to authenticat such information by other means anyway.
