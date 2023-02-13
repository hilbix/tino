# SystemD `.mount`

I always assume that you use `bash`

## Create a mount

> Before mounting WebDav, ([be sure to have it configured it correctly!](../webdav.md).
> Else DAVfs2 **will** destroy data!  (I am not sure it even works reliably, though.)


```
TYP=davfs
SRC=http://127.0.0.1/pub/
DST=/srv/samba/dav
OPT=uid=1000,gid=1000,file_mode=0664,dir_mode=2775,grpid

UNIT="$(systemd-escape --suffix mount "${DST#/}")" &&

cat >"/etc/systemd/system/$UNIT" <<==EOF==
[Unit]
Description=Mount $DST
After=network-online.target
Wants=network-online.target

[Mount]
What=$SRC
Where=$DST
Options=$OPT
Type=$TYP
TimeoutSec=15

[Install]
WantedBy=multi-user.target
==EOF==

systemctl daemon-reload
systemctl enable "$UNIT"
systemctl start "$UNIT"
```
