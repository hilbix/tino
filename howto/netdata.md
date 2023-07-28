**This is not complete yet**

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


# Basic Setup

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
- All VMs are isolated, so cannot directly talk to the Internet
- All VMs run Debian 11
- All VMs have full access to a mirror of the authoritative Debian repositories (so `apt` works)

I am talking of the probably most basic setup here.

The services the VMs provide to the Internet still are directly exposed to the Internet.
There is no Application Level Firewall or something else like an IDS in between.
So the firewall has big holes.  But it only has holes for the services which are provided to the Intenret.

Hence the VMs must be seen to live in a very low level variant of a basic DMZ.
It's nothing highly professional, instead it is something that just works.

This setup is less for security but more for proper administration.
And it is  there to protect me against my own configuration errrors.
Like something, that just works, because it happen to talk to use some external service I am not aware of.
If that external service then fails, I might get a problem.

With external services I think of things like Docker and Maven registries.  Or external License services.
If something needs such things, I want to know it in advance about this fact.
As I do not want to suddenly detect, that something fails at my side, because something failed elsewhere.
This is why the Firewall must not allow arbitrary connections from a VM to the Internet.

> This is also why I cannot and will never use something like netdata.cloud.
> External sevices, especially when free of charge, are an absolute no-go.
> These either must be On Premise (such that I am responsible)
> or must be On Contract (such that I can sue them).
>
> **Everything else is against the law!**
>
> I live in Germany.  The laws I think of are GDPR and Labour Rights (caution: IANAL!).
> The GDPR means, that all (privacy) data must be kept under control.
> But you cannot keep data under control without a contract.
> The Labour Rights mean, that employee data must not cross the Country border.
>
> Monitoring might contain privacy and employee data.  You cannot evade that fact!
>
> For example, if the number of SSH sessions are counted, this counts when empoyees (Admins) log in.
> **This is data which is protected by the DSGVO and Labour Rights!**
>
> Hence **using external (free) services like NetData is against the law here in Germany**.
> My interpretation.  IANAL.  YMMV.  **But you have been warned!**


## The quick and the dirty

    apt-get install netdata
    # If you have installed NetData from somewhere else than the Debian repository
    # DO NOT FORGET to do following afterwards:
    touch /etc/netdata/.opt-out-from-anonymous-statistics

I really have no idea why NetData does this.  **Their defaults violate the law!**
To protect you, your company and your customers and your data, always be sure to do this:

    sudo touch /etc/netdata/.opt-out-from-anonymous-statistics

> I really have 0 tolerance for things like this.  This is not even a pirate way.
> Pirates have even some basic form of honor.  But this just is criminal (in my eyes)
> and **there is absolutely no excuse to implement things like this**!
>
> Luckily Debian is honest and disables such horror by default.  **Thank you Debian Maintainers!**
> It's a real shame that you have to check for things like this on Open Source upstreams.
> I'd vote that packages from upstreams doing things like this must be put into `non-free`
> and be considered and treated like proprietary commercial code (which is Open Source).
>
> FYI: `netdata` is in `main`
>
> **To all those who do not understand this, here are the facts:**
>
> The European Court of Justice has ruled, that, due to the very nature how Germany is organized,
> the `IP` belongs to privacy data here, which must be protected according to our DSGVO.
> **Hence it is against the law in Germany, to use the IP, if it is not strictly necessary.**
> 
> Transmitting anonymous statistics, like NetData does, is never strictly necessary!
> **Hence NetData must(!) inform all users using the IP for this purpose.**
>
> Note that it is not just enough to pretend to inform the users.
> You must document that fact (such that it can be proven in Court!), that you, indeed,
> have informed the user and that the user was, indeed, in a position to read and understand
> this information properly (you do not need to document, that the user has read and
> understood the information.  So if the user choses to not read the information that is ok.
> But this is the choice of the user, not your choice).
>
> **Without such a mathematically correct proof, you violate the DSGVO here in Germany!**
>
> But .. informing somebody using an IP is impossible without using the IP in Internet.  
> And .. due to the one way nature of IP packets, you cannot make sure that,
> AFTER you received an IP, you can, indeed, reach the IP's user to inform that user!
> So you might not have delivered the information to the user, which is required by the DSGVO
> to be deliver to the user, which means, you illegally received and used the IP already!
>
> **You exactly get it!**  This problem explains, why you cannot use Opt-Out in a context like
> what NetData does.  It simply always breaks the law.  Not more, not less.  **Opt-Out in the Internet
> is outlawed, thanks to German Law!**  (Well, not all Opt-Out, but over 99% of the time,
> as it is very hard, near to impossibility, to lawfully use and implement Opt-Out here in Germany.)
>
> This affects everybody in Internet.  If you do not like that, please stay away.
> Of Opt-Out or the Internet.  Choose your likings.


## 10.0.0.x NetData client

The clients are set up minimally.  They all run the probes and forward it to the NetData Host 10.0.0.2.

The main configuration basically switches off everything like the Registry or the Web Interface.  The IPs shown there are chosen such, that they do no harm in case something goes wrong (your firewall goes transparent).  But this assumes, you have no unprivileged foreign users in the same network and network namespace which is used by NetData for communication:

`/etc/netdata/netdata.conf`
```
[global]                                                                              
	run as user = netdata
	web files owner = root
	web files group = root
	bind socket to IP = 127.0.0.1
	memory mode = none

[health]
	enabled = no

[web]
	mode = none

[registry]
	enabled = no
```

Following file **is the important part** and says to forward all data to the NetData Host 10.0.0.2:

`/etc/netdata/stream.conf`:
```
[stream]
	enabled = yes
	destination = 10.0.0.2:19999
	api key = 00000000-0000-0000-0000-000000000000
	timeout seconds = 60
	send charts matching = *
	buffer size bytes = 1048576
	reconnect delay seconds = 5
	initial clock resync iterations = 60
```

> You do not need to change the `api key`, as we will use `00000000-0000-0000-0000-000000000000` below.
>
> Of course you can change and use your own `api key`.
> However, in a secured setup, where only trusted hosts can connect to the NetData Host,
> you do not need a sepcial API key.  It is only a source of potential PITA.
>
> Beware!  A shared cleartext secret like this cannot be used as a security feature.
> It only can be used to protect against accidental misconfiguration
> in case you run several distinct NetData installations.
>
> To sum it up: Such an API-Key is generally not needed and a sign for some wrong design goal.
> Here (probably): NetData requires the API-Key to implement their Cloud service.  Horrible.
>
> Please do not get me wrong:  In case you do something publicly, like a CI ([there is a really
> great one](https://cirrus-ci.com/), then using NetData and NetData Cloud probably is the right thing!
> Then their service is welcomed!  And if you are some lonely person running your own handful of nodes,
> then NetData Cloud (probably) comes handy, too!  And, in Future, when Enterprise support for On Premise
> is offered with a paid plan from NetData, I - really and honestly - wish them a tremendous success!
>
> But for all others, I recommend to stay away from the free plan there to keep your own data private!
> And here the API-Key stays in the way for your solution.  For plain nothing.  That's bad design.
>
> Read:  Opening (explicitely) a port and leaving away the API-Key should work out-of-the-box.
> Protecting this open port can be left to some proper security framework.
> There are plenty:  Netfilter, HaProxy, SSL client certificates, IPv6 Packet Security, whatever you like.
> There is really no need to re-invent the wheel within something like NetData, again and again!

Usually, **NetData automatically detects all the services which can be monitored**.

If not or you want to change something, run:

    sudo /etc/netdata/edit-config

Here you see all builtin NetData probes you can change and configure:

- `charts.d/`
- `health.d/`
- `python.d/`

Note that the defaults are usually fine, such that you do not need to configure anything.


### Where is the beef?

If you are puzzled where all those API-Keys etc. come from,
have a look into the directory `~netdata` (the home of the `netdata` user).

  cd ~netdata
  find . -type f -ls


## 10.0.0.2 NetData Host

The host receives all the data from the other machines.  It also provides the Web interface.
And it keeps the historic data.  Somewhat.  

> And in future, it will forward the data to the real monitoring (Prometheus), too.
>
> NetData does not implement a suitable way to keep or view historic data.
> With historic data I mean 10+ years retention, of course.
> (Some of my services run over 25 years already!)
>
> Currently my NetData host is limited to keep data for around 4 days.
> All older data is discarded, due to limited resources on the host.
> And NetData requires a lot of resources to keep all the data!

`/etc/netdata.conf`:
```
[global]
        run as user = netdata
        web files owner = root
        web files group = root
        bind socket to IP = 127.0.0.1

[web]
        bind to  = 10.0.0.2:19999 127.4.0.1:19999

[registry]
        enabled = yes
        registry to announce = http://127.4.0.1:19999
```


# Special notes

Note that most time the defaults of NetData are fine.

> Like for the MySQL module which monitors MySQL.  But I do not use it.

But sometimes I change things.  I note them here.  For me, not for you.


## PostgreSQL

> You probably do not need to use this configuration.
> It is not a recommendation, but just something I do.

My PostgreSQL config (for monitoring PostgreSQL) looks like this:

`/etc/netdata/python.d/postgres.conf`:
```
socket:
    name     : 'local'
    user     : 'netdata'
    database : 'postgres'
```

with following setting for PostgreSQL:

`/etc/postgresql/*/main/pg_hba.conf`:
```
local all netdata peer
```

Why?  I do not want NetData to run as the `postgres` user,
such that I can see, that NetData got access to PostgreSQL.
This also leaves the `postgres` user free for other things.

Also, if something breaks (in `pg_hpa.conf`), NetData is locked out,
such that I can detect it more quickly.   For examples with upgrades.
