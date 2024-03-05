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
>
> Lessons learned:
>
> - Too much went wrong
>   - Root cause is the lack of a good plan to counter this situation
>   - Only knowing what to do is not enough, because in a stress situation too many errors happen.
>   - I knew this already before of course, but this assured that this is correct.
> - Lack of a proper monitoring was a root cause of the too long duration all the downtimes
>   - The downtimes were much longer than needed or even completely unnecessary
>   - But there simply is no proper monitoring out there in my case .. yet
> 
>  However:
>
> - Things improved now.
> - And things will continue to improve, too.
> - Slowly but steadily.
> - Please bear with me.
> - I will update the information on <http://susi.de/>

Some personal notes about "what is a DDoS":

- A DDoS is a Distributed Denial of Service
  - In that case some (probably hundreds) of IPs send out many (hundreds) of connections to a single web server to overload it.
  - Which worked against SUSI, as the setup here basically stems from the last millenium, were things were a bit different than today.
- The DDoS of SUSI still was small, compared to what strikes others.
  - But as SUSI is so old, it got into trouble fast
- There are two types of DDoS:
  - Unintended DDoS, like a website breaks under the load due to too many users try to access it in parallel
  - Intended DDoS where somebody looks for the best way to bring a website into trouble.
- The DDoS of SUSI was of the last type.
  - So it was not just some bad luck.
  - Hence it must be regarded as a direct Attack against SUSI.
- A DDoS must be seen as something like the weather
  - DDoS are not as bad as Hurricanes.  As Hurricanes damage things ususally.
  - But it can be seen as Lighning Ice which makes the roads impassable as long as it happens
- Lightning Ice has several properties which a DDoS has, too:
  - It can last days
  - It can make things really troublesome
  - It vanishes by itself
  - You cannot do much against it
  - You better just sit and wait until it goes by
  - Afterwards, things usually return to normal on themselves
  - And both are triggered by human stupidity.

> Well, the current climatic change which boosts things like Lightning Ice is entirely caused by human stupidity, right?

I do not tell anything here about what I plan or have implemented to counter DDoS in future:

- I do not want to give any clues to the attacker how to improve the attack.
- And I am not confident it works, as it is not battle tested.
- And if things really go bad, I still can contact [Cyber Security](https://www.bmvg.de/de/themen/cybersicherheit)
  - Err, I mean [this](https://www.spiegel.de/netzwelt/netzpolitik/gerichtsurteil-ddos-angriff-ist-strafbare-computersabotage-a-768245.html)

So all you read below is what happened and when it happened and, if I know this, why it happened.


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

The good thing is, that the new setup of SUSI is an improvement over the setup before, so the new VM of SUSI is much more modern than the old one.
Even that SUSI stays as-is, the new Host is far more flexible (and better documented), such, that moving SUSI out of the line of fire is much easier.

> This means, if the host or IP is affected by a DDoS, SUSI can be moved to another host
> and things like CloudFront can be put in front of it to counter attacks.
> In future this can even be done fully automated when a known attack vector is detected.
> However this is not in place today, of course, all I want to say is, there still is much work ahead.

Traffic will be directed to the new IP, soon, so you will see a DNS change .. again.
However the old IP will be monitored (by me) and continue to work for a few days and weeks.

If you are using some firewall rule to allow access to SUSI.de, be sure to update your settings.


## 2024-03-01 09:15 UTC

I probably found out why things no more work with SystemD:

`man crypttab` on Debian `bookworm` states on `keyscript`s:  
> WARNING: With systemd as init system, this option might be ignored. At the time this is written (December 2016), the systemd cryptsetup helper doesn't support the keyscript option to /etc/crypttab. For the time being, the only option to use keyscripts along with systemd is to force processing of the corresponding crypto devices in the initramfs. See the 'initramfs' option for further information.

Well, that is exactly what I do:  Use `keyscripts` which are needed to unlock the device.

> Many thanks for SystemD breaking what flawlessly worked over 20 years without any problem!

The best thing here is that SystemD does not output any trace of this occurance.

> Looks like JournalD has a very bad time accessing `/var` to store a log of this problem,
> becaue `/var` needs unlocking with a `keyscript` first, which isn't supported by SystemD.
>
> Checkmate!
>
> Perhaps logging of SystemD deserves some critical improvement, eh?

I think I will give `passdev` a try (which was unavailable when the host was created).
But this does not change my mind to decommission the old host.


## 2024-03-02 06:30 UTC

SUSI was down approx. 17 hours .. again.  Due to some stupid error of me which .. again .. went unnoticed.

This was indirectly caused by the DDoS.  Because the old host is to be decommissioned now, I copied the filesystems to the new host.
But there was not enough space available.  Yes, a very stupid mistake.

Due to the ongoing works of the DDoS, there existing (but very unusable free) Monitoring steadily was alarming me, so I have muted it.
So the additional error of SUSI going down again did not reach me until today, Saturday, were I detected it in my morning routine.
Mostly not because SUSI was down but because other services were affected, too.

Due to the downtime of SUSI the DDoS message was spit out in error.  **There was no DDoS going on**, this was due to the DDoS before.
Another thing I did not clean up after SUSI was up again.  This error is now fixed, too.

> I am in the process to create a better monitoring.
> Why?  Because there is only unusable crap out there which does not even slightly fullfills my needs.
>
> - No, I am just a privat person and no company with big bucks to pay for a suitable monitoring.
> - NO, I wont go naked and buy the service by selling valuable data to some obscure third party in their free tier!
> - No, I am still not in the position to pay insane amounts of money for Monitoring with very low value for me
> - Please note that the usual cloud based monitorings out there get hold on your IP, too.
>   - In Germany your IP is protected by law and hence must not be forwarded to any third party without your explicite consent
>   - I take (read: SUSI takes) your privacy rights very serious, so I cannot use such services because this would be against the law (IANAL)
>   - This rules out to use all those existing cloud based monitoring solutions, except for the very basic ones.
>   - And the very basic ones appear of being of no value in the current situation.
>   - They even might make things worse because of the fruitless effort involved.
>
> Note that $1 per month already is an insane amount, because it is far more expensive than when monitoring is done right:
>
> A Raspberry PI for less than $80 one time cost is capable of monitoring hundreds if not thousands of hosts in parallel.
> And to operate it costs less than $20 per year (in power consumption, far less if solar powered).  
> This little PI also is able to provide me with unlimited detailed historic monitoring information for a whole lifetime!
> And it is able to call me or send an SMS or toggle a warning in my house automation **for no additional costs at all**!
>
> So why do you think, that anybody is interested in paying more than a single buck per month for a cloud based monitoring service,
> which even then when I pay for it offers far less than what such a cheap PI is capable of doing?
> And why shall I risk that my valuable monitoring data is sold to others by that service?
>
> **WTF is going wrong in this world?!?**
> 
> When I have something which works for me, I will Open Source this here at GitHub, of course.
>
> Note that this will be probably mostly [NetData based](../howto/netdata.md).  NetData without Cloud, of course!
> But SUSI is far too old for this approach, so my monitoring must offer far more than just that.

To make it short:

- 2024-03-01 14:48 UTC SUSI came down because the VM's host filesystem filled up
- The monitoring spit out warnings - which were muted because there were too much of them
- Due to the downtime the DDoS information page was handed out to all, because I forgot to update that page.
- I did not notice the downtime before I went to bed (I was a bit exhausted due of the DDoS the day before).
- When I started my daily routine today (Saturday) I noticed the downtime
- 2024-03-02 06:40 UTC the problem was solved and SUSI was up again

I am sorry for the inconvenience, but I am not a superhuman.  Instead I just tell it here.

Thank you for your understanding.


## 2024-03-03 You have to be careful

> "To err is human.  But to really fuck things up, you need a computer."  [OEDO 808 Cyber City](https://www.imdb.com/title/tt0220218/)

When I did the move, I did it quickly.  This means, that Mails are now coming in over a proxied tunnel connection, too, until SUSI is changed to the new IP.

> The good thing is to sort everything out before the move to the new IP is applied.
> So problems like this here do not affect the new IP.
>
> The new IP has been already assigned, but I defer the IP change a few days until everything is settled.

The problem was, that, unluckily, the IP of the proxy (which is seen as the sender IP) was out ot the allowed domains to relay, which are listed in `/etc/mail/relay-domains`.

> AFAICS a configuration error, as you can name your reverse as you like.  So if you find out what is in `relay-domains`
> you can send SPAM over another relay without problem.  Hence recommendation:  Never use `relay-domains` in a DNS configuration.

This was a very very very old setup.  Namely something, which was done in the last century.  Go figure ..

Some SPAMmers found this out - of course (there are automated process for this) - and started to abuse the SUSI MTA for transferring SPAM.

> Well, sorry, again my fault.

I found out today.  Again, not thanks to some monitoring of some sort but manually while testing things.

> A mail queue of 2000 entries is a bit much for such a little system like SUSI.
> It is very well able to handle enourmous amounts of Mail, of course, without taking harm,
> but it is very unfriendly to others to allow SPAM like this.

Hence, this configuration error now is fixed, too.  Sigh.

> This was not caused by the DDoS directly, as the configuration error was done over 25 years ago.
> It only hit now due to all the other changes, which were needed to hande the current situation.
> It could have hit previosly, though, without me seeing it.
>
> Nevertheless I do not say "thank you for the DDoS to bring all those other problems to my awareness".
> Nope, I am really not amused!


## 2024-03-04 Time was 17h off

After SUSI came down (see above: 2024-03-02 06:30 UTC) I did not reboot the VM.  I just hibernated it, rebooted the host and started the VM again out of its previous state.

So after the hibernation, the time was 16h off and the VM apparently was unable to cope
with the situation.  Additionally there is a time drift (see next) which slowly
made the time gap become 17 hours.

Afterwards I watched the NTP service more closely and decided to test another method:

Using `adjtimex` to compensate instead by using the RTC.

> The RTC always represent the correct time, as it is simulated by the host.
> And the host is time synced.


## 2024-03-05 Dancing the Timewarp .. again

For unknown reason, `adjtimex` is unable to keep the time.  After 12 hours the
VM was approx 15 minutes behind time.

Apparently `adjtimex` does not adjust the time by the offset to the RTC,
but to some unknown internal algorithm.  Weird.

Also (this very old version of) `adjtimex` seems to have bugs:

```
unable to open /dev/port read/write : : Too many open files
```

Followed by a crash.  Well, only this single process is affected,
but this is a bit too buggy for me.

What I'd like to see is some tool:

- Which is small (so no such big thing like `chrony`),
- uses the `adjtime` kernel call
- to carefully adjust the time
- based on the offset of the time from the RTC.
- It should do this each 10s,
- and if the time is too far off,
- it should jump the time forward.
- And it never should jump the time backward.

Isn't there really no [such tool](https://github.com/hilbix/franknfurter) out there?

> The name must, of course,
> be [`franknfurter`](https://en.wikipedia.org/wiki/The_Rocky_Horror_Picture_Show)


## 2024-03-05 08:00 UTC (estimated) DDoS strikes again

Unluckily I had no time when I detected it, because, sometimes, Admins have to do other things.

However now (11:20) I am again on it, learning what exactly happens and how to mitigate it.

Luckliy I haven't moved to the new IP already, hence the DDoS hits the old IP and the old server.
So I have an entire (free to work with) server to experiment with without harming the "real" (productive) server.

What I seen are over 2500 parallel connections to the service:

```
netstat -natp  | fgrep 136.243.197.98:80 | wc -l
2350
```

