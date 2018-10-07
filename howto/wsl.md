# Windows Subsystem for Linux

WSL is neat.  It obsoltes things like Git-Shell and CygWin.  Now you can run native Linux apps under Windows.
This here sums things which I was not aware easily.

> This currently is based on Windows 10 from September 2018

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
  `DEVICE: /mnt/DEVICE drvfs case=dir 0 0`

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
