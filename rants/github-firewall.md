Summary:

- Cirrus CI ([Marketplace](https://github.com/marketplace/cirrus-ci)) - [works for me as it only wants read access](../howto/cirrus-ci.md), Linux/Windows/MacOS-X, minimal Web-UI, but needs not-so-easy-to-use file `.cirrus.yml` (except with `Dockerfile`s, which I do not grok yet)
- Semaphore ([Marketplace](https://github.com/marketplace/semaphore)) - cannot use without firewall as it wants full write access.  Besides of that it looks very easy to use.
- Travis CI ([Marketplace](https://github.com/marketplace/travis-ci)) - cannot use without firewall as it wants full write access.  Needs not-so-easy-to-use file `.travis.yml`

> We definitively need a GitHub Firewall!  What is a GitHub Firewall?
>
> This is some firewalled account with arbitrary (fake) account data which has readonly access to all of your public repositories.
> (It can have readonly access to your private repositories as well if you allow.)
>
> All changes to the firewalled account never make it back to your real account without your consent.
> Hence, whatever happens to the data in your firewalled account, it isn't affecting your real account at all!
>
> So a **GitHub Firewall** does two things:
>
> - It defends your privacy against any and all possiblilities.
>   It not only protects you against failure on the other side, it also protects you for your own human errors.
> - It restricts access to the GitHub API, because only the firewalled data can be compromized, not the real one.
>
> I'd like to see this as a GitHub feature.  Without the Help of GitHub it can be implemented as well,
> but this is clumsy, as it involves doubling all the data in the Repos.
>
> As a naming:  Instead account `XXXX` use account `XXXX-fw`


# GitHub Firewall

Having a CI is a nice thing.  And there are [quite a lot in the Marketplace](https://github.com/marketplace/category/continuous-integration)

All my data is Open Source and I use the GitHub free Tier, so I decided to try all those which are Free to use, in favor of my OpenSource projects.

> With a CI in Background you prevent some errors, like to push code to the master branch with does nut survive Unit Tests.

However, AFAICS some of those CIs are implemented so braindeadly, that they are a major security risk to your data on GitHub.
(Am I the only one to notice that yet?)

To fix that, we need something like a GitHub firewall!

(This text will be extended when I have the time.)

## Semaphore -> Easy to set up but Extremely Insecure by Default

- Pros: Very easy to setup.  Supports GitHub and BitBucket.  Nearly no documentation to read, it tells you everything you need to know (perhaps except on how to add branches).
- Cons: Unusable from a security perspective.  Only supports GitHub and BitBucket.

I went through the registration and then added my first project.  Then I had issues to find out where to add additional branches.
(Nope, it's not under Project's setting in the Branches tab, instead it's hiding as 'lil tiny (+) right next to the branch in the project's dashboard).

Then I noticed horrible things, which are an extreme danger to all of my repositories in my GitHub account:

- Semaphore uses Read/Write deployment keys.
  That's extremely bad, because for security reasons, a CI must not have write access.

- Semaphore uses the "all repo" permission (or whatever it's called).  So **Semaphore is able to take over all data in the repositories and replace it by fake data!**  This is an absolute no-go.
  (Note that this can only happen, if Semaphore is granted access to your Repo data, and somebody evil takes over Semaphore.  As soon as you revoke OAuth access, this can no more happen.  **So be sure to revoke Access on the GitHub side!** It's under **[Settings :: Applications :: Authorized OAuth Apps](https://github.com/settings/applications)**)

If Semaphore ever is taken over by some evil entity (aka cracked), it can not only read all the data
(which is public anyway) but it also can change them, as it likes.  So it can add backdoors or worse to your software!

> Note that Semaphore additionally has access to your nonpublic mail address.
> But that's OK, as long as you do not give it access to your privat repos.

### Conclusion: You cannot use Semaphore without a GitHub Firewall

The fix was too complicated for me to try out, as long as there are others in the marketplace to try out.
Here is the idea how to firewall Semaphore:

- Create a secondary GitHub Account.
- Configure Semaphore on that secondary account only.
- Push all repositories, which shall go to this CI, to the secondary account.
- Retrieve the results from the secondary account and incorporate them into your real account.

The last two things probably can be automated with the GitHub API somehow, such that you do not have to worry about anything.

Also, if something evil happens to the secondary account, your main account still is safe and sound.

This also improves privacy, because you can use a throw-away-mail-address for the secondary account.
Hence if Semaphore gets hacked, **this would not even leak your nonpublic mail address**.

Unfortunately doing so needs a high effort.


## Cirrus CI (works, looks secure enough, but needs a `.cirrus.yml` to function)

> I have a [small HowTo for Cirrus CI](../howto/cirrus-ci.md)

- Pros: Integrated into GitHub, supports Linux/Windows/MacOS (even that I do not know how)
- Cons: Complex, as it is integrated into GitHub and needs a complex file `.cirrus.yml` (`yml` alone is far too complex already!).  Only supports GitHub

> To get it started:  Activate on GitHub Marketplace.  Then create some `.cirrus.yml` on the repo you want, push and there you go.  See below.

From a security point of view it looks very promising:
Readonly access to everything and write access is only needed for states.
This is correct, as this is the minimum needed.

So technically it seems to be implemented very nice, but humanly it is very puzzling to get it started.
Just everything happens behind the scenes, and there is no nifty front end interface which might blow your mind.

https://cirrus-ci.com/ is the dashboard and it is just the bare minimum.  Not much to do there except Logout.
Until you push something against GitHub, then it suddenly gets filled with information!

Documentation sits on https://cirrus-ci.org/ and without documentation, you are doomed.  This is not a modern setup ;)

Let alone the `.cirrus.yml` file.  This is very good and very bad at the same time!

It is quite complex to get it proper.  However this way Cirrus CI does not need to maintain some arbitrary setup, all you need is to activate it and create this file and push.  And this is where the problem starts.


### `.cirrus.yml` WTF

See https://cirrus-ci.org/guide/writing-tasks/

There is no configuraton tool.  At least I did not find one.  All I found were https://cirrus-ci.org/examples/ which is a bit .. well .. bare.  Do not get me wrong.  The exampls are quite amazing.  And that is the problem:  You are amazed.  This does not really help you to understand it.

Open questions and issues with Cirrus CI:

- How to exclude some repo from the dashboard?  I have repos, which are pushed frequently (say: each microsecond).  How how prevent these galaxies of planets of fields with heyballs to hide the needles?

- Where is the list of containers I can use?
  - Moreover:  Is there a standard container with all GNU-tools like `gcc` and `gawk`?

- How to test a build against several platforms at once?

- How to create a badge on the `README.md` for some branch?

My usual build looks like:

```
git submodule update --init
make
make test # sometimes
sudo make install
```

This translates to following `.cirrus.yml`:

```
container:
  image: gcc:latest

make_task:
  prep_script: git submodule update --init
  compile_script: make
  install_script: make install
```


### BTW

I like the UI.  It's minimal but functional.  No bloat, no distracting things.
It's quite not perfect, you still can leave away something.
For example those repository settings could be replaced by a Cirrus CI meta repo (see below how).

A good idea are the encrypted variables.  However I would like to see following improvement there:

- Be able to re-use such variables by different users.
- Be able to use an external service to securely provide such variables.

Re-Use means, that if I clone a project, I do not need to change the `.cirrus.yml` file to use my credentials.
This can be done by a two-step-translation of a variable instead of a single step.

This works hand in hand with the second wish.  Cirrus CI certainly does not want to keep state information for users.
This is error prone, you need Backups and the like.  Bad thing, get rid of this!

`git` to the rescue here.  Require users to have one "**Cirrus CI meta repo**".  This then serves following purpose:

- First, it keeps all the user meta data.  All, even that, which Cirrus CI needs to keep today.
  - So you do not need to keep the "Security Preferences" of each repo as this can be configured in the meta-repo.
  - Please note that secured variable are not stored by Cirrus CI today, as they are self-contained.
- In case a variable uses two-step-translation, it is translated as follows:
  - In the `master` branch of the meta-repo a YML file is looked up which is named after the repo.
  - If a variable value is present there, it is taken.
  - If the value is a secured variable, it is decrypted.
  - If it is a "commitish:file" definition, this object is read and used as the variable value
  - If the latter is secured, it is decryted as well.
- Also you can put more information into this meta-repo, like preferences for builds etc.
  - As you look up a yml file named after the repo anyway, you could even eliminate the need for a `.cirrus.yml` file
- If you authorize Cirrus CI to push against the meta repo, you can even build a user UI for most tasks users want to do with Cirrus CI.
  - You do not need direct write access.  Write access can go to a secondary `git` repo which then is used to cherry-pick the changes.

So Cirrus CI would do good to support it this way.  It would leverage most Cons.

Also note:

- Currently, there is no way to build a repo with Cirrus CI, before you push to it.  It needs a push.  Which is stupid.
- With such a meta-repo, a push against the meta-file of a repo would trigger a build.  This is good.

Why is it good?  Well, consider you have a repo named XXX which depends on YYY.  YYY might have a bug, so XXX fails.

Perhaps this relationship is very very complex.  Like something, which works when the traffic lights of a certain crossing is operational to 80% oder more.  You get the idea.  So you need to be able to build something out of a push schedule.

Cirrus CI apparently does not support this easily today.  Which is a sad thing.


## CircleCI (not yet evaluated)

- Pros: I do not know yet.
- Cons: I do not know yet.

Perhaps I will evaluate next, if I fail with Cirrus CI.


## Codefresh (not yet evaluated)

- Pros: I do not know yet.
- Cons: I do not know yet.

Just read the very first sentence on Marketplace.


## Buddy (not yet evaluated)

- Pros: I do not know yet.
- Cons: I do not know yet.

Is this a CI as I want?


## Travis CI -> Complex to Set Up and Extremely Insecure by Default

- Pros: Godfather of CIs for GitHub.  Local configuration in `.travis.yml` instead of some obscure external service.
- Cons: Unusable from a security perspective at my side.

Falls in the same trap as Semaphore.  So I cannot use it.

The permissions on the GitHub App look reasonable.  They are a bit broader than from Semaphore, though.

However as soon as you try to login to https://www.travis-ci.com/ it wants "all repository read/write" for your account.  As Semaphore wants, too.

Sorry, no, I won't give that.  Ever.  For the same reasons stated above.  **Not without a firewall.**
This is sad!


## Jenkins (not yet evaluated)

- Pros: I do not know yet.  Probably:  Godfather of CIs.
- Cons: I do not know yet.  Probably:  Not a hosted service, so you need to do it yourself.
