# ZFS Hints

## Links

ZFS compression and speed:

- https://www.reddit.com/r/zfs/comments/svnycx/a_simple_real_world_zfs_compression_speed_an/
- https://www.reddit.com/r/zfs/comments/sxx9p7/a_simple_real_world_zfs_compression_speed_an/
- https://www.reddit.com/r/zfs/comments/t9cexx/a_simple_real_world_zfs_compression_speed_an/

## Snippets

### Create

```
apt install zfsutils-linux
zpool create zfs -o ashift=12 -O compression=zstd-10 -O checksum=sha256 -O dedup=sha256,verify /dev/sdb
for a in first second third
do zfs create zfs/"$a"; done
zfs snapshot -r zfs@protect
```

- `-o ashift=12` is a must to protect against accidental `ashift` of 9
- `-O compression=zstd-10` should never hurt
- `-O checksum=sha256` modern hardware has SHA built in
- `-O dedup=sha256,verify` YMMV, but deactivating it on demand seems better
