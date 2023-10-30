> TL;DR: `/usr/bin/socat -d -d -t2 -T2 UDP4-RECVFROM:123,reuseaddr,fork,bind=$INTERNAL_INTERFACE UDP-SENDTO:$NTP_SERVER:123` is your friend

# NTP

## `SystemD.timesyncd` is a nightmare

`SystemD.timesyncd` sometimes simply does not work and does not keep the time.  In that case following does not work:

- Updating the time at boot.  I do not know why, but after boot my time often is completely wrong.  And `SystemD.timesyncd` does nothing against this.  I really have no idea why or how to fix that.  I tried.  I failed miserably.

- Updating the time while the machine is running.  Apparently `SystemD.timesyncd` does a bad job in keeping the time correct.  I really have no idea why or how to fix that.  I tried.  I failed miserably.

What I expect is, that `SystemD.timesyncd` keeps up the time.  And if anything fails, like it cannot get the time from the network or it apparently fails to set the system time for some reason or the system time jumps forth and back out of control of `SystemD.timesyncd`, then I expect that a modern piece of software tells this prominently, and also within this, it exactly tells what's going on and how to fix it.

However `SystemD.timesyncd` is mute.  I simply cannot find any trace about the problem.  Following ran on two different machines:

```
A$ timedatectl
               Local time: Mon 2023-10-30 04:38:35 CET
           Universal time: Mon 2023-10-30 03:38:35 UTC
                 RTC time: Mon 2023-10-30 03:38:35
                Time zone: Europe/Berlin (CET, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no

B$ timedatectl
               Local time: Mon 2023-10-30 04:36:29 CET
           Universal time: Mon 2023-10-30 03:36:29 UTC
                 RTC time: Mon 2023-10-30 03:37:47
                Time zone: Europe/Berlin (CET, +0100)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no
```

What does this want to tell me?  "System clock synchronized: no" why?  What's wrong?

Note that the RTC time even is "much better" than the system time.  So why isn't it using the RTC?  A known drift of the RTC can be compensated.  The accounted time cannot be more correct than the RTC, because CPUs can sleep.

I really do not understand any trace of why SystemD is implemented this way and what SystemD wants to tell me or does not tell me at all.

Well, to find the problem, we must look deeper, the hard way:

```
B$ systemctl status systemd-timesyncd
● systemd-timesyncd.service - Network Time Synchronization
     Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-10-12 06:47:48 CEST; 2 weeks 3 days ago
       Docs: man:systemd-timesyncd.service(8)
   Main PID: 3274206 (systemd-timesyn)
     Status: "Idle."
      Tasks: 2 (limit: 38240)
     Memory: 472.0K
        CPU: 2.894s
     CGroup: /system.slice/systemd-timesyncd.service
             └─3274206 /lib/systemd/systemd-timesyncd
```

Thanks for telling exactly nothing.

```
B$ sudo systemctl status systemd-timesyncd
● systemd-timesyncd.service - Network Time Synchronization
     Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-10-12 06:47:48 CEST; 2 weeks 3 days ago
       Docs: man:systemd-timesyncd.service(8)
   Main PID: 3274206 (systemd-timesyn)
     Status: "Idle."
      Tasks: 2 (limit: 38240)
     Memory: 472.0K
        CPU: 2.894s
     CGroup: /system.slice/systemd-timesyncd.service
             └─3274206 /lib/systemd/systemd-timesyncd

Oct 29 23:14:18 B systemd-timesyncd[3274206]: Timed out waiting for reply from 192.168.0.1:123 (192.168.0.1).
```

You only get the information when you are privileged!  **This is very bad.**  Actually I expect to be able to get the same information as unprivileged user easily!  As querying the local NTP traditionally is some unprivileged action.  But SystemD does everything differently ..

### What happened?

When moving to `chrony` on my local time server I forgot to configure it.  Following did the trick as `root` on my local time server:

```
# echo allow 192.168.0.0/16 > /etc/chrony/conf.d/allow-192.168.conf
# systemctl restart chrony
```

Now `chrony` listens on `UDP 0.0.0.0:123` and answers time queries:

```
# ss -lup | grep chrony
UNCONN 0      0              0.0.0.0:ntp                0.0.0.0:*    users:(("chronyd",pid=1355049,fd=7))         
UNCONN 0      0            127.0.0.1:323                0.0.0.0:*    users:(("chronyd",pid=1355049,fd=5))         
UNCONN 0      0                [::1]:323                      *:*    users:(("chronyd",pid=1355049,fd=6))         
```

Following commands are helpful to peek into `chrony` (in contrast to SystemD, these  work unprivileged, of course):

```
chronyc tracking
chronyc sources -v
chronyc sourcestats -v
chronyc selectdata -v
chronyc activity
chronyc ntpdata
```

Note that I am using the default `/etc/chrony/chrony.conf` file from the distribution.

Afterwards:

```
B$ timedatectl
               Local time: Mon 2023-10-30 05:14:15 CET
           Universal time: Mon 2023-10-30 04:14:15 UTC
                 RTC time: Mon 2023-10-30 04:14:15
                Time zone: Europe/Berlin (CET, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no

$ sudo systemctl status systemd-timesyncd
● systemd-timesyncd.service - Network Time Synchronization
     Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-10-12 06:47:48 CEST; 2 weeks 3 days ago
       Docs: man:systemd-timesyncd.service(8)
   Main PID: 3274206 (systemd-timesyn)
     Status: "Initial synchronization to time server 192.168.0.1:123 (192.168.0.1)."
      Tasks: 2 (limit: 38240)
     Memory: 544.0K
        CPU: 2.900s
     CGroup: /system.slice/systemd-timesyncd.service
             └─3274206 /lib/systemd/systemd-timesyncd

Oct 29 23:48:36 B systemd-timesyncd[3274206]: Timed out waiting for reply from 192.168.0.1:123 (192.168.0.1).
..redacted..
Oct 30 04:59:25 giganto systemd-timesyncd[3274206]: Initial synchronization to time server 192.168.0.1:123 (192.168.0.1).
```

Now it works.  But I still must be superuser to display this!  WTF!?!


## NTP proxy

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
