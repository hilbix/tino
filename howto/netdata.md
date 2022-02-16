> If you are puzzled, I am using [Hetzner Cloud](https://hetzner.cloud/).
>
> This cloud offers private networks like 10.0.0.0 to connect between the machines.
>
> YMMV if you use another Cloud.


# HowTo NetData

## Preface

### First:

As I really have absolutely no idea what the new dynamic documentation pages of NetData want to tell me,
I [cloned and reverted the old NetData Wiki](https://github.com/hilbix/netdata/wiki) such,
hat it can be read and used again.  For me, and perhaps for you, too.

> It is no more fully accurate.  But this is not needed.  I need it for reference.  To understand NetData.

Perhaps in a distant future [I start to grok what the NetData Web Pages](https://www.netdata.cloud/) want to tell me.
But sorry, I utterly fail to understand what is written there.
Not because of my English.  Because I do not understand what they want to tell me.

My problems are:

- I have a bunch of machines
- I want to monitor them
- I want that everything just works and is hassle free
- I want to understand what's going on (on the machines, and the monitoring)
- I want to effortlessly stay informed about now, past and future

The [NetData Pages](https://www.netdata.cloud/) are nice to look at, but give exactly 0 clue to solve any of these problems.
**They are not helpful in any respect.**  They are a problem for itself.

Their slogan on the web pages: "Monitor everything in real time. For free."

Here is my interpretation:

- "Monitoring" - nope, it is not what I call Monitoring.  It is just machine insight.
  - Insight is a part of Monitoring, but it probably the least important part.
  - Insight usually is done from commandline.  Like `vmstat 3`.  Or `psql`.  And so on.
  - NetData presents these insight in a very graphical way.  Which is good and bad at the same time.
  - But it is a good start for insight, as it gives us overwhelmingly many data points.
  - However **Monitoring is something, which should prevent the need for a steady insight** like NetData gives us.
- "everything" - nope.  It may be close, but it does not give me everything.
  - Perhaps it gives you everything.
  - But it does not give me everything I need for monitoring.
  - It does not even come close, sorry.
- "in real time." - that's mostly a problem.
  - Monitoring, for the most part, must not be real time.  Must not!
  - In contrast it must be "in time".
  - That's a big difference and usually excludes each other, as "real time" usually comes too late.
  - "Real time" means, that I work for the monitoring, as I have to watch it in real time.
  - "In time" means, that the monotoring works for me, as the monitoring informs me right in time about the situation.
  - This fundamental difference is like traditional TV ("real time") and streaming ("on demand").
- "For free." - actually is a lie, as NetData comes at a price.
  - Perhaps they mean it does not cost money.  But money is not the problem, as money is a regenerative resource.
  - However NetData takes time and needs surveillance.  This takes a nonrecoverable prices:  Precious time.
  - I do not call this free, I call this "far too expensive".

Conclusion:

As every word they tell is a lie, I really do not understand what the web pages of NetData want to tell me.
Sorry.

> Please do not misinterpret me:  
> The NetData pages lie about the product.  
> But nevertheless, the product NetData is very useful!  
> But to be useful, you first must understand what it can do for you and how this is archived!  
> And this is exectly what the pages there are lacking.


### Second:

I run a sample installation to gather oversight over the current state of my machines.

> This is what this here is all about.  For now.

Here it how the NetData pages work:

- I click on "Get NetData"
- I see "Continue with GitHub"
- I click on it and authorize the login
- Then it tells me to run some script on my machine

And I am out already.  Why?

- I do not want to expose my machines to the Internet.

This is because the first thing **all of my machines get is a firewall** to the Internet.
And hence their command simply does not work at all.
I first have to tear down all of my security to do what they want.
**A complete fail, an absolute no-go.**

> A firewall is the very first thing you need on the Internet.  
> It's the most basic low level thing for your machines.  
> It's nothing complex, it's something just for the very bloody starters.  
> As without a firewall, you already have failed before you start.  
> Right?

This is especially true for the cloud, of course.
When you use the cloud, others provide the resources of your machine.
There is no hardware you control or own.

So in the Cloud there is even a much higher demand for a good monitoring than on physical machines.
As you need to get informed about performance problems, which do not stem from your setup.

Also in a Cloud you do not control the network yourself.  Hence you do not know what's going on.
There is no way to attach some IDS or sniffing or whatever.  You only get what you have paid for.

Hence the most basic Cloud setup looks as follows:

- A firewall
- A load balancer and jump host
- A virtual network
- Your VMs in the Cloud

Each component is cloud based, straight forward and not complex, right?  
Something you can install with just a few clicks of a button, right?

And now you want to add Monitoring.  You head to NetData and .. fail.

None of your VMs in the Cloud are allowed to connect to https://my-netdata.io/
as this is prohibited by the Firewall.

- They provide Debian.  Does not work as the VM has no Internet access.
- They provide MacOS.  Does not work, no MacOS.
- They provide Docker.  Docker is a complete no-go for me.
- They provide Kubernetes.  Well, I do not use Kubernetes, because it's not my Cloud.

Checkmate.

I even tried to [follow this guide, but it failed](https://community.hetzner.com/tutorials/install-secure-netdata).
Already the first command does not work.

> This is due to the Firewall, as it ought to fail!

Hence I need a different approach which is shown here.


### Third:

This all still does not give me 2 things I need:

- Something I call monitoring
- A historic oversight

For now NetData only installs the data probes on all machines, and it works.

Two very fundamental things, which are the fundamental part to do monitoring.

If I ever come around to do that, I probably will tell it here.


# Setup

> Sorry, this is not a complete guide for now.
> Why?
> Because it already runs at my nodes.
>
> So I can no more tell, what I did, to get it set up.
> All I can tell is, how it works now.

The setup consists of following parts:

- A private network 10.0.0.0/24 between all machines
- 10.0.0.1 is the router and firewall (provided by the Cloud)
- 10.0.0.2 is the monitoring host (a VM)
- 10.0.0.3 and above are the other hosts to monitor

