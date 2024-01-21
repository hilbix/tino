> TL;DR for Snap I have 2 requirements:
>
> - The enforced auto update feature has to go (workaround known)
> - Mirroring must be possible (and these mirrors must be usable without coordination later on.  No workaround known and therefor a complete showstopper at my side)

# Reminder to self how to debug `snaps`

```
snap run --shell SNAP
```

This prints some ugly warning

```
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

even that usually it is impossible what they say

```
$ sudo
bash: /usr/bin/sudo: Permission denied
```

as long as apparmor is enabled due to (from `dmesg` run outside of a Snap):

```
$ sudo dmesg -wH
apparmor="DENIED" operation="exec" class="file" profile="snap..." name="/usr/bin/sudo" pid=1709911 comm="bash" requested_mask="x" denied_mask="x" fsuid=1000 ouid=0
apparmor="DENIED" operation="open" class="file" profile="snap..." name="/etc/" pid=1709234 comm="bash" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
```

sigh.  Also most common debugging aids are not present:

```
$ strace
bash: strace: command not found
```

and even if you introduce it this has problems:

```
$ bin/strace /snap/firefox/current/firefox.launcher 
bin/strace: test_ptrace_get_syscall_info: PTRACE_TRACEME: Operation not permitted
bin/strace: ptrace(PTRACE_TRACEME, ...): Operation not permitted
bin/strace: PTRACE_SETOPTIONS: Operation not permitted
bin/strace: detach: waitpid(1720363): No child processes
bin/strace: Process 1720363 detached
```

The trick here is to do following:

```
$ echo $$
1234
```

And then outside of the snap do:

```
$ sudo strace -fp 1234 2>TRC
```

> For some unknown reason `strace -p` still prints to stderr instead of stdout.

and then run the inside:

```
$ /snap/firefox/current/firefox.launcher
Error: cannot open display: :2.0
```

which then reveals the culprit

```
connect(6, {sa_family=AF_UNIX, sun_path="/run/user/1000/snap.firefox/:2.0"}, 35) = -1 ENOENT (No such file or directory)
close(6)                  = 0
write(2, "Error: cannot open display: :2.0"..., 33) = 33
```

which leads to

```
$ ls -al /run/user/1000/snap.firefox/ 
total 0
drwx------  3 tino tino  80 Jan 21 13:09 .
drwx------ 17 tino tino 540 Jan 21 13:09 ..
drwxr-xr-x  2 tino tino  60 Jan 21 16:46 dconf
lrwxrwxrwx  1 tino tino  40 Jan 21 13:09 wayland-0 -> /run/user/1000/snap.firefox/../wayland-0
```

which leaves me completely out of clues.  Where is my 2nd X server?

> Note that it stopped working after running `snap refresh` which refreshed the snap environment.


# [snap](https://snapcraft.io) is considered harmful

IMHO snap is one of the worst designed piece of postmodern software.  It is probably not as worse as SystemD,
but very near it.

> Until now I have not come to the conclusion, that SystemD is indeed harmful.
>
> SystemD is quite different.  It breaks history.  It is a Moloch, the Sendmail of the Inits.  
> Also it is big.  Too big for me to figure out every aspect.  Hence there is the possibility,
> that I am just too stupid to understand it fully.  Hence I would wrongly accuse it to be harmful.
>
> So, for now, SystemD is not considered to be in this area here.  But it can be listed as Honorable Mention.


## `snapd` as SPoF

You cannot cache Snaps, because Snap refuses to be cached properly.

Hence forget using Snap in some offline lab situation.  Either you get direct access to snapcraft.io or you are doomed.

This also functions as **Single Point of Failure**.  snapcraft.io is down or unreachable?  You are doomed as well.

Also there is no corrective.  If you use Snap, your life starts to depend on somebody, who now **is in the power to harm your infrastructure**.
Because there is no alternative.

Just think about it a minute.  Or less.  Because it is true.  Anybody who forces you to depend on his will means, you **get into slavery**.

In contrast look at some properly done things like the Debian Repository.  Not only are there an enourmous amount of distrubuted alternatives of their apt repos,
it is also dead simple to mirror one for your own sake.  To become completely independent of the Debian Community.  If you dare.  But it is entirely possible.

This is freedom.  **In contrast Snap is war.**  You first must abolish this slavery to return to freedom.

> I for my part think, that slavery must be abolished and verboten on the global scale.  All forms of slavery, slavery like that seen in Snap, too.  Period.

There is no caching daemon for Snap like `apt-cacher-ng`, because the inventors of Snap refuse this.  Actively!  Abd they keep snapcraft.io in a state of intransparent Closed Source.  Actively!

Also note, that `apt-cacher-ng` is third party.  It is something completely independent from the apt repos.
Just because they are properly designed.

But Snap keeps everyhing tightly secured and closed.  The even actively refuse to help others to implement something like that.

Why?

I think this is becase that means that they then lose controle over you.
Which means, **Snap wants to control you**.

Perhaps you are masochistic and want that.  I definitively do not want to be hurt by something like Snap.  And I think, this is my human right, too.

Note that, for me, what they tell in <https://youtu.be/BLm3HkZ-sMs?si=BnBMh-PlTmzMJ6eC> makes absolutely no sense to me.

It is like **"Slavery is so incredibly good for you, so you must be enthusiastic becoming enslaved against and you are a moron if this is against your will"**.

Wow.  Please note that I am from Germany.  And I never will forget that worst piece of our own history!

There is some very important difference of Snap and GitHub.  Both are Closed Source, but GitHub is not harmful.

It is easy to get rid of GitHub.  Just do not use it.  Just use something as simple as `git --mirror`.

Hence in Contrast to Canonical, **Microsoft is not acting harmful**.  

I know all the woes people expressed when Microsoft took over GitHub.  All told you "this is the end of GitHub".
Some even left GitHub in favor of GitLab.  WTF?

> Ever had a look at the security records of GitLab?  Really?  So why can anybody out there ever consider that as a viable Alternative to GitHub?

I saw the takeover of GitLab entirely different.  And I was right!

Microsoft was in desparate need for a platform like GitHub.  Also Microsoft does not need to make a living out of exploiting GitHub.
Microsoft now knows how important Open Source is to them, so they understood why it is so important - for them - to offer GitHub to everybody and keep it free to use.

So the exact opposite happened than what people feared.  As I anticipated, GitHub got better.  And it even became better than I imagined!

> And things still improve at GitHub.

So GitHub cannot be compared to Snapcraft.  It is not like comparing Apples with Pears.  And not like comparing Apples with Bananas.
It is like comparing Apples with Poison. (BTW [Apples can kill you](https://www.britannica.com/story/can-apple-seeds-kill-you))

I use GitHub.  Without using GitHub at all.  Thanks to the unique design of `git` this is possible.

> `git config --global url.git@gitmirror.local/github/.insteadOf https://github.com/`
>
> and add repos to this mirror with
>
> `cd ~git/github && git clone --mirror https://github.com/$USER/$REPO.git $USER/$REPO.git`

Using GitHub without using GitHub works like a breeze.  This solution is completely independent of GitHub.
**And even if unexpectedly GitHub vanishes entirely and forever, no harm is done and everything continues to work as nothing has to be changed**
(except for the mirror process).

Now, how do I do the same with Snapcraft?  **I even tried to find it, but did not find any command to properly download a Snap** so I can make up a local
alternative of snapcraft.io!

So do not compare Snapcraft with some Closed Source Cloud Service which is done properly!

### To stress it

To become a central appstore, snapcraft.io does not need to keep the snaps secret.  They do not even need to keep these snaps on snapcraft.io.

> It is nice that they offer the store themself for free.  But is horrible that they do not allow external stores.

This does not contradict safety.  `git` proves that!  All you need is the hash.  Nothing else is needed to keep it secure!
And this can be kept and provided by snapcraft.io.  And this can be done Closed Source.

Because providing such form of security is not harmed by what the server software is.  Either you trust snapcraft.io.  Or you dont.
This does not change if the source ofsnapcraft.io is kept closed.  Because the security trait of the snaps is independent of if the source of the server is open or closed!

However there is a huge difference if you require a vendor lockin when it comes to using this information.
If I know a Snap with certain Hash is marked secure to use by snapcraft.io, why do I have to download it a 1000 times from snapcraft.io when I install it on 1000 cloud VMs?

And why am I required to be vendor locked into snapcraft.io if I want to pull a Snap from a group I trust like Mozilla Firefox?

### Update to `snapd` faults existing Snaps

Also I have an environment, but suddenly the Snaps stopped working.  What happened?  `snapd` itself was updated.  Thats it.

Suddenly my environment became unusable, because I did something they probably have not expected in snap.  Not in the Snaps.  In snap!
And I have not the slightest chance, to fix that myself.  And I am not in a position to make the snap creators to fix their bug.
Because they already have refused to do so.

**Snap is not only harmful.  It already is causing harm!**


### To be more precise

Here are my comments on <https://youtu.be/BLm3HkZ-sMs?si=BnBMh-PlTmzMJ6eC> (30 minutes into this video)

"If you end up with a 170000 snapstores, you degrade that discoverability story."

- This claim is false.  And you know that.
  - We have DNS which contradicts this claim.
  - We have search engines which even work for the completely unorganized case (in contrast snapcraft.io is organized)
  - We have central registries.  Well, that Yahoo failed in that resprect to organize the web is no prove, snapcraft.io cannot do it
  - Editorials and promotion of apps do not need a vendor lockin like snapcraft.io does
  - Hence there is absolutely no problem in discoverability

"and they automatically get published into the store" .. "but it means, the store is now deeply engrained into all of the infrastructure and moving parts of like the backend"

- This claim is not also false
  - and they know it
  - Also it was never true, even not 1970
  - It also fully ignores on how the Internet was built
- They **decided** to do it that way.
  - This is just NIHIL (Not Invented Here Is Lousy) because of refusal of all BCPs
  - This is pure despotism.  Nothing else.
- Now they **refuse** to change that.
  - OTOH I can understand that refusal.  Haveing done something complete insane locks them into the jail of their wrong habbits now.  They no more can escape.
  - But this still does not explain, why they wanted to lock in everyboy else in their own jail from the beginning.
- Decoupling things is as easy as `git push` these days
  - And it already was a long time before snapcraft.io even existed
  - So why have they decided to re-invent a wheel which is not round?

> When I implement something new, I try to implement it on top of something, which is capable to do it.
> I only re-invent wheels myself if they are not round or wrongly designed for the environment I am in.  Perhaps because it is a new environment.
> **But there is absolutely nothing new on delilvering packages.**  This was solved even decades before.
>
> Yes, things have evolved after that time.  So why did they even think of implementing something, which throws away all the good things of the past
> and re-invent something, which is completely unusable crap?  I really do not get it.

"because its got tendrills into all of the infrastructure"

- Thats ok
  - So you can keep the server source closed source.  I do not object to that!
- However this still does not explain a bit
  - Why do they block direct access to the snaps
  - Why is there no way to create a mirror of all snaps from snapcraft.io?

"its a ton of work to actually sort of decouple all of that"

- I am with you.
- But this is whataboutism.
  - It does not epxplain anything to me
  - It is just misleading the discussion
- There is absolutely no need to decouple anything
  - There is absolutely no need to Open Source anything either!
- All you need is to allow the snap client to access a snap mirror
  - And allow to mirror the Snaps in question
  - With mirror I mean full mirror for all architectures involved
  - Because I usually use the same snaps on 3 different architectures
  - And this on several (more than 10) machines

> A farm of 100 PI-Zeros, fully equipped with memory card, power adaptor and 3D printed casing, still cost far less than a single iPhone!
> And are a bit more powerful, too.
>
> Now put a single Snap on them.  Or update it.  Even with a fast Internet this takes ages and becomes a DoS on snapcraft.io so that their blocking kicks in!
> 
> And how run these in some isolated environment (read: PI zeros without WiFi) and keep them updated?
> Really no problem for Debian Apt repositories.  At my side a single PI400 handles these repos for all with no issues at all.
> But it becomes overwhelmed when it comes to snapcraft.io!  (Also my Internet connecticity of 250 MBit/s becomes maxed out for a couple of hours.)
>
> Yes, I do things like "spin up 50 of them from scratch".  Yes, this does not need WiFi.

All it needs are following very simple things:

- Allow snapd to access a mirror instead of snapcraft.io
  - This does not mean a different snapcraft service or self hosted snaps.
  - This even does not mean something like a proxy.  There can be proxies, but this here is different.
  - It must be possible to access the mirror via filesystem
  - It should be possible to acces the mirror via web requests
  - With or without SSL.
- Allow snapd to fill that mirror from snapcraft.io
  - Download and update the mirror with the snaps from snapcraft.io
  - Download and update the authority/security information from snapcraft.io

That should be farily easy to implement for somebody who has access to the closed source of snapcraft.io.

- However it is hard to do it with reverse-engineering.
- Also, according to the Snap people, everything is "fast moving".

Keeping things updated should also be fairly easy to update for somebody who has access to the closed source of snapcraft.io.

- Because then it fits in the existing code base and the updates come naturally with near to no overhead.
- However with reverse-engineering this is a major obstacle, nearly impossible to maintain!

Read: Not or refusing to do this, snapcraft does harm.  And they reject this with the entirely wrong arguments.

**It is not about open sourcing snapcraft.io.  It is all about providing freedom to the community!**

And this does not need to open source the server code or to detangle anything in the Infrastructure at Canoncical.

It just means to put some mirror capability into the `snap` command.  That's all and really nothing spectacular or difficult!

> There is absolutely no need to mirror everything.
> All there is to "cache" something on one machine and be able to reuse that "cache" from a different machine.
>
> Nothing complex and something done for decades.

I know you voluntarily designed things such, that caches are not meant to exist.  But this was not only by-choice.
I think, this was a requirement.  Because there is really no good other reason, the only conclusion can be,
that that you want to take over the world and enslave everybody.

So please prove me wrong and add a properly designed mirror feature, such that `snap` can be used in an offline fashion
without the need of network access.

Again to stress it:

- First Machine downloads everything into a mirror.
  - This is either networked or uses another mirror.
  - This machine does not know anything about other machines.
  - This machine and the other machine do not need to interact at all.
- Another Machine then reuses this mirror to update
  - This machine may have no networking at all (PI zero without W)
  - The mirror just has to materializes there somehow (like plugging in some USB stick)
  - This could happen a few years or even decades later (for example to compare how some old production would have run on the new but different architecture)
- Another Machine can only update or mirror, what was mirrored by First machine, of course.
  - So there is no need to mirror all the stuff on snapcraft.io!
  - But I do not object, if you need to download everything.
  - I have enough big machines with a fast internet connection in the cloud.
  - And a very good, easy to use and robust sync algorithm (ZFS with dedup)

This is what a proper mirror looks like.  [And I know you dislike doing that](https://askubuntu.com/a/1236260/164798).
But saying, it is too much work is just a weak excuse.  Its 2024 now.  Its already overtime to do so!


## The chance to win against `snapd` is lower than the chance to win at a casino slot machine

Suddenly chrome no more worked.  The error was:

```
Content snap command-chain for /snap/chromium/2655/gnome-platform/command-chain/desktop-launch not found: ensure slot is connected
```

Whatever this wanted to tell me.  I found a closed bug on `snap`.

> Apparently this is a known bug in `snapd` **which will never be repaired** because it is considered something which ..
> Well, read yourself:  <https://github.com/snapcrafters/discord/issues/135#issuecomment-1455074024>
>
> BTW this **definitively is a bug in `snap` itself** because it cannot be that packages go harakiri thanks to snap being incapable updating them properly.

How to resolve?  As read in above linked comments.

- `snap connections chromium` -- list all the connections of chromium
- Then find out which connection does not work.  I did not find a reliable way to find out which one is the problem.
  - However I found out that the `gnome-42-2204` was missing at my side, too
  - So I installed it
- `snap install gnome-42-2204`
- `snap connect chromium:gnome-42-2204 gnome-42-2204:gnome-42-2204`
  - I really do not know what this means.
  - I tried to find out [but the documentation left me in the dark](https://snapcraft.io/docs/interface-management)
  - I understand the words, but I really do not understand what they want to tell me.
  - I only understand things like this if there is no riddle in between
- In `snap connect <snap>:<plug interface> <snap>:<slot interface>` there is a hidden riddle not explained anywhere
  - `<snap>:<plug interface>` is `chromium:gnome-42-2204` as shown in `snap connections chromium`
  - Finding this is the first riddle
- How `<plug interface>` relates to the snap name is the second riddle.
  - If you are lucky, both are the same?
  - Does this assumption hold?
  - Always?
- `<snap>:<slot interface>` is ..
  - I have no idea how to find this, because it is not documented
  - With the second riddle solved, you can assume, that `<snap>:<slot interface>` starts with the snap which came from `<plug interface>`
- How to find `<slot interface>` if it does not happen to be the same as `<plug interface>`?

They simply do not resolve these 4 riddles.  With 4 riddles with "only" 20 possible solutions each, you have 160000 possible solutions.

The odds of casino slot machines are roughly 1:20. Hence the odds of `snapd` are much worse ..


### Why?

The design priciple of Snap is out of bounds.  **Snap contradicts the design principle "do no harm"**.

This entry here is earned due to following fact:

- https://forum.snapcraft.io/t/disabling-automatic-refresh-for-snap-from-store/707


### What is the bug?

The bug is, that the automatic update feature of `snapd` does harm.

It already did so at my side, it caused some automated process (utilizing chromium) to fail
(due to some known bug when updating snaps while they are active).

> They alredy know about this!  And they declare it as some unsolved problem!
> And they refuse to solve it even that they know how to resolve it!

The problem is the design principle of `snapd`.  They have one fact set, and they refuse to change it:

**Updates are installed unconditionally after 60 days.  No matter of fact.  Unconditionally.  Brutally.**

There is no other way than to disable Snap completely.  Either update or bust.

## Why does this harm?

Because there is a non 0 probability, that **people will die due to the design principle of snap**.  It's as easy as this.

There is no excuse for this.  If somebody dies because update feature of snapd cannot be disabled,
this is not a design flas of the process using snap, it is a design flaw of snap.

Why?  Because Snap implements it this way.  It gives you no way to do it properly.

> People do nasty and wrong things.  If I design software, I must keep that in mind.
>
> I am not talking about software being used the wrong way:
> 
> You can kill people with a knife, but the knife's manufacturer is not guilty for this, as you cannot construct a safe knife.
> The primary use of a knife is to be used for some non-harmful purpose (cutting, eating, hospitals, etc.).
> While the primary use of a weapon is to use it for some harmful purpose (shooting, killing, hurting).
>
> Hence a weapon manufacturer is responsible for the death of the people killed with the weapons,
> as a weapon is explicitely designed to do harm.  The whole purpose of a weapon is to hurt, else it wouldn't be a weapon.
> As hurting is implemented by design principle, there is a death probability of non-zero on purpose.
> This is the guilt of the manifacturer.  Regardless what he says.  It's his fault.  Period.
>
> **Constructing something with a design to explicitely having a higher probability of hurting others is a fault.**
> The only excuse is, that there is no better way of desiging it, so that the non-0-probability cannot be evaded,
> while the primary design principle must be to not hurt others.
> 
> There is no better way (yet) to design a knife or scalpel.  There is simply no alternative.  
> **But there are alternatives to harmful weapons.**  Many of them!
>
> Example:  Take a modern armoured car into the dark ages.  It will be a monster as barely any weapon at that time
> will be able to penetrate it or harm the people inside.
> (Exception probably is only the Trebuchet throwing 1 tonnes rock on it.)
>
> So advanced modern civil technology is capable to counter military weapons after some time.
>
> All we need is to follow this path ultimatively and to obsolete weapons and military conflicts.
> All you need is to start considering it!
> 
> No, I do not tell that this is easy!  Or that it is cheaper than doing it the military way.
> And it even might harm us (in contrast to the others) when we do it until we reach peace.
>
> All I say is that it can be done.  If we want.  And it can be done without purposely hurting others.
>
> That's the human way.  (Note that the human nature is completely different.  Human nature is entirely destructive.)

If somebody does not disable auto-update of Snap and somebody gets killed due to this, this is a bug.

If the "somebody" forgot to do so, the Bug is the "somebody"'s fault.

**However if Snap refuses to disable auto-update, the Bug is Snap's fault!**

And Snap refuses to do so.

So if somebody does something with the help of Snap and the auto-update causes a death, this would be the fault of Snap.

Well, the probablility of this might be very low.  However it is non-0.

Hence **Snap fails to implement the "prevent to kill people by design" principle**!

Or in other words:  **Snap must be considered harmful** as Snap might kill people.

q.e.d.

### Postdictum

At the beginning, I wrote that Snap is very badly designed.

This is not only by the lack of design principle to not hurt others.  It is also because it forgets about the need
of at least 25 years of computing.

> Note that they share this property with SystemD.  SystemD implements a lot of advanced things.
>
> However it completely forgets about the needs of the last 25 years (at least).

For example what you cannot do with Snap the easy way:

- Get rid of no more used stuff.
  - Compare `git`.  As in `git` there is some automatic Garbage Collection built into Snap.
  - However unlike `git` you cannot enforce the Garbage Collection.  Snap always keeps a trail of garbage.  Always.
  - And there is no way to get rid of this [except by reinventing the wheel](../howto/.apt) on yourself.
- Kill processes which are under Snap's control
  - Unlike Linux Containers and `schroot`, Snap offers no way to stop all processes of a certain Snap.
  - I really have no idea why they do not implement that, as again, you can implement that on your own.
  - But it is error prone and depends heavily on the target architecture.  So it needs to be a feature of Snap!  But isn't.

> This list probably is incomplete.
>
> But everything above can be found elsewhere long before Snap.
> All of this are principles which must be accounted for if you create a new package manager.
> Else it is just waste.  Something creating grief and hurt.

If you do something new, you need to do it properly.  For example `git`.  It did something new, and it did it properly.

You may be loving `git` or hating it.  But you cannot evade the fact that it did everything properly.
And there is no design principle hurting anybody.  If something is considered useful to others, it will become part of `git`.

> For example, under the hood `git` contains advanced tree algorithms like Traveling Salesman.

In contrast to Snap, where the "enforce update, always, no questions asked, no control possible" is hurting others.  Already.
And this is not because "we cannot do it".  
It is because of "[we can do it but we refuse to do it because we are in the position to decide so](https://forum.snapcraft.io/t/disabling-automatic-refresh-for-snap-from-store/707)".


**That's one of the basic ways on how to hurt others.**

## For the benefit of the reader

We are admins.  So we are in control.  Hene there is a way to disable Snap's autoupdate feature, of course.

However this involves following steps:

- [Disable `snapd` entirely](https://askubuntu.com/a/1269770/164798)
- When you want to update
  - Start `snapd`
  - Do the update
  - Stop `snapd`
- When you want to start a Snap
  - Stop `snapd` from communicating with the outside world
  - Start `snapd` for a short periode of time
  - Start the Snap (this needs `snapd`)
  - Stop `snapd` again
  - Allow `snapd` to communicate with the outside world

However this is like shooting yourself in your foot in case you are hungry.
Because then you get into hospital, which then offers you a meal.

As Snap is now inevitable part of Ubuntu (you won't get updates on Chromium if you refuse to use Snap),
there is no proper way to evade Snap.  **Hence we have to live with this shit.**

> Like we have to live with SystemD.
> 
> Except that living with SystemD is a lot more easy,
> because some parts of SystemD are better designed then there was before.  Parts.  Not everything!  
> But with Snap I cannot see anything better designed than others.  It's just different.  But no better.

Trying to evade Snap is like trying to evade Earth.  
One can probably leave Earth in the hope to find another Planet with some properly implented Humankind.  
But this is not very feasible today.

> Having said that I must confess:  
> If somebody offers me a trip to Mars, one way, with the option to be able to properly live my life there,
> up to my inevitable death (without a premature end of life due to being abandoned or similar)
> I would **immediately** accept this offer, even if it's a bit risky!  (This is not a joke.  It's an offer!)
>
> (Note that my weigth is 120kg plus, excluding freight.  So yes, I am expensive.)
