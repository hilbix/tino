# HowTo grow ZFS

My recommendation to create a pool on ZFS on Linux is following:

- Use LVM
  - Create a PV on each device without partition table.
  - Put each PV in its own VG
  - Create a single LV on each VG
  - Leave enough free room on the PV for LVM snapshots, something like 100GB
- Then use LUKS to encrypt the LVs
- Then use ZFS on top of the encrypted devices

I usually use raidz3 for this.  YMMV.


## Why LVM

LVM is good as it allows you to name your device.
Just do `pvs` and you know, what's on which device.
So you can label the devices and never mix anything up.

Also LVM allows you to do things like `pvmove` outside of the control of ZFS.

> LVM has no overhead, only benefits.  Especially when you use devices from
> different brands, which might slightly differ in capacity.  So you have
> full control over the capacity used for ZFS devices.

And very important is that you are able to extend the LVs with multiple PVs.

By putting devices together, I can double the size of a VG and hence extend
the LVs beyond the size of the individual devices.  This is good in case I
want to extend ZFS more quickly than it takes the time to copy the data
from the old devices to the new ones.

Also I can reuse the smaller devices to create bigger VGs until more bigger
devices arrive.

Always using LVM saves a lot of work and offers additional flexibility.
This both is always a very good thing.


## Why LUKS

LUKS is good in case your device breaks.  I usually use LUKS in combination with
automatic unlocking on boot.  The unlocking is done with a cheap and easy to
destroy USB sticks (usually you do not need to destroy anything, just overwrite).

So to decommission a device or reuse it for something else is very easy to do:

Just unplug and here you go.  All your previous data on the device stays secure,
as nobody can access your valuable data on normal circumstances.
(Note that I do not need to protect against intelligence agencies or police,
so I do not need perfect security here.  However it is enough to protect the data
if a device gets lost and somehow shows up at eBay.)

> With modern processors and AES-NI there is nearly no overhead due to LUKS.

Note that ZFS also offers encryption.  This is still good, too.  Because perhaps
you want to protect access to certain parts of it.  In that case the key management
built into ZFS is perfectly suited.

So the automatic unlock of LUKS is for everyday use,
and ZFS encryption for special use.

Also LUKS is good in case you resize LVs.  You will often (at least at my side)
find old filesystem signatures on devices if you do not use encryption.
With LUKS this will not happen, so there will not show up unexpected prompts
from your semiautomated (or fully automated) scripts.


## Why Extending

Regardless if you use zraid3 or mirroring, you certainly want to be able to
extend your pool over the years.

Do not fall into the trap to extend it by adding more devices.  This is a PITA,
because then you have old parts and new parts and over the years you will get
very confused.

Also raidz cannot be extended, so you cannot create 8 device raidz3 from a
7 device raidz3 (which is very frustrating, sorry to say that).

> Also I would like to see a raidz5 or higher.  SnapRAID shows that this is possible.
> 
> SnapRAID allows nearly a free N+M combination, and is able to increase N and M
> independently.  So it is possible.  But sadly it is not supported by ZFS.


## HowTo extend

So you have replaced your devices with bigger ones.  Thanks to LVM this all was
done fully online, so ZFS hasn't seen anything particular yet.  Or you still have
some free room on your LVs and want to utilize that.

This assumes, that all your ZFS VGs and LVs have a common prefix.

- Here it is `zfs` for the VGs.
  - I name them `zfs00a` to `zfs12a` for the 13 ZFS devices
  - The letter increases if I replace a device with another one
  - So if I see `zfs00g` I know, there are 6 old (probably reused or destroyed)
    devices around which may contain old data from the same ZFS.
  - From `z` I will go over to `zaa` (but I haven't reached more than `g` in over 15 years)
- It also is `zfs` for the LVs.
  - For simplicity the LVs are named exactly the same as their VGs.
  - Each VG only has a single LV.
  - Some VGs have more than one PV to get to the same size as other VGs.
- Note that PVs do not have names and only carry the names of their VG and LVs.
- Note that my pool also is named `zfs`
  - I am probably not very creative in naming things.

First step:  Extend the LVs

```
for a in /dev/zfs*/zfs*; do echo lvresize -L+${GB}G "$a" '&&' ; done
```

Halfstep:  Update loopback

> Note that this step usually is not needed.
>
> In certain setups I have a things behind a loopback for greater flexibility.
>
> And doing this step should never hurt!

```
for a in `losetup -nO name`; do losetup -c "$a"; done
```


Second step:  Inform LUKS about the new size

```
for a in  /dev/mapper/crypt-zfs*; do cryptsetup resize "$a"; done
```

Halfstep:  Update loopback

> See above, this step should never hurt even if it not needed.

```
for a in `losetup -nO name`; do losetup -c "$a"; done
```

Third step:  Check

> Doing checks always is a good thing

```
for a in /dev/zfs*/zfs* /dev/mapper/crypt-zfs* `losetup -nO name`; do lsblk -bno SIZE "$a"; done | sort | uniq -c
```
This reports 2 sizes:

> YMMV as this highly depends on `lsblk` and your configuration.

- A bigger one, which is the full size of the LV
  - This has the count which is as high as the number devices you use
- A smaller one, which is the size of the resulting LUKS device
  - This has a factor of the count of the number of devices you use

If there are more than 2 sizes, something probably went wrong as the LVs differ in size.

> This is not really a problem, but will not utilize all the space of every LV.

Fourth step: Print commands to extend the pool

```
POOL=zfs    # this is how your pool is named, in my case it is "zfs"
zpool status $POOL | awk -vPOOL="$POOL" '/crypt/ && /ONLINE/ {print "echo " $1 " && zpool online -e " POOL " " $1 " &&"}'
```

If you are satisfied, copy the output to your shell again, add a `:` (or `/bin/true`) at the end and execute it.
