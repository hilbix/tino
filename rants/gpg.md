> If you wonder where I got the knowledge from: https://wiki.debian.org/Subkeys


# `gpg` is unusable cryptography

> Do not use this shit here below.  Why?  **BECAUSE GPG IS INSECURE** if used this way.
>
> WTF, really?!?
>
> Sure.
>
> As always in cryptography tools the default of GPG is to do it
> the moste insane, most insecure, most braindead, most incompatible and most unsupported way.
> `gpg` is a purely nonproductive, difficult and dangerrous to use tool, which only does no harm if used properly.
> But it leaves you completely in the dark, on how to use it properly!
>
> Also it will create incompatibilities in the future.  Be prepared that,
> **in only 20 years from now, you will neiter be able to repeat nor decode nor verify things you have done today**.
> You have been warned!
>
> Instead of offering just what you need for the most common case in a secure and easy to use and ultimately future proof way,
> they leave you alone in the dark, offering you the bare minimum unusable thing and leave you alone in a few years from now,
> even if you did everyhting perfectly today
> (which is less likely than winning a lottery by not participating in the lottery).
>
> **And then they will blame you for failing to properly use their cryptography!**
>
> Also they cry out loud due to the cruel world where nobody uses cryptography and all people beeing far too stupid
> not following their advice for decades.
>
> Which advice?  What you give us is ridiculous, bad designed unusable crappy nazi shit!
>
> All you crate is trouble ahead, and you are not willing to cope with this trouble you are responsible for.
> That's destructive!  Plan ahead.  Plan 50 years ahead.  Plan 1000 years ahead.  And if you can make sure,
> that nothing bad can be forseen for the next historical aera by what you created,
> THEN please come back and present it.
>
> - Then you can claim that it is usable and future proof.
> - Then you can recommend everybody shall use it.
> - Then you can expect, people to adopt what you have created.
> - Then you are helpful!
>
> If not, stay out of the way of the future, please.  It will work without you, too.  Probably even better!

Well, there is `gpg`.  But it must be initialized.  I really have no idea why.  So I try it with Google.

Use the first hit:

    gpg --full-generate-key

But this does not work, because option `--full-generate-key` is unknown.  If this does not work, it is told to use this:

    gpg --default-new-key-algo rsa4096 --gen-key

However it does not work either, because option `--default-new-key-algo` is not understood.

A later search then returns

    gpg --gen-key

This outputs with following riddle:

    Please select what kind of key you want:
       (1) RSA and RSA (default)
       (2) DSA and Elgamal
       (3) DSA (sign only)
       (4) RSA (sign only)

I try option `(1)`.  This gives me following:

    RSA keys may be between 1024 and 4096 bits long.

WTF?  It is 2018!  Keysize of 2048 is considered to be broken until 2030, so it shall no more be offered.

And DSA is considered insecure is some of the bits used for NONCEs are known, which (according to my reading)
gets more and more likely if you can observe enough signatures done with DSA.  So DSA must be droppe for public things.

Hence the only thing left is the default thing.  So why bother the user with some questions, which can be answered the wrong way?
(Note: GPG shall support everything as before.  However the default should stay secure and hence only offer the most secure way.)

Then later:

    You need a Passphrase to protect your secret key.
    
WTF?  This is an automatich signing key.  So why bother with a passphrase?  This is far too complicated!

Read, it should be done as following:

- If just invoked, it shall abort and tell you, that you either must allow a passphrase or you must tell that there is no passphrase which is insecure.
  However, asking for a passphrase all the sudden is absolutely the wrong way.
- So please, add 2 options to GPG and document those two options if you just call it with `gpg --gen-key`

Now, after all this hassle, I now have a key:

    gpg --list-secret-keys

outputs

    sec   2048R/A62751DD 2018-05-20
    uid                  Valentin Hilbig (Temporary signing key) <webmaster@scylla-charybdis.com>
    ssb   2048R/4976C9BA 2018-05-20

> **WARNING!**  This is not how you should use GPG, ever.  Never use the master key as shown here.
>
> Never ever.  Do not do that.  You have been warned.  If you ignore that, you will in future hit the end of the road, badly.
>
> Please do not ask me how to do it properly.  As I do not know yet for sure.  It is a well known secret.
> Not well known.  It is well known that it is a secret.  A very well hidden secret.  Hidden in plain sight.
> (Hiding things in plain sight is the high art of hiding things.  So please do not tell me that was by accident.)

But this

    gbp buildpackage

then still fails:

    Now signing changes and any dsc files...
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    gpg: skipped "Valentin Hilbig <webmaster@scylla-charybdis.com>": secret key not available
    gpg: /tmp/debsign.dqXac67a/json2sh_1.dsc: clearsign failed: secret key not available
    debsign: gpg error occurred!  Aborting....
    debuild: fatal error at line 1295:
    running debsign failed
    gbp:error: 'debuild -i -I' failed: it exited with 29
    
After hours (at least if felt this long) of Googling I found out that this is due to

    $ debsign json2sh_1.dsc
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    gpg: skipped "Valentin Hilbig <webmaster@scylla-charybdis.com>": secret key not available
    gpg: /tmp/debsign.e4uYKsEH/json2sh_1.dsc: clearsign failed: secret key not available
    debsign: gpg error occurred!  Aborting....

WTF?  Why isn't this command printed when the error occurs?  Why do you have to first scrape some billion terabyte of documentation (this is what Google does) just to find out what's wrong?  Why is documentation so bad?  (Note that you do not need any documentation if the scripts are just self-explaining, especiall in case when some error occurs.)

Now the problem left is, how to make

    "Valentin Hilbig <webmaster@scylla-charybdis.com>"
    
out of

    "Valentin Hilbig (Temporary signing key) <webmaster@scylla-charybdis.com>"
    
I really cannot present the correct way how to fix this, because it is inexplainable.  I somehow managed it after some enormous amounts of incomprehensible commands with trial and error.  What I did was (partly):

     gpg --edit-key 4976C9BA
     adduid
     deluid 1
     save

And with "adduid" I needed to re-enter just everything as before, but leave away the comment.  Nag nag nag!  SIGH.

I know what caused this mega-GAU of usability.  I understand what the programmers did.  However I do not accept that.  This is more than plain wrong, this is not only ridiculous, it is plain crap as it is unusable.

Hence, again, a major fail here.  Things must not happen this way.  Period.  And no discussions about that.  This is wrong.
This already was wrong 20 years ago.  It shall never happend this way.  Period.  Again.

Now it works:

    debsign json2sh_1.dsc
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    Successfully signed dsc file

Who is responsible for this shit and who should be beaten (badly!) due to his major fail?


# How to safely use `gpg`

Short answer: You can't.

Long answer:

There are major design flaws in how `gpg` and the web of trust works.
One is even catastrophic:

- To sign someone else's key, you need the master key.

The master key is what you shall keep protected.  Someething which is only taken out as the ultimate weapon,
only if more than just a major worldwide catastrophe has happend.  This must be an universal dead end catastrope,
like some big bang again or something worse.

Understood?

The master key must be protected at all costs.  Even with your life.

Hence this key best must not be used, ever, after creating this key.

However with `gpg` you have no choice.  You have to use the master key now and then.

But the most worse thing you have to do is, to use your master key on signing partys.  So when you are in the Cloud,
when there are millions of others infiltrated by the probably worst you can think of, where you have to keep your
belongings protected all time, which means, best is to never even bring them with you.

Following this simplest of all security measures at all means, that you cannot form a web of trust this way.
Simply because you cannot sign anything, because the master key is not available.  Must not be available.
Else all the purpose of a master key is voided.

Did I say "design flaws"?  This is an ultimate design catastrophe!

So besides these major flaws, `gpg` could have a use.

If you manage to use it properly.  Please read https://wiki.debian.org/Subkeys

- Try to understand that
- Try to understand, why you must not use the master key, ever.
- Try to understand how to manage subkeys
- Try to understand their limitation (you cannot create a master key like subkey)
- Try to understand how to apply this properly to your problems
- Try to solve your problems using subkeys

If you fail just in a bit of a step of above, better abstain and ask somebody who does not
suffer the [Dunning Kruger Effect](https://en.wikipedia.org/wiki/Dunning%E2%80%93Kruger_effect) on crytography.

> **Warning!** At least 99% of the people out there, including me, suffer of the Dunning Kruger Effect in the field of crypto.
>
> The only difference is, that I am aware of this, so I can warn you NOT TO FOLLOW ANY OF MY ADVICES.
>
> Even that I think I am better than 99% of the rest of the Internet, this is not enough.
> For Cryptography you need a confidence level of at least 99,9999999999999% to be able to do it right,
> else the probability to get into trouble is 1.  Yes, 1, which means:  For sure.
>
> I am only 99,9% confident I got it right.  That's not enough.  **So please, do not trust me.**

