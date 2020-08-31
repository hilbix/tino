# HaProxy

Some recipes to HaProxy which are not exactly so straight forward.  Adapt accordingly.

## Use a configuration directory

Newer HaProxy versions allow a directory as configuration.  But I do not know of any distribution which implements that.
But you can do this yourself, without tweaking the default configuration or anything.  It just works:

```
mkdir /etc/haproxy/haproxy.cfg.d/
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.d/00000-haproxy.cfg
ln -s /etc/haproxy/haproxy.cfg.d /etc/haproxy/haproxy.cfg
```

> This assumes that the distribution uses the standard place /etc/haproxy/haproxy.cfg for the configuration file

Then, in future, put your files into `/etc/haproxy/haproxy.cfg.d/`.  My recommendation is to do it as follows (in `bash` sense):

`/etc/haproxy/haproxy.cfg.d/$PORT-$HOST.${SOMETHING:-cfg}`

where:

-`$PORT` is the port number in the sense `printf %05d`, so 5 digits with 0 filling
- `$HOST` is the entry from `/etc/hosts` used to bind the thingie to
- `${SOMETHING:-cfg}` is something which explains to you what this is used for.
  - If you do not use this, `cfg` is used instead.
  - **This must not contain a `.`** to keep the entries easily scriptable as follows:  
    `for a in /etc/haproxy/haproxy.cfg.d/*; do PORT="${a%%-*}"; HOST="${a#*-}"; HOST="${HOST%.*}"; SUFF="${a##*.}"; run "$PORT" "$HOST" "$SUFF"; done`

In `/etc/hosts` add the IP for the `$HOST` the thingie is listening on.  If not in `/etc/hosts` it may be taken from DNS as well (for external interfaces, etc.).
But I recommend `/etc/hosts` because it is too bad to not being able to completely startup HaProxy when DNS is currently not yet available.
Do not think this does not happen.  It will happen, sooner or later, even if you happen to be the DNS primary yourself.  Shit happens.
Only do the most robust setups on your loadbalancers, as this is probably the most critical part in your whole setup.

### Example `/etc/haproxy/haproxy.cfg.d/00080-localhost.nginx`

This is on my developer machine:

```
listen  nginx
        bind localhost:80
        mode http
        server nginx v4nginx:8000
```

Here the filename already nearly explains the contents.  The only bits are `v4nginx` which is an entry in `/etc/hosts` which binds the listening port
of `nginx`.  You can even create a configuration which **works on production as well in development**:

`/etc/haproxy/haproxy.cfg.d/00080-webservice.nginx`:

```
listen  nginx
        bind v4webservice:80
	bind v6webservice:80
        mode http
        server nginx1 v4nginx1:8000
        server nginx2 v4nginx2:8000
        server nginx3 v4nginx3:8000
        server nginx4 v4nginx4:8000
```

This then can be even be deployed on your bunch of load balancers from `git`.  The only difference is found in `/etc/hosts` which is pointing everything to `localhost` on your developer machine.


## Secure SSL Tunnel

Secure SSH tunnel between 2 HaProxy instances.

- Problem: Securely access some service on another machine running on localhost only
- Solution: `localhost -http-> haproxy (client) -SSL-> haproxy (server) -http-> localhost`

On server.example.com:

```
apt install minica

mkdir /etc/haproxy/ca
cd /etc/haproxy/ca
minica server        && cat        server.crt        server.key > server.pem
minica client@server && cat client@server.crt client@server.key > client.pem

vim /etc/haproxy/haproxy.cfg
```
```
listen	couch
	bind server.example.com:5984 ssl crt /etc/haproxy/ca/server.pem verify required ca-file /etc/haproxy/ca/cacert.crt
        mode tcp
	server couch 127.0.0.1:5984
```

On client.example.com:

```
mkdir /etc/haproxy/ca
scp server.example.com:/etc/haproxy/ca/client.pem /etc/haproxy/ca/

vim /etc/haproxy/haproxy.cfg
```
```
listen	couch
	bind 127.0.0.1:5984
        mode tcp
	server couch server.example.com:5984 ssl crt /etc/haproxy/ca/client.pem verify required ca-file /etc/haproxy/ca/cacert.crt
```

Notes:

- This example is to access a remote [CouchDB istance](couchdb.md) in a secure way.
- MiniCA is not suitable for some sane SSL setup, but here it works.
