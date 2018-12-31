# Configuring DHCPCD

RTFM [dhcpcd.conf](https://www.daemon-systems.org/man/dhcpcd.conf.5.html)?  Nope.
Of course the most important things are not explained there.
Example: `ip6_address`.  Grep for it.  It isn't there.

> How is one expected to be able to manage something which simply isn't documented at all?

## Problems

### Point-to-point

- https://unix.stackexchange.com/questions/433439/how-to-set-a-static-ipv6-default-route-with-dhcpcd

    DEVICE <---PTP---> Machine1 <---somenetwork---> Router <---Internet---> Destination
         + <---PTP---> Machine2 <---somenetwork---> +
         + <---PTP---> Machine3 <---somenetwork---> +
         + <---PTP---> Machine4 <---somenetwork---> Destination
         + <---PTP---> Machine. <---somenetwork---> Router <---somenetwork---> X
         + <---PTP---> Machine. <---somenetwork---> Router <---Internet---> not reachable Destination
         + <---PTP---> Machine. <---somenetwork---> Machine 0.0.0.0/0
         + <---PTP---> MachineN <---somenetwork---> and so on

It'S extremely easy to express this in IPv4:

- Setup a PTP interface
- Place the default route over it
- On MachineX place a back route over the PTP interface.
- Done

How is this done with IPv6 and DHCPCD?  Do DEVICE and Machine really need a routing kernel for this?

Please note:

- DEVICE is no router
- MachineX is no router.
- Only IP forwarding is enabled on both sides based on routes.
- The link between DEVICE and Machine is using some socket like transport (like SPI or `ssh`).

This is the norm, not the exception.  Think of IPoAC or tunnels like from The Boring Company.
