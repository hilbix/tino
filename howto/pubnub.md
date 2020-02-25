# PubNub

Today you no more need infrastructure yourself.  All you need is a browser which uses some shared Internet connection.

The problem with this is, that you cannot create your own services yourself this way as you can connect to others,
but others cannot connect to you.

If everybody would be in the same situation, actually nobody can talk to each other directly, as you cannot connect nowhere.

There is STUN, but what if your shared Internet connection does not support this?  You are not allowed to open a port.
For security purpose or something completely different.

There is TURN, but TURN services usually are not public.  So you would need to host your own.

However there are quite some free services out there which can help you with nearly all your needs:

- There is GitHub, where you can publicly host your public data.
  - This even allows you to publish your static pages of your own domain via HTTPS.
  - If you need more there are some public web page services, however I do not use them so I cannot recommend any.
- There is CirrusCI which integrates perfectly into GitHub, which can be used to compile things or do docker easily
  - [Another variant is to run Linux in the browser](https://geekflare.com/run-linux-from-a-web-browser/)
- There are some free computing services, too, however I do not use them
  - Instead I use some [VPS for 3€/month](https://cloud.hetzner.com/)
  - Perhaps there are even cheaper services but I know Hetzner for years, they offer excellent service, stability and performance
  - But if done properly you do probably not need that

This here is about PubNub, a service, which allows you to create messaging channels.

**PubNub is a bit gaga when it comes to security**, but we are talking about public services, right?
So security is not much of a concern here.  Everything is done in public anyway, so there is no need to hide anything.

## Getting started

PubNub is very easy to get started.  However the problem here is, as always, they do not start at the minimum.
There is too much information missing.  Hence I wrote this here,
because they do not tell from the start how easy it is to use their API.

They offer vast library bindings with a huge amount of complex and hard to understand code.
But you do not need anything from that.  Just the commandline and `curl` is enough!

Why don't they tell you?  I have no idea.

## Prep

[Register with PubNub](https://dashboard.pubnub.com/signup)

- You can use a scratch Google Account for this

Create your first test application
- You can disable all features
- All you need are the two keys: Publish-Key and Subscribe-Key

Put the keys into your environment:

	PUBK=pub-c-XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
	SUBK=sub-c-XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

Also define a test channel to use

	CHAN=test

## Try

Then open 2 terminal windows with this settings.  In the first:

	curl -gD- "https://ps.pndsn.com/v2/subscribe/$SUBK/$CHAN/0?tt=0"; echo

This gives you something like

	HTTP/1.1 200 OK
	Date: Tue, 25 Feb 2020 12:31:36 GMT
	Content-Type: text/javascript; charset="UTF-8"
	Content-Length: 45
	Connection: keep-alive
	Cache-Control: no-cache
	Access-Control-Allow-Origin: *
	Access-Control-Allow-Methods: GET
	
	{"t":{"t":"15826338962908122","r":12},"m":[]}

Remember this settings:

	PUBT=15826338962908122
	PUBR=12

Now repeat this request:

	curl -gD- "https://ps.pndsn.com/v2/subscribe/$SUBK/$CHAN/0?tt=$PUBT&tr=$PUBR"; echo

This request will block for a while.  In the second terminal do:

	curl -gD- "https://ps.pndsn.com/signal/$PUBK/$SUBK/0/$CHAN/0/\"hello-world\""; echo

You now will see something like:

	[1,"Sent","15826341938400063"]
	
and in the other window

	{"t":{"t":"15826341938398226","r":12},"m":[{"a":"4","f":0,"e":1,"p":{"t":"15826341938400063","r":12},"k":"sub-c-18c02f88-c57d-11e9-8ada-366022f02051","c":"test2","d":"hello-world"}]}

That's it.  To continue on the first windows, use

	PUBT=15826341938398226
	curl -gD- "https://ps.pndsn.com/v2/subscribe/$SUBK/$CHAN/0?tt=$PUBT&tr=$PUBR"; echo

This way you get the next message, if there is one ever.

## Notes

- The above uses the SIGNAL API, which only can send short JSON messages.
- Signals are cheaper than messages.
- You can longer messages via their API and can use POST to transfer data
- Everything must be JSON
- And they allow a reasonable amount of messages in their free tier.

If you arer a company the free tier probably cannot solve your problem.
However for a normal human being, the monthly free tier should be more than enough.

# Security gaga

The only problem with PubNub I can see is, that you need both keys to publish.
Hence anybody who wants to send you a message also has the subscription key, so can receive messages on your behalf or abuse your credentials.

I do not understand why both keys are needed in that case.  But it is as it is.
