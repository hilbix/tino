# Linux Namespaces

Well, there are two beasts.  Control Groups and Namespaces.  They are mostly additive.  However things are implemented very confusingly!

# Control Groups

> See: `/sys/fs/cgroup/` and `cat /proc/$$/cgroup`

With Control Groups you can manage ressources (this is incomplete, as I am still puzzled):

- 1:`name` (I really have no idea)
- 2:`cpuset` (I really have no idea)
- 3:`hugetlb` (I really have no idea)
- 4:`cpu,cpuacct` (I really have no idea)
- 5:`blkio` (I really have no idea)
- 6:`freezer` (I really have no idea)
- 7:`memory` limit the memory usage - this is especially handy with firefox, which loves to eat multiple times the available RAM if not limited
- 8:`net_cls,net_prio` (I really have no idea)
- 9:`perf_event` (I really have no idea)
- 10:`pids` (I really have no idea)
- 11:`devices` (I really have no idea)

# Namespaces

> See: `???` and `ls -al /proc/$$/ns/`

Namespaces allow to partition the hardware as well as to virtualize the kernel without virtualization.
It is what containers are made of.

Following namespaces exist (I have really no idea how this corresponds to `cgroups`!):

- `cgroup` (I really have no idea)
- `ipc` separated shared memory.  It also separates System V message queues (whatever this is) and semaphopres (I know what semaphores are, but I do not know what they refer to in this context)
- `mnt` this allows processes to have another root and even see another mount table.  This is like `chroot` on steroids.
- `net` can define your own virtual IP stack, which involves everything:  Separate loopback, routing, firewall, sockets, etc.  This way two processes can even listen on the same port on the same IP without trouble.
- `pid` limit what processes see in `/proc/`.  This allows processes to run better isolated, as processes in different `pid` namespaces cannot see each other.
- `user` allows to have different user tables.  This mainly is to allow a different set of capabilities.  (Perhaps there is some user-mapping to, I will see.)
- `uts` the process sees different `hostname` and `domainname` (this affects the kernel calls, not the filesystem!)

## Namespace `net`

With `net` you can create virtual IP stacks.  And you can assign physical interfaces to those stacks.  One physical interface can only be in a single namespace, though.

AFAICS if you need to share things, you need to create virtual interfaces and route between those interfaces.
Or all processes which need the interface must be in the same namespace.

## Namespace `pid`

AFAICS `pid`-namespaces do not increase the limit of available processes.  So all namespaces still share the same process table.
And a single PID can only be present in one of the namespaces.

The only thing is, that another namespace cannot see and cannot access the process space of the other namespace.
As they are separate.

Note:

- The newly run (`fork()`ed) process (the child) will become PID 1 in it's new namespace, taking over the role of `/bin/init`.  (This is impossible without `fork()`.)


## Common commands

- `cgcreate` etc.:  Forget about those.  They might be nice.  Perhaps they are portable.  But they are far too complex to understand.  There is a better way.
- `unshare`: This is the command to create and enter namespaces.  You cannot move existing processes into namespaces, because this would rise the need to force taking away things from a process which might make them fail.  Instead there must be a `fork()` to enter a namespace.
- `nsenter`: T.B.D.
- `setns`: T.B.D.

### Managing cgroups

Managing cgroups is better done directly via the filesystem.  This is less error prone, more easy to understand and you do not need to learn a newer syntax.

Have a look here: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/starting_a_process

Also look into the example section of `man 5 cgconfig.conf`.  Compare the really puzzling syntax with the easy to understand commands shown in this example section which result from these complex setups.

(It's similar on how Puppet does things, compared to some some easy batch file which just presets the firewall in a predictable way.)


# Howto

## Limit memory

Following
- creates cgroup `memlimit`
- Sets a 3GB RAM limit
- Allows an additional use of max 3GB of swap space.  Note that this means, it can occupy up to 6GB in swap if everything is swapped out.
- And dynamically reduces the RAM consumption to 1GB in case there is memory pressure

```
NAME=memlimit
mkdir /sys/fs/cgroup/memory/$NAME
echo 3G > /sys/fs/cgroup/memory/$NAME/memory.limit_in_bytes
echo 6G > /sys/fs/cgroup/memory/$NAME/memory.memsw.limit_in_bytes
echo 1G > /sys/fs/cgroup/memory/$NAME/memory.soft_limit_in_bytes
```

Now let the current `/bin/bash` join this group and fork `firefox`:

```
sudo bash -c 'echo $1 >> /sys/fs/cgroup/memory/memlimit/tasks' . $$
firefox
```

Here is a `suid` rule (for my tool [suid](//github.com/hilbix/suid)) which limits the current process to this 3G rule:

```
mem3:::::/:/bin/bash:-c:NAME=/sys/fs/cgroup/memory/memlimit; mkdir -p $NAME; echo 3G > $NAME/memory.limit_in_bytes; echo 6G > $NAME/memory.memsw.limit_in_bytes; echo 1G > memory.soft_limit_in_bytes; echo $PPID >> $NAME/tasks
```
