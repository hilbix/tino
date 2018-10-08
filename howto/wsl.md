# Windows Subsystem for Linux

WSL is neat.  It obsoltes things like Git-Shell and CygWin.  Now you can run native Linux apps under Windows.
This here sums things which I was not aware easily.

> This currently is based on Windows 10 Build 17713 (from October 2018, you might need to enable insider preview)

See also:

- https://docs.microsoft.com/en-us/windows/wsl/about
- https://blogs.msdn.microsoft.com/commandline/tag/wsl/

## Install

See https://docs.microsoft.com/en-us/windows/wsl/install-win10

- Enable optional WSL
- Install `DISTRO` (for example from Store)
- Run it once (`DISTRO.exe`) to setup

> https://docs.microsoft.com/en-us/windows/wsl/wsl-config

- `wslconfig` to configure
- `/etc/wsl.conf` (under Linux!) allows to configure startup settings
- Note that `/etc/fstab` is honored by default  
  `DEVICE: /mnt/DEVICE drvfs case=dir,metadata 0 0`

## Running WSL

WSL always runs from the Windows User.  Hence you cannot start it before a login.

> Find out how to run some WSL command
> - before the login
> - automatically after login
> - in background without console (not even a short time)

- `wsl.exe [command]` run command of standard Distro in current directory
- `bash.exe [-c command]` run `bash` in default Distro in default User's directory
- `DISTRO.exe [/?]` configuration/control of `DISTRO`.  Runs in the default User's directory
- `lxrun.exe` configuration for "Legacy" Distro

The first invokement initializes WSL.  The later then reuses this environment.

## `drvfs`

> Currently only full drives can be mounted, not a sub-path of a drive

    mount -o OPTIONS DEVICE: /mnt/DEVICE

or `/etc/fstab`

    DEVICE: /mnt/DEVICE drvfs OPTIONS 0 0

- `DEVICE` is the Device letter
- `OPTIONS` is a comma separated list of options

Following `OPTIONS` exist:

- `case=CASE` https://blogs.msdn.microsoft.com/commandline/2018/02/28/per-directory-case-sensitivity-and-wsl/
- `metadata`  https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/
- `uid=UID` user of all files
- `gid=GID` owner of all files
- `umask=MASK` like `umask` but for file mode bits (r and w are deduced by the Windows setting, x is always set)
- `fmask=MASK` like `umask` but for normal files
- `dmask=MASK` like `umask` but for directories

Example `/etc/fstab`:

    C:      /mnt/c  drvfs   case=dir,metadata,uid=0,gid=0,fmask=0133,dmask=022 0 0
    D:      /mnt/d  drvfs   case=dir,metadata,uid=0,gid=0,fmask=0133,dmask=022 0 0

### Option `case=`

    OPTION      Flag=off     Flag=on     Flag creation
    case=off    insensitive  sensitive   off
    case=dir    insensitive  sensitive   on
    case=force  sensitive    sensitive   on

Commands to alter the per-directory flag:

    off:    fsutil.exe file setCaseSensitiveInfo DIR disable
    on:     fsutil.exe file setCaseSensitiveInfo DIR enable
    query:  fsutil.exe file queryCaseSensitiveInfo DIR

The flag is not inherited.  `DIR` for `fsutil.exe` is the Windows path, not the Unix one.

## `/etc/wsl.conf`

https://docs.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings

`[automount]`
- `enabled = true` mount all fixed drives (options may be overridden with `/etc/fstab`)
- `enabled = false` do not automatically mount fixed drives
- `mountFsTab = true` use `/etc/fstab`
- `mountFsTab = false` ignore `/etc/fstab`
- `root = "/mnt"` where to automount drives (under the drive's letter)
- `options = "OPTIONS"` use the given mount options

`[network]`
- `generateHosts = true` create `/etc/hosts`
- `generateHosts = false` leave `/etc/hosts` as-is
- `generateResolvConf = true` create `/etc/resolv.conf`
- `generateResolvConf = false` leave `/etc/resolv.conf` as-is

`[interop]`
- `enabled = true` allow launching windows processes from within WSL
- `enabled = false` windows processes cannot be launched from WSL
- `appendWindowsPath = true` add windows paths to `PATH`
- `appendWindowsPath = false` do not add windows paths to `PATH`

Disable/Enable/Check interop per-session:

    echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop
    echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop
    cat /proc/sys/fs/binfmt_misc/WSLInterop

## Environment `WSLENV`

- https://docs.microsoft.com/en-us/windows/wsl/interop#share-environment-variables-between-windows-and-wsl
- https://blogs.msdn.microsoft.com/commandline/2017/12/22/share-environment-vars-between-wsl-and-windows/

The environment variable `WSLENV` lists all ENV variables to share between Windows and WSL:

- Colon separated entries.  Example: `WLSENV=PATH/ul:HOME/p:LOGNAME/w`
- Entry is `VARNAME` or `VARNAME/FLAGS` where VARNAME is the name of the evnvironment variable

`FLAGS` is a combination of following characters:
- `p` translate path from/to Windows format (like: Path)
- `l` environment variable is a list of PATHs (like: List WSL: `A:B:C`, Windows: `A;B;C`)
- `u` variable is only passed from Win to WSL (like: To Unix)
- `w` variable is only passed from WSL to Win (like: To Windows)
