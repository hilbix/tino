Sigh, why do you always have to find out the hard way?  I try to be as concise as possible.

# Linux SystemTap

See also:

- https://sourceware.org/systemtap/wiki/
  - https://sourceware.org/systemtap/man/
  - https://sourceware.org/systemtap/examples/
- https://wiki.debian.org/SystemTap

## Getting started

Everything needs `root` as you are dealing with the kernel directly.
(Or `stap` group, but I do not like that, I rather use [my `suid` wrapper](https://github.com/hilbix/suid) instead.)

- `apt-get install systemtap systemtap-doc`
  - You can leave `systemtap-doc` away if you like if you rather read manpages online
- `stap-prep`
  - Ubuntu 20.04: This downloads (via `apt`) all needed debug symbols of the currently running kernel
  - **Warning** This puts 5GB+ under `/usr/lib/debug/`.  Per kernel, of course.
- `stap -v -e 'probe oneshot { println("Hello World") }'`
  - This is not instant and takes a while to compile and run.

## Probes

- [`man stapprobes`](https://sourceware.org/systemtap/man/stapprobes.3stap.html)
- `stap -L 'kernel.trace("filelock:*")'` list kernel's trace points matching the glob `filelock:*`
- `stap -L 'syscall.read*'` list all syscalls matching the glob `read*`
- `stap -L 'kernel.function("*name*")'` to list all kernel functions matching the glob `*name*`

- `stap -L 'process("/bin/ls").function("*user*")' list all functions matching the glob `*user*` of process `/bin/ls` (see `build-id` below)

## Debug symbols

The debug symbols also contain the function signatures, such that you can access the function call parameters.

- `/usr/lib/debug/boot/` location of the debug symbols of a kernel named after the kernel
- `/usr/lib/debug/.build-id/` location of the debug symbols of programs named after the `debug-id`

### `build-id`

- `readelf -x .note.gnu.build-id "$PROGRAM"` displays the `build-id` starting with the 2nd line of the hexdump
  - Sadly the output of `readelf` is hardly scriptable
- `/usr/lib/debug/.build-id/$X/$Y.debug` are the debug symbols of `$PROGRAM`
  - `$X` takes the first 2 hex digits, `$Y` takes the rest
- If the file is missing, you need to find it somewhere.
  - I have no idea (yet) how to create them yourself.
  - However they are created as `.ddeb` packages, when Debian packages are built

Example:

- `stap -L 'process("/bin/ls").function("*user*")'`  ([Source](https://wiki.debian.org/SystemTap))

# Example

To run an example, just save the code to a file and then run `stap file` or `stap -g file`, see the introducing comment.

## `kill.stp`

This lists all `kill`s and where they are coming from:

```
#!/bin/sh
//bin/true && exec stap "$0"

probe syscall.kill {
  if (sig)
    printf("kill %ld %ld(%s) from %s\n", sig, pid, pid2execname(pid), pstrace(pid2task(pid())))
}
```

Notes:

- Output looks like `kill 15 418881(tmux: server) from  systemd(12762)`
- [`pid()`](https://sourceware.org/systemtap/man/function::pid.3stap.html) is a builtin function while `pid` refers to the argument named `pid`.  A bit confusing?
- `syscall.kill name:string pid:long sig:long sig_name:string argstr:string` are the arguments,  
  listed with `stap -L syscall.kill`.  (See above.)

## `fsync.stp`

Dump `fsync`s going on:

```
#!/bin/sh
//bin/true && exec stap "$0"

probe kernel.function("do_fsync") {
  printf("fsync(%ld) %ld(%s) from %s\n", $fd, pid(), pid2execname(pid()), pstrace(pid2task(pid())))
}
```

Suppress `fsync`s of a given process (see above to list names):

```
#!/bin/bash
//bin/true && exec stap -g "$0" "${1:-beam.smp}" "${@:2}"

global ok, err;

probe kernel.function("do_fsync") { if (pid2execname(pid()) == @1) try { printf("%ld ", $fd); $fd=-1; ok++; } catch { err++ } }
probe kernel.function("do_fsync").return { if (pid2execname(pid()) == "beam.smp") try { $return=0; } catch { err++ } }

probe error,end { printf("ok=%ld err=%ld\n", ok, err); }
```

- `beam.smp` is the Erlang process.  I use this to speed up large CouchDB inserts on slow disks a factor of 100+
