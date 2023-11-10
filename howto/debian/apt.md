# HowTo apt

Some quirks about `apt`

## `apt` maintainers [enable PDiff against your will](https://lists.debian.org/deity/2016/10/msg00037.html)

Nowadays there is some rule in Debian which re-enables PDiffs for content files even if they are globally disabled.

> They say, this needs to be enabled by default.
>
> However for me this claim seems to be entirely wrong:
>
> AFAICS PDIFFs thwart caching.  Thanks to caching, downloading even 1 GB file takes less than a second on my 10 GBit network.  (Can anybody please enlighten me how to allow `apt-cacher-ng` to process PDiffs correctly with absolutely no bugs ahead?)
>
> Also Devices use battery power to reassemble the compressed content files.  AFAICS it drains much less power when they download the big files from the cache and process them afterwards.  (Can anybody please enlighten me how to test my claim?)

Here is how to disable PDiffs for now and in future (until they find some new way to again decide against us):

```
//usr/bin/apt-config dump | sed -n '/::PDiffs/s/"true"/"false"/p' >> /etc/apt/apt.conf.d/99proxy
```

Why `99proxy`?  Because it now initially looks like this at my side:

```
//usr/bin/apt-config dump | sed -n '/::PDiffs/s/"true"/"false"/p' >> /etc/apt/apt.conf.d/99proxy; [ 99proxy = "${0##*/}" ] && exit
Acquire::Pdiffs "false";
Acquire::http::Proxy "http://192.168.0.1:3142";
```

> Note: The first line allows to run `bash /etc/apt/apt.conf.d/99proxy` and does not hurt if copy and pasted.   I like it easy.

With `apt-cacher-ng` running on port 3142.  This also works for `https://` targets by running

```
sed -i 's|https://|http://HTTPS///|' /etc/apt/sources.list.d/*
```

For example `/etc/apt/sources.list.d/mozillateam-ubuntu-ppa-jammy.list` then looks like this:
```
deb http://HTTPS///ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ jammy main
# deb-src http://HTTPS///ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ jammy main
```


## `apt-key update` does no more work

Symptom after some debian-buster-minimal install:

```
# apt-get update
Get: 1 http://deb.debian.org/debian buster InRelease [121 kB]                                                                                              
Err http://deb.debian.org/debian buster InRelease                                                                                                          
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517    
Fetched 121 kB in 0s (331 kB/s)                                                                                                                                              
W: GPG error: http://deb.debian.org/debian buster InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBK
EY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517                                                                                                    
E: The repository 'http://deb.debian.org/debian buster InRelease' is not signed.                                                                           
E: Failed to download some files                                                                                                                                             
W: Failed to fetch http://deb.debian.org/debian/dists/buster/InRelease: The following signatures couldn't be verified because the public key is not availab
le: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517                                                                                         
E: Some index files failed to download. They have been ignored, or old ones used instead.                                                                                    
```

And

```
# apt-key update
Warning: 'apt-key update' is deprecated and should not be used anymore!
Note: In your distribution this command is a no-op and can therefore be removed safely.
```

Well, it only feels like 250% of all Internet tutorials about `apt NO_PUBKEY` reference `apt-key update`.
Hence it seems logical that you cripple it.  Wohooo!  Very well done!

> Spoiler: This was sarcasm.
>
> Me thinks SystemD has gone a bit too viral now, no?
>
> BTW, this was zynism.

The trick is, to do it as follows now:

```
# apt-key add /etc/apt/trusted.gpg.d/*.gpg
OK
```

Now it works:

```
# apt-get update
Get:1 http://deb.debian.org/debian buster InRelease [121 kB]
Get:2 http://deb.debian.org/debian buster/main amd64 Packages [7906 kB]
Get:3 http://deb.debian.org/debian buster/main Translation-en [5968 kB]
Fetched 14.0 MB in 3s (5563 kB/s)
Reading package lists... Done
```

A last word to say:  **WTF?!?**
