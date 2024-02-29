> https://valentin.hilbig.de/ is also affected, because it is running on the same host as susi.de

# [SUSI.de](http://susi.de/) is under attack

A DDoS attack stikes SUSI today.  Over 400 parallel connections were opened to it, from hundreds of IPs,
overloading the rather old SUSI.de service.

SUSI is a VM.  So the host which hosts the VM was not highly affected, only the VM got stress.


## 2024-02-29 10:00 UTC

I started to investigate, but due to some error, I rebooted the host.  Bad luck,
the host was recently updated to SystemD but not yet rebooted and .. reboot did not work.
The encrypted filesystems did not come up again, due to ..
I really have no idea, but the Internet is full of such problems.

> Thanks, SystemD!

As I am unable to access the console of the machine remotely, I was out of clues what exactly goes wrong.

The filesystems are accessible and I can get on the data, but I cannot boot the system currently.
So the idea is to move the VM to another host and start it there.

Unluckily I did not follow best pratice when setting up encrypted ZFS where the VM sits on.
This means, I cannot access that safely.  Hence I do not want to activate it before I have a safe copy.
This can take .. days.  Much too long for my taste.

Hence I now try to find a way to do it everything differently.

- Perhaps I am able to bring up the host
  - (Update: I think this is futile.  I will probably decommission the host soon.)
- Perhaps I am able to access ZFS safely
  - (Update: I was able to do so)

I do not know .. yet.

> Update: I am still curious why it does not boot.  But no time for this ..


## 2024-02-29 17:00 UTC

I did not manage to make the system boot.  All old kernels (SysV) do boot.  All new kernels (SystemD) do not.
I am out of clues.

Luckily the rescue system has ZFS builtin.  And also I found a way to do it safely.

Hence I am now in the process to transfer the VM to a new server.  The old one will only become a
temporarily relay for the IPs until I manage to put it properly behind a Proxy service.


## 2024-02-29 18:10 UTC

To protect the DNS of SUSI against a possible DoS on this bases, DNS is now moved to <https://desec.io/>
just to be safe here.

The original host (which still does not boot, which is not caused by the attack itself but I think by
a recent upgrade to SystemD without reboot) will act as a relay for the old IP until I manage to move the IP, too.

The data of the VM already has been transferred to a new host and now is verified.

It may take some time to activate the VM again.

After that I will add DDoS protection part by part if that still is needed.

If nothing helps, I will put CloudFront in front of SUSI.

Please stay tuned ..


