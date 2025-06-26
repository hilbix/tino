# Misc

Miscellaneous short notes

## `apt`

- [`apt-config dump | grep -i ignore`](https://superuser.com/a/1493796/72223)
  extensions ignored in `/etc/apt/sources.list.d/` (I use `.disabled` and `.orig`)

##

```
apt install bpfcc-tools
```

```
execsnoop-bpfcc -tUx
exitsnoop-bpfcc
```

## `ss`

- [`ss -anp`](https://unix.stackexchange.com/questions/235979/how-do-i-find-out-more-about-socket-files-in-proc-fd/236013#comment1143685_236013) instead of `lsof -blnP -i -U`

## More

This is from me:

- [AppArmor](../apparmor.md)
- [AVAHI/mDNS](../avahi-mdns.md)
- [ControlGroups](../cg.md)
- [Kernel Trace (FTrace)](linux-kernel-trace.md)
- [System TAP](../stap.md)
- [Unix tools](../unix.md)
