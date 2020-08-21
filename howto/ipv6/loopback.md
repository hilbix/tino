> These might express my opinion as I might err.  If something is wrong, please open an issue.

# IPv6 loopback

There is only 1 loopback IP address on IPv6.  But you can create more for yourself.

## WTF?!?

No.  This is **not really a WTF**!

There is only one single loopback address because `::1` can be written as `::0.0.0.1` as well.

The original design of IPv6 mentioned `::/96` as the IPv4 compatible address space which directly corresponds to IPv4.
Hence `::1` is `::0.0.0.1` and directly corresponds to `0.0.0.1`.

Nowadays this direct mapping is deprecated (why?), but that leaves us with just a single Loopback address.
(I found something mentioning, that `::ffff:0:0/96` allows to re-use the ipV4 header checksum unchanged somehow.
But I did not really understand the motivation at all.
Any pointer to this out there which explain this in some understandable way?)

> That `0.0.0.0/8` is free and usually not used does not mean that we will not see it becomes used in future if the demand arises.
>
> We probably will keep free `0.0.0.0/16` (or at least `0.0.0.0/24`), but the rest probably can be reused.


## Use `127.0.0.0/8` to create more loopbacks

`127.0.0.1/8` is the well known loopback device of IPv4.  Hence you can use 16 million of loopback addresses as long as you have IPv4 enabled.
But what to do if this changes in future?  Just a single IPv6 loopback device this is a PITA!

So the idea is, stay with your way of using loopback under IPv4 and map it into the IPv6 space.  As all IPv4 addresses can be expressed in IPv6, too,
there will be no incompatibilities (besides the mapped address and the change to the IPv6 protocol).

There are several possible mappings of `127.0.0.1` into IPv6:

- `::127.0.0.1/104` we should not go this route
- `::ffff:127.0.0.1/104` **This is probably the way to go**
- `::ffff:0:127.0.0.1/104` An alternative possibility
- `64:ff9b::127.0.0.1/104` Possible but a bit weird, as `64:ff9b::/96` is meant to be routed to some public NAT64 gateway
- `64:ff9b:1:::127.0.0.1/104` Better than `64:ff9b::/96` but still weird, because this still is meant to be routed to a local NAT64 gateway
- `100::127.0.0.1/104` very bad idea
- `2001:db8::127.0.0.1/104` bad idea

I really have no idea why, but this is what I observe on my side:

- `::ffff:127.0.0.1` fails with "Invalid argument"
- `::ffff:0:127.0.0.1` gives me the desired `Destination unreachable: No route` due to the missing interface.


## `2003::/3`: IPv6 routed address space

> `ff00::/8` Multicast is partly routed, too

[Global Unicast](https://www.iana.org/assignments/ipv6-unicast-address-assignments/ipv6-unicast-address-assignments.xhtml)

> If you don't do it manually, you won't experience all those nice shitload first hand.

- `2000::/16` ???
- `2001::/23` [IETF Protocol Assignments](https://www.iana.org/assignments/iana-ipv6-special-registry)
  - `2001::/32` Teredo Tunneling (I have no idea.  Not routed?)
  - `2001:0001::0/128` ??? 
  - `2001:0001::1/128` [RFC7723](https://www.iana.org/go/rfc7723) local PCP anycast
  - `2001:0001::2/128` [RFC8155](https://www.iana.org/go/rfc8155) local(?) TURN anycast
  - `2001:0001::3/128` ???
  - `2001:0001::4/126`..`2001:0001:8000::/33` ???
  - `2001:0002::/48` DISCARD (corresponds to `198.18.0.0/15`) **(not routed)**
  - `2001:0002:0001::/48`..`2001:0002:8000::/33` ???
  - `2001:0003::/32` [RFC7450](https://tools.ietf.org/html/rfc7450) AMT: Automatic Multicast Tunneling
  - `2001:0004:0000::/40`..`2001:0004:0121::/48` ???
  - `2001:0004:0112::/48` [RFC7535](https://www.iana.org/go/rfc7535) AS112-16 anycast
  - `2001:0004:0113::/48`..`2001:0008::/29` ???
  - `2001:0010::/28` DEPRECATED (was: ORCHIDv1)
  - `2001:0020::/28` ORCHIDv2 (I really have not the slightest idea) **(not routed)**
  - `2001:0030::/28`..`2001:0100::/24` ???
- `2001:0200::/23` APNIC
- `2001:0400::/23` ARIN
- `2001:0600::/23` RIPE NCC
- `2001:0800::/22` RIPE NCC
- `2001:0c00::/22` APNIC
  - `2001:0db8::/32` EXAMPLE **(not routed)**
- `2001:1000::/23` ???
- `2001:1200::/23` LACNIC
- `2001:1400::/22` RIPE NCC
- `2001:1800::/23` ARIN
- `2001:1a00::/23` RIPE NCC
- `2001:1c00::/22` RIPE NCC
- `2001:2000::/19` RIPE NCC
- `2001:4000::/23` RIPE NCC
- `2001:4200::/23` AFRINIC
- `2001:4400::/23` APNIC
- `2001:4600::/23` RIPE NCC
- `2001:4800::/23` ARIN
- `2001:4a00::/23` RIPE NCC
- `2001:4c00::/23` RIPE NCC
- `2001:4e00::/23` ???
- `2001:5000::/20` RIPE NCC
- `2001:6000::/19` ???
- `2001:8000::/18` APNIC
- `2001:c000::/18` ???
- `2002::/16` [6to4](https://tools.ietf.org/html/rfc3056) (retired?  Anycast?)
- `2003::/16`
  - `2003::/18` RIPE NCC
  - `2003::4000/18`..`2003::8000/17` (unused)
- `2004::/14' ???
- `2008::/13' ???
- `2010::/12' ???
- `2020::/11' ???
- `2040::/10' ???
- `2080::/0' ???
- `2100::/8` ???
- `2200::/7` ???
- `2400::/6`:
  - `2400::/12` APNIC (East)
  - `2410::/12`..`2500::/8` ???
- `2600::/6`
  - `2600::/12` ARIN (North America)
  - `2610::/23` ARIN
  - `2610:0002::/23`..`2618::/24` ???
  - `2620::/23` ARIN
        - `2620:4f:8000::/48` Bullshit Bingo: A direct allocation from within an allocation to [AS112](https://www.iana.org/go/rfc7534)
  - `2630::/12` ARIN
- `2800::/6`
  - `2800::/12` LACNIC (South America)
- `2a00::/6`
  - `2a00::/12` RIPE NCC (Europe)
- `2c00::/6`
  - `2c00::/12` AFRINIC (Africa)
- `2d00::/12` reserved
- `2e00::/12` reserved
- `3000::/4` reserved
  - `3ffe::/16` was: 6bone v1
  - `3ffe:831f::/32` was: highjacked by some widely deployed Teredo
  - `5f00::/8` was: 6bone v2


## IANA reserved address space

There are [quite a bit of reserved IP addresses](https://en.wikipedia.org/wiki/Reserved_IP_addresses) for some purpose (note that `WTF` means:
I do not have the slightest idea what this is for, as I did not understand the docs):

- `0.0.0.0/32` Unspecified Address
- `0.0.0.0/8` only valid as source address
- `10.0.0.0/8` Private: Not routed on Internet, **valid in source address of routed packets** (mostly ICMP)
- `100.64.0.0/10` CGN: Carrier Grade NAT
- `127.0.0.0/8` Loopback (does not leave host)
- `169.254.0.0/16` Link Local: local LAN only, not routed on Internet
- `172.16.0.0/12` Private
- `192.0.0.0/24` WTF
- `192.0.2.0/24` EXAMPLE: TEST-NET-1 (like: example.net)
- `192.88.99.0/24` Reserved (retired?  Anycast?)
- `192.168.0.0/16` Private
- `198.18.0.0/15` DISCARD: Not routed on Internet, **invalid** in source address of routed packets.  BCP: **NULL such packets** (used for performance tests)
- `198.51.100.0/24` EXAMPLE: TEST-NET-2 (like: example.com)
- `203.0.113.0/24` EXAMPLE: TEST-NET-3 (like: example.org)
- `224.0.0.0/4` Multicast
- `240.0.0.0/4` reserved, unused
- `255.255.255.255/32` link local broadcast

- `::/8` [reserved](https://www.iana.org/assignments/ipv6-address-space/ipv6-address-space.xhtml)
  - `::/128` Unspecified Address
  - `::1/128` Loopback
  - `::/96` DEPRECATED IPv4-compatible addresses
  - `::ffff:0:0/96` IPv4 mapped
  - `::ffff:0:0:0/96` IPv4 translated
  - `0064:ff9b::/96` [Global IPv4/IPv6 translation](https://www.iana.org/go/rfc6052) (routable!)
  - `0064:ff9b:1::/48` [Local IPv4/IPv6 translation](https://www.iana.org/go/rfc8215) (not routable)
- `0100::/8` reserved
  - `0100::/64` DISCARD
- `0200::/7` reserved / DERECATED (was used for [RFC1888](https://tools.ietf.org/html/rfc1888))
- `0400::/6` reserved
- `0800::/5` reserved
- `1000::/4` reserved
- `2000::/3` [Global Unicast](https://www.iana.org/assignments/ipv6-unicast-address-assignments/ipv6-unicast-address-assignments.xhtml)
  - See above
- `4000::/3` reserved
- `6000::/3` reserved
- `8000::/3` reserved
- `a000::/3` reserved
- `c000::/3` reserved
- `e000::/4` reserved
- `f000::/5` reserved
- `f800::/6` reserved
- `fc00::/7` Site Local: Not routed outside your own network compares to: IPv4 Private)
- `fe00::/9` reserved
- `fe80::/10` Link Local
- `fec0::/10` DEPRECATED (was: Site Local)
- `ff00::/8` Multicast
  - `ff00::/12` are reserved for IANA well known multicast assignments, all others above this prefix can be allocated in their SCOPE:
  - `ffx0::/16` (reserved)
  - `ffx1::/16` interface local
  - `ffx2::/16` link local
  - `ffx3::/16` realm local (broader than link local but smaller than admin local)
  - `ffx4::/16` admin local (broader than realm local but smaller than site local)
  - `ffx5::/16` site local
  - `ffx6::/16` (use for broader than site-local)
  - `ffx7::/16` (use for even broader but less than orgainization local)
  - `ffx8::/16` organization local (for organisations spanning more than one site)
  - `ffxy::/16` (use for things between multiple organizations but less broader than global) 
  - `ffxe::/16` global (whole Internet)
  - `ffxf::/16` (reserved)
