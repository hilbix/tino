# Worker

Workers are small Code-Snippets, which can serve as an application

> If you have additional worker examples with real numbers, (Heroku?) please open an Issue

## Services

- 1 million req/d are roughly 11 requests/second


### Always Free

There is a free tier in Amazon EC2 but only for 1 year.  Afterwards Hetzner is cheaper.

- https://pipedream.net/ 1 Request/s with 15ms CPU and 100 KB (in/out)
  - Note that even the most simple workload seems to take 25ms to 125ms there (always the same script)
  - Problem: Worker stops executing until end of the day if limit reached

- https://workers.cloudflare.com/ 1 Requests/s with 10ms CPU
  - Note that Cloudflare states that even complex workloads often take less than 10ms
  - Problem: Worker stops executing until end of the day if limit reached

### Monthly fixed cost

Hetzner https://hetzner.cloud/ (VPS, so you must run the service yourself)

- Costs:
  - ~~3 EUR for 10 Requests/s with max. 100ms CPU and 150 KB (5 TB outgoing traffic limit per mmonth)~~
  - 5,20 EUR for 20 Requests/s with max. 100ms CPU and 350 KB (20 TB outgoing traffic limit per month).
  - 100 Req/s costs around 26 EUR/Month
  - The Hetzner Cloud scales and is available in 3 regions (Germany, Finland, US)
  - (Update: Hetzner has higher prices now, so a 2 vCPU CPX11 server is best price/effort for microservices and is available in all regions.)
- Problems:
  - ~~VPS permanenly limited to 10 MBit/s if traffic limit reached~~
  - Extremely high additional cost if traffic limit is reached, so be sure to properly limit the traffic
  - However: You are in full control, just do not anwswer, as only outgoing traffic is counted
  - But: Scalable, but you need to do this yourself

T.B.D. I do not know more today.


### Monthly unlimited cost

- https://workers.cloudflare.com/ allows 50ms CPU
  - 5 EUR/Month for 3.7 Req/s
  - 100 Req/s costs roughly 133 $/Month (I am not sure, this is from their example on the CloudFlare homepage)
  - Problem: Excess costs as you pay for more workload
  - However: Probably scales very well
  - I was unable to find out the correct costs, as it looks like the costs are not attributed transparently on their public homepage.


## Conclusion

If you are toying around for yourself or developing, you can use Pipedream or Cloudflare free

- Pipedream is cool
- But Cloudflare seem to be far more powerful

If you have unlimited money or speed is crucial

- Cloudflare

If you have limited resources and know what you are doing:

- Your own VPS in some powerful Cloud
