# What I learned today

Today I learned, that `grep`, one of the probably most often used tool in Linux is now defunct.  **It simply does not work anymore.**

Here is how to prove:

```
truncate -s 8E test    # if this fails, get something that works.
echo $'\nHello World' >> test
grep -i hello test
```

KABOOOM.

What I would expect is that it prints "Hello World" within a millisecond.
Even on a 32 Bit system.  On a 32 Bit system you can proof it as follows:

```
truncate -s 1T test    # if this fails, get something that works.
echo $'\nHello World' >> test
grep -i hello test
```
gives
```
Memory exhausted
```

Sigh.  Conclusion:  **You can no more rely on `grep` doing the job!**

Apparently it is time to create something, which really works.  As usual.

(Note that `/bin/cp` is no more up to it's job either.  If you try to copy some file which fails on the 0th byte,
this might be taken as EOF, and `cp` returns success instead of failing.  I once stumbled upon this.)


## Background

`grep` nowadays uses `mmap` to map the file.  WTF?  How can you possibly map a 16 EB file (supported by ZFS) into a 64 Bit address room?

Who is the one I need to slap in the face for this?  Either do some fallback, or just start to do sane things.

(And no, having a 15 EB file with some data behind is not insane, if it is supported by the filesystem!)
