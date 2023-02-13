# Short SAMBA howto

The steps to create a public writeable samba share is not straight forward.

## Install

```
apt install samba
```

## `/etc/samba/smb.conf`

It is 2023, and still Samba has no way to be configured easily using separated configuration files.  Sigh.

- In the `[global]` section:
  - Change `workgroup = WORKGROUP`
  - Add `guest account = ACCOUNT` where `ACCOUNT` must be an existing Unix name.  No Unix ID allowed here.  (It's 2023 and still .. sigh)
- Disable all other sections in the file
  - You do not need them.
  - Usually.
- Add your section, something like following

```
[pub]
path            = /srv/samba/dav
browsable       = yes
writeable       = yes
read only       = no
create mask     = 0777
directory mask  = 0777
public          = yes
guest ok        = yes
guest only      = yes
```

Then

```
systemctl restart smbd
```

Now it should work as expected.


### What does this do?

Well, in my Intranet I want to have a public writable file share.

- It must be publicly available
- No user names
- No passwords
- Writable over any standard

This fileshare is backed by SVN base WebDAV.  SVN is able to bring back all files and all intermediate versions of a file.

> This is mainly not to protect against vandals, it is to protect against vandalism .. from software bugs.  But also vandals and similar.

The problem is, that Windows apparently dislikes WebDAV (I did not get it to mount).  Hence I need another way.  This is Samba.

> Perhaps this is because WebDAV is not served via HTTPS.  I am in my Intranet.  I do not need encryption or trust.

This way it works as follows:

- SVN keeps the data secure
- Apache serves WebDAV from SVN
- Nginx maps the Apache into the web tree
- DAVfs2 mounts the WebDAV share
- Samba then serves the mount

> It's 2023 and still .. sigh.

See also:

- [WebDAV](webdav.md)
- [SystemD mount](systemd/mount.md)
