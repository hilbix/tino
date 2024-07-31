> Not ready yet, I am in the process to investigate how to do it

# HowTo ZFS encryption

It looks like some of the best kept secret of ZFS is how to use encryption.
I tried to figure it out.  I read everything out there.  Nothing really works.  Really nothing works at all for me.
So here are the gory details.  Found out the worst possible hard way you probably can imagine.  Or not.

> WTF!  Why is there no easy to understand guide out there?  Not a single one?  It's 2024!
> And still encryption is handled as if it would be the 1980s when there only were rumours about
> that there might be ways to properly encrypt things (read: The needs for encryption were not properly known,
> hence there was the belief, that DES would keep things secure for some millenia).
>
> Today provenly secure things like AES are out there and even proven quantum resistant PKI will very soon
> replace RSA, which already is insecure in a sense, that it probably will only need a few quadrillion dollars
> to break 4096 bit RSA in a few years today (so it will be broken at the end of this century by sure).


## T.B.D.

> This is an intermediate save to protect against disaster strikes.

## About encryption

There are several ways how to encrypt ZFS.


### Recommended way: Unencrypted ZFS over encrypted VG

> Encrypted VG is a VG with each PVs within a diffferent encrypted LUKS Container

- Create (encrypted) LUKS on Device
- Create PV on LUKS
- Create VG with this PV
- Create LV on VG
- Create ZFS on LV

CON:
- You can accidentally extend the VG with unencrypted PVs and thus harm the encryption
- No plausible deniability
- No authenticated encryption
- You can mix up key management as you probably have dozends of encrypted PVs
- Not recommended by anybody else, others say, this is not a reliable mode of operation or even is dangerous
- You can accidentally mix ZFS volumes with other volumes on the 
- You need to backup all those LUKS headers

PRO:
- Straight forward and very secure
- Probably the most reliable and compatible way to do it
  - Even the oldest Linux respects the LUKS containers (sees that there might be valuable data)
- Easy to understand
- Easy to manage
- Easy to work with
- You can intentionally extend the VG with unencrypted PVs
  - You can have unencrypted parts on the VG
  - You can even mirror parts of encrypted volumes, like the ZFS header (which is not recommended)
- Easy and straight forwared transparent double encryption for extra secured parts

Notes:
- Put LUKS directly on the device, so skip the partitioning if not needed
- Partitioning is only needed if you want to have a GRUB boot area on the disk, too
- Works very well with GRUB, as GRUB is able to detect LUKS


### Not recommended way: Unencrypted ZFS over encrypted LV

> Encrypted LV is an encrypted LUKS container within an unencrypted LV

- Create unencrypted PV on Device
- Create VG with this PV
- Create (unencrypted) LV on VG
- Create (encrypted) LUKS on LV
- Create (unencrypted) ZFSPOOL on (encrypted) LUKS

### Native ZFS encryption

> This is what this here is all about

- Create unencrypted PV on Device
- Create VG with this PV
- Create (unencrypted) LV on VG
- Create encrypted ZFSPOOL on LV

### Not recommended way

- Create encrypted ZFSPOOL on Device
  - This is what Ubuntu 24.04 does if you boot from an encrypt ZFS root filesystem

Why always have LVM beneath ZFS?

LVM is a good way to create devices, which can be automatically detected and are compatible to a huge variety
of systems in a sense, that they are able to detect them - not necessarily use them.

This is fundamentally different from an encrypted devices which just looks like being filled with random data.
(AKA plausible deniability.)

In Computers, ease always is a key factor to success.  This even is true when securing things.

If you happen to secure something with a complex to follow error prone way of doing it,
it is only a matter of time until you will fail.  Fail utterly.  As time works against you!

So you must eliminate time here.  Best is, that you are able to do something **without prior knowledge**.
So everything is hidden in plain sight.  You always are able to deduce the next step to come with what
you have done previously.  Everything should be a single step only.  So no double-step things needed,
like "activate ZFS with a password".  Nope.  First password, then activate.  Step by step.

> I call this the ["follow the yellow brick road"](https://en.wikipedia.org/wiki/Yellow_brick_road) design principle.

Keep that in mind.  Hence native ZFS encryption is good.  And this text here is about native ZFS encryption.

However if you try to boot from encrypted ZFS you cannot separate the steps "activate OS" from
"entering password".  Hence you are doomed to fail.

And this was exactly what happened to me when using encrypted ZFS setup with Ubuntu 24.04 for the first time.
After some innoccent update of the OS, GRUB suddenly failed to boot, because it became unable to detect ZFS.
I really do not know what happened, but no guide out there even mentioned what to do in this case.
Or failed utterly.  There were only two advises left:

- "Reinstall from scratch"
- "Try to repair from an Ubuntu live boot disk"

Note that both recipes, as presented, failed for me, due to some minor changes which were applied to the system in
advance, and **there was no obvious way on how to recover from this situation**.

However in my above recommendation, recovering from the situation is straight forward, as each step is not
a complicated one, there are many steps, but each step is explained by itself.  Straight forward.
And hence easy to follow.

So what did I do in my situation?

Well, I started writing this here to keep it in mind, and learn how to do it:

- Install a new system my recommended way
  - Note that this needs to become another document, as this here is about ZFS encryption, not about secured ZFS system boot
- Reactivate the encrypted ZFS from how Ubuntu did it
  - Which is why I wrote it to not need to keep that in my mind, so releave my memory (as I am aging all too fast)
- Send the data to the newly created encrypted ZFS
  - Do this by keeping the security conditions intact while this is done!
  - Do this by keeping the redundancy conditions intact while this is done!
  - So it can be interrupted and recovered any time in the process, even if a disaster strikes
- And thus rebuild the previous (broken) system from scratch (but this time myself, so it stays repairable)

Note that I stopped using ZFS as a root partition as well.

- Not because it is not feasible
- But just because I need more experience with this in future
  - As my first try failed utterly

If done properly with LVM beneath, you can morph your system into ZFS root later on.
As LVM is very flexible and allows to resize (even shrink) things on the fly with not much hassle.

> Note that shrinking can involve to copy things, so it cannot be done entirely on a live system.
> However you can prepare the slow things while the system is live and then switch in a matter of seconds
> doing just a reboot.  That usually is the way I do it in complex or not completely supported situations.
>
> The key factor for this is to never ever fill your PVs up to 100%, such that you always can add snapshot
> and mirror information on the fly.  Doing this across different physical devices is the path to
> administrative hell, as there always is the chance that you need to interrupt things due to some
> unexpected situation (like a power outage or a lighning strike) and then have to come back to it
> weeks, months or years later.  And then - do you really remember how to re-assemble the parts?
>
> You might think "this does not happen so often".  You are wrong.  So think again!  This is called
> "birthday phenomenon", and yes, while it is very unlikely that something bad happens while you
> are on something particular, birthday phenomenon strikes quite more unexpected often when doing
> things repeatedly.  And doing system maintenance is somthing, you do quite often, right?
>
> So trust me.  It will hit you.  And as Murphy dictates, exactly when you are the least prepared.
> The only thing which can save you from that is, that you do things the most possible safe way.
> Always.
