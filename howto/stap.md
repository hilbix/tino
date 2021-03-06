Sigh, why do you always have to find out the hard way?  I try to be as concise as possible.

# Linux SystemTap

See also:

- https://sourceware.org/systemtap/wiki/
  - https://sourceware.org/systemtap/man/
  - https://sourceware.org/systemtap/examples/
- https://wiki.debian.org/SystemTap

## Getting started

Everything needs `root` as you are dealing with the kernel directly.
(Or `stap` group, but I do not like that, I rather use [my `suid` wrapper](https://github.com/hilbix/suid) instead.)

- `apt-get install systemtap systemtap-doc`
  - You can leave `systemtap-doc` away if you like if you rather read manpages online
- `stap-prep`
  - Ubuntu 20.04: This downloads (via `apt`) all needed debug symbols of the currently running kernel
  - **Warning** This puts 5GB+ under `/usr/lib/debug/`.  Per kernel, of course.
  - Under Debian Buster it tells me that `linux-image-4.19.0-13-amd64-dbgsym` is missing.  
    That's right, as you need `linux-image-4.19.0-13-amd64-dbg` without `sym`.  WTF?
- `stap -v -e 'probe oneshot { println("Hello World") }'`
  - This is not instant and takes a while to compile and run.

## Probes

- [`man stapprobes`](https://sourceware.org/systemtap/man/stapprobes.3stap.html)
- `stap -L 'kernel.trace("filelock:*")'` list kernel's trace points matching the glob `filelock:*`
- `stap -L 'syscall.read*'` list all syscalls matching the glob `read*`
- `stap -L 'kernel.function("*name*")'` to list all kernel functions matching the glob `*name*`

- `stap -L 'process("/bin/ls").function("*user*")' list all functions matching the glob `*user*` of process `/bin/ls` (see `build-id` below)

## Debug symbols

The debug symbols also contain the function signatures, such that you can access the function call parameters.

- `/usr/lib/debug/boot/` location of the debug symbols of a kernel named after the kernel
- `/usr/lib/debug/.build-id/` location of the debug symbols of programs named after the `debug-id`

### `build-id`

- `readelf -x .note.gnu.build-id "$PROGRAM"` displays the `build-id` starting with the 2nd line of the hexdump
  - Sadly the output of `readelf` is hardly scriptable
- `/usr/lib/debug/.build-id/$X/$Y.debug` are the debug symbols of `$PROGRAM`
  - `$X` takes the first 2 hex digits, `$Y` takes the rest
- If the file is missing, you need to find it somewhere.
  - I have no idea (yet) how to create them yourself.
  - However they are created as `.ddeb` packages, when Debian packages are built

Example:

- `stap -L 'process("/bin/ls").function("*user*")'`  ([Source](https://wiki.debian.org/SystemTap))

# Example

To run an example, just save the code to a file and then run `stap file` or `stap -g file`, see the introducing comment.

## `kill.stp`

This lists all `kill`s and where they are coming from:

```
#!/bin/sh
//bin/true && exec stap "$0"

probe syscall.kill {
  if (sig)
    printf("kill %ld %ld(%s) from %s\n", sig, pid, pid2execname(pid), pstrace(pid2task(pid())))
}

probe begin { printf("list of kill() calls:\n") }
```

Notes:

- Output looks like `kill 15 418881(tmux: server) from  systemd(12762)`
- [`pid()`](https://sourceware.org/systemtap/man/function::pid.3stap.html) is a builtin function while `pid` refers to the argument named `pid`.  A bit confusing?
- `syscall.kill name:string pid:long sig:long sig_name:string argstr:string` are the arguments,  
  listed with `stap -L syscall.kill`.  (See above.)

## `fsync.stp`

Dump `fsync`s going on:

```
#!/bin/sh
//bin/true && exec stap "$0"

probe kernel.function("do_fsync").return { ns=(gettimeofday_ns() - @entry(gettimeofday_ns())); printf("%4ld.%06ldms fsync(%ld) %ld(%s) from %s\n", ns/1000000, ns%1000000, @entry($fd), pid(), pid2execname(pid()), pstrace(pid2task(pid()))) }
probe begin { printf("list of fsync() calls (does not catch 'sync's):\n") }
```

Suppress `fsync`s of a given process name (give the process name on commandline, see above to list names):

- Based on https://sourceware.org/systemtap/examples/io/eatmydata.stp
- The default name is `beam.smp` which is the Erlang process.  
  I use this to speed up large CouchDB inserts on slow disks a factor of 100+
- It is similar of `eatmydata` (which needs a dynamically linked executable), but this here is on kernel level and only is active as long as the probe is active.

> **WARNING!** Suppressing `fsync()` might corrupt data in case of a system crash like a power outage.

```
#!/bin/bash
//bin/true && exec stap -g "$0" "${1:-beam.smp}" "${@:2}"

global ok, err;

probe kernel.function("do_fsync") { if (pid2execname(pid()) == @1) try { printf("%ld ", $fd); $fd=-1; ok++ } catch { err++ } }
probe kernel.function("do_fsync").return { if (pid2execname(pid()) == @1) try { $return=0 } catch { err++ } }

probe begin { printf("supressing fsync() from %s (outputs just the suppressed fildes)\n", @1) }
probe error,end { printf("ok=%ld err=%ld\n", ok, err) }
```

## Ubuntu 20.04

```
$ cat /etc/apt/sources.list.d/20.04.list 

  deb     http://de.archive.ubuntu.com/ubuntu/	focal		main restricted multiverse universe
  deb-src http://de.archive.ubuntu.com/ubuntu/	focal		main restricted multiverse universe
  deb     http://de.archive.ubuntu.com/ubuntu/	focal-updates	main restricted multiverse universe
  deb-src http://de.archive.ubuntu.com/ubuntu/	focal-updates	main restricted multiverse universe
  deb     http://de.archive.ubuntu.com/ubuntu/	focal-backports	main restricted multiverse universe
  deb-src http://de.archive.ubuntu.com/ubuntu/	focal-backports	main restricted multiverse universe

  deb     http://security.ubuntu.com/ubuntu/	focal-security	main restricted multiverse universe
  deb-src http://security.ubuntu.com/ubuntu/	focal-security	main restricted multiverse universe

  deb     http://ddebs.ubuntu.com		focal		main restricted multiverse universe
  deb     http://ddebs.ubuntu.com		focal-updates	main restricted multiverse universe
  deb     http://ddebs.ubuntu.com		focal-proposed	main restricted multiverse universe

# deb     http://de.archive.ubuntu.com/ubuntu/	focal-proposed	main restricted multiverse universe
# deb-src http://de.archive.ubuntu.com/ubuntu/	focal-proposed	main restricted multiverse universe

```

```
$ sudo du -sh /usr/lib/debug
7.1G	/usr/lib/debug
```

```
$ dpkg -l *-dbgsym | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                            Version             Architecture Description
+++-===============================================-===================-============-============================================================
ii  coreutils-dbgsym                                8.30-3ubuntu2       amd64        debug symbols for coreutils
ii  linux-image-5.8.0-48-lowlatency-dbgsym          5.8.0-48.54~20.04.1 amd64        Signed kernel image lowlatency
in  linux-image-unsigned-5.8.0-48-generic-dbgsym    <none>              amd64        (no description available)
ii  linux-image-unsigned-5.8.0-48-lowlatency-dbgsym 5.8.0-48.54~20.04.1 amd64        Linux kernel debug image for version 5.8.0 on 64 bit x86 SMP
un  pkg-create-dbgsym                               <none>              <none>       (no description available)
```

```
$ dpkg -l *keyring* | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                       Version                     Architecture Description
+++-==========================-===========================-============-========================================================================
ii  debian-archive-keyring     2019.1ubuntu2               all          GnuPG archive keys of the Debian archive
ii  debian-keyring             2020.03.24                  all          GnuPG keys of Debian Developers and Maintainers
ii  gir1.2-gnomekeyring-1.0    3.12.0-1build1              amd64        GNOME keyring services library - introspection data
ii  gnome-keyring              3.36.0-1ubuntu1             amd64        GNOME keyring services (daemon and tools)
ii  gnome-keyring-pkcs11:amd64 3.36.0-1ubuntu1             amd64        GNOME keyring module for the PKCS#11 module loading library
ii  libgnome-keyring-common    3.12.0-1build1              all          GNOME keyring services library - data files
ii  libgnome-keyring-dev       3.12.0-1build1              amd64        Development files for GNOME keyring service
ii  libgnome-keyring0:amd64    3.12.0-1build1              amd64        GNOME keyring services library
ii  libpam-gnome-keyring:amd64 3.36.0-1ubuntu1             amd64        PAM module to unlock the GNOME keyring upon login
ii  python3-keyring            18.0.1-2ubuntu1             all          store and access your passwords safely - Python 3 version of the package
ii  python3-keyrings.alt       3.4.0-1                     all          alternate backend implementations for python3-keyring
ii  signon-keyring-extension   0.6+14.10.20140513-0ubuntu2 amd64        GNOME keyring extension for signond
un  ubuntu-cloudimage-keyring  <none>                      <none>       (no description available)
ii  ubuntu-dbgsym-keyring      2020.02.11.4                all          GnuPG keys of the Ubuntu Debug Symbols Archive
ii  ubuntu-keyring             2020.02.11.4                all          GnuPG keys of the Ubuntu archive
```

```
$ uname -a
Linux medusa 5.4.0-54-lowlatency #60-Ubuntu SMP PREEMPT Fri Nov 6 11:28:21 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

- As you can see, an older kernel is still loaded, so `stap` does not work on this computer
- This is [how Ubuntu Bug 1920640 was fixed](https://bugs.launchpad.net/ubuntu/+source/ubuntu-keyring/+bug/1920640)
  - See also [my post on AskUbuntu](https://askubuntu.com/q/1325481/164798)
- Ubuntu has deleted all debug packets signed with the old key

```
$ uname -r
5.4.0-54-lowlatency

$ apt-cache policy linux-image-`uname -r`-dbgsym
N: Unable to locate package linux-image-5.4.0-54-lowlatency-dbgsym
N: Couldn't find any package by glob 'linux-image-5.4.0-54-lowlatency-dbgsym'
N: Couldn't find any package by regex 'linux-image-5.4.0-54-lowlatency-dbgsym'

$ apt-cache policy linux-image-5.4.0-54-dbgsym
N: Unable to locate package linux-image-5.4.0-54-dbgsym
N: Couldn't find any package by glob 'linux-image-5.4.0-54-dbgsym'
N: Couldn't find any package by regex 'linux-image-5.4.0-54-dbgsym'
```

Note that I never had similar problems with Debian (see below).  After reboot of my workstation, I want to boot into Kernel `5.8.0-48`, so `stap` works again.  But who ever reboots Linux?

```
$ uptime
 12:12:45 up 130 days,  7:44, 24 users,  load average: 6.48, 7.31, 6.86
```

Compare to some other of my busy hosts (that's the uptime I want to see):

```
$ uptime
 12:15:18 up 1061 days, 5 min,  2 users,  load average: 1.03, 1.25, 1.07
```

Note that I call something "stable" only, if it reaches uptimes `>1000` without problems.  Under load, of course!


## Debian 10

```
$ cat /etc/apt/sources.list.d/debian-10-buster.list

  deb		http://security.debian.org/		buster/updates		main contrib non-free
  deb-src	http://security.debian.org/		buster/updates		main contrib non-free
  deb		http://deb.debian.org/debian/		buster			main contrib non-free
  deb-src	http://deb.debian.org/debian/		buster			main contrib non-free
  deb		http://deb.debian.org/debian/		buster-updates		main contrib non-free
  deb-src	http://deb.debian.org/debian/		buster-updates		main contrib non-free
  deb		http://deb.debian.org/debian/		buster-backports	main contrib non-free
  deb-src	http://deb.debian.org/debian/		buster-backports	main contrib non-free

  deb		http://deb.debian.org/debian-debug/	buster-debug		main contrib non-free
  deb		http://deb.debian.org/debian-debug/	buster-backports-debug	main contrib non-free
  deb		http://deb.debian.org/debian-debug/	buster-proposed-updates-debug	main contrib non-free

```

```
$ du -sh /usr/lib/debug/
9.9G	/usr/lib/debug/
```

```
$ dpkg -l linux-*-dbg | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                            Version      Architecture Description
+++-===============================-============-============-=============================================
ii  linux-image-4.19.0-13-amd64-dbg 4.19.160-2   amd64        Debug symbols for linux-image-4.19.0-13-amd64
ii  linux-image-4.19.0-14-amd64-dbg 4.19.171-2   amd64        Debug symbols for linux-image-4.19.0-14-amd64
```

```
$ dpkg -l *keyring* | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                       Version        Architecture Description
+++-==========================-==============-============-===========================================================
ii  debian-archive-keyring     2019.1+deb10u1 all          GnuPG archive keys of the Debian archive
ii  debian-keyring             2019.02.25     all          GnuPG keys of Debian Developers and Maintainers
ii  gir1.2-gnomekeyring-1.0    3.12.0-1+b2    amd64        GNOME keyring services library - introspection data
ii  gnome-keyring              3.28.2-5       amd64        GNOME keyring services (daemon and tools)
ii  gnome-keyring-pkcs11:amd64 3.28.2-5       amd64        GNOME keyring module for the PKCS#11 module loading library
ii  libgnome-keyring-common    3.12.0-1       all          GNOME keyring services library - data files
ii  libgnome-keyring0:amd64    3.12.0-1+b2    amd64        GNOME keyring services library
un  libp11-kit-gnome-keyring   <none>         <none>       (no description available)
ii  libpam-gnome-keyring:amd64 3.28.2-5       amd64        PAM module to unlock the GNOME keyring upon login
ii  python-keyring             17.1.1-1       all          store and access your passwords safely
ii  python-keyrings.alt        3.1.1-1        all          alternate backend implementations for python-keyring
ii  ubuntu-archive-keyring     2018.09.18.1-5 all          GnuPG keys of the Ubuntu archive - transition package
ii  ubuntu-cloud-keyring       2018.09.18.1-5 all          GnuPG keys of the Ubuntu Cloud Archive
ii  ubuntu-dbgsym-keyring      2018.09.18.1-5 all          GnuPG keys of the Ubuntu Debug Symbols Archive
ii  ubuntu-keyring             2018.09.18.1-5 all          GnuPG keys of the Ubuntu archive
```

```
$ uname -a
Linux giganto 4.19.0-14-amd64 #1 SMP Debian 4.19.171-2 (2021-01-30) x86_64 GNU/Linux
```

```
$ uptime
 12:19:31 up 37 days,  8:26, 78 users,  load average: 29.59, 32.72, 31.71
```

Did I say load?
