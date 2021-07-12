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
















































