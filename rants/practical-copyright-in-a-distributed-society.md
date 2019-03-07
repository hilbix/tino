# Practical Copyright in a distributed society

## The Problem

The problem in our modern world is Copyright and Consumers.  Both sides have their needs.

Copyright owners want to make a revenue out of the content they create.

Consumers want to have reception freedom on everything they consume.

These two seem to be something which you cannot combine.  Apparently one side must lose the war.

Really?

No, this is not the case.  Just do the right thing and everything will be fine.  Fine for both sides.

In the following I describe a system which is:

- Practicable
- Easy to implement
- Convenient to use for both sides
- Works without doubt or other nonsense
- Does not need lawyers
- Enables honest people to stay free and honest.
- Enables honest content creators to get paid for their work.
- Prosecutes dishonest behavior

Note that dishonest behavior is not prevented nor punished by the system.  We do not need that, because things are clear:

If you are dishonest, this can be detected, and this then can be punished by other means.  Easily and without doubt.
Hence there is no problem to enforce this by the natural normal way we have to day to enforce things:

Police, Lawyers and Courts.

## The central registry

The way to protect things are very easy to maintain with a central content registry.
Here is how I would recommend to implement such a platform:

### Registry for the Content Creators

- Digital content creators (Creators) take the best quality of digital content they have
- They upload this content to the registry
- Then they register references of less quality content, which originates from this content, to the registry as well.
- The Creators then can add meta information about that content

### Registry for content Receptors

- Content-Receptors (Users) query the registry about the content using content hashes.
- The registry either responds with no information - in that case the content is not registered and hence it is free to use.
- Else the registry responds with the answer about the status (i. E. licensing terms) of the content.
- Then the User can check the license or obtain a license.
- In the response there is a quality response (percent).  Each license of better quality includes all licenses of lesser quality.
- If the license matches the licensing terms, the content is viewed, else the content may not be viewed.

The automated license check can be implemented - anonymously - into public available content players,
such that all users can view content unrestricted as long as they have the license.

For example, if somebody has a newspaper license, he can read the full article.
People without that can obtain a (free of cost) excerpt license and hence read the comprehension of the article.

This is up to the Creator how to implement that.

Note that there are no enforcements for dishonest people, who, in reality, take a newspaper from the news stand without paying
and then, after reading, put the newspaper back and pretend, they did no harm.  They did.  However there is no punishment
included in doing so, unless the newsstand owner shoots this abuser.  But you get it.

Most people are honest and will use this system.  As it is anonymous, protects their rights and is easy to follow.
We should not design a system which expects dishonest behavior.  People who do so know they are criminals,
and without a license they own it is easy to prove, they are.


### Registry terms

The registry must live and needs money.  This is easy to archive by having a fee for registering content.

- The fee to register content is 1 EUR per year per 1 MB of unencrypted and uncompressed content stored in the registry, 
  calculated by the number of bytes of less quality content.
- Note that this is per-document (you cannot combine things to fill up 1 MB).
- Storage of the less quality content (which must be much smaller) does not cost anything.
  For larger things, like movies, this less quality content is implemented by content hashes
  which is calculated over a certain snippet of the original content with the lower quality setting.
  (There can be multiple such snippets for each content and multiple qualitis for the same snippet.)
- The content is protected as long as the fee is paid, limited to a max. of 50 years after the death of the last creator.
- When the fee is no more paid, the content is kept by the registry **two times the time, the content was protected**.
- Afterwards it is deleted or archived and considered to be in the public domain.

To access the content on the registry is with a fee involved:

- The registry provides everything which is has for public download.
- For downloading things there is a fee involved: 1 EUR per GB in either direction.
- This includes all data of this registry, including the access to the hash information.
- With 1 GB you can verify 1000000 hashes, as least, as 1 Hash with metainformation should be less than 1000 bytes.

The prices are fixed for now and the future.  If the EUR loses some value, the fee gets lower.
At the same time it is expected, that storage and transfer costs got much lower.

Hence there cannot be any problem in running the registry:

- All costs are covered.  Today.
- And everything is easy to use, today.

Note that you need to pay each year, and you must pay in advance.
Hence if you pay 1 EUR, you have 1 Million queries or 1 GB of download.

After a year this is used up, regardless how much is left, and you have to pay again before you can communicate again.


## Free public access

There is no free public access.  Every access counts.

However with 1 EUR per year for 1 GB of data (which is 1 Million queries per User) there should be no problem.
For example in Germany, the Rundfunkabgabe costs about 17 EUR per month(!).  Only 1 EUR per year(!) should be enough
for this registry.

However there is a free API to access the registry.


## Anonymous use

Neither the Creators nor the Users need to directly contact the registry.
Hence you can take part anonymously.

**This means, you also can anonymously publish your content and receive revenues for it!**

Here is how:

The registry is not operating on accounts.  It only knows about payments and usage-terms.

If you protect some published content (by publishing it via this platform) you can set the terms.
You can always change the terms later on.

However the one who claims this all does not neccessarily is the same as the creator.
Anybody can do this.  On request of the creator or not.
(If it is not rightful, the normal ususal methods apply:
You go to the court, the court checks it, and then the platform will follow.)

Hence Upload/Download/Queries can involve a 3rd party, an anonymizer, where everything is done on behalf of this proxy.

Note that in that case the proxy pays for the service.  Like everybody does.
You cannot use your access right in that case, as the platform else would identify you.

Note that you can have caches and proxies and anything below the platform.

The platform only charges for use and registered content.  There should not even be any problem,
when there is only one single user who does everything, the upload and the checking.

Likewise there is no problem, if you have 100 billion concurrent users.
As this means, you have - at least - 100 billion EUR per year.

Really no problem to handle with modern cloud technology, even on the most exepnsive cloud you can imagine.


## License management

How is license management done?

It isn't by the platform.  The plaform only has means to communicate the licensing terms.

It will respond with a pointer how to check the license (there must be standard for this, such that automated tests
can be done here) and another one, how to obtain a license.  One or many.

If you got the license by other means, this is OK.  For example, each DVD then needs to include a license,
which allows you to play the DVD contents - if it is registered in the platform.

Licensing is done outside the platform.

- The user has to, somehow, obtain the license, perhaps by the pointers given.
- The user has to ensure, the license is correct.  Usually this is implicitly tested by the players.

And the content creator only has to find some license manager, who implementes the license management.

Here the content creator can make the money.  Because nobody protects the Creator to carge for the license.


## License duration

There is no limit on the duration of the license.  A license can last forever or only a period of time.

However please note that you do not need a license anymore as soon as the contents is de-registered with the registry.
At that same time the content becomes free to use for now and all times in future.
(Note that contents is unprotected before it is registered with the registry.
Not registering things is OK, however expect trolls, who will register unregistered things, just for the
fun that you the need to prove - by court - that you are the rightful owner, before the registry needs to accept that.
Note that you have to pay for the court yourself in that case, as the troll probably will be anonymous.)

Note that anybody can pay for the contents extension.  This does not need to be the author or the original creator.
Other creators can do this.

Also note that nobody needs to give you a license.  If a contents is registered and paid for,
then nobody gives a license to it, nobody can play/read/etc. the contents and stay legal at the same time!


# Whis is this fair?

Well, contents which is not worth 1 EUR/year/MB probably is not worth to be protected.

- Protecting a news text article costs you 1 EUR/year.
- Protecting an 800 MB independent movie, shared on youtube, costs you 800 EUR/year.
- Protecting a HD-BluRay movie with 50 GB costs you 50000 EUR/year.

However¸ as long as you can make a revenue out of it, it is worth the price for sure.
Even people with few mony can protect things this way very easily and effectively.

You do not need to register with the platform if you can protect your contents properly.
For example, if DRM of the BlueRay would work, you would not need to register it, all you need is lesser quality.

However (as we know) DRM does not work at all, so here you have a better system than DRM to protect your content.
Why not?  If a user downloaded your movie from ThePirateBay, obtains a license and then plays it, what is bad here?

You got your licenese!  Without any effort!  You did not even need to provide anything, except the license.
Just cash flow without problems.  Everything is fine.

Also need that you can have different licenses.  For example viewing it at home is OK with the license,
but not sending it to an audience like on a Beamer on a LAN party.

Here you can provide different licenses with ease!  And there is no doubt for anybody,
no doubt there is a special license needed (as this can be looked up via registry)
and no doubt on how to obtain the license (as this information is present in the registry as well).

This cannot be more easy I guess.

This also is fair, as there is a very simple way to follow the rules.
Either something is protected, or you are free to use it.


## Protecting intellectual rights

Now to some other thing.  Illegal file share.

Some user has downloaded your Movie from some of those "illegal file hosters" (note that I do not thing there is
anything illegal there.  Perhaps some people did not stick to the law when uploading contents.  But this does
not render such platforms illegal!)

Now the user wants to play it.  The player contacts the registry, finds a hash for a lower quality variant of your movie
and presents the user the need to have a license.

The user now takes out the code from his DVD release and can play the movie just downloaded, because it has less than DVD quality.

Where is the problem with this?  The user has a license.  However perhaps he forgot to carry the DVD around.
Why should the legal owner of a DVD be bothered with this "illegal download"?
He did no harm to you, the creator, because he already paid the contents!

Now the user shares the license.  He has only one DVD but 10 of his friends download the file and view the movie,
with the code of the owner.

Well, WTF, why?  They can view the movie - which was downloaded legally - without any license if they like.
They know, they are doing this illegally.  How should using a license outside the licensing terms make a difference?
The only difference is that they pretend to have a license, which can be easily checked.
The license is for a DVD, so they must own the DVD, but they do not.  Hence they are lying.
Hence they did nothing differently than to view it without a license at all.

And no, you cannot prevent others from consuming your content illegaly.  This simply isn't possible.
For example, somebody can "bug" a theatre, and this way take a screener of any movie of this theatre.
How do you want to protect against this?

Isn't it more easy to just make it as easy as it can get to enable rightful owners to use their license?

And how do you do that?

Well, just download the file from the "illegal" file share yourself.

And register a lower quality with your existing contents.

This is fair, as soon as you do you claim your copyrigth again.  Automatically.
Even for files, which were downloaded long before you managed to find them.

As soon as the user plays them again, he will see a licensing term message,
that the thing now is protected.

Users not following the rules are not following the rules, there is no way to enforce that.
However you do something good for the rightful owners of your content,
they can still use "illegal" file hosters to access your contents.

Also by playing fair, you inspire people to do so, too, and obtain a license in some distant future.
As it is easy and convenient most people will do, I am sure, because most people do want to play by rules
(even that they perhaps currently cannot do this, due to some obscene circumstances).


# There is no problem, only a solution

This really is a solution.

It is not only a solution, it is the only solution.

Why?

Because the Internet does not tolerate falures.

Trying to enforce things, by law, and doing so the wrong way, will be an error.
Something the Internet will not forgive.

Hence implement it the correct, the Internet way.  As shown above.

This works.  This is the only thing which will work.  For now and in future.

And I am sure: As soon such a central registry exists, everybody will be happy to use it.

Not from the beginning.  It will take it's time.  But then it will be a success.
The biggest success for all, as there are only winners:

- Creators
- Consumers
- And the most important ones:  Contents (which is available through the Platform and there is plenty of time to create a copy).

> Why is contents the most important one?  Well, the Internet is made out of Data.
>
> Contents, that's all the Internet is about!
>
> Do please do not mess with your contents.  The Internet will not forgive!
