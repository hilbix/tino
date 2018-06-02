# DNS vs. Security

In the Internet nowadays is more and more pressure to do things, which are designed inherently wrong.

I won't follow this.  I will not obey.  Wrong is wrong and will stay wrong for now and for all future.


## What's wrong with DNS?

Nothing is wrong with DNS.  DNS is the phone book of the Internet.  And that is all of it.


## What's wrong with DNSsec?

Nothing is wrong with DNSsec.  DNSsec is just something, which allows you to authenticate all entries in the phone book.

However it is weak security.  All there is that the entries are not forged.  There is no information, whatsoever, that the entries are indeed correct.

DNSsec is based on a trust chain.  Usually you can trust the root zone.  However after this, everything can happen.

So all you know with DNSsec is, that all those entities in the trust chain control the information you get, but nobody else.

This is a major improvement, as not everybody can forge the information, only a few can, and usually you can deduce who this is.

However you still have no information whatsoever, if the information you got is honest.


## What's wrong with using DNS for security?

DNS was not constructed for this purpose, as DNS is a purely optional feature.

### (A) DNS is a phone book

If you want to do a phone call, you can consult the phone book to deduce the phone number.  Then you can do your phone call.

However, you do not need the phone book to make a phone call at all.  If you know the number, you can call the number.

If you use DNS for security, then DNS starts to become non-optional.  If you switch off DNS, you deactivate the security!

This is something which is a fundamentally wrong design.  DNS is optional, is allowed to fail, is something, which is not mandatory.
You completely change the rules of what DNS is and what it was designed for.


### (B) DNS is unidirectional

If you use DNS for security, you usually only read information.  As in information theory and quantum physics, information transfer is not propagating back.

This is why there is no faster-than-light communication (as found in all science fiction, where it is no science but only fiction)
even with the spontanous property propagation of quants.  And this is why Einstein's Relativity Theory (the simple one) works as it works.

This means, DNS information only propagates into a single direction.

This also means, you cannot have bi-directional communication, even if you have two seprarate DNS talking to each other.

Hence, if you want to use DNS for security, you need a third party who authenticates both sides.  Some introducer, as usual.

And this also means, that fundamental basics for security are not met with DNS.


### (C) DNS is a separate service

Internet is designed such, that each service must be intrinsic.

That's what was (and is) wrong with SSL with OCSP.  OCSP works by contacting a 3rd party.

As already told above, you always need some 3rd party to establish trust in a secure environment.
So what's wrong with OCSP?

OCSP is wrong, because it unneccessarily extends this paradigm for a need of a continuous contact to this 3rd party!

Normally you only need the 3rd party once.  Stay with this.  This already is too much (but inevitable).

Hence OCSP by itself is a fundamentally wrong design.

Nowadays we have OCSP stapeling.  OCSP stapeling looks better, but if you look very closely it is far from being perfect.

OCSP stapeling is better in the sense, that the Client no more needs to contact the OCSP-servers (as you cannot make sure, that the client can do this).
As the server, which uses a certificate, usually must be able to talk to the CA, you can make sure it can update the OCSP token.

Well, yes.  However this only authenticates (weakly) the Server to the Client.  What if you need it the other way round?

You see:  OCSP Stapeling does NOT provide everything you need to do it properly.  It can help, but it is no real solution.

And that is the same if you put additional information in DNS which is required for security.  You must not!
This breaks what DNS was designed for.

DNS is something which is optional, not mandatory, and you must keep it, else you create additional SPOFs.
And this is a very bad thing.


## What's wrong with DKIM?

Everything is wrong with DKIM.  DKIM is something, which must not be put into DNS, as this breaks SMTP.

Why?

It is easy to understand if you look into the nature of the Internet.  The Internet Protocol creates a Peer to Peer network.
It was designed as such.  Even that some people (mostly states and ISPs) neglect this fact, the Internet is P2P.

Peer to Peer means, that everybody can communicate with everybody.  And DKIM breaks that.

In contrast, SMTP is a store-and-forward network.  Something fundamentally different.

So what's wrong in using DKIM to check if mail is legitimate?

First, it breaks SMTP.  SMTP is not meant to be authentic.  It's not part of SMTP's design.
There are even means in SMTP that a message must be delivered, even when it is faulty!

Second, SMTP has no backchannel.  It has bounces, but this is not the usual way to tell "I do not want to do my job".
It is meant for fundamental problems in Mail delivery.
So in case you think you do not like what you see, you cannot communicate back that fact.  You can try.
But you will fail.  As this is no part of SMTP.

SMTP is meant to work completely different as you think!  Most people think of SMTP as this:

    User -mailer-> MTA -Internet-> MTA -postbox-> User
                    ^               ^
               authenticates    checks for
                   user         legit sender

SMTP like a postal service.  Well, you are wrong.  The postal service does not check, if the sender is legit.  And neither does SMTP.

However SMTP is designed to work differently.  Some Mail delivery can look like this:

    User -> Maildrop -> Smarthost -> MTA -> DeliveryService -> MX -> outer-MTA -> inner-MTA -> Branch-MTA -> Storage -> User

In this setup, which one authenticates the user?

- The Maildrop cannot do, because it has no authority to do so.
- The Smarthost cannot do, because it is still shielded from Internet and has no correlation to the domain used.
- The MTA then could do it.  Perhaps.  However it has to handle a very high load situation.  Usually for security it is a dumb device which just queues and forwards Mail.
- The DeliveryService is a 3rd party.  It can tell the Mail comes from Smarthost, but not from User.  But it cannot ensure the mail is legit.
- The MX is something, which just queues incoming mail in case the outer-MTA is overwhelmed.
- The outer-MTA cannot do checking, as it must not know the policy.
- The inner-MTA cannot do checking, as it is already shielded from the Internet.
- And so on.

There is no node, which can do the job.  Also think about this:

It is perfectly legit, to use your private or some anonymous Mail name to send mail from your employer.
However the employer cannot authenticate your private Mail address, right?
Because if the employer can do, anybody could do it.

But wait, you can design it such, that it works!

Of course you can.  However each step here speaks SMTP.  To make it work, you need to speak some different protocol.
And this, certainly, is not DKIM.


## What's wrong with SPF

Well, SPF is not as bad as DKIM.  However it still breaks SMTP.

SPF tells the other side, which MTAs are legit for sending Mails with a certain From.
The good part is, that you can specify this list.

However there are some fundamental flaws in this:

- First, your DNS must be reachable by the receiving MTA.
  Think back to the picture above with DKIM.  The receiving MTA can be anywhere in the Internet.
  Internet is P2P, but in SMTP is store-and-forward.
  Hence there is no guarantee, that the receiver can talk to you.
  It can talk to the sending relay, but the sending relay need not be assiciated to you at all!

- Second, you do not know where your mail goes.  It can travel any route.
  It's not you who defines who sees your mail.  It's the admins of the MTAs in the mail's path.
  And this information is dynamic.  But DNS is (in regard to this) static information.
  This does not fit at all!

- Third, there is no standard on how to define and include SPF.
  You can define SPF in DNS.  However you have trainloads of ways to do it.
  And you can change it, any time.
  Hence, if you want to include other's SPF rules, you still need to update frequently.
  
- Forth, Mail delivery is asynchronous.
  So even if you can make sure, your DNS information is correct when sending mail,
  your mail may be delayed.  A week.  Can you make sure your DNS is still correct in a week?
  

# Summary

Regardless what you want to do, think of DNS as an optional phone book.

If there is any, this is nice.  If not, things must continue to work.

If your service is designed with this principle, you honor the Internet way.

If not, you don't.  Then please leave the Internet, as you do not honor it.

Thank you very much.

