Update: You can create Organizations on GitHub.

Apparently some of the GH Apps are able to work on the Orgs independently and only require basic access to the main account.
Hence you can give them the elevated access rights only on some dummy-organization but keep your main account secure.
Doing this you can partially archive something like a GH firewall.

AFAICS not all GH Apps can do this.  Some do not treat Orgs independently from your main account, so they always want access to everything on the main account.  It does not help to reduce their access rights on the Orgs, as they already want to have full control over your main account and thus over all of your organizations in parallel, regardless of the access rights you set (as they can change them as they like).  Hence this **not only endangers your main account but all of your Orgs in parallel**, too.  I really have no idea why GH allowes this, but it is as it is.

In GH apparently the GH App is in full charge of the access rights.  Neither you nor GH seem to be allowed to change the access rights afterwards if the App does not allow nor implement this.  As most Apps do not do this, all you can do is to completely revoke the access rights - we already learned the hard way that this then can be already too late anyway -, even if these elevated rights are never needed, because the App should be restricted to one of the Orgs only.  Sorry, GH, this is probably the most stupid way to implement this one can ever imagine.  The right thing to do would be threefold:

- The access rights, an App wants to see.
- The access rights, an App gets.
- The access rights which are rerouted to some Org.

This is:

- The App always sees the access rights it wants.  Always.  If it requires 101% control over the account, it sees 101% control over the account.  Period.
- Then there are the access rights, the App gets.  If the access rights of the App differ with the access rights it gets, this results in access or permission errors returned by the API.
- However 99% of the Apps would fail in this case.  Because they are badly implemented.  As usual.  Hence the 3rd way would be to reroute the App to some DummyOrg which then acts as the main account.  Hence the App always succeeds, but only affects the DummyOrg and not the main account.  (This is what I call GH Firewall.)  This is not complex stuff, all you need is to allow to choose some Org instead of the main account when some access rights are requested.  So the main account just only is an Org.

> I do not understand, why there are Orgs.  An Org is just some special form of account.  Hence both should be quite the same.
> But they aren't.  I have no idea, why.  Yes, the problem is, that Orgs do not have some properties an Account has.
> So to be able to reroute the "main" access rights to the Org means, that some account-dummy-data must be added.
> This is clumsy.  It is nearly as clumsy as the handling of SSH-Keys.
>
> Why is there a difference between Account Keys and Deploy Keys?  Why is there a difference of App access rights and SSH keys?
> Why isn't there not a way to control, what which access is allowed to, independently if it is some access token,
> SSH key, App authentication, Oauth, whatever?  Why am I not allowed to change permissions afterwards?
> All I am allowed is to completely revoke access.  All or nothing.  WTF is this?
>
> Said differently:  You are in the desert.  You are thirsty.  All you want is a bottle of water.
> However everything which you are able to get is either get all water on this planet at once or no water at all.
> Because it is binary.  All or nothing.  Just a bottle of water isn't implemented as Nobody requires this.
>
> Welcome to the postmodern virtual world.  Where Nobody is you.  Where billions of Nobodys do not count.  Sigh.


---------------

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
