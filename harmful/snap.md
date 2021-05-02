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

## Why?

The design priciple of Snap is out of bounds.  **Snap contradicts the design principle "do no harm"**.

This entry here is earned due to following fact:

- https://forum.snapcraft.io/t/disabling-automatic-refresh-for-snap-from-store/707


## What is the bug?

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
