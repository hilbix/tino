# Windows Subsystem for Linux

WSL is neat.  It obsoltes things like Git-Shell and CygWin.  Now you can run native Linux apps under Windows.
This here sums things which I was not aware easily.

> This currently is based on Windows 10 from September 2018

## Install

Enable developer mode, add component Windows Subsystem for Linux and from Windows Store install your favorite Linux Distro.

- `wslconfig` to configure

## Running WSL

WSL always runs from the Windows User.  Hence you cannot start it before a login.

> Find out how to run some WSL command
> - before the login
> - automatically after login
> - in background without console (not even a short time)

- `wsl.exe [command]` run command in standard Distro
- `DISTRO.exe [-c command]` run command in default shell of given `DISTRO` (does not work for Distro "Legacy")
- `bash.exe [-c command]` run `bash` in default Distro

The first invokement initializes WSL.  The later then reuses this environment.
