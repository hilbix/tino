# Tresorit: Dangerous Snakeoil of Encrypted Mail.

## WTF why?

I like Threema ..

- Because their client is Open Source.
- Because they are doing E2E instant messaging right.
- Because they are more GDPR compliant than others (compare: Whatsapp)
- Because they do abstain from Hirnschiss (like Signal)

.. but recently they announced a Webinar with Tresorit .. and I became too curious.

First, I clicked on the Link in the Threema-Announcement and then follwed the link to [Tresorit](https://tresorit.com/).
I did not see much .. ah, oops, their main website does not work without JavaScript.  Bad idea.

After adding `tresorit.com` and `cdn.tresorit.com` to allow JS, their page started to work.

> But who is msecnd.net and why are they forwarding your IP by default there?
>
> Note:  I live in Germany.  In Germany the IP is personal data (as ruled by the ECJ).
> Hence it is not allowed to forward the IP to a third party without prior(!) information given to the person which is using the IP.
>
> Hence their website violates the DSGVO (The German version of GDPR) in case somebody else from Germany comes along
> who allows JS from a third party (which is the default in FireFox, Chrome and other browsers).  I use NoScript.
> Hence in my case (probably: only) I have protected Tresorit from violating DSGVO.  Am I a nice guy, right?

The next step was to disable all cookie access.

> At least their default when disabling seems to be somewhat less horrible than others.  But still horrible enough,
> as, according to my reading of GDPR, default must be to reject all Cookies, else this, again, is a grave violation to GDPR.  
> Long story, and IANAL.

Then I visited <https://tresorit.com/email-encryption-service> and clicked on "See how it works".

Some popup comes up with following message:

    An error occurred.
    Try watching this video on www.youtube.com, or enable JavaScript if it is disabled in your browser.

Hooray.  They are a bit violent today, aren't they?  At least when it comes to GDPR I suppose.  Well, again, not with me, because NoScript, again, blocked this threat.

> At least they use JS from <https://www.youtube-nocookie.com> to embed the video from a third party
> [Datenkrake](https://de.wikipedia.org/wiki/Datenkrake) (like with Kindergarten there seems to be no proper English translation).
> But this does not make this anything better.

Then I started over to Youtube and watched the video.

> And this made me immediately open this new category "snakeoil" in my Zettelkasten.

BTW: I have no problem with Youtube.  I know it belongs to the Datenkrake Google.  And I have no problem with Google, as  
the problem is not with Google itself, it is with how dumb people are to hand over all data to it, even if they do not own the data rightfully!
For example by embedding youtube video without notifying their users before handing over to Youtube.  Again, a very sad and far too long story.

> Well, as all social networks, Google builds on mostly dumb humans.  Doing that isn't Google's fault, in contrast it's their oppertunity.

## Either the Video is a big lie, or they have a serious problem there

Disclaimer:  I did not analyse Tresorit encrypted mail.  I just watched the Video.
So if I did not understand someting correctly, it's still their fault.

> In case I err, I am not sorrt and I will not apologize.  It's not my fault when Marketing does horrible things.
>
> Also note that I will not analyze things in my free time.  But you can pay me for doing so.
> But I am not a Cipherpunk.  Only some Mathematician with a bit of interest in PKI.

The first part seems simple enough, something a (talented) student can probably implement in a longer afternoon session.
Just some Outlook Plugin which seamlessly encrypts eMail.
Apparently with some hassle free background encryption scheme in place.

Well done .. if it would work.  But the last part of the video directly leads into the hell of doubt,
that the entire system is just some dangerous snakeoil.

Here some third party without the plugin comes into play.
The one verifies the eMail address and then is able to decrypt the message from within the Browser.
And can send back Secure eMail.

Which is a big contradiction in itself.

> No, the Browser is not the problematic part here.  Today browsers often are more secure than the underlying OS.  Or Outlook.  Or both.

Where is the contradiction?

Well, either something is secure .. or it is not.  Where "secure" is something like pregnancy.

Either you are pregnant .. or not.  It my be that you still do not deliver, as pregnancy is not guarantee for a healthy living baby, but most time it should be.

That's how I understand "secure".  And often, when Marketing says "secure" it is fake as in "fake pregnancy".  YKWIM.

And this seems to be exactly the case here (I will explain below).

But first:

## Why is fake security more harmful than no security at all?

Well, the problem is very old and should be in the head of everybody today.

If you do things and you think you are secured, but you are not, you live in danger.  In more danger than when you know, that you do things an insecure way.
Because then you know that you live in danger, while with fake security, you live in danger but do not know it at all!  And you become careless ..

So something which makes you feel safer than it is is worse than when it is missing at all.
This is especially true for all types of Cryptography which is

- intransparent
- based on security by obscurity
- involves some centraliyed third party

Security comes with a price.  It is something you cannot buy.  It is just something you must live and breathe.
And most important, you need to use the proper tools to gain security.

> Using an atomic bomb to secure your assets is probably the wrong tool.
> Likewise using some insecure tool which offers a backdoor someone else can use without your knowledge.
> And if security comes with too much hassle or is too complex to live, you will fail.
>
> There entire history of mankind is a proof for the points above.  If you think you can make it better, you probably first have to leave behind your human nature.
> You have been warned.

In our case some third party, TresorIt, tries to sell you security.
As always your first look must be on how trustworthy they are.

- Where are they located?  How are the legal rules there?  (Tresorit is based in Switzerland, which looks good.)
- Who they are?  Do they have some reputation built up? (TresorIt seems to be too new for this.  Started in 2011 is a bit young.)
- Can you trust their services?  Are they Open Source?  (Not looked after this)
- Does things make sense?  Or does it look like Marketing Gibberish?  (Well, sorry, TresorIt fails this criteria.)

## Where is the problem?

Well, the problem is .. easyness here for a Third Party user.

- The user verifies the Mail address.  Well, this allows to hinder otheres who try to decrypt the Mail.  But this makes it not sure othere cannot access.
- The user uses a Web Service to decrypt the Mail.  This needs a service which does so.  Hence the service can decrypt the mail!

Even that the decryption can be done in the browser alone, this does not help here to gain any security at all.

The Mail is already delivered to the incoming mailbox of the user.  It is encrypted.  But this gives us no guarantee at all, as the user must be enabled somehow to decrypt the mail.

As the user is new to the system, the user has not created some identity yet where some asymmetric key can be present.
Instead the user uses some escrow service (the website) to decrypt the message.

Adding some mail identification (something like a weak 2nd Factor:  The user must know the mail message and must possess the power to receive mail
on the original mail address) is better than nothing, but does not eliminate the basic problem here:

Bootstrapping the secure encryption.

Some better way would be to have some setup (AKA onboarding) process for taking place in the encryption scheme.
So the user does following:

- Receive an email which tells that some mail should be send encrypted
- The user than creates an identity
- The message then is re-encrypted for this user's identity and sent to the user
- The user decrypts the message

Note that this can be done in any modern browser today!  This is no rocket science enymore.  It's nearly trivial.
And the keys never need to leave the user's browser.

The user then can backup the identity.  Perhaps (optionally!) to some cloud service like TresorIt.
But this is something completely different to what TresorIt offers, as TresorIt clearly tells us,
that the Third Party user is not a TresorIt customer in that scenario.

The difference is in, if it is enforced or free will.
If a user wants to stay secure, the user can decide not to backup anything externally,
but keep things fully local.

This exactly is not, what TresorIt offers.  Hence TresorIt enforces the user to use the TresorIt service to decrypt the Mail.
And even if this would be done in a fully transparent way, TresorIt still is a SPoF (Single Point of Failure) in the whole process,
as TresorIt would be able to decrypt all mail without help of the user.

TresorIt is a central Escrow service for the entire encryption platform.  This follows the [St. Floriani's Principle](https://de.wikipedia.org/wiki/Sankt-Florian-Prinzip),
which means it does not get rid of the problem, instead it moves the problem elsewhere and - very likely - even makes it worse.

In the best case you do not create new holes.  And you - perhaps - create some slight better value.

But you still do not solve the basic problem at all.  Which is:  Secure mail communication.

So they offer snakoil.  And this is bad, as people think, they are better protected than they are.

## Failure analysis

- You send mail to some third party
- The third party receives the mail
- The third party is able to decrypt the mail

Where is the threat?

Well, you mistyped the mail address.  Some common error.  In that case the third party is able to decrypt the mail.

- Pro: If you recognize your error in time, you can revoke the keys, and hence keep the mail secure.
- Con: If you do not recognize your error, you are still doomed as before
- Con: As you think you are secure, you are less likely to recognize your error, and even if you do you perhaps still think you are secure, thanks to encryption.
- Con: People do not know how to revoke the keys.  Or if they do, they might do this by accident.  Some new source of error comes up.

Hence such a system only works in a world, where nobody misbehaves.  But in a world where nobody misbehaves, you do not need such a system at all.

A good system is resilient against all the common mistakes.  This system is not.  Because it lacks proper identities.

- You send mail to some third party
- The third party receives the mail
- The third party is able to decrypt the mail
- The third party answers the mail

Where is the threat?

Well, the third party now has a problem.

As the third party wants a copy of the mail (for legal reason, whatever), the copy must be stored somewhere.
It is a requirement, that the copy can later be retrieved by the third party again.
At the will of the third party, of course, not your will nor TresorIt's will.

Hence you must not revoke the key ot the third party.  Else?  Well, the third party must keep some copy somewhere else.
Which is - very likely - not encrypted at all.

So where is the secure answer offered by TresorIt?  Again, TresorIt offers some completely wrong assumption:

- Everybody plays by their rules
- Everybody stays in their ecosystem

All these assumptions are completly wrong, misleading and dangerous.  Hence all you get is the false sense of security.

Hence they sell you snakeoil.  Even dangerous snakoil in that case.

## Conclusion

TresorIt's Email Encryption Service may have it's use.
However it fails because it tries to solve a problem the wrong way.

The correct way would be:

- Secure inhouse communication (where "inhouse" is the TresorIt ecosystem here, so between all customaers) in a transparent way
  - This includes no way for TresorIt to offer Key Escrow (like Threema)
- Plus secure outside communication
  - Which then comes with some addition burden, that is, the new outside participant first must create some (volatile?) identity in the ecosystem

Hence sending mail to some outside the sytem cannot be as shown.

- You send mail to some third party
- You get informed, that the mail could not yet be delivered, as the identity of the third party is not yet set up
  - This can mean, that you mistyped the mail address
- You then can decide to have the third party create an identity
  - This process can be handed over to some automated service, which holds back your mail for you and re-encrypts it as soon as the identity is added
  - This process can run in-house, that is on some of your own servers which are not under control of TresorIt.
  - This process can also be done in the cloud of TresorIt if your dare.  But then it only affects the very first message, not all messages.
  - You can also chose to be notified when the identity is created, and re-send the mail from your workplace
  - You workplace can perhaps even be intelligent enough to do this for you
  - As you are probably in some enterprise setup, some service like Exchange can take over this part, too
- The third party then gets some Mail which explains how to create the identity
  - The third party can decide to use TresorIt as a service for this
  - The third party can create the identity in the Browser
  - Or use some other plugin which creates a compatible identity
- The identity (AKA public key) is sent back into the ecosystem
- Now the mail can be re-send with the proper encryption for this identity
- The third party can now decrypt it and answers with encrypted mail

Where is the difference?

There needs not be much of a difference.  When the third party receives the first mail, it is a link to the browser.
Now the browser creates an identity.  This identity (public key) is handed over to the TresorIt service.
The service makes an email verification to just to be sure.
Now the identity is added for this mail address and in future communication can take place.

However this all has a price:

- First, some loss of ease.  As the third party now must be informed, that some local identity is created.
  - In case you erase your data in the browser, the identity gets lost and all further commuication no more works
  - So we need some way to revoke the identity
- Second, missing open standard.
  - To trust all those encryption, everything must be done on open standards
  - Hence there is no way to protect TresorIt from the fact, that their solution of secure mail gets out of their hands
  - So TresorIt just is one Open Source player as all the others.  No Vendor Lockin.
  - However they have the chance to become the market leaders for this standard they have envisioned.
  - But I doubt this is the case here.  If so, the marketing did a very bad job!  Blame them!
- Third, Vendor Lockin
  - I doubt that you can leave TresorIt behind without leaving behind all of your precious data (like encrypted mails)
  - If I am wrong here, why did I find no word about this on their homepage?
- Fourth, they pretend to be GDPR compliant, but AFAICS fail for the DSGVO (which is the GDPR for Germany)
  - In Germany the IP belongs to the personal data which must not be given to a third party without prior notice
  - I do not know if this happens in case of their encrypted mail system, too, but it is likely, as they are very careless on their homepage already

In contrast to Threema, who created some open standard for their product (the client is open source, so you can verify everything yourself)
the TresorIt webpagage nowhere mentions someting similar.  AFAICS this "seucre" email service probably runs on top of their
TresorIt cloud service, which probably is the wrong way to think of email security.

> I, for my part, run SMTT servers for over 30 years now.  Therefor I know, that cloud storage has nothing to do with SMTP at all.
> Either somthing is email - then it uses some email RFC like UUCP or SMTP -, or it is not, then it can use cloud storage or HTTP.
>
> YMMV

## Some very final note

If you want some enterprise ready encrypte mail system and document storage, then there already is one.
It is called [Lotus Notes](https://en.wikipedia.org/wiki/HCL_Domino) and successfully delivers for more than 30 years already!

> Well, taking part without some Notes client probably is a bit difficult.  However my experience with Notes is now 20 years old,
> perhaps things have changed today.

And no, this is not an advertisement, just my private opinion.  Sorry for that pun!
