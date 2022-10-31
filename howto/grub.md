# HowTo Grub2

## Manual Boot

### HyperV

If your VM starts `grub` under HyperV, usually your screen is blank.
Just press Enter to unblank it.  You then hopefully see the `grub>` prompt.


### Stage 0

If `grub` does not start at all, you need a grub startimage.

> T.B.D. how to create that


### Stage 1

Grub then boots into stage 1.  This is from the boot sector plus 3 more sectors or so.

Then it tries to find it's stage 2, modules and stuff.
If it can't you need to configure stage 1 to get the stage 2 booted.

> T.B.D. how to boot stage 2 from stage 1


### Stage 2

Grub booted, but there is no menu.  All you have is a `grub>` prompt.

First, set the pager, so things do not scroll out of your screen:

	set pager=1

Then do

	lsmod

This must show some loaded modules.  If they are missing, load them.
Which modules are needed depends on your setup.  You probably need:

	insmod ls
	insmod part_gpt
	insmod lvm
	insmod ext2
	insmod gzio

Or a few others, if your setup needs those:

	insmod xfs
	insmod luks
	insmod zfs

Now type `ls`.  This should give you a list of devices recognized by `grub`.

Your root/boot devices should be there.  Set the correct device to the variable `prefix=`

	set prefix=(lvm/vg-root)/boot/grub
	ls $prefix

This should give you an output of the directory where `grub` is installed.

Usually there is the menu in it:

	cat $prefix/grub.cfg

In case the config is OK, you can enter `normal` mode:

	normal


### Manual boot

> At my side, I can use TAB completion to enter paths more easily.  
> YMMV, I do not know which module is enabling this feature.

`normal` did not work?  Or the menu file is corrupt?
Then you need to boot manually into the kernel as follows:

	set root=lvm/vg-root
	ls ($root)/boot

This should give you a listing of the installed Linux kernels.  If not, find your `/boot` device.

> Usually `root` is similar to `$prefix` (without the parantheses, though)
> but in some setups, `/boot` may be on a different FS, then you use `set root=lvm/vg-boot` or similar.  `ls` is your friend to find the correct drive.

Now set the linux commandline:

	linux /boot/vmlinuz root=/dev/mapper/vg-root ro video=hyperv_fb:1920x1080
	initrd /boot/initrd.img
	boot

> hyperv_fb is an example here to set the resolution of the graphics under Windows 11 Hyper-V.
> Usually you can leave it away of course.  But do not forget the `ro`.


### Some final notes

If you use SystemD (which is very likely) things are likely to break afterwards,
as SystemD is a very extremly totally picky init system.  If a few things go wrong,
things go wrong catastrophically.  YMMV, but this is what I can observe.

There is a trick:  **DO NOT USE SYSTEMD**

But as it is often impossible to do so, because your system is already infected by this disaster,
there is an alternate trick. Just add

	init=/bin/bash

to the Linux commandline.  This boots into `bash` instead of SystemD.
And you now are back into control.

Things you can do in this `bash`:

- `mount -o remount,rw /` to make the root device writable
- `openvt bash` to create another virtual terminal
  - Better do not run in the main console, as job control etc. is not available there!
- `exec /sbin/init` run the "real" init.  This only works from the `bash` which has PID 1.


## Console+Serial+KVM

On a VM it is good to have a fallback serial console, to be able to access the console of a VM via commandline (`virsh console $VM`) as well as via `virt-manager` graphically, just in case.

`/etc/default/grub`

```
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200n8"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"
GRUB_TERMINAL="console serial"
```

```
update-grub
systemctl enable serial-getty@ttyS0.service
systemctl start  serial-getty@ttyS0.service
```

### VM settings

You need to have a serial line configured in your VM (`virsh edit $VM`):

```
<domain type='kvm'>
  <devices>
[..]
    <serial type='pty'>
      <target port='0'/>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
[..]
  </devices>
</domain>
```

Note: I do not know it this suffices.  Perhaps there is a bit more XML configuration needed.
