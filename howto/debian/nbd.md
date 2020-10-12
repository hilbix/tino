> This was tested for Ubuntu 20.04 with kernel 5.4.0-42-lowlatency:
>
>     ii  nbd-client     1:3.20-1     amd64        Network Block Device protocol - client
>     ii  nbd-server     1:3.20-1     amd64        Network Block Device protocol - server
>
> YMMV, looks like things changed a recently.


# HowTo nbd

    SRC=file-you-want-to-export
    sudo nbd-server 127.0.0.1:7777 "$(readlink -e "$SRC")" -d -C/doesnotexist -c

    sudo nbd-client 127.0.0.1 7777 -nofork


## WTF why?

- I have an LVM image file I want to export residing on zfs-fuse
- I want to mount the image readonly, such that it is not accidentally destroyed.
- But LVM requires full write access if you need a command like `lvchange -a` or `lvreduce --missing`.
- So I tried `losetup` from a cloned ZFS snapshot of the image file
- But this fails, because **`losetup` exports ZFS (FUSE) files implicitely readonly**

Complete Fail!  So this needs `nbd` to the rescue.

But .. I really do not understand what was done to `nbd`.  In the 1990s it was easy to use.
Today it became a real monster you have to workaround.  WTF!?!  Nothing is straight forward anymore.

Even worse, all the examples fail utterly.  Those in the local manual pages.  WTF?!?


## But this looks easy!

It isn't, because the manual pages are misleading or wrong.
Here are the list of bugs encountered with these dirty little bastards:

> I usually like bastards!

- `nbd-server -C/doesnotexist` disables configuration.  Yes, you have to specify a nonexisting path.
  - Else weird things can happen, because `/etc/nbd-server/config` might overwrite your precious commandline!
- `nbd-server -d` keeps the server in foreground
  - Some people warned about SystemD, right?  SystemD unconditionally kills unknown background processes on logout.
  - As we want run on-demand without SystemD interfering, we keep things simple and run in foreground.
  - Keep it this way, as this reminds you not to logout.  Do not try to cheat, SystemD never forgives.
- You need to give the full path to `nbd-server`.  Why?  I really have no idea!  Especially because:
- `nbd-server` does not loop in this configuration.  If the client disconnects, `nbd-server` terminates.
  - This probably is even exactly what we want in this situation.
  - However I would expect that it allows reconnection, in case something breaks unexpectedly.
- `nbd-server -c` prevents that the client writes to the `$SRC` file
  - This is an important option here.
  - If you leave it away, writes go to the target (in case you need that).
- `nbd-server` spits out a warning which is .. irritating a bit
- I did not manage to give the `nbd`-device to `nbd-client` - it always fails for some unknown reason.
  - The examples from manual pages did not work.  None.
  - Hence you will have a hard time if you want to script things.
- The used device is output to `stdout`, but .. only in human readable format!
  - The output also contains a lot of warnings and the perhaps interesting stuff (like the size) is difficult to parse.
  - `LC_ALL=C` is your friend if you try to script it!
- `nbd-client` apparently ignores the `-nofork` option.
  - `nbd-client` hands the connection over to the kernel.
  - Then there is nothing more to do.
  - But why is there such an option if it is not implemented?
  - `nbd-client` spits out warnings for really nothing, but in this case .. deaf and mute!

And:

- `nbd-server IP:port` but `nbd-client IP port`.  Lacks symmetry.
- `nbd-client` allows to connect to Unix Domain Sockets natively.
- `nbd-server`, however, seems to not support those Unix Domain Sockets directly.
- `nbd-server` can talk to `STDIN`/`STDOUT` (`inetd`-mode) as the connection.
  - But `nbd-client` doesn't.

This is what I would expect to be possible (this is not difficult to archive):

    nbd-client /bin/nbd-server -c - file

This is fully autodetectable:

-`nbd-client` sees a path which must be something that exists
  - if a Unix Domain Socket, this is used
  - if some executable file, the rest of the commandline are arguments to the command.
  - In that case a socketpair/pipe-pair is created as `STDIN` for the forked command.
- `nbd-server` sees a `-` and knows it must run in foreground from `STDIN`
  - This also disables configuration file if not specified with `-C`
  - And the `file` now can be a relative path name

Easy and very straight forward.


## Example

```
# nbd-server 127.0.0.1:7777 "$(readlink -e "$SRC")" -d -C/doesnotexist -c

** (process:281628): WARNING **: 22:52:21.420: Specifying an export on the command line no longer uses the oldstyle protocol.
```

```
# nbd-client 127.0.0.1 7777  -nofork                                                                                                 
Warning: the oldstyle protocol is no longer supported.                                                                                            
This method now uses the newstyle protocol with a default export                                                                                  
Negotiation: ..size = 61054MB                                                                                                                     
Connected /dev/nbd1                                                                                                                               
# partprobe /dev/nbd1
# pvdisplay /dev/nbd1p2
```
snip
```
# vgreduce --removemissing --force $VG
```
hopefully not too many error printed here
```
# vgchange -ay $VG
```
Yay!  We now can look into the remaining LV mirror legs undisturbed!  Wasn't that easy?  .. not!
```
# nbd-client -d /dev/nbd1
```

`nbd-server` exits.

However I'd rather like to `^C` the `nbd-client` which should make it detach and the server exit.
And vice versa.  But I found no way for this.

> The idea here is to easily synchronize / retry if something breaks,
> because this principle even works over the network (the `n` of `nbd`).
>
> And - as you are looking for this solution here - this probably means,
> something already broke!  Do you want things to break even more?
>
> YMMV.
