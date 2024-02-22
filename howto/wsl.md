# Windows Subsystem for Linux

WSL is neat.  It obsoletes things like Git-Shell and CygWin.  Now you can run native Linux apps under Windows.
This here sums things which I was not aware easily.

## Current

Now Win11 is out and WSL2 should be your standard

	wsl --set-default-version 2

On Win11 it offers X11 compatibility.  Sorry, I haven't tested this feature yet.

### WSL without Microsoft Store

I found a problem if you have disabled Micrsoft store.  In that case you will see some strange error that some service isn't started.  (This is the missing store and Installer from store.)

In that case you still can use the default Linux etc. applicatons from Microsoft.  You just have to download and install them yourself.  As follows:

- Go to <https://docs.microsoft.com/en-us/windows/wsl/install-manual>
- Scroll downward to the Distributions
- Scroll downward to the Download area of the Distributions (sic!)
- Click on the download you need.

This will download some `.appxbundle` or `.appx` file (depending on what you download).

First, **verify the authenticity** of the download

- Go to your download directory
- Upload the file to <https://virustotal.com> (it isn't uploaded, it just hashes the file and compares it to the last known scan)
  - **Only proceede if everything is sound and safe!**
- Then right-click on the downloaded file (`.appx` or `.appxbundle`)
  - Choose "Details" ("Eigenschaften" in German, sorry, I have no english Windows)
  - Look at the "Digital Signature" tab for a valid signature
- Note that the signature can look a bit confusing, it might be something like an ID which is meaningful only when Microsoft Store is installed
- If the signature is valid, start the downloaded, but do not click furter!
  - This won't start the file, first you will get some prompt to verify this is legitimate
  - This is exactly the prompt we want to look at
- A prompt shows up which shows the legitmate creator.
  - Here you will se something which is readable by ordinary humans (usually)
  - Be sure to verify it is authentic.
  - Close this prompt.  **Do not install here!**

If it is an `.appxbundle`:

- Unpack it (into some directory).  I recommend to use [`7-zip`](https://www.7-zip.org/).  Perhaps others work, too.
- Now you will see several `.appx` files
- Choose the `.appx` which is right for your platform
  - If in doubt look at the size of the files.  It always is a very very big one.
  - Nowadays you will usually see something like `_x86` in the file's name

Now to the `.appx` file:

- Unpack the `.appx` file into some directory
  - I still recommend to use [`7-zip`](https://www.7-zip.org/).  Perhaps others work, too.
- In the directory you will see several `*.exe` files
  - Choose the right one
  - If in doubt, it is the bigger one
  - for `Debian` the file is (usually) `debian.exe`, for Ubuntu it is `ubuntu.exe` and so on.

This creates a `ext4.vhdx` file somewhere on your filestystem (as usual the details are very well hidden from the user).
The directory where this file is installed is the distribution.  The whole directory.  Even that there is only the single file in it.

> You cannot rename `ext4.vhdx`.


### Move the distribution

Well, you do not want the `ext4.vhdx` where it is?  Sadly there is no easy way to move this file.

> You can deregister the Distro, move it and re-register it using `wsl.exe`.  But this is a bit difficult.

The way to go is:

- Shutdown `wsl`, so it unlocks the container (`ext4.vhdx`)
- Move the container
- Alter the path with `regedit.exe`

The first step is:  **WARNING** this stops all WSL processes unconditionally!

	wsl --shutdown

Now you can move the `ext4.vhdx`.

> Note that it is a sparse file, so not all data is allocated.
>
> Dumb copy programs might copy the empty sectors as well, which might take very long (and you might run out space unexpectedly)
>
> For example I had a 250 GB `ext4.vhdx` on a 120 GB drive.  It fitted there because the real used data was below 4 GB.

Now open `regedit.exe`:

- Navigate to `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\`
- You will see all your installed WSL distributions with their GUIDs
  - Find the GUID with a string variable `BasePath` pointing to the old location
- Adjust `BasePath` to the new path.
  - This variable points to the directory, not the `ext4.vhdx` file!



### Compact `ext4.vhdx`

The container file only grows.  To shrink it again, you need some compaction program.

> This only works when your distro is not running and WSL does not keep the file open.
>
> Either use `wsl --shutdown`, or use `wsl -t distribution`.  **Warning** This stops all WSL processes from the affected distributions.

See also <https://docs.microsoft.com/en-us/windows/wsl/vhd-size>

- Open PowerShell
- Run `diskpart` program
- Enter `select vdisk file="FULL-PATH-TO-YOUR-DISTRO\ext4.vhdx"`
- Enter `compact disk`

The path to your `ext4.vhdx` can be found with Explorer or `regedit.exe` (see above)

> Certainly there is a better way to do it with PowerShell, but I do not know, sorry.


## Use Windows Terminal

> This here is **not needed** if you install Windows Terminal from Store.
> 
> However it might be that you have no Store (because it was disabled).

Windows Terminal is working right.  So use it.  You do not need something like Putty for a sane terminal emulation under Windows.

- Go to the Release area of GitHub for Windows Terminal: <https://github.com/microsoft/terminal/release>
  - GitHub is owned by Microsoft these days.  Do not wonder why the download is there.  It's Open Source!
- Chose the version to download
  - These days you do not need the Preview anymore, the normal one is good enough
  - There are different versions for different Windows versions, be sure to pick the right one
- Download the `.mixbundle`
- Verify it is authentic
  - In the details of the download you will find the digital signature of Microsoft!
- Unpack the file (see above)
- Chose the correct `.msix` file for your platform (usually `_x64`)
- Unpack the `.msix`
- Everything can run from there
  - use `wt.exe`

If you have trouble after upgrading:

The error messages are often quite a bit misleading.  For example WT 1.1 used `~` as Home-Path,
WT 1.15 refused to start the configured program.  Changing the settings for the start directory to `%USERPROFILE%` did the trick here. 

YMMV.

---------

Below might be outdated, because it was written for WSL 1

---------

## Install

> This currently is based on Windows 10 Build 17713 (from October 2018, you might need to enable insider preview)

See also:

- https://docs.microsoft.com/en-us/windows/wsl/about
- https://blogs.msdn.microsoft.com/commandline/tag/wsl/

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

> TODO:
>
> Find out how to run some WSL command
> - before the login
> - automatically after login
> - in background without console (not even a short blink)

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

    OPTION      Flag=off     Flag=on     Flag set on creation
    case=off    insensitive  sensitive   off
    case=dir    insensitive  sensitive   on
    case=force  sensitive    sensitive   on

Commands to alter the per-directory flag (`Flag=` in the above table):

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


## Misc

- Unix-Sockets under Windows https://blogs.msdn.microsoft.com/commandline/2018/02/07/windowswsl-interop-with-af_unix/
