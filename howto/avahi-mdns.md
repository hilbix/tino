# Avahi AKA mDNS

Avahi is the standard implementation of some mDNS daemon on Linux.

It sits in background and discovers and announces services and also can act as a repeater.

But ..

.. things are not that easy, of course.  Hence to not forget it, I list here what I find about it.

> This is a bit Debian centric.  But this is mainly for me, not for you.  Sorry!


## Avahi config

Sorry, Avahi is difficult.  So I cannot say this is secure or not.  Use at your own risk!  This probably should not be changed on multi-user-machines.


### `/etc/avahi/avahi-daemon.conf`

```
[server]
enable-dbus=yes
```

- Configuration automatically reloads Avahi
  - But Avahi might have (unknowingly) lost the connection to DBus, then it needs a `systemctl restart avahi-daemon`
  - If it takes too long or hangs: `systemctl stop avahi-daemon & sleep 3; killall -9 avahi-daemon; wait; systemctl start avahi-daemon`
- Above allows avahi-daemon to be accessed via DBus
  - Perhaps fixes `org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.`
  - Perhaps fixes `Failed to create client object: Daemon not running`
- Usually it is on, but might have been disabled at compile time
- Needed that on my PI400

```
[reflector]
enable-reflector=yes
```

- Avahi should catch up this change automatically
- This forwards information between networks
  - Good if machine is multi homed and acts as a repeater/router/bridge/proxy
- See <https://blog.christophersmart.com/2020/03/30/resolving-mdns-across-vlans-with-avahi-on-openwrt/>


## mDNS tools

### query

`avahi-discover`

- X11 UI
- `apt install avahi-discover`
- `ssh -X router avahi-discover`
  - If you have a DBus problem see above `enable-dbus`

`mdns-scan`

- Commandline scan tool (works without DBus)
- `apt install mdns-scan`

`bshell`, `bssh`, `bvnc`

- `apt install avahi-ui-utils`


### Others

`mdnsd` and `mquery`

- `apt install mdnsd`
- It comes enabled.  To disable:
  - `systemctl disable mdnsd`
  - `systemctl stop mdnsd`
  - `systemctl mask mdnsd`
- `mquery`
  - similar to `mdns-scan`
- `man mdnsd`


## Service publishing

> Note that `apt-cacher-ng` is publishing its service via Avahi already

I did not test this myself, but perhaps see:

- <https://sosheskaz.github.io/tutorial/2016/09/26/Avahi-HTTP-Service.html>
- <https://holyarmy.org/2008/01/advertising-linux-services-via-avahibonjour/>
- <https://holyarmy.org/2008/11/bonjour-avahi-addendum/>
- <https://simonwheatley.co.uk/2008/04/avahi-finder-icons/>

Example with no meaning adapted from these URLs:

`/etc/avahi/services/YOURSERVICE.service`
```
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
<name replace-wildcards="yes">%h</name>
<service>
<type>_device-info._tcp</type>
  <port>0</port>
  <txt-record>model=RackMac</txt-record>
</service>
<service>
  <type>_http._tcp</type>
  <port>80</port>
  <txt-record>server=Apache</txt-record>
</service>
<service>
  <type>_ssh._tcp</type>
  <port>22</port>
  <txt-record>version=8.4p1</txt-record>
</service>
</service-group>
```

See also:

- <https://github.com/lathiat/avahi/blob/master/service-type-database/service-types>
- `apt-file search /etc/avahi/services/`
