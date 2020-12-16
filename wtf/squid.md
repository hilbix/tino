# WTF Squid?

I am running Squid.  But perhaps I shouldn't.  Squid just told me to better stop using it.

WTF?  Well, this here happened:

APT cacher NG does it right:

```
# curl -v -D- http://192.168.0.1:3142/security.debian.org/dists/buster/updates/InRelease
* Expire in 0 ms for 6 (transfer 0x564077aaef50)
*   Trying 192.168.0.1...
* TCP_NODELAY set
* Expire in 200 ms for 4 (transfer 0x564077aaef50)
* Connected to 192.168.93.8 (192.168.0.1) port 3142 (#0)
> GET /security.debian.org/dists/buster/updates/InRelease HTTP/1.1
> Host: 192.168.0.1:3142
> User-Agent: curl/7.64.0
> Accept: */*
>
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< Content-Length: 65372
Content-Length: 65372
< Last-Modified: Tue, 15 Dec 2020 12:51:26 GMT
Last-Modified: Tue, 15 Dec 2020 12:51:26 GMT
< Content-Type: application/octet-stream
Content-Type: application/octet-stream
< Date: Tue Dec 15 22:01:40 2020
Date: Tue Dec 15 22:01:40 2020
< Server: Debian Apt-Cacher NG/3.2.1
Server: Debian Apt-Cacher NG/3.2.1
< X-Original-Source: http://security.debian.org/dists/buster/updates/InRelease
X-Original-Source: http://security.debian.org/dists/buster/updates/InRelease
< Connection: Keep-Alive
Connection: Keep-Alive

<
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256
```

SQUID gets it wrong:

```
# telnet 192.168.0.2 8080
Trying 192.168.0.2...
Connected to 192.168.0.2.
Escape character is '^]'.
GET http://192.168.0.1:3142/security.debian.org/dists/buster/updates/InRelease HTTP/1.1

HTTP/1.1 200 OK
Last-Modified: Tue, 15 Dec 2020 12:51:26 GMT
Content-Type: application/octet-stream
Content-Length: 0
Date: Tue Dec 15 21:58:39 2020
Server: Debian Apt-Cacher NG/3.2.1
X-Original-Source: http://security.debian.org/dists/buster/updates/InRelease
Age: 122
X-Cache: HIT from squid
X-Cache-Lookup: HIT from squid:8080
Connection: keep-alive

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256
```

**`Content-Length: 0`?!?  If Content-Length is 0, then no body must follow, but there is one coming from SQUID.

WTF is going on here?  How can this ever happen?
