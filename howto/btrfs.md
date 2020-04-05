> WTF WHY isn't there a concise HowTo for btrfs for people who know
> Linux very well, but have really no idea of `btrfs` yet?
>
> This here is for all those people, who want to know the gory details first.

# HowTo BTRFS

> **Warning!** [It's 2020 and BTRFS still is unstable.](https://btrfs.wiki.kernel.org/index.php/Status)

If you need protection against silent data corruptions and self healing mirrors (no, md copy is not self healing),
then you have 2 options:  ZFS and BTRFS.

> ZFS is more than just stable, offers zraid3 and, in general, and was better designed than BTRFS.  Period!  
> The only drawback is that ZFS is not part of the kernel, and you should neither boot from it no use it as root.
>
> My BCP is to have a normal system (whichever "normal" means) and put the ZFS (encrypted) pool onto `/home`.
> This works more than just well.  This was a crucial time- and lifesaver many times now!  
> (Also disable `ssh`-`root`-login and put one `ssh`-`sudo`-login on `/` for times `/home` is not mounted.)
>
> Note that, if BTRFS becomes more stable, I might start to recommend having `/` as BTRFS.
> This here works into that direction, as having a root FS which detects silent data corruption is overdue.

So on a system with only 256 MB RAM there is only one option:
BTRFS, as ZFS is not designed to run on systems with less than 1 GB RAM.
Do not even try ZFS with systems less than 1 GB, you have been warned.

> Why do not replace the system?  Because this cannot be done right now.  "right now" means "not before 2025 or 2030"

## Create

> I always assume you have LVM.  Because not having it means you are doomed and will hit deep shit in future.  Period.
>
> My current BCP for booting disks is (you will be delighted with this setup as soon as trouble hits you):
>
> - partition 1: 1 GB MD-RAID1 ext2 `/boot` with GRUB (ext4 on `/boot` is just wasted)
> - partition 2: 100 GB MD-RAID1 LVM PV (entire device on devices less than 250 GB)
> - partition 3: separate LVM PV for all the rest of the drive (in the same VG)
>
> Notes:
>
> - Use MD-RAID1 even if you have a single disk.  It does not hurt but helps in case you add a 2nd disk.  
>   Even on systems which only support 1 disk.  Because you can upgrade the system independent from setup then.
>
> - Do not use LVM mirroring for any boot relevant disks (including root).  You have been warned.  
>   Instead put it on partition 2, as the PV there is mirrored by MD.  Why?  GRUB refuses to access LVM mirrors.
>
> - Keep in mind that GRUB's `save_env` fails on MD/Mirrored devices.  
>   (My patches to enable that on a per-case basis, so you know it's insecure, were rejected by upstream.)
>
> - If you want encryption, use that over LVM (Hence: `MD -> PV -> LV -> LUKS -> FS`).  
>   [You can automatically unlock devices with cheap USB keys](https://github.com/hilbix/LUKS)

