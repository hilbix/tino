> Noch nicht fertig.  Ist nur ein STUB.

# HowTO iSCSI

WTF, I do not get it.  iSCSI is something very fundamental.  However, is there really no guide out there how to setup some iSCSI quickly on Linux?  So here it is.

## Install

```
apt install open-iscsi
```

## iSCSI Target

This is the server, which provides the device which the client mounts.

Create the device:

```
dd if=/dev/zero of=IMAGE bs=1M count=1000
```

Export it
