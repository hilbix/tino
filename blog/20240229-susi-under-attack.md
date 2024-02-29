# SUSI.de is under attack

A DDoS attack stikes SUSI today.  Over 400 parallel connections were opened to it, from hundreds of IPs,
overloading the rather old SUSI.de service.

SUSI is a VM.  So the host which hosts the VM was not highly affected, only the VM got stress.

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
- Perhaps I am able to access ZFS safely

I do not know .. yet.
