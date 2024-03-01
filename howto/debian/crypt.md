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
swap	/dev/vg/swap	/dev/urandom	cipher=aes-xts-plain64,size=128,swap
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
swap1	/dev/vg0/swap1	/dev/urandom	cipher=aes-xts-plain64,size=128,swap
swap2	/dev/vg0/swap2	/dev/urandom	cipher=aes-xts-plain64,size=128,swap
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

If PVs are on LUKS this means, you will not even see what is in the PVs.

> T.B.D.


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
