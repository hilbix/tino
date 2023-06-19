> I did not manage to get it running on Android yet.
>
> However it works for OpneVPN under Linux.


# FastestVPN

I bought a lifetime VPN from [FastestVPN.com](https://fastestvpn.com)

Why?  Because it costs less than 1 year NordVPN.

I note it here because many of the things were not able to see before my purchase.

> I am OK with what I got.  Because I did not expect much for barely the price of a dinner for two.


## Lifetime?

Well, sort of.  I do not expect this company to last long, even that it is around for years now.

And for this price I do not expect the fastest VPN either.


## Fastest?

What means 'fastest' to you?

They are probably not really the fastest VPN provider in the world as the name suggests.
But FTR, when using their VPN, `ping 1.1.1.1` improved at my side.

WTF?

- A normal packet
  - Goes out of the network stack of the Client
  - Routed to the remote
  - Remote responds
  - Routed back to the VPN server
  - Comes in the network stack of the Client
- A VPN packet takes another route
  - The packet is received by the Client from the Kernel
  - Encapsulated
  - Goes out of the network stack of the Client
  - Routed to the VPN server
  - Goes into the network stack of the VPN server
  - Decapsulated
  - Goes out the network stack to the Internet
  - Routed to the remote
  - Remote responds
  - Routed back to the VPN server
  - Encapsulated
  - Goes out the network stack of the VPN server
  - Routed to the Client
  - Comes in the network stack of the Client
  - Decapsulated
  - Client hands over the packet to the Kernel

How can the second thing be faster than the first?

Well, it can.  If you have some ISP like I apparently have.

- The direct packet reaches the destination according to the routing policy of your ISP
- The VPN packet reaches the VPN server according to the routing policy of your ISP
  - Then the data reaches the destination according to the routing policy of the VPN service

It happens, that the route to the VPN service plus the route from there to the destination can be faster than the direct route to the destination.  For this the VPN service must be located somewhere, which has a very good network connectivity.  And it must be fast switching.

- This mainly happens if your ISP is not full-stack but uses some monster like CGN (Carrier Grade NAT) for IPv4 connectivity
  - CGN session setup is extremely slow as this involves packet inspection
  - It can add several milliseconds of delay wher 1ms means a signal can travel 200km instead!
  - There are no sessions for `ping` packets, hence the CGN needs to visit each `ping` packet and create a transient session for it!
  - In contrast for UDP, only the first packet needs a session setup, all the following packets are handled faster
  - And with a VPN, the CGN only sees the UDP packets, not the `ping` packets!
- This also can happen if your ISP tries to route the traffic a cheaper route
  - There are premium links and cheap links
  - CDNs like CloudFlare (1.1.1.1 is CF) try their best to move everything near the customer
  - However ISPs see it differently and want to route the trafick the cheapest route
  - This are contradicting rules, so what CF sees is not necessarily the best route, as ISPs are cheating on them
  - OTOH VPN providers also try to place their servers at the fastest connectivity
  - So it is likely, they have a very fast connection to CF
  - And it is likely, they have a very fast connection to your ISP, too
  - So a VPN makes you independent of your ISP trying to do it the cheapest possible way.
  - (This cannot be guaranteed.  Some ISPs are known to degrade their service for some obscurely defined "non-standard usage" like VPN.)
- Also, a VPN server can cheat on `ping` packets
  - **So `ping` is not a very accurate tool to measure speed.**

So is FastestVPN fast?  I doubt I ever can tell, as this is not, why I use VPNs.

- I mostly use VPNs for testing purpose
- As I have more than 1 ISP in parallel, I use more than 1 VPN in parallel
- So this is not, what I mainly use VPNs for:
  - Circumvent GeoBlocking
  - Hide my presence
  - Protect my privacy
  - Circumvent some access restrictions
- This all is a nice to have.  But not a crucial must-have.

In the old days, I ran some proxy hosts on different continents myself instead.
And these cost much more than such VPN services.

**The biggest downside is, that FastestVPN does not offer inbound ports.**
Therefor I cannot fully replace my contental boxes with it,
as those also need to be able to forward incoming data connections.

Note that a single random-but-fixed port on a VPN host would suffice.

- random means, that the VPN can assign me the port, I do not need to chose the port number
- fixed means, that I always get the same port on the VPN server
  - Alternatively the port comes with UPnP, so my software can automatically adapt

However with so few hosts they have, it is impossible to offer incoming ports,
as the simply do not have enough IP/Port combinations for all of their customers.


## Features

This provider has nearly no features at all.  However it can be used without any app.

Downsides:

- No WireGuard
  - The fastest VPN protocol is not supported
- No port forwarding at all.
  - This makes things (like Torrents) slow to unusable, as there is no P2P available.
  - WebRTC should work, though, with the use of external Turn servers.
  - Which is a bit of contradicting, what a VPN stands for
- No session tokens.
  - This means, you share the same login for all sessions.
- No 2FA.
  - This means, your shared login data is not secured whatsoever.
- Only a handful servers (2023-06)
  - 14 PPTP
  - 47 L2TP
  - 72 IKEv2
  - 71 TCP
  - 71 UDP
  - 35 IPSec
  - 35 OpenConnect
  - 59 servers in total worldwide
  - I counted more servers alone in Denmark for another VPN provider
  - Other VPN providers have 100 times as much servers worldwide
- [Unclear usage policy](https://fastestvpn.com/terms-of-service)
  - Very broken German language (I am German).  I try to pharaphrase what I understood.
  - "They terminate accounts which violates the rules."  which is OK for me.
  - "Do not promote their service for illegal activities"  which is OK, too, but:
    They do not write that.  They write it in a way I perhaps did not understand correctly.
  - "No child-abuse, child-exploitation and no child-nudity."  
    This is absolutely OK.  
    However, again, I am not confident I understood them correctly.  
    Another interpretation might be that they disallow legal access to legal nudity of any form, and any form of promotion of exploitation.  
    If this is right, accessing nearly everything on the Internet becomes a violation of their term.  Regardless if you use their VPN or not.  
    In Germany nonsexual every-day nudity (breast-feeding babies, nude nipples, bare penis) is allowed even on films for 6 year olds.  So looking TV from ARD, ZDF, Arte or even a debate of our Bundestag may break their rules!  (ARD and ZDF are Germany's main public service broadcast services.)  
    Also most Opt-Out cookie banners found today (more than 90%!) are clearly unlawful and thus promote an exploit of the DSGVO.  Hence surfing the web is an exploitation according to their rules.  
    I do not think this is meant.  However this is, what they wrote literally.  
    (BTW, according to German law, unbearable rules like those need not be followed and are considered non-written.)
  - "No cyber threats."  OK!
  - "No hacking of their service."  Of course OK
  - "Access their services after being banned."  WTF?  How can this be possible?
  - "Break the law with the help of their service, either your local law or that of the chosen server region."  Which is OK, I think.  
    But again, I hope I understodd them right.  Because what they wrote only applies to one side of the connection
    (and I am not entirely sure which one) and seems not being restricted to happen via their service.  
    So a virtual parking violation on the moon may terminate the account?  Or doing something which is required by law at one end and unlawful at the other.
  - I did not understand "Break the laws of the country/region you are in using our services

> Notes about law:
>
> If you are an EU citizen and using an US server,
> US law may force you to enter data,
> because you come from an US IP.
> However it can be unlawful to export this data from the EU,
>
> (For example, US law requires you to enter your ZIP code.  Which is protected data according to GDPR in EU.)
>
> So due to VPN you must violate one law, either US or EU.  (As US law is often technically enforced it is likely you break your local EU law.)  
> Such problems should never terminate an account.  I'd really like to see some clarification here.

Upside:

- Price.  47 EUR/lifetime paid via Credit Card
- 10 concurrent logins/devices
- No APP needed
- Many other protocols


## What VPN protocol to use?

Top is best

- Wireguard - NOT AVAILABLE for FastestVPN
- OpenVPN UDP **recommended**
- OpenVPN TCP, if UDP not available
- OpenConnect - This OpenSource stems original from the Cisco world and should be secure
- IPSec - note that it can be combined with IKEv2 or L2TP, where L2TP/IPSec seems better choice than IKEv2/IPSec (my opinion)
- IKEv2 - faster then L2TP (at the expense of some safety)
- L2TP - slower (higher overhead) but a bit more secure than IKEv2
- PPTP - should be avoided at all cost


## P2P WebRTC

According to my tests, they do not allow hole-puncing for WebRTC, which is bad, as this disables direct P2P.

So you need to use a MitM like a TURN server, as, sadly, STUN servers are not enough to establish a WebRTC connection.

Background: UDP port forwarding can be implemented different ways:

- Map src only
  - So each user gets exactly a single port
  - Any packet destined to this port is forwarded to the user
  - This is less secure and offers less number of parallel UDP connections
  - It also can be a bit confusing, as multiple client source ports then all get the same mapped VPN port
  - Is like getting a random static port assigned
  - Allows hole punching
  - Problem: Only supports 60000 concurrent users (or even less) per server
- Map src:srcport
  - So each user connection exactly a single port
  - Any packet destined to this port is forwarded to the user
  - This is less secure and offers less number of parallel UDP connections
  - This should work with almost all setups
  - Allows hole punching
  - Is like getting multiple random static ports assigned
  - Problem: Only supports far less than 60000 concurrent users per server
- Map src:srcport:dest
  - This is like a little firewall, so only 'dest' is able to speak with the user
  - This allows may ports to be mapped without much trouble
  - Prevents hole punching, hence needs TURN servers
  - Problem: Allows only 60000 (or less) concurrent connections to a destination (which can become a problem if some user misbehaves)
- Map src:dest
  - Does not support all application types
  - Problem: Only supports far less than 60000 concurrent users per server to the same destination (which can be a problem)
  - Allows hole punching
- Map src:srcport:dest:destport
  - Allows nearly unlimited number of parallel connections (provided you have enough RAM to map this all)
  - This is what FastestVPN does
  - Prevents hole punching, hence needs TURN servers

use different UDP ports for different destinations.  From a security perspective this is better,


## You get what you pay for?

I do not know what you expect.

- If I get only 1 year, this is expensive, due to the few (and therefor slow) servers
- However if I get 10 years VPN, then this 47 EUR are cheap


## Example

Debian 11:

	apt install openvpn
	cd /etc/openvpn/client
	mv /path/to/unpacked/zip/* .
	cat >.x <<EOF
	#!/bin/bash

	cd "$(dirname -- "$0")" &&
	exec openvpn --config udp_files/germany1-udp.ovpn --config login.ovpn
	EOF
	chmod +x ./.x
	cat >login.ovpn <<<'auth-user-pass login.txt'
	echo 'username' > login.txt
	echo 'password' >> login.txt
	chmod 600 login.txt
	./.x

This outputs something like

```
2023-06-19 18:00:22 WARNING: Compression for receiving enabled. Compression has been used in the past to break encryption. Sent packets are not compressed unless "allow-compression yes" is also set.
2023-06-19 18:00:22 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
2023-06-19 18:00:22 OpenVPN 2.5.1 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on May 14 2021
2023-06-19 18:00:22 library versions: OpenSSL 1.1.1n  15 Mar 2022, LZO 2.10
2023-06-19 18:00:22 WARNING: --ping should normally be used with --ping-restart or --ping-exit
2023-06-19 18:00:22 WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.
2023-06-19 18:00:22 TCP/UDP: Preserving recently used remote address: [AF_INET]146.70.139.154:4443
2023-06-19 18:00:22 UDP link local: (not bound)
2023-06-19 18:00:22 UDP link remote: [AF_INET]146.70.139.154:4443
2023-06-19 18:00:23 WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1602', remote='link-mtu 1570'
2023-06-19 18:00:23 WARNING: 'tun-mtu' is used inconsistently, local='tun-mtu 1532', remote='tun-mtu 1500'
2023-06-19 18:00:23 [FastestVPN] Peer Connection Initiated with [AF_INET]146.70.139.154:4443
2023-06-19 18:00:24 Options error: Unrecognized option or missing or extra parameter(s) in [PUSH-OPTIONS]:5: block-outside-dns (2.5.1)
2023-06-19 18:00:24 NOTE: setsockopt TCP_NODELAY=1 failed
2023-06-19 18:00:24 TUN/TAP device tun0 opened
2023-06-19 18:00:24 net_iface_mtu_set: mtu 1500 for tun0
2023-06-19 18:00:24 net_iface_up: set tun0 up
2023-06-19 18:00:24 net_addr_v4_add: 10.16.0.12/16 dev tun0
2023-06-19 18:00:24 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
2023-06-19 18:00:24 Initialization Sequence Completed
```

Well, a lot of warnings.  This does not look good.  However, it works.

Particular:

- `AES-256-CBC` is a very bad algorithm.
  - CBC always is one of the worst modes you can chose when it comes to safety, this is why OpenVPN no more has it in the defaults.
  - However it is one of the fastest modes of operation
- Compression should not be used.  However it makes things faster as the packets become smaller.
- MTU is crucial for a smooth operation.
  - Why isn't it set correctly in the files?
  - It still works
- Port 4443 is non-standard
  - However UDP always is a bit non-standard
- **No server certificate verification method has been enabled.**
  - This is very very very bad, as this allows any MitM to take over your connection to the VPN.
  - However if the server ever changes the certificat, this would puzzle normal users.
  - You can either live securely or like a zombie without brain.
  - They apparently chose to support zombies only
  - You could easily(!) support brains, but they apparently do not want to.  Which is a sad thing.

