> This is not yet verified, I might miss something

See also:

- [Disable fsync() on to dramatically speed up CouchDB write speed](stap.md)
- [Secure tunnel to CouchDB using HaProxy](haproxy.md)

# CouchDB

CouchDB or MongoDB?  Well.  Both are NoSQL document stores.
Both have several unique features.  Both are Open Souce.
Both claim to scale.  Both can be run without authentication whatsoever (so any anonumous user gets RW access).

Why the latter?  Because user-management on these databases sucks.  Period.

- These databases have no support for PAM, NIS, Kerberos, Radius.
- Note that this does NOT mean you should give anonymous administrative access.  But data acess usually runs very well without any authentiation.

PRO for MongoDB:

- Backed by a Company (if you need commercial support).
- Good support for different multiple databases
- IPC support
- Good documentation
- GeoLocation search

PRO for CouchDB:

- CouchDB is real Open Source while MongoDB has no more a Permissive Open Source License
- 100% web compatible, so needs no drivers at all
- Sync Feature on Steroids.
- PouchDB (even that public linking this way is Nightmare on Security street)
- Document Views
- Scriptable with JavaScript
- Written in Erlang and Erlang's Runtime was designed to scale.  
  (It is unknown to me if this predicate extends to CouchDB as well.)

## Install

The problem boils down how to verify the public key of the Apache Packages, as Apache failed completely to provide some sane upgrade path from previous packages.

Before the key was this:

```
$ gpg /etc/apt/trusted.gpg.d/couchdb.gpg
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
pub   rsa4096 2015-02-17 [SC]
      8756C4F765C9AC3CB6B85D62379CE192D401AB61
uid           Bintray (by JFrog) <bintray@bintray.com>
sub   rsa4096 2015-02-17 [E]
```

Now the key is:

```
$ gpg keys.asc.gpg 
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
pub   rsa8192 2015-01-19 [SC]
      390EF70BB1EA12B2773962950EE62FB37A00258D
uid           The Apache Software Foundation (Package repository signing key) <root@apache.org>

$ gpg --list-packets keys.asc.gpg
# off=0 ctb=99 tag=6 hlen=3 plen=1037
:public key packet:
        version 4, algo 1, created 1421682057, expires 0
        pkey[0]: [8192 bits]
        pkey[1]: [17 bits]
        keyid: 0EE62FB37A00258D
# off=1040 ctb=b4 tag=13 hlen=2 plen=81
:user ID packet: "The Apache Software Foundation (Package repository signing key) <root@apache.org>"
# off=1123 ctb=89 tag=2 hlen=3 plen=1079
:signature packet: algo 1, keyid 0EE62FB37A00258D
        version 4, created 1421682057, md5len 0, sigclass 0x13
        digest algo 10, begin of digest e8 ca
        hashed subpkt 2 len 4 (sig created 2015-01-19)
        hashed subpkt 27 len 1 (key flags: 03)
        hashed subpkt 11 len 4 (pref-sym-algos: 9 8 7 3)
        hashed subpkt 21 len 4 (pref-hash-algos: 10 9 8 11)
        hashed subpkt 22 len 4 (pref-zip-algos: 2 3 1 0)
        hashed subpkt 30 len 1 (features: 01)
        hashed subpkt 23 len 1 (keyserver preferences: 80)
        subpkt 16 len 8 (issuer key ID 0EE62FB37A00258D)
        data: [8189 bits]
# off=2205 ctb=89 tag=2 hlen=3 plen=540
:signature packet: algo 1, keyid 2B118A5FA15F30B9
        version 4, created 1421684294, md5len 0, sigclass 0x10
        digest algo 10, begin of digest f5 25
        hashed subpkt 2 len 4 (sig created 2015-01-19)
        subpkt 16 len 8 (issuer key ID 2B118A5FA15F30B9)
        data: [4095 bits]
```

As you can see, the problem is, that you cannot trust the key at all:

- It is not signed by any entity you trust (usually)
- The **the change happened on 2021-04-25** while the **key is from 2015-01-19**.  (WTF!?!)

> Why wasn't this key used in the past when it already existed?

Here is how I verified the key:

- [Googling for the key name](https://startpage.com/sp/search?q=%22The%20Apache%20Software%20Foundation%20%28Package%20repository%20signing%20key%29%20%3Croot@apache.org%3E%22) reveals 2 hots as of today 2021-06-12, one of them is unusable as it is for RPM (and Apache uses a different key to sign RPM)
- [Googling for 0EE62FB37A00258D](https://startpage.com/sp/search?q=0EE62FB37A00258D) reveals no hit as of today 2021-06-12
- [Googling for 2B118A5FA15F30B9](https://startpage.com/sp/search?q=2B118A5FA15F30B9) reveals no hit as of today 2021-06-12
- [Googling for 390EF70BB1EA12B2773962950EE62FB37A00258D](https://startpage.com/sp/search?q=390EF70BB1EA12B2773962950EE62FB37A00258D) reveals 3 hits as of today 2021-06-12
  - [archive.org on one of the hits](https://web.archive.org/web/20210426040237/https://docs.couchdb.org/en/stable/install/unix.html) reveales a copy from 2021-04-26 which contains the key
- [GitHub has a commit dating back to 2021-04-26](https://github.com/apache/couchdb-documentation/blob/3e7273dca604a225d8c74ee21514327f56425405/src/install/unix.rst#enabling-the-apache-couchdb-package-repository) this is also signed [and has a "verified" on it](https://github.com/apache/couchdb-documentation/commit/3e7273dca604a225d8c74ee21514327f56425405)

The latter (GitHub) is probably the best source.  However you cannot be fully sure that everything is sound, as not much time has passed since these changes, so perhaps something went wrong unnoticed.

**Except for the unexplained way to verify the new key for existing installations** you can [follow the documentation from Apache](https://github.com/apache/couchdb-documentation/blob/3e7273dca604a225d8c74ee21514327f56425405/src/install/unix.rst#enabling-the-apache-couchdb-package-repository) (link goes to the commit for safety, so this might be old information) to install CouchDB.

> That's the major problem.  **If you exchange the key you MUST(!) make sure that there is a signature path from the old key to the new one everybody can trust!**
>
> That is:
> - All you have is the old key
> - There is some way to verify the new key by the old one
>
> Not being able to do so **creates a security hole** and headaches on how to safely upgrade to all the changes.
>
> Read:  If you cannot supply such an safe upgrade path, then please appologize explaining the situation
> and **then start to change things such that you can do better in future**!
>
> If you fail to do so, you are selling SnakeOil, not proper Code Signing!


## Problems

When you install CouchDB be sure there is **no public available open port** left after install.
This is not so easy as it sounds.

CouchDB - as of today - violates the Debian FSSTD by putting the configuration at `/opt/couchdb/etc/`
instead of the correct `/etc/opt/couchdb/`.  For secure production setups
(where `/opt/` is mounted readonly) this means, you cannot configure CouchDB while running!

Installing CouchDB on Debian as a standalone node listening on 127.0.0.1 is not secure by default.
Setup leaves the [port of the Erlang-VM](https://github.com/apache/couchdb/issues/2306) alone,
[opening a dangerous hole](https://erlang.org/doc/reference_manual/distributed.html) into your machine.

```
cat <<'EOF' | sudo tee -a /opt/couchdb/etc/vm.args

# WTF SHUTUP STUPID!
-kernel inet_dist_use_interface {127,0,0,1}
-kernel inet_dist_listen_min 60001
-kernel inet_dist_listen_max 60001
EOF
```


## Configuration

Also I use following configuration:

`/etc/opt/couchdb/local.d/90-tino.ini`:
```
[chttpd]
admin_only_all_dbs = false

[couchdb]
os_process_timeout = 100000
max_document_size = 500000000

[couch_httpd_auth]
timeout = 600000
```

This:

- Allows non-admins to list all databases (allows non-admin web apps to autodetect everything)- 
  - This is **only suitable if CouchDB stays `localhost`** and is not reachable from the Internet!
- Increase the document size to 500 MB
- Increase the web timeout of a Fauxton login to (nearly) 1 week
















































