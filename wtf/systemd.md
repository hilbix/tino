**Better stop using SystemD on Servers.  It just creates unneccessary trouble!**

Here are examples, why:

## `umount -l /sys/fs/cgroup` crashes SystemD

```
SirCloud# reboot                                                                                                                
A dependency job for reboot.target failed. See 'journalctl -xe' for details.                                                                 
```

`journalctl -xe` gives us:

```
-- Subject: Process /lib/systemd/systemd-initctl could not be executed
-- Defined-By: systemd
-- Support: http://www.ubuntu.com/support
-- 
-- The process /lib/systemd/systemd-initctl could not be executed and failed.
-- 
-- The error number returned by this process is 2.
Jun 09 13:04:16 SirCloud systemd[1]: systemd-initctl.service: Main process exited, code=exited, status=219/CGROUP
Jun 09 13:04:16 SirCloud systemd[1]: systemd-initctl.service: Failed with result 'exit-code'.
Jun 09 13:04:16 SirCloud systemd[1]: systemd-initctl.service: Start request repeated too quickly.
Jun 09 13:04:16 SirCloud systemd[1]: systemd-initctl.service: Failed with result 'exit-code'.
Jun 09 13:04:16 SirCloud systemd[1]: Failed to start /dev/initctl Compatibility Daemon.
-- Subject: Unit systemd-initctl.service has failed
-- Defined-By: systemd
-- Support: http://www.ubuntu.com/support
-- 
-- Unit systemd-initctl.service has failed.
-- 
-- The result is RESULT.
Jun 09 13:04:16 SirCloud systemd[1]: systemd-initctl.socket: Failed with result 'service-start-limit-hit'.
```

WTF?

Well, a bit above the solution can be seen:  I disabled cgroups.  Hence:

```
Jun 09 13:04:16 SirCloud systemd[29269]: systemd-initctl.service: Failed to attach to cgroup /system.slice/systemd-initctl.service: No such f
Jun 09 13:04:16 SirCloud systemd[29269]: systemd-initctl.service: Failed at step CGROUP spawning /lib/systemd/systemd-initctl: No such file o
```

Hence, thanks to SystemD, following creates an unmangable system:

`umount -l /sys/fs/cgroup`

Go figure!
