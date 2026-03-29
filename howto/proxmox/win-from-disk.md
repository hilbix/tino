# HowTo Proxmox

TL;DR:

- Create a virtual disk (here: `/dev/mapper/win-virtual`) out of the original disk using `dmsetup` with `snapshot`
- Create a new Windows VM (here: `111`) without any device.
  - Note that I not even gave the VM any networking or CDROM.
- Then add the virtual disk to the VM from the Proxmox commandline:  
  `qm set 111 -sata0 /dev/mapper/win-virtual`
- Give the VM at least 8 GB of RAM (else .. it gets slow)
- Use UEFI Bios with UEFI disk (where Proxmox saves the EFI settings)
- Start the VM
- In my case `grub` showed up, as I excluded the Linux paritions on the virtual disk.

Following then booted into Windows:

```
insmod chain
chainloader (hd0,gpt1)/EFI/Microsoft/Boot/bootmgfw.efi
boot
```

At my side it took quite some time until Windows finally became ready.  But everything seems to run, even WSL did as expected.


## Windows via Virtual Disk

If you ask a KI how to run windows from your disk, you get .. stuff.  However these are not real clues how to do it.

Here is the initial setup of my machine:

- First, I installed Windows 11 onto the system.
- Then I added a secondary boot into Ubuntu as well.
- Then I decided to use Proxmmox instead.

So I created a new logical volume, installed Proxmox, bootet into it, attached new disks and migrated the old Ubuntu-Stuff to ZFS.
Now the machine boots Proxmox.

But what to do with the Windows-install.  Wouldn't it be nice to run this from Proxmox as well?

> Also I wanted to be careful, such that if something fails, I am able to revert and start again.


## Create the bare VM

If you want to install the VirtIO ISOs (I didn't use them, it works without), here is how:

- First, make sure you downloaded the Driver-ISO
- You need a Storage for ISO which can hold the download, so:
- In "Datacenter" use `Storage` to create or find the storage for `ISO image`
- Then in the `Server view` or `Folder view` select this storage and then `ISO images`
- Click on `Download from URL` and enter the URL for the `virtio-win-*.iso` and let it download

According to the [Proxmox documentation](https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers#virtio-win_Releases), you can find the ISO URLs there:  
<https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/?C=M;O=D>

Then the rest is straight forward with the Proxmox wizard:

- Create a new VM (I chose number `111`).
- Select `Windows 11` and `Do not use any media`
  - Optionally add the driver ISO here
- Use the `OVMF (UEFI)` BIOS
  - The EFI disk is not used by the OS but only by Proxmox to keep the EFI settings
- Do not add any disk, as the Wizard does not support it directly
- Give it at least 8 GB of RAM, else things get very slow
- Select Windows11 OS
- No Networking for now, this avoids driver problems


## Create a Virtual Disk

This virtual disk resembles the original windows harddrive without modifying it.  Hence it is easy to revert if something fails.

> Beware!  If you ever boot into Windows directly instead of Proxmox, you need to re-create the virtual disk.
> As the bare-metal Windows does not see any changes from this virtual disk!

Fortunately, Windows is only on the first part of the main drive and Linux is behind it, so I decided to shrink the disk Windows sees.

Here is a setup script I used to provide `/dev/mapper/win-virtual` disk:

```
#!/bin/bash
#
# vim: ft=bash

SRC=/dev/nvme0n1
SSZ=1684115456
COW=/dev/mapper/work-tmp--cow
CSZ=$(blockdev --getsz "$COW") || exit;

# unmap old mapping
for a in win-virtual win-virtual-cow win-virtual-source;
do
        dmsetup info "$a" 2>/dev/null || continue;
        dmsetup remove "$a" || exit;
done;

# map the loop devices
declare -A LOOP;
for a in "$SRC";
do
        for d in $(losetup --associated "$a" | sed -n 's/:.*$//p');
        do
                echo "detaching $d from $a" || exit;
                losetup -v -d "$d" || exit;
        done;
        l="$(losetup --show --find --read-only "$a")" || exit;
        echo "attached $l from $a" || exit;
        LOOP["$a"]="$l";
done;

set -xe;

dmsetup create --readonly win-virtual-source --table "0 $SSZ snapshot-origin ${LOOP["$SRC"]}"
dmsetup create            win-virtual-cow    --table "0 $CSZ linear $COW 0"
dmsetup create            win-virtual        --table "0 $SSZ snapshot /dev/mapper/win-virtual-source /dev/mapper/win-virtual-cow P 16"

dmsetup status /dev/mapper/win-virtual
```

Notes:

- If something fails, then first correct the problem!
  - You can re-run this script, as it unmaps everything first
  - If something is in use, this unmapping fails!  In that case better reboot and start again.
  - You have been warned, as fiddling with the block layer is something very dangerous for your data!
- `1684115456` is the start of my Linux partition(s) on the disk.
  - See `parted /dev/nvme0n1` and then `unit s` then `print free`
  - Note that you need a few free/unused sectors at the end of the disk to store the GPT backup table!
- The `/dev/mapper/work-tmp--cow` was just some LV created with `lvcreate -L20G -n tmp-cow work`.
- I do not know why a `loop` device is needed, however without I got the message, that `/dev/nvme0n1` is BUSY.
  (Probably because it is our Boot-Device)
- The original device CANNOT be altered (see `losetup --readonly`).
  So all the changes are written to `/dev/mapper/work-tmp--cow`.
- `watch -n10 dmsetup status /dev/mapper/win-virtual` to see the utilization

The first time after the disk is created, the `COW` part is empty and the `GPT` partition table is corrupt (because I shrunk the disk!).

> !BEWARE!
>
> Do NOT alter `/dev/nvme0n1` here!  Use the newly created `/dev/mapper/win-virtual` disk.

Hence I had to fix that using `gdisk /dev/mapper/win-virtual` and then:

- Delete all the "excess" Linux partitions
- `w`rite the resulting partition tables  
  which only works if `gdisk` is able to re-write the `GPT` backup partition table.

> To stress it:
> - `/dev/mapper/win-virtual` reads from `/dev/nvme0n1` but does not write to it!
> - All changes are written to the COW device `/dev/mapper/win-virtual-cow`  
>   which is backed by `/dev/mapper/work-tmp--cow` in my case!

Now the virtual disk `/dev/mapper/win-virtual` is usable!


## Map the Virtual Disk to the VM

This needs the Proxmox commandline, as the UI does not support that.

If your VM is `111` then adding the disk `/dev/mapper/win-virtual` is the command:

```
qm set 111 -sata0 /dev/mapper/win-virtual
```

Afterwards I did change the boot order on the VM to first boot from this added disk.


## Additional things?

Well, you probably want to install the `virtio-win` drivers and then enable networking, change the disk to virtio etc.

However I did not need anything of this (yet), so I do not know the exact steps for this yet.





