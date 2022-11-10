> The perhaps most problematic part of NordVPN is, that they do not offer their App via Microsoft Store.
>
> **Under Linux and Androd NordVPN integrates with the OS' standard update mechanisms.  On Windows they do not.  Why?**


# NordVPN

- I do not endorse nor promote NordVPN.
- I am not affiliated with NordVPN either.
- I do not know if there are cheaper or better other VPN solutions.
- I do not care if NordVPN tracks something or not.

For more see FYI at the end.


## Linux

I mainly use Linux.   So Linux support is crucial.  And it works.

### Quickies

#### Setup

Until I find a better and more secure way:

	sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

Note to self:  Find out how to use native tools like OpenVPN or Kernel's WireGuard somehow.


#### Login

- <https://my.nordaccount.com/de/dashboard/nordvpn/>
- Scroll down to "Token"
- Create a token
  - You can give it for some time or without expiry
- Copy token
- `nordvpn login --token __PASTE_TOKEN_HERE__`

#### IPv6

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




# FYI

Here are my criterias why I use a VPN:

- It's just a tool to allow me to check things using different IP addresses.
- It also allows me to get things out of the way of another party.
  - Like when I try to trace something what could be an attack.
  - It's bad to offer a potential attacker additional bits of your infrastructure by exposing your IPs.
- **There also is MeshNET.**
  - It allows for different devices which share nothing than NordVPN to interconnect.
  - But I do not use if for now.  But is is good to have.
- It's cheaper than doing it all on my own (for now)
  - Running a single VPX on my own costs around 5 EUR/month and only offers a single IP
  - NordVPN costs a bit less and offers various IPs in various countries
- NordVPN just works.
  - I could do it on my own, as I know how to do VPN from scratch just with the kernel and me.
  - But doing things on your own is additional effort.
  - Using NordVPN looks promising to lessen the effort to me.
- NordVPN support was already helpful for me to my full satisfaction.  (On Sunday at midnight.)
  - **Getting fast support 24/7 is an extremly important criteria for me**
  - Even that I do not need Support a lot as I am an extremely experienced Network Administrator
  - However NordVPN provides their own software, and such software has issues.  (That's why I write this here.  To remind me on myself in future.)
- I like it that the same solution supports all types of devices I use
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
