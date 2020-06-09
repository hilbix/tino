> Note that this might not be perfect yet.  As I am not very used to cgrules yet.
>
> In future I might improve this when I find the time to find out the exact internals.
>
> But what I write below works for me.  YMMV.

Disclaimer:  If you break it following this HowTo, I am not responsible for your action.


# Linux Control Groups

Linux Control Groups are extremely useful, for example to reduce the memory hunger of browsers and other things.

In my case I use it on small single CPU VMs to

- reduce the memory impact of badly designed background processes (like Chromium)
- increase the concurrenceness of processes running on the VM

It sounds odd to increase the concurrenceness by reducing the CPU percentage a process may consume.
But overall this is a good thing.  So processes with a high CPU demand still leave idle CPU for other concurrent actions,
which then can be fullfilled in a more timely manner.

## Ubuntu (Bionic) install

	apt-get install cgroup-tools cgroups-lite

- `cgroup-lite` mounts `/sys/fs/cgroup/` which gives fast filesystem based overview of your cgroups and settings.  
  It is basically just for orientation to easily look into it and what's running currently.
  
- `cgroup-tools` is what you need to use what you find below

`cgroup-tools` installs a bundle of helper tools.  Until now I did not find them very useful compared to `/sys/fs/cgroup/`.
However this also enables the configuration files to load the cgroup-setting at boot time.
And that's the important thing we need.


## `/etc/init/cgroup-lite.conf`

This looks like a configuration script but isn't.  Leave it alone.  It mounts `/sys/fs/cgroup/`


## `/etc/cgred.conf`

See also `man cgred.conf`

> I have no idea how these settings are applied to `cgrulesengd` or if they are needed at all.

It's a bit irritating that all following files do not come pre-installed (with a `.dpkg-dist` or something)
and hence do not seem to be associated with any package.  But they belong to `cgroup-tools`, as this package
installs the manual pages for them.

However as there are no samples, you need to re-invent them on your own each time.  WTF WHY?

But perhaps this is a good thing, too.  This way you could create your own Debian package to roll out to your own
machines (not that it would be easy to use overrides, though).

`/etc/cgred.conf`:
```
CONFIG_FILE="/etc/cgrules.conf"
NODAEMON=""
#NODAEMON="--nodaemon"

SOCKET_USER=""
SOCKET_GROUP=""

LOG=""
#LOG="--nolog"
LOG="-v"
```


## `/etc/cgrules.conf`

See also `man cgrules.conf`

> I have no idea if it still works if you rename this file.  So better stay with the name as-is.

`/etc/cgrules.conf`:

```
#<user>		<controllers>		<groups>
root		*			default
*		cpu,memory		all
```

This applies the `default` CG to `root` processeses,
and the `all` control group to all other users.

This is usually what you want.

> It's a bit clumsy, though, as we need to specify a `root` rule instead of having something like "anything but root".
>
> But there is no other way to exclude `root` processes from the `all` CG.
>
> Also note that you must use the name `root` here, which is clumsy as well,
> in case you renamed `root` to something else.
> But (according to documentation) straight forward and clear to understand exact and never to mistaken things like
> a UserID cannot be used here.  Very bad design whereever you look.  Sigh.

**How CGs are implemented is a big pile of extremely smelly and most ugly mess:**

You cannot use certain names.  For example the `default` CG already is taken by the system.
Some other CG names like `tasks` or `root` are forbidden as well.  However, all that is not documented at all,
and if you stumble upon such a name, this leads to some cryptic completely misleading error messages
in different situations, with no help whatsoever.  And the list of forbidden names might change any time.

You have been warned.


## `/etc/cgconfig.conf`

See also `man cgconfig.conf`

> I have no idea how this file comes into play.

This file defines the control groups.  The following example is from a VM with 1 Core (single thread) with 2 GB of RAM.

Hence:

- A single process can only eat 50% of the CPU
- And a single process cannot eat up all of the RAM but leaves 500 MB for the System to avoid swapping.

Note that Chromium works with this most times.  However from now and then it crashes, because today
1.5 GB seems to be too few RAM to handle even the most primitive pages (like a blank page) today.
Go figure.  (I have no problem with such excess memory crashes, because else the machine would vanish
into swapping hell for several hours before recovering.)

`/etc/cgconfig.conf`:

```
group all {
  cpu {
    cpu.cfs_period_us=100000;
    cpu.cfs_quota_us=50000;
  }
  memory {
    memory.limit_in_bytes = 1500m;
  }
}
```

Notes:

- `cpu.cfs_period_us=100000` is the default.


## After you changed things

There is no command to apply the changes.  At least it is not documented.  Of course not.

Here is how I apply things:

```
reboot
```

SIC!  Thanks to SystemD I did not find another way, as SystemD hogs on the CG mount and does not allow us to alter
anything, besides when the system boots.

If you find a way to apply above files **properly** (this is:  Regardless what you have changed,
the result is exactly the same as if you did a reboot), then please let me know (Issue on GH here).
Thanks!
