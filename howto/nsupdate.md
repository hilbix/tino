# How to use `nsupdate`

It looks like this is a very well covered deep (dark?) secret.

- There is a manual page, but it does not cover the information in a way, that you can understand how to use it.
- There is information on the web about some details, but those bloggers do not show the whole story, only some bits, which do not fit together.
- According to some links on some pages, there once was some basic information on how to use `nsupdate`, but those pages are long gone.

Here I try to cover this.  Every bit which is needed to understand how to use `nsupdate` in the real world environment.

## Free alternative

- If you do not happen to have a DNS infrastructure which can provide the `nsupdate` backends,
- and you do not want to operate your own nameservers
- and you do not want to buy services like dyn.com,
- here are example services for alternatives to `nsupdate`
- which are production ready and offer some really usable free basic service.

> Disclaimer:  I never tried this myself, all information was taken from their official websites.

- Cloudflare DNS has an API which allows you to update DNS records on the fly.
  - It does not offer direct `nsupdate` support, though.
  - For small sites / companies, the service is completely free.
  - The free Cloudflare service also includes an extensive DDoS protection for your webservices.
  - For less than 250$/year you even get a Cloudflare paid service which is comparable to a $2000/year service of dyn.com (which does not include a DDoS protection to your infrastructure at all!)
- (If you know free alternatives to Cloudflare which include full fledged DNS, please let me know.)

Some notes on some services with `nsupdate` support (I haven't checked it thoroughly.  My opinion is based on what they offer on their web pages):

- dyn.com: IMHO they are criminally overpriced for what they offer.
  - I was not able to detect a secure setup for `nsupdate` usage.  A secure setup is constructed such, that participants A and B are fully isolated from each other.  AFAICS dyn offers unpropriate sub-minimal security, as all (A and B) must share the same API key and all (A and B) then have full access over everything.  Hence for N clients you need N expensive Dyn accounts.  WTF?!?
  - They tell on their pages, that they offer DDoS-Protection, but customers like Netflix had an outage: Dyn was DDoSsed, and NetFlix became a victim of dyn.com not doing their homework properly.  (If they pretend to offer DDoS, their infrastructure must be able to handle at least the highest seen traffic rates without affecting customers.  Hence their obligation is to be able to handle 3-4 times the maximum DDoS-traffic seen on the planet.  They apparently don't do this.)
  - Dyn lies:  They tell about "Battle-tested reliability and security", but only offer inferior DDoS-Protection.   They tell about "ultimate resiliency" but offer a far inferior DNS-DDoS protection compared to Cloudflare.
  - They are extremely expensive:  A business account costs nearly 2000$/year.  Compare this to 50$/year for 2 VPS.
  - They are extremely limited:  They offer 5 QPS.  WTF?  Those 2 VPS will handle 10000 QPS without any minor trouble.
  - For 7$/Month Cloudflare offers 27 QPS while Dyn offers .38 QPS.
  - For 160$/Month Cloudflare offers 617 QPS while Dyn offers 5 QPS.
  - I do not have any idea, what 8000 QPS costs at Dyn, but Cloudflare offers a complete Enterprise level protection of your domain, including 8000 QPS, if you pay them Dyn's "Enterprise" feature price, including real DDoS-Protection, not only on DNS level but also on Web level.
- (If you think some services are missing here, please let me know.)

Notes about Cloudflare:
  - I have a free Cloudflare account for evaluation purpose, but no Domain there yet.
  - Cloudflare is paid per-domain.  (However if comparing with Dyn, for a secure setup, for security purpose, you need separate accounts there, too.)
  - I do not consider Cloudflare to be cheap.  (But compared to them Dyn is extraordinary expensive.)
  - IMHO Cloudflare offers some reasonable pricing in case you do not want to do it all of your own or do not have the expertise to, say, run a fleet of 500 different VPS boxes all around the world.
  - If I ever need DDoS protection, I definitively will consider Cloudflare (however I will never even consider Dyn).


## Precondition

- You already have a working Primary Nameservice for a domain with existing zone data, not only a simple resolver.
- Either you do all of the DNS yourself, or you have it delegated to some ISP.
- The existing zone information must not be harmed at any time.
- The security of the zone information must not be harmed at any time.  This includes the security of your name servers.
- You want to use `nsupdate` for all your domain needs, like automated `letsencrypt` ACME `dns-01` authentication.

## Essential steps

- Create a domain for dynamic use (called: dyn-comain)
  - This can be either some fresh registered unused new domain in it's entirety.
  - Or you delegate some subdomain of your domain which is not yet used.
- Create a DNS for this dyn-domain.
- Setup this dyn-domain for secure `nsupdate` usage.
- Configure the `nsupdate` functionality.
- Create `CNAME`s for all of your dynamic needs on your other static zones.

## Considerations

- If you need the dyn-domain for real domain usage, you need at least 2 nameservers at different ISPs to serve the dyn-domain.
  - Even the cheapest 1 Core VPS with 512 MB RAM and 10 GB disk is enough for this.
  - Such a suitable VPS costs around 2$/Month.  You need two.  So the complete price is less than 50$ a year.
  - **This is half the price expensive companies charge for their far more limited service**
- If you only need support for `dns-01` ACME protocol, a single nameserver for this is sufficient.
  - This is 
- This single nameserver can be one of your existing DNS, of course.

The example below explains how to use 

## Implementation part A

T.B.D.
