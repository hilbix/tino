> https://valentin.hilbig.de/ is also affected, because it is running on the same host as susi.de

# [SUSI.de](http://susi.de/) is under attack

A DDoS attack stikes SUSI today.  Over 400 parallel connections were opened to it, from (probably) hundreds of IPs,
overloading the rather old SUSI.de service.

> I haven't found the time to analyse the logs deeply enough.

SUSI is a VM.  So the host which hosts the VM was not highly affected, only the VM got stress.

> TL;DR
>
> - No data was corrupted.  Only SUSI became unavailable.  A classical DoS.
> - If such attacks continue to happen, I will file a case with the authorities.


## 2024-02-29 10:00 UTC

I started to investigate, but due to some error, I rebooted the host.  Bad luck,
the host was recently updated to SystemD but not yet rebooted and .. reboot did not work.
The encrypted filesystems did not come up again, due to ..
I really have no idea, but the Internet is full of such problems.

> Thanks, SystemD!

As I am unable to access the console of the machine remotely, I was out of clues what exactly goes wrong.

The filesystems are accessible and I can get on the data, but I cannot boot into the system currently.
So the idea is to move the VM to another host and start it there.

Unluckily I did not follow best pratice when setting up encrypted ZFS where the VM sits on.
This means, I cannot access that safely.  Hence I do not want to activate it before I have a safe copy.
This can take .. days.  Much too long for my taste.

Hence I now try to find a way to do it differently.

- Perhaps I am able to bring up the host
  - (Update: I think this is futile.  I will probably decommission the host soon.)
- Perhaps I am able to access ZFS safely
  - (Update: I was able to do so)

I do not know .. yet.

> Update: I am still curious why it does not boot.  But no time for this ..


## 2024-02-29 17:00 UTC

I did not manage to make the system boot.  All old kernels (SysV) do boot.  All new kernels (SystemD) do not.
I am out of clues.

Luckily the rescue system has ZFS builtin.  And also I found a way to access it safely.

Hence I am now in the process to transfer the VM to a new server.  The old one will only become a
temporarily relay for the IPs until I manage to put it properly behind a Proxy service.


## 2024-02-29 18:10 UTC

To protect the DNS of SUSI against a possible DoS on this bases, DNS is now moved to <https://desec.io/>
just to be safe here.

The original host (which still does not boot, which is not caused by the attack itself but I think by
a recent upgrade to SystemD without reboot) will act as a relay for the old IP until I manage to move the IP, too.

The data of the VM already has been transferred to a new host and now is being verified.

It may take some time to activate the VM again.

After that I will add DDoS protection part by part if that still is needed.

If nothing helps, I will put CloudFront in front of SUSI.

Please stay tuned ..


## 2024-02-29 19:40 UTC

The VM is verified and is up again, but still not reachable from network because first I want to do
a bit more investigation of the state of the VM before I will attach it again.


## 2024-02-29 20:30 UTC

SUSI is online again.  The attack has apparently stopped.  For now.

> Expect small hickups while I improve things.

However I found out that there was another attack on 2024-02-27 which went unnoticed by me,
because nobody informed me.

> To stress it:
>
> If SUSI has a problem, please call my phone and leave a very short message.
> A "SUSI is down" is enough.  Thanks.

The code base of SUSI is too old for current monitoring (i.E. things like NetData do not work there),
but thanks to the new host I probably can add some basic monitoring without it.


## 2024-03-01 04:00 UTC

**Announcing an IP change of SUSI.de.**

> The new IP is not yet defined.

A transition from an old host to a new one is a major task, so there are many things still open.
SUSI is not the only VM affected, but this blog is only about SUSI.

> Note that all of this would have been needed to be done in future anyway.  The DDoS only made this urgent .. now.

To be able to decommission the old node, a new IP of SUSI.de is needed.  This IP now has been ordered.

The good thing is, that the new setup of SUSI is an improvement of the setup before, so the new VM of SUSI is much more modern than the old one.
Even that SUSI stays as-is, the new Host is far more flexible (and better documented), such, that moving SUSI out of the line of fire is much easier.

> This means, if the host or IP is affected by a DDoS, SUSI can be moved to another host
> and things like CloudFront can be put in front of it to counter attacks.
> In future this can even be done fully automated when a known attack vector is detected.
> However this is not in place today, of course, all I want to say is, there still is much work ahead.

Traffic will be directed to the new IP, soon, so you will see a DNS change .. again.
However the old IP will be monitored (by me) and continue to work for a few days and weeks.

If you are using some firewall rule to allow access to SUSI.de, be sure to update your settings.
