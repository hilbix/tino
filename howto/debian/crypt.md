> Perhaps also read `/usr/share/doc/cryptsetup-initramfs/README.initramfs.gz`
> as it gives you a lot of clues!

# Debian Encrypted Filesystems

Here I note some information about how to properly setup encrypted drives on Debian.

Note:

- This here is not to do encryption to protect against adversaries.
- This is just to protect the data in case a drive needs replacement.
- So be sure that the key is never present on the drive itself

This is exactly what I do here.

## TL;DR

```
swap	/dev/vg/swap	/dev/urandom	cipher=aes-xts-plain64,size=256,swap
```

- Use encrypted LVs on unencrypted PVs.
- Use 3 LUKS keys for each:
  - `passdev` automatic key
  - Manual decryption key for on-demand single-use which can be passed to a third party if needed
  - Global disaster decryption key which is kept secret
- Use encrypted LVs for ZFS, too
  - And use ZFS encryption on top of this if needed


## SWAP encryption

The very first thing you should always do is to enable encryption on the SWAP partition.
If you do not need something like "resume from hibernate", usually seen on servers or VMs,
this can be done with a random key.  So the setup is straight forward and easy:

`/etc/crypttab`:

```
swap1	/dev/vg0/swap1	/dev/urandom	cipher=aes-xts-plain64,size=256,swap
swap2	/dev/vg0/swap2	/dev/urandom	cipher=aes-xts-plain64,size=256,swap
```

You can even do this on-the-fly:

- `swapoff -a`
- `cryptdisk-start swap1 swap2`
- Edit `/etc/fstab` to use `/dev/mapper/swap1` etc. instead of the current swaps
- `swapon -a`

> The question is not to use crypt on swap or not.  As secure operations like SSL are done everywhere nowadays,
> you must encrypt the swap, else encrypted data may be stored on the device fully decrypted (and keys may leak).
>
> So the question is either to use encrypted swap or no swap at all.  Nothing in between, please!
>
> Note that it always is good to have some swap in place.  Just in case.  If it already is there,
> it is easy to increase on the fly.  If it is not set up yet, you perhaps make mistakes adding it when you are in a stress situation.


## LVM encryption

> I assume you always have LVM in place.  Even with ZFS.

The question here is:

- PVs on LUKS
- or LUKS on PVs

If PVs are on LUKS this means, you will not even see what is in the PVs.  So you must decide:

- Do you want better administrabillity
- Or do you really have the need to hide everything

I chose the first.  This means if find some drive laying around and plug it in, I can see what is in the PV.
This also gives me the hints needed to find the correct decryption key, as there is enough information in the LVM header, usually.

> Only if done right.  But this here is all about doing it right, right?

Hence all the PVs are created directly and the encrypted devices are added afterwards.

- This has the advantage, that you can create unencrypted devices, too.  I don't know, but perhaps this can come handy, too.
- Also as all LVM data is unencrypted (mirroring, thin provisioning, etc.) this might lessen the impact of bad memory or plain other errors.

This way the system can be setup straight forward, and later on you can add the encryption layer before valuable data hits the drives.

Another question is if you should use LUKS1 or LUKS2 and which algorithm.  My answer to this is:

- If in doubt, use the default of your distro, so do not add any option to `cryptsetup luksFormat device`
  - Very old distros perhaps do not use `aes-xts-plain64`.  Use `--cipher=aes-xts-plain64` there
- If you need some boot compatibility (for example the rescue system of your ISP), use `--type luks1`
- If you want maximum compatibilty (to mostly current situations) use `--pbkdf pbkdf2`
- Use `cryptsetup --help` to see the "Default compiled-in device cipher parameters" (at the very end of the output)

> **!WARNING!**
>
> **`keyscript`s are incompatible with SystemD!**
> AFAICS they only work with `cryptdisk_start` and initrd.
>
> `man crypttab` on Debian `bookworm` states:  
> WARNING: With systemd as init system, this option might be ignored. At the time this is written (December 2016), the systemd cryptsetup helper doesn't support the keyscript option to /etc/crypttab. For the time being, the only option to use keyscripts along with systemd is to force processing of the corresponding crypto devices in the initramfs. See the 'initramfs' option for further information.


First, create a `keyscript` which outputs the some key when run.

- This is `/path/to/keyscript.sh` below
- Test the keyscript outputs the key: `/path/to/keyscript.sh | od -tx1z`
- If the keyscript is for devices needed to boot, it must be able to run in initrd
  - I recently had trouble to do so, so this is the most problematic part here
  - Sorry, currently I cannot help you, but I am working on it.  
    It will show up in "Automatic Remote Key Management" below if I come around.

Alternatives to the `,keyscript=/path/to/keyscript.sh` in `/etc/crypttab`:

- `,passdev`.  The `keyfile` parameter (3rd column) becomes `device:path`
  - like `/dev/disk/by-label/usbunlock:/unlock.key`
  - This tries to read `/unlock.key` from filesystem `/dev/disk/by-label/usbunlock`
  - It also waits until this device becomes available
- Use a device directly like `,keyfile-offset=4095,keyfile-size=512,tries=0`
  - `/dev/disk/by-label/usbunlock`
  - The problematic part here is, that it will not wait for USB to come up
  - Hence `,tries=0` to make it loop until it succeeds
  - Which might waste CPU forever fruitlessly

Then the process is:

```
lvcreate -n crypt -L5G vg0
luksformat --cipher=aes-xts-plain64 /dev/vg0/crypt1 <(/path/to/keyscript.sh)
UUID="`blkid -o value -s UUID /dev/vg0/crypt1`"    # you can use instead: cryptsetup luksUUID /dev/vg0/crypt1
echo "crypt1 UUID=$UUID none luks,keyscript=/path/to/keyscript.sh" >> /etc/crypttab
cryptdisk_start crypt1
```

- I recommend to add `,noearly` in case it is a LVM LV which is put into initrd.

I recommend to keep it straight forward:

- 1st column: Use the LV's name as the target name in `/dev/mapper/`
  - this works, as the LV itself is named `/dev/mapper/vg-name`
- 2nd column: Use UUIDs where possible
  - As you used the name of the LV there is no much problem to locate the LV in question without looking up `blkid --uuid UUID`
  - For example if you rename your VG, you do not need to update anything here
- 3rd column: Use `none` as the keyfile
  - This column will be passed to the keyscript as argument
  - You can create derived keys this way, but I recommend to use the same key on all devices
- 4th column:  Do not use other options

That's basically all to it.


## ZFS encryption

ZFS already has very good encryption support.  So the question is

- Use only ZFS encryption
- Or use LUKS instead

I vote for both via LVM encryption.

This is:

- Create a PV
- Create an encrypted LV on the PV
  - Do not use the full space
- Then add it to ZFS

This way, if something breaks, ZFS is unable to use the device.
This usually is exactly what you want and gives you another layer of administration here.

As this comes naturally with the above LVM setup, there is absolutely nothing to it to explain here.


## (Automatic) Key Management

The easiest way is to use `passdev` from within `/etc/crypttab` and use it with some (cheap) USB key.

- The USB key is to be overwritten and physically destroyed when it is of no more use
  - Due to wear levelling you perhaps cannot delete the key material on it
  - Hence it is a bad idea to re-use such sticks in a different computer
  - Except you stay with the key
- Computer Security is not about being fully safe
  - Computer Security is about being aware of possible threats!

However please do not forget that devices can break.  (I have a ton of those!)

Luckily, LUKS offers 4 keyslots.

- One is for automatic decryption by `passdev` or similar
- One is for manual decryption in case you must access it (as an image etc.) in the future
  - After using the key, this key should be changed!
  - This key can be used to unlock a drive by a third party, like if this is needed to give evidence to the autorities
  - You definitively do not want to hand out your global disaster recovery key in this situation!
- One is for disaster recovery
  - This is a key, which is very well hidden and only used if disaster strikes
  - It should be printed and kept in a sealed envelope in some bank tresor
  - Note that the printer must not be networked, so use some old memoryless directly attached printer!
- The 4th slot can be kept free

How do I do this?

- I create the LUKS with the automatic decryption
- Then I transfer the LUKS header to a secured computer
- There I add the other 2 keyslots
- Then I transfer the LUKS header back to the device

This way I only have to worry about the automatic decryption key.

- This is unavoidable
- Everything else is avoidable
  - This is why I do not add the Disaster Keys on the machine itself, as this is used for multiple computers
  - It is pure convenience to add the manual decruption key on the secured computer, as it is stored there

> The process needs examples.  However currently I cannot paste them here, as it is incomplete or may expose secrets-as-I-do-it.


## Full Boot Encryption

For the time being I did not find a good way to have even the boot partition encrypted.

> But I am working on this!
>
> The idea here is to create some minimalistic boot Linux,
> which then `kexec`s the kernel and initrd.
>
> To be able to do so, it then can pull the key from some remote server etc.

The thing about this is, this way you can have some fully encrypted system laying around,
for example some cloud VM, which then can be started on-demand.
But only with your help, so nobody else can do this, as the system is bootable, but lacking everything to be booted.

But this also must work fully automatic.  Like this:

- Machine reboots
- Machine contacts the service
- Some app (something like an authenticator) asks you for permission
- You enter the code
- The machine gets the key and continues to boot

At least that is what I'd like to see, as this is the minimum requirement to make such an option worthwhile.

Much work ahead to gain this.  One stepstone is the next thing: Automatic Remote Key Management


## Automatic Remote Key Management

Some machines cannot or should not keep their own key.  However these machines still must be able to boot.

The idea here is, that they are able to pull the key from some external service.

There seem to be things like that out there.  However I did not come around to check them out.

So this still is T.B.D.

The idea here is:

- The Boot partition still is unencrypted.
- Everything uses encrypted filesystemd
- Some script provides the key

The problem is, that networking is not set up in InitRD.  However this is needed.  These are the ideas here:

- Use some own IP stack.
  - This is fully feasible as there are embedded TCP stacks out there
  - Hence the tool then can talk to the service and do everything
  - It can be statically linked, too.
- Use the kernel IP stack
  - However we have to cleanup thoroughly afterwards

I am undecided.


## Notes about parameters

If you are really paranoid about Quantum resistance, then you need to use `size=256` and `hash=sha3`.
(I never tested it.)

> Note that this is here based on what we know today.  Tomorrow, things may have changed already.

However I do not think this is worth the effort, as this here is not against powerful adversaries who,
by chance, can run an expensive quantum computer which might be available in 100 years or so,
but just to protect the data (so to fulfill what the law requires) against being accidentally recovered.

- `aes-xts-plain64` is the algorithm.  AFAICS this has the least number of flaws of all the available algorithms
- `size=256` choses AES256 over AES128.  AES128 should be faster and less power hungry.  But on my side it failed.
- `hash=sha1` choses SHA1 as the hash for the passphrase, which is usually faster and less power hungry than SHA2 or SHA3

> `plain64` is only needed for big drives above 1 TiB.  However it does not hurt much to use it even with smaller devices.
> Just be safe here, as you do not want that a key might be used two times and allows a delta attack.

You might think AES128 is insecure as this uses shorter AES and SHA1 is considered broken because there are collision attacks.

This is only partly correct.  AES128 is considered safe against conventional computers.
In certain situations it even has advantages over AES256.  Also AES128 should be faster than AES256.
And with storage, you want to reduce latency introduced by encryption.

SHA1 is known to be vulnerable to collision attacks.  So you can create two documents, which have the same SHA.

But SHA is not fully broken (yet):

- With a given SHA it still is very unlikely that you manage to create another document which matches the SHA
- You still cannot invert or predict it, even if used with smaller keys, so if it is used as a PRNG like here it is fully safe.

So to break the disk encryption, you have following problem:

- First, you must break AES.  Breaking AES128 should be hard enough until at least 2050.
- Second, if you manage to have cracked a sector, being able to crack another sector depends on the algorithm, not the SHA.
- SHA is only used to hash your passphrase to derive a key from it.

Hence the SHA only has a small impact of the safety of the encryption, as the major part still lies within AES.
And AES128 failed at my side, the above is probably the best choice  .. for now.

> Definitively do not use MD5 in a cryptographic area.  As it is probably easy to predict MD5 today.  I am not sure, but I think so.
