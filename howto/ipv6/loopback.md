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
- `64:ff9b::127.0.0.1/104` Possible but a bit weird, as `64:ff9b::/96` is meant to be routed to the NAT64 gateway
- `100::127.0.0.1/104` very bad idea
- `2001:db8::127.0.0.1/104` bad idea

I really have no idea why, but this is what I observe on my side:

- `::ffff:127.0.0.1` fails with "Invalid argument"
- `::ffff:0:127.0.0.1` gives me the desired `Destination unreachable: No route` due to the missing interface.

> T.B.D.

## Overview of IPv6 routed address space

T.B.D.

## Overview of IANA reserved address space

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

- `::/128` Unspecified Address
- `::1/128` Loopback
- `::/96` DEPRECATED IPv4-compatible addresses
- `::ffff:0:0/96` IPv4 mapped
- `::ffff:0:0:0/96` IPv4 translated
- `0064:ff9b::/96` IPv4/IPv6 translation
- `0100::/64` DISCARD
- `0200::/7` DERECATED
- `2001::/32` Teredo Tunneling (I have no idea)
- `2001:2::/48` DISCARD (corresponds to `198.18.0.0/15`)
- `2001:20::/28` ORCHIDv2 (I really have not the slightest idea): Not routed on Internet
- `2001:db8::/32` EXAMPLE
- `2002::/16` 6to4 (retired?  Anycast?)
- `fc00::/7` Site Local: Not routed outside your own network *comares to: IPv4 Private)
- `fe80::/10` Link Local
- `fec0::/10` DEPRECATED
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
