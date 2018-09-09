# GitHub and CI

Having a CI is a nice thing.  And there are [quite a lot in the Marketplace](https://github.com/marketplace/category/continuous-integration)

All my data is Open Source and I use the GitHub free Tier, so I decided to try all those which are Free to use, in favor of my OpenSource project.

> With a CI in Background you prevent some errors, like to push code to the master branch with does nut survive Unit Tests.

## Semaphore -> Extremely Insecure by Default

I went through the registration and then added my first project.  Then I had issues to find out where to add additional branches.
(Nope, it's not under Project's setting in the Branches tab, instead it's hiding as 'lil tiny (+) right next to the branch in the project's dashboard).

Then I noticed horrible things, which are an extreme danger to all of my repositories in my GitHub account:

- Semaphore uses Read/Write deployment keys.
  That's extremely bad, because for security reasons, a CI must not have write access.

- **Semaphore is able to take over all data in the repositories and replace it by fake data!**  This is an absolute no-go.

If Semaphore ever is taken over by some evil entity (aka cracked), it can not only read all the data
(which is public anyway) but it also can change them, as it likes.  So it can add backdoors or worse to your software!

> Note that Semaphore additionally has access to your nonpublic mail address.
> But that's OK, as long as you do not give it access to your privat repos.

### Conclusion: You cannot use Semaphore without a proper firewall

The fix was too complicated for me to try out, as long as there are others.  Here is the idea how to firewall Semaphore:

- Create a secondary GitHub Account.
- Configure Semaphore on that secondary account only.
- Push all repositories, which shall go to this CI, to the secondary account.
- Retrieve the results from the secondary account and incorporate them into your real account.

The last two things probably can be automated with the GitHub API somehow, such that you do not have to worry about.

If something evil happens to the secondary account, your main account still is safe and sound.

This also improves privacy, because you can use a throw-away-mail-address for the secondary account.
Hence if Semaphore gets hacked, **this would not even leak your nonpublic mail address**.
