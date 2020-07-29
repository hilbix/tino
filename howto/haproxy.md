# HaProxy

Some recipes to HaProxy which are not exactly so straight forward.  Adapt accordingly.


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

FYI: This example is to access a remote [CouchDB istance](couchdb.md) in a secure way.
