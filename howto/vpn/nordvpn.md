> The perhaps most problematic part of NordVPN is, that they do not offer their App via Microsoft Store.
>
> **Under Linux and Androd NordVPN integrates with the OS' standard update mechanisms.  On Windows they do not.  Why?**

# NordVPN

Please read [README.md](README.md) carefully.  This here is mainly meant as a reminder to myself.

## Linux

I mainly use Linux.   So Linux support is crucial.  And it works.

### Setup

Until I find a better and more secure way:

	sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

Note to self:

- Find out how to use native tools like OpenVPN or Kernel's WireGuard somehow.
- Create an Ansible Playbook with apt keys etc.

```
sudo apt install nordvpn
sudo groupadd nordvpn
sudo usermod -aG nordvpn $USER
```


### Login

#### Variant 1 via Web

- `nordvpn login`
- Copy URL to browser which is printed
- Complete everything until the "Great" screen shows up
- Copy URL from the green button
- `nordvpn login --callback '__PASTE_URL_HERE__'`
  - This last step is not told on their website!

#### Variant 2 with Token

- <https://my.nordaccount.com/de/dashboard/nordvpn/>
- Scroll down to "Token"
- Create a token
  - You can give it for some time or without expiry
- Copy token
- `nordvpn login --token '__PASTE_TOKEN_HERE__'`


### Configure

Whitelist you local networks before running `nordvpn c`:

```
for a in `ip -j r s | jq -r '.[].dst' | fgrep -x default`; do nordvpn whitelist add subnet "$a"; done
```

> This needs `jq` installed: `sudo apt install jq`


## Meshnet

Meshnet documentation is .. bad to non existing:

On Android there seems to be a bug.  If you enable Meshnet and then disconnect from NordVPN, then the MeshNet still stays active.

Which means, all Internet is blocked (because it tries to route via Meshnet, but Meshnet is not available due to NordVPN is offlined).

### Enable Meshnet

```
nordvpn set firewall disable
nordvpn set technology nordlynx
nordvpn set meshnet enable
nordvpn connect
```

```
nordvpn meshnet peer list
```

### Enable node to be used for other peers as VPN server

Once on the VPN server:

```
nordvpn set routing on
```

Then for each peer:

```
while read -r peer;
do
  nordvpn meshnet peer incoming allow "$peer";
  nordvpn meshnet peer routing allow "$peer";
  nordvpn meshnet peer local allow "$peer";
  nordvpn meshnet peer auto-accept enable "$peer";
done;
```

> Sorry, I do not know how to automate this


## IPv6

The good news is, IPv6 works.  The bad is:  It is not obvious how to enable it.

> My thanks go to the NordVPN support for helping me getting it to work.

Not all servers support IPv6.  The Linux client does not automatcally switch to IPv6 enabled servers.
So you have to select them yourself!

> 2022-11-10 there are only 4 servers out there which support IPv6:
>
> - 2 in UK
> - 2 in US
>
> And they do not offer WireGuard protocol, only OpenVPN UDP/TCP and IKE/IPsec

- `nordvpn s ipv6 on`
- <https://nordvpn.com/de/servers/tools/>
- Select "show advanced options"
- Click on "Select security protocol"
  - Type "v6" in the search bar which pops up
- Change the protocol which is listed on the server
  - `nordvpn set technology openvpn`
  - `nordvpn set protocol UDP`
- **At my side it did only work until I connected to the correct region first!**
  - `nordvpn c uk`
- Then connect to the IPv6 server
  - `nordvpn c ukXXXX` (from the selection)

`ping ipv6.google.com` should work now

You can also check on the interface:

	ip a s

This should show something like

> `*REDACTED*` below is where I hid some information

```
16: nordtun: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 500
    link/none
    inet 10.8.2.2/24 scope global nordtun
       valid_lft forever preferred_lft forever
    inet6 2001:ac8:*REDACTED*:2/112 scope global
       valid_lft forever preferred_lft forever
```


# Long texts

## Linux

### TTY install

Here is how to install NordVPN over a TTY line (like `ssh`) with no need of a graphical console.

Following does not work, it fails at step 2:

- <https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Raspberry-Pi-Elementary-OS-and-Linux-Mint.htm>

> **WARNING!** The first step of following is completely insecure!
>
> If you are behind something like Zscaler, anything might happen.  There might be a MitM fully controlling what you download!
> **HTTPS cannot protect you!**  If somebody tells you that HTTPS is secure, this is a lie.  Period!
>
> In future I might add some better way here.  But for now this must suffice.  However **I do not recommend to do it that way!  You have been warned!**

As an ordinary user (you need `sudo` rights):

	sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
	nordvpn login

Then:

- Grab the URL printed
- Open it in a JavaScript capable browser
  - Complete the login in the browser
- A page with "Great" on it shows up
- Your browser wants to start something
  - Disallow that.
- Hover over the "Continue" link
  - Copy the Link

Then (replace `$URL` with the URL you copied.  Keep the quotes!):

	nordvpn login --callback '$URL'
	nordvpn c
	nordvpn set killswitch on

### Intranet

> Note that NordVPN uses a single IP out of the range 10.x.x.x for the VPN at my side.  
> It's a single IP only, so you probably will not notice if you happen to use 10.x on your Intranet.  
> However I do not know what to do if there is a collision.
>
> So I recommend not to whitelist 10.x

You want Intranet connectivity?  Here is how (replace `192.168.0.0/24` with your Intranet IPs):

> You should not do this outside of your private LAN, as opening some IPs for networks you do not control might be not what you want.

	nordvpn whitelist add subnet 192.168.0.0/24
	ip r g 1.1.1.1
	ip r g 192.168.0.0

If both show the same interface (called `nordlynx` or similar) you still have no Intranet connectivity.
This is because your packets destined to the Intranet are routed over the NordVPN interface and therefor cannot reach your Intranet.

> If curious where this routing stems from, do `ip route list table all`

In that case you need to add a route to your default gateway, such that this is routed through the correct interface.
The correct interface can be seen as follows:

	ip r l t main match 192.168.0.0/24

This will list the gateway you need to route to to reach your intranet.  This whole process can be automated as follows (you need to install `jq` for this):

	for net in 192.168.0.0/24;
	do
		nordvpn whitelist add subnet "$net";
		ip r a "$net" via "$(ip -j r l t main match "$net" | jq -r '.[] | .gateway')";
	done

Note that this needs to run at each reboot, as NordVPN does not keep that information across reboots.

`crontab` option `@reboot` is your friend.

> Note that I tried to add the routes with NetworkManager, but it did not work.
