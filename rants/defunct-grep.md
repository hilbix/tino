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
Even on a 32 Bit system.

Sigh.

Apparently it is time to
Time to create something, which really works again.

## Background

`grep` nowadays uses `mmap` to map the file.  WTF?  How can you possibly map a 16 EB file (supported by ZFS) into a 64 Bit address room?

Who is the one I need to slap in the face for this?  Either do some fallback, or just start to do sane things.

(And no, having a 15 EB file with some data behind is not insane, if it is supported by the filesystem!)
