> Perhaps also read `/usr/share/doc/cryptsetup-initramfs/README.initramfs.gz`
> as it gives you a lot of clues!

# Debian Encrypted Filesystems

Here I note some information about how to properly setup encrypted drives on Debian.

Note:

- This here is not to do encryption to protect against adversaries.
- This is just to protect the data in case a drive needs replacement.
- So be sure that the key is never present on the drive itself

This is exactly what I do here.


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
