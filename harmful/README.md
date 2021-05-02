In this area I list software which is **considererd harmful**.

Harmful is every piece of software, which was constructed with a design descision,
which either **harms people or may even cause deaths**.

This is not about bugs.  It is about software written without peace in mind.
Software which contradicts what I call the human principle.


## Background

When I was 23, so over 30 years ago, something happened.  It did not change my life, but it changed the way I design software:

**Some piece of software I wrote almost killed somebody!**

This always reminds me to think about following at each design descision deeply:

**How many deaths I am willing to accept due to decisions I made** (not only but mostly) in my software design?

This leads to two questions **when desiging software**:

**How high is the probablitly of a death?**

and

**How much harm (probability-wise by the software) is acceptable?**

To all those questions **the only answer can be a big fat `0`**.

Or said otherwise:  **It is a bug** if any of the three questions above is **not a big fat `0`**.

And it's not a small bug.  It is probably the biggest bug possible with the highest rating available.
**Something which must be changed immediately**.

We are all humans, right?

- So our topmost priority must be, to not risk somebody else is harmed or killed, right?
- So our products must be constructed as safe as possible, right?
- So every decision we do in our products must be done such, that, even under the most weird even improbable conditions, as few harm is done as possible, right?
- And if we failed so, it must be our topmost priority to change that, right?

As everything else would be inhuman.  Makes us to some unbearable monster.  Right?

That's the motivation of this folder:  **Fight and defeat monsters!**


## The story

When I was 23, so over 30 years ago, I wrote some addon to some software for a production site.

It was an inhibit switch, something which prevents people from unintendedly changing parameters of a machine,
which operates on 20kV (or higher), when it was "hot".  Because doing so would be harmful.

The facility was done by some hardware which works with a current loop.  So this are two pins,
which must be connected by 100 Ohm to be in the right state.  If the two wires are opened or shorted,
both situations are detected and the software would block.  Also the hardware in the computer was failsafe,
that is, if something broke, the software can detect that failure and would stop.

Nothing can go wrong, right?  So everything is safe?

**Wrong.  Do not understimate human creativity!**  Or to say: Human laziness!

When I left the construction site because my contract was fullfilled, the inhibit current loop was not yet established.
So the software was unable to detect, when the high voltage generators are on or off.

This was due to a simple fact:  The main power switches of the high voltage generators
were lacking additional contacts to switch the current loop on or off.

As both worked, so either "open" or "short", this was not much of a problem.
Just change the power switch do something, which either opens or shorts the wires in the wrong state.
And it can be done in series as well (note that "open" would be the safer bet in case of a daisy chain,
but this does not change this story here).

There were 4 such generators, with 4 switches, where 2 of them powered one production facility each.
The software had 2 current loop detectors to detect which of the two production facilities it controlled were hot.

Hence all left to do was to connect 4 wires the right way through the power switches of the generators,
and 2 resistors of 100 Ohm.

There also was no problem to see if everything is working right.  Power the generators and see if the software
enables or disables changing parameters of the correct production site.

Something which is easy to do, so easy that I left this to the construction crew on the site which had to
finish the machine.

**Probably the biggest error in my life!**  (Well, please forgive me, I was just 23!)

Can you guess what happened?

Nope, wrong!  They did not wrongly wire the thing or such.  **They did not wire the current loops at all!**

Instead they used my diagnose plug (which contained two 100 Ohm resistors) which was only meant to change and debug the software.
With the help of the plug, the software could be used in a mode, which allowed it to operate without the machine.

However the problem was:  I had no free sensor left.  Hence the software was unable to detect the presence of the
diagnose plug.  The plug was just meant to allowed me to test the proper functioning of the current loops.

So they plugged in the diagnose plug, enabled both curent loops on it, and they were set.  The machine operated "properly".

AFAICS they did that, because there was not enough time to replace the main power switches on due date,
and so they had no way to wire the current loops.

> These power switches are [standard components](https://www.google.de/search?q=4+polig+nockenschalter+rot+gelb+63a+front),
> around $35 each (today, probably a similar price back then), available nearly everywhere since decades.
>
> So there was no shortage or something difficult to do.
> All they did need to do is to replace the 3 phase main switch with a 4 phase main switch of the same size.

It came as it must came.

Not a week later the first operating error changed the parameters on the wrong side of the production line.
The side of the production facility which was currently "hot" applying the 20 kV.
When the motors moved the "hot" production side, it immediately cought fire.

The fire made it into the storage supply area and more than 150 tonns of plastic got on fire.

**One fireman got injured during the fire.**

This only happened because I left the building too early.
I should have insisted to stay until the proper implementation of the current loop.

> Where was my error?
>
> The bug was the diagnostic plug.  The software was not able to detect it.
> And such it caused harm.  Something as important as a failsafe must not be
> constructed such, that there is some easy way to circumvent it by accident or laziess.

There is no excuse.  Perhaps, by law, I am not responsible.  As I did everything which I was able and responsible to do.

> I do not know what happened to the poor guy, who caused the fire by accidentally chosing the wrong side of the machine.
>
> It was not his fault.  As a failsafe should have prevented him to do that.  But the failsafe was compromized.
>
> And, AFAICS, only the construction company knew, that there was a failsafe implemented by me.
> The current loop they did not apply and shortened with the diagnostic plug.
>
> As a consequence, I never got involved into the case.
> When I heared of it, it was already part of the dark mist of history.
>
> (Note that I tried to find evidence of this fire in Internet.  But I failed, sorry.)

Even that I do not feel responsible, as I was too young and naive at that time, I personally feel responsible
**to draw up the obious conclusion and never allow my software to harm anybody as best as I can**.

> There's more to this story I do not tell on purpose:
>
> - The company which failed to properly implement the current loop.  (BTW it will no more do harm, as it was shut down a long time ago.)
> - The factory which burned down (note that I do not know the name, only some location.  And my memory might fail there.)
> - People and names involved in this all  (Note that this is too long ago, that I even do not remember them properly, so I might tell wrong names.)
> - And the company I worked for at that time.
>
> But I swear, everything I write here is true.  True according to my perhaps failing memory.  But true.

Please keep in mind, that I am human.  So I err.

Hence I do not tell you my software is perfect.  But if you find a bug contradicting this principle
"**do no harm, in any and even the impossible worst situation**" this is a **high level top prio Bug** for me.
