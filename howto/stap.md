Sigh, why do you always have to find out the hard way?  I try to be as concise as possible.

# Linux SystemTap

See also:

- https://sourceware.org/systemtap/wiki/
- https://sourceware.org/systemtap/man/
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

To run an example, just save the code to a file and then call `stap file`.

## `kill.probe`

This lists all `kill`s and where they are coming from:

```
probe syscall.kill {
  if (sig)
    printf("kill %ld %ld(%s) from %s\n", sig, pid, pid2execname(pid), pstrace(pid2task(pid())))
}
```
