> TL;DR: `/usr/bin/socat -d -d -t2 -T2 UDP4-RECVFROM:123,reuseaddr,fork,bind=$INTERNAL_INTERFACE UDP-SENDTO:$NTP_SERVER:123` is your friend

# NTP proxy

- Goal: You want to bring NTP into separated networks.
- Problem: **You have SystemD.**  SystemD does not provide NTP service for sub networks.
- Wrong Solution:  Enable IP forwarding / Masquerading.
  - This thwarts network separation, because it makes your machine a router.
  - Also this needs Admin privilege and a change to Network Configuration, which always might be dangerous if something is administered off-site.
- Wrong Solution:  Disable SystemD.timesyncd and install full fledged NTP service.
  - This does not help in Security, as there the Security History of NTP is a Nightmare.  Why should you replace one Security-Nightmare with another one?
  - Less software always is a better choice, because disabling SystemD.timesyncd does not get rid of anything.
  - Also this needs Admin privilege and a change to your machine setup.  Bad if that makes your machine special, as if you manage many machines setups shall be similar.

The solution shown here is to install some UDP Proxy which forwards the NTP requests of the SubNet to the real NTP server.

> **WARNING!**  This effectively implements some Jitter when it comes to NTP synchronisation.
>
> So this here is not suitable for high precision time synchronisation.  If you need that, you need a dedicated high precision time source like a dedicated NTP server!
>
> However this is perfect for low pecision unpredictable NTP Clients like those running `SystemD.timesyncd`

Note:

- I really do not know why I was unable to find something suitable via Google.
- Am I the only one using NTP with SystemD and Network Isolation?  (Like Linux Namespaces?)


## Intermediary Solution

	/usr/bin/socat -d -d -t2 -T2 UDP4-RECVFROM:123,reuseaddr,fork,bind=$INTERNAL_INTERFACE UDP-SENDTO:$NTP_SERVER:123

- Leave `bind=$INTERNAL_INTERFACE` away if you want to listen on all interfaces.
- `$NTP_SERVER` is the IP (or DNS name) of your NTP server.
- This only works if your NTP server never changes it's IP, so this does not work with things like `0.pool.ntp.org`.
- Note that most modern Home Routers are NTP time sources as well.  To `$NTP_SERVER` probably is your Default Gateway.

Notes:

- This is far from perfect, as `socat` does a `fork()` for each UDP client it sees.
- This needs to listen to a privileged port
- So this still needs administrative privileges

BTW:

- I do not want something written in Python, as it should be either builtin or a very small binary on a small box


### Variant

With my tool [`suid`](https://github.com/hilbix/suid) this privileged thing can be run as an ordinary user.

You need a line like this in `/etc/suid.d/ntp.conf`:

	ntp:::::/:/usr/bin/socat:-d:-d:-t2:-T2:UDP4-RECVFROM\:123,bind=192.168.0.1,reuseaddr,fork:UDP-SENDTO\:192.168.1.1\:123

Then it can be started using a script `autostart/ntp.sh` which looks like:

	#!/bin/bash
	exec suid ntp

This can be run via cron, see [`autostart.sh`](https://github.com/hilbix/ptybuffer/blob/master/script/autostart.sh) via another of my tools.

> Sadly, `socat` does not allow SUID filesystem flags, as it does not drop privilege after binding to the privileged ports.
> I consider this a bug.  So we should use a different program which allows to give up privileges.


## The right solution

Sorry, I do not know any yet.  I did not find a better solution than the one above which works out-of-the-box like the Intermediary Solution.

AFAICS you need to write some specialized program to do what is needed.  It does not need to fork.  And it does not need to do any complex things.

Something which only needs a few KB of memory to run and a few KB per UDP connection, which can handle tousands of packets per second.

Best probably would be to have it builtin into HaProxy.  But AFAICS it isn't.

### Anatomy of this program

This should be implemented in two programs:

First:

- Open a privileged port
- Give up privileges
- Forward this privileged port to another program

Second:

- Receive from this Port which is passed in
- Open the outgoing UDP port
- Forward the packet to the destination (perhaps with zero copy with `splice()`?)
- Wait for replies
- Forward those replies to the source
- If somehting fails, just this connection
- Timeout the connection if it is idle too long (in milliseconds)

And this all should run in a single thread.

Why like this?

- Because it is more secure this way.
  - Just the first needs privilege, opens the port and gives up privileges afterwards.
  - Then the second stage runs unprivileged.
  - The privileged part is hopefully straight forward code with only needs some minimal major system libraries (which are likely to not contain bugs).
  - Everything else then runs unprivileged.
- Also this perhaps can be implemented into my tool `suid`, too
  - `suid` handles all the privileged parts, as it is easy to get things wrong when it comes to dropping privileges.
  - So you do not even need to drop privileges, as this can be handled by `suid` for you!
  - However, this is not yet built into `suid`, sorry.
  - As this probably also needs support for something like [`passfd`](https://github.com/hilbix/passfd) (another of my tools) in `suid`
    (which makes things a bit too complex for my taste, so I did not have a good idea for Namespaces and FD-Passing there, yet)
