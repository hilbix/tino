Update: GitHub told me, that there will be no exception of the 1 account rule.  At least that is what I understood.

Hence, security against excess access right apps cannot be implemented using GitHub alone.
Either you sacrifice your GitHub account, or you cannot use GitHub for those CIs/Apps, etc.

---------------

# For open source security I need a 2nd free account at GH

Hello GitHub,

do you allow me to create a 2nd free personal account, please?

Here is why this is crucial:

I have a problem.  I do Open Source.  I do it on GitHub.  And I want to keep my GH account secure.

But I am forced to expose it to possibly 3rd party abuse when I want to use some more advances security features offered at GH apps.

Apps like WhiteSource want WRITE access to the repos.  For security reasons (security walling) and security freedom I **cannot** give such WRITE access to any of my repos.  Only you (GH aka. Microsoft), me and perhaps some contributors whome I fully trust are allowed to get write access.  But I will and cannot trust some obscure 3rd party, because there is no way they can gain the required trust level!  (In that respect it was very good for me that GH was bought by MS, as MS already had a higher trust level than GH had at my side.  At least I run Windows on some of my computers where I do online banking and stuff, so I must fully trust MS as they have full control over my computer, right?  And I run Android on my mobile, so I must fully trust Google as well as my phone card provider, as they have full control over my phone, right?  Likewise I fully trust my bank, my government and associated services, the police, some of my neighbours and my family, of course.  But that already is a heck of a lot trust spent, so it should stop somewhere!)

The easiest and most convenient and manageable way of keeping the main account secure while using advanced security apps would be to split the account in two parts:

- The main account, which is kept fully secure

- And an insecure 2nd account, I call it firewall-account.

This way one can clone everything into the firewall account and give all those wrongly designed GH apps access to the firewall account. Then these apps can do anything to it.  Become a hacked service, kill all associated accounts, trojanize all sources, dump all nonpublic data they have access to to Piratebay, push insane things or profanity, everything.  Nothing harms the main account, so in the catastrophic scenario no big harm is done.  Of course all these neat little apps can also just do their job they are supposed to do, in which case they are incredibly helpful.

Incredibly helpful vs. a guarantee to be no threat to the main account.  That would be easy.  If one can have a 2nd free account .. But you can't!

This also is a good workflow, being able to control all those changes via Pull requests into the main account.  No, I definitively do not want other (not 100% trusted) Apps to push to my repos without prior knowledge to me.  I want to keep control myself.  And perhaps I use a thing like Gerrit (no, sorry, Gerrit is too weird, but you get the idea), which does not cope well with unapproved changes showing up in the repo.

However in your terms you prohibit such a 2nd account!

Doing it in my main account by forking my own repos into a 2nd repo with different name and limit those insane apps to only those internally-forked repos is PITA, hence I won't do it as long as I lack a good way to fully automate this.  Also this would makes things very puzzling for visitors or users of the Open Source.  As they might hit the wrong of the two repositories, cloning from the wrong repo etc. etc. etc.

In that respect it would be better to do this with private repos which allow all the dangerous stuff.  Not private because there are private things on it, but private to hide this security nightmare from others, who are not aware of such firewalls.  However IMHO this also isn't the correct way to go.  Doing Open Source Security in private is a bit weird ..

Yes, well, right, security does come for a price.  That's right.  And paying GH for a 2nd account perhaps isn't a bad thing either.  But that's not the point here.  The point is how to use all those (likely very helpful) apps which require WRITE access to your repos in a secure fashion, were even security nightmares at the app side cannot spread harm!

Hence the only thing I see is to have some 2nd firewall account feature on GH.  A way to do this openly, publicly and right, with the help of GH.

The options are now:

- Ask you for permission for such a 2nd account
- Get a paid account (which isn't an option at my side currently, I cannot afford $7/month currently)
- Create a 2nd account elsewhere (i. E. GitLab) which then becomes the main account (and GH one the firewall one.  That way GH becomes secondary important which probably is nothing GH wants to be.)

Today, we do not have a suitable feature (like independent shadow accounts with a different permission set, where changes do not propagate to the main account without explicit consent of the ownwer) here on GH which easily integrates firewall accounts.  But I do not want to wait until GH eventually adds such a feature.  Security is too important and has a long leaning curve.  So I want to start to enhance my repos TODAY, but I am hindered to do so.

**My proposal:**

- Allow everybody to create a 2nd free account.
- The 2nd account must follow a clearly defined naming convention based on the main account
- An (in future, I do not think GH allows this today) you must use the same (hidden main recovery) Mail address on both accounts.  (This is not a problem.  People who do not want to expose their main mail address to 3rd party can use a scratch address for both accounts - one that differs from their main address - and then can configure their not-to-exposed mail as the notifier mail just in their main account etc.).  Note that this is just a KISS requirement, because people are just too stupid, so they will loose control of the 2nd mail address used for the firewall account because they just forget that there is such a thing.  A requirement to keep similar things together right from the beginning is a keystone to success!

So these two accounts are clearly and openly linked, such that you (GH) can put a warning banner on the repo that second account not seeing the main account.  (Also apps, which do not want to support secondary accounts for a reason might block access based on the name.)

Example:

My account is "hilbix".  If I would be allowed to create a 2nd account, this would be "hilbix-fw".  No this is NOT a good name if you want to provide and support that feature ever.  So my proposal would be that you require such 2nd accounts to carry some special prefix like

test.hilbix  
firewall.hilbix  
2nd.hilbix

As long as dots are not allowed (probably because of *.github.io) we can use dashes instead and migrate those accounts in future.

No, renaming them in future cannot be a big harm, as they are secondaries.  Secondaries which are scratch/firewall accounts which must not be used for critical stuff, except security separation.  (And if such 2nd accounts become something like test.USER.github.io, this looks nice to me as well.)

Note that these "dot"-feature is easy to program.  As (see above) it must use an already existing main mail address.  Hence if you try to enter something to "test.hilbix" as account, then you can add a note "must use the existing mail address of the account hilbix" there.  To not allow guessing, no error is shown if you happen to enter the wrong mail address, it is just not sent, so the new account cannot be activated.

(The real difficult stuff probably is to not break other assumptions in your codebase elsewhere.)

Notes:

- That this is why I only can use Cirrus-CI, because they are the only CI which requires sane and usable access rights.  All others are insane security risks.

- My main account has no SSH key in it for the same reason.  Having such "god-keys" with full access to all and everything is insane!  Luckily GH offers writeable deployment keys (initially they weren't RO, which was the right coice!).  So I manage all my repos via writeable deployment keys instead.
This is a mission critical feature to me, which I miss on GitLab btw.  (Anyway, GitLab and security are not a good - especially if you host it yourself you need a second security layer like a good application firewall to secure it.  But this is something completely different.)

- What I can do is to shift my OS development main account from GH to GitLab and only use GH (the better one of the two IMHO) as the firewall slave.  But really, WTF why?  Only because GH terms do not allow a 2nd free account?  Isn't this nuts?

PS: I will publish this under https://github.com/hilbix/tino/blob/master/misc/github-2nd.md
