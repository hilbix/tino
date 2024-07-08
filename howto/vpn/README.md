# VPNs

- I do not endorse nor promote any VPN.
- I am not affiliated with any VPN provider either.
- I do not know if there are cheaper or better other VPN solutions.
- I do not care if a VPN tracks something or not.

General speaking:

- **DO NOT PAY FOR A VPN!**.
  - For most people this is just a waste of money!
  - Quite often they simply do not work as advertised.
  - Also they are often just a waste of time, too.
- **Commercial VPNs do not offer what they sell!**
  - For example it took me over 30 minutes to find out that NordVPN is blocked in Jordan!
  - Nevertheless NordVPN advertises itself as "Best VPN for Jordan".
  - However an SSH tunnel to my own VPS worked completely flawlessly within a fraction of a second.
  - Jordan offers very fast Internet, but apparently blocks all VPN on IP level.
- Read:
  - If a commercial VPN does **not** work, you **definitively need** it!
  - However if a commercial VPN does work, **you probably do not need it at all**!
  - This is due to legal issues in such countries.
  - Countries where you need a VPN, a commercial VPN **must not work**.
  - Else the probablility of a "sudden fatal accident" of their CEOs rises above 100%

Also note that all commercial VPN I know **do not offer P2P**.

> P2P is a fundamental part of the Intenret.  For example it is needed for WebRTC.
> Read: VideoChat and similar things rely on P2P.  **Commercial VPNs do not offer that!**
>
> However if you create your own VPN, you can use P2P!  This usually is even cheaper
> than a commercial VPN.  (Read:  I do not know any commercial VPN which is cheaper.)

If you want to protect your privacy:

- A commercial VPNs cannot offer any real benefit or guarantee on privacy!
- The only person who can protect your privacy is you on your own!

If you want to hide your IP:

- A commercial VPNs cannot offer any real benefit or guarentee in hiding your IP!
- They are still legally bound to the terms of the country they operate in.
- And usually those commercial VPNs operate in all countries they sell their VPN to.
- This includes your country.

If you want to protect against your IP is attacked:

- A commercial VPNs can help you.
- However there are usually much cheaper solutions than that.
- Also if your IP really is attacked, this will terminate your commercial VPN account very soon.

So what is a VPN for?

- As luxury
  - It is a good thing that luxury exist.  But luxury is just expensive and superfluous!
  - So if you do not know yourself why you really need a VPN, it is just such a luxury.
- A commercial VPN is good to test connectivity from many places on the earth.
  - This is what I use it for
- A commercial VPN is good to test GeoLocks
  - If you create a GeoLock, you need the VPN to be able to block it properly
  - So only very naiive implementations of GeoLocks can be circumvented with a commercial VPN
  - Even if a VPN works for circumventing a GeoLock today, you may get into trouble sooner or later.
  - Do not trust what marketing says:  I know how to prevent VPNs from circumventing GeoLocks, and I did not even dive any deeper into that matter!
- A commercial VPN is good for experiments
  - This is what I use it for, too.
  - So the use of commercial VPNs in this respect is extremely limited.
  - For example I am not allowed to **test attack vectors against my own computers**.

## Free VPN Alternatives

There are free Alternatives which offer **real anonymous Internet** access:

- [TOR](https://torproject.org/)
- [I2P](https://i2p2.de)

If those do not work in a country out of the box, better do not try to circumvent the block.
Because this is likely to be against the law in those countries which are blocking those.


## Free VPN to protect in public WiFi networks

Most Routers (like Fritz!Box) allow to run a VPN on your own Broadand Internet Connection.
If you want to protect your internet access on public WiFi, just use this one your router comes with!

- Note that this works where a commercial VPNs work, too.
- However if it does not work, then a commercial VPN will not work, either!


## Your own VPN for less than 5 EUR/month

If you really need something like a dedicated IP or want something, which really works
even in blocked countries all over the world, then the best thing is to run your own VPS.

VPS, not VPN.  VPS stands for virtual private server.
This is a VM and there are quit capable VPS out there for less than 5 EUR/month!

> Typically with a commercial VPN the price is higher, because they charge for all pieces.
>
> Also your VPS will offer P2P, too, hence you can use things like WebRTC without the need
> for rakes like TurnServers.  (Also the VPS can act as your own TurnServer, of course!)

Operating such a VPS is not straight forward, though.  But perhaps in future I am able to
offer some Ansible Playbook to automatically install it.  (Such that you can bootstrap
it with CloudInit.)

There is not much to it.  If done properly, maintaining such a VPS is just a click of a button.

### I am working on this

However please not expect something before 2030.  It has very low priority.

The idea behind this is:

- Be able to deploy a VPS on the Internet with just a few clicks of a button
  - It must maily maintain itself
- Accompany these with some shared Raspberry PIs

This should:

- Offer some Extranet
- Be able to be administered using some primitive web pages
- Be undetectable

The latter means, the VPN should look like normal HTTP/2 or HTTP/3 traffic and use the same ports.

Hence to block it:

- Either nearly everything must be blocked
  - Read: You have no unencumbered Internet connection
- Or somebody must block one explicitly
  - Read: By observing what you do (probably with a camera looking at your keyboard and screen)

Note that this solution shall permit Domain Fronting, too, via some Gateway.
And it shall run at least under:

- Windows
- Linux (x86 and AMD)
- Android

Yes, that's a lot to do.  Hence it will take a lot of time.  It will be done bit by bit.
Each bit only when the need arises.


# FYI (old copied babble)

Here are my criterias why I use a VPN:

- It's just a tool to allow me to check things using different IP addresses.
- It also allows me to get things out of the way of another party.
  - Like when I try to trace something what could be an attack.
  - It's bad to offer a potential attacker additional bits of your infrastructure by exposing your IPs.
- **There also is MeshNET** in NordVPN
  - It allows for different devices which share nothing than NordVPN to interconnect.
  - This comes handy.  Not for me, but others (read: Family)
- It's cheaper than doing it all on my own (for now)
  - Running a single VPS on my own costs around 5 EUR/month and only offers a single country
  - NordVPN costs a bit less and offers various IPs in various countries
  - Note that I am not talking about P2P or incoming connections, those do not work with NordVPN
- Commercial VPN just work.
  - I could do it on my own, as I know how to do VPN from scratch just with the kernel and me.
  - But doing things on your own is additional effort.
  - Using commercial VPNs looks promising to lessen my effort until I find a better solution.
- **Getting fast support 24/7 is an extremly important criteria for me**
  - NordVPN support was already helpful for me to my full satisfaction.  (On Sunday at midnight.)
  - Even that I do not need Support a lot as I am an extremely experienced Network Administrator
  - However with commercial VPNs you need support, as they run their own software
  - (That's why I write this here.  To remind me on myself in future.)
- It is a must that the same solution supports all types of devices I use
  - Linux.  Like Raspberry PI.
  - Windows.  Event that I do not use it here currently.
  - Android.
  - (I do not use any other as my Apple/IOS testmachines went dead after just 3 years.)
 
Here are my non-criterias for using a VPN:

- I do not need to hide.  **If you need to hide, you are perhaps better protected using something like TorBrowser** which comes completely free.
  - At my side, TOR does not offer me any added value.  I am German and hence (still can) live in freedom.  Freedom of speech, thought, habbit and living style.
  - In contrast, TOR is just another Tool I use for several things.  But that I usually want to archive simply does not work with TorBrowser or works worse.
- I do not need to circumvent GeoBlocking or similar.
  - I am happy with what I have.
  - I do not need to watch NetFlix from US or access content YouTube hides from Germans due to some frantic Content Mafia gone wild.  That's non of my business.
  - I do not need to cicumvent upload filters.  Because I am no creator.
- I am (luckily) not in the need to protect my privacy.
  - VPNs cannot magically protect privacy.  If somebody tells you that, it's a lie.
  - VPNs can help in protecting privacy if used correctly.  However this is nothing a normal person can archive.
  - Do not get tricked in using a VPN if you do not previously know what you are doing or why you need one.  It's a false start to start here.
  - Even TorBrowser cannot help you in this respect as long as you do not know how to use it correctly.
  - Being just paranoid is not enough if you need to protect your privacy.  You must also be capable to do so.
  - Protecting Privacy is a very demanding profession.  It's just a little bit more difficult (say 100000000000%, that's a billion times) than Rocket Science.
  - Why?  If a rocket explodes, that's only a tradegy.  But if you fail just a single time for a single bit in privacy, you are doomed for the rest of your life.
  - There is no second chance in privacy.  Period.  AFAICS the only way to get back your privacy is to leave everything else behind like entering witness protection.

I am pretty aware that a VPN cannot protect you if you do nasty things.  That's not what I need at all.
