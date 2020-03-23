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

There are several other VPS providers with a similar price

- https://hetzner.cloud/ VPS, so you must run the service yourself
  - 3 EUR for 10 Requests/s with max. 100ms CPU and 5 KB (out)
  - Problem: VPS permanenly limited to 10 MBit/s if traffic limit (5 TB out) reached
  - However: You are in full control, just do not anwswer
  - But: Scalable, but you need to do this yourself


### Monthly unlimited cost

- https://workers.cloudflare.com/ allows 50ms CPU
  - 5 EUR for 5 Req/s
  - roughly 1.30 EUR per 1 Req/s above
  - Problem: Worker stops executing until end of the day if limit reached
  - However: Scales very well

## Conclusion

If you are toying around for yourself or developing, you can use Pipedream or Cloudflare free

- Pipedream is cool
- But Cloudflare seem to be far more powerful

If you have unlimited money or speed is crucial

- Cloudflare

If you have limited resources and know what you are doing:

- Your own VPS in some powerful Cloud
