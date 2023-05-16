ADPC could be a game changer in the GDPR vs. Web.  Hence I posted my thoughts about this as an issue there and recorded this here (for me, myself and I).

Copy of my initial post to <https://github.com/Data-Protection-Control/ADPC/issues/25> follows.

--------

I think there is something important missing in the standard.

AFAICS we need a high resilience against abuse (and more, see below).  For this, we probably need [Subresource Integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity) plus a bit more.

If done right, this not only thwarts tracking (to some extent), the main purpose is to eliminate all ambiguity of the consent.  And possibly to hinder some correlation attacks on the `ADPC` header (read: Get hold on your consents by some evil third party).

> Beware, I am no Cipherpunk.  So perhaps I mixed up the cryptographic parts.


# Main motivation

When I consent to something on the web, I consent to a specific version of the legal document of the website.

But when the website changes these terms, I still only consent to the old version.  Else a website can say:

"Do you consent to terms 1 to 5 of our AGB" and then change the AGB at their liking, because the browser still continues to send the consent header.

**No way!**

Hence what we need is to consent to the exact legals terms.

--------------------------

## The proposed changes in the "Consent Request Resource"

Glossary:

- `CRR` refers to "Consent Request Resource"
- `SI` refers to "Subresource Integrity"
  - I only refer to the hash variant here, as only a hash identifies a specific version of a document.

The `CRR` must:

- contain more mandatory parts
- contain a cryptographic protection (~~MAC~~ Edit: AFAICS no MAC needed at all, as the Hash already authenticates)


### Part 1: Link to Legal Terms using `SI`

As the consent due to some `CRR` always is given according to the current legal terms, the consent is bound to these legal terms.  When the legal terms change, the consent does not automatically apply to the new legal terms.  Hence there must be a way to track to which the consent belongs.

There already is a standard for this called `SI`.  So the link to the Legal Terms must be embedded in the `CRR` and protected by `SI`.  This way we have a link between what you have consent and what the terms were at the time of the consent.  And this link cannot be broken (only got lost).

If such a page which covers Legal Terms contains additional legally binding resources (like images, links to other pages, etc.) then these links must also be covered by `SI`.  Any link which is not covered by `SI` hence is not legally binding and not part of the consent.

There may be several links in the `CRR` of this type:

- A Vendor might chose a link for each for different language settings
- A Vendor might chose different version for different Markets
- A Vendor might chose just an ugly big single page which then refers to all the other documents.

YMMV but I see a use case here.

> The interesting part here is, that we only need the `SI` hash to uniquely identify the document.
> We do not need some (possibly lengthy) URL or similar.  The hash is enough.


### Part 2: Wording of the `CRR`

When I consent to something, it is important, which variant I consented.  Because there are subtle details in the different languages.  And AFAICS we need translations.  But the user does not use all the translations, just one.

The vendor might also revise these texts, to clarify or whatever, while not revising the Legal Terms, as this something completely different.  For proper changes in the Legals, you need Lawyers.  However for changes of the `CRR`, you just need a CTO or even only the Web Designer.

Hence both are different, and need a different security context.

In the `CRR` there are currently `ID`s.  Which could be abused for tracking.  (Feel free to add links to those other Issues here.)

Tracking is bad.  Hence this proposal eliminates the `ID`s in favor of the index.  But the index lacks information about, what the consent contained.  Hence we need a clear thing which expresses it again.

To be able to track Part 2, the JSON object must be brought into some stable format and then is hashed with an algorithm.  This is done in the next part.


### Part 3: The combined Hash

A third section of the `CRR` now creates a combined hash for Part 1 and Part 2 in a way that both can no more be separated.

The two parts offer `O(NxM)`.  But quite often only `N` or `M` make sense.  Hence the Vendor provides these meaningful combinations in Part 3 of the `CRR`.  For example, for Switzerland (`.ch`) there may be 3 combinations or 9 (for the 3 languages of the consent, and the 3 languages of the Legal Terms) combinations, because some people might want to agree in Swiss language but with the French legals.  I really have no idea, why.  But we can allow this freedom.

The Vendor now provides entries of the form:

`{ "Hash": [ "part1", "part2" ] }`, looking like `{"oqVuAfXRKap7f": ["en_US","de_DE"]}`

- For Part1 we already have the `SI` Hash.  Call it `H1` (for legal hash).
- For Part2 we transform the JSON into some stable form (to be defined, like minimal sorted JSON with no padding).  Call it `H2` 
- Now calculate `Hash(H1 H2 H1 H2)`
- Then truncate it to some suitable length
- Length must represent at least 69 bit of the Hash, hence you need at least 12 characters if the Hash is encoded base64.

> This is only a proposal.  I am no Cipherpunk, hence somebody else might find something more secure.

The important part here is, that the Browser is able to calculate and verify this hash independent of the Vendor.

> This does not make tracking impossible, but it becomes very difficult.  As you - see below - must be able to reproduce the documents which produced this Hash on the User's request, as the Browser had verified the documents at the time of the decision.


## Now the consent

`ADPC: withdraw=*, object=direct-marketing`

- Nothing changed here.  The Hash is not even involved.

`ADPC: withdraw=*, object=direct-marketing, consent=oqVuAfXRKap7f,3,4`

- This says, that you consented to index 3 and 4 of the `CRR` parts 1/2 which are identified by Hash `oqVuAfXRKap7f`.

It still is short enough (probably even shorter as with the current spec) and also mathematically exact references everything.


## Requirements

There must be some rules, so it is clear how to handle edge cases:

The Consent is only valid, if the Vendor is capable to reproduce all documents from this Hash.  Else the Consent is voided.

- This means, the User can somehow look up `oqVuAfXRKap7f` at the vendor (possible in some User area) and then must be presented with the documents (Part1 and Part2) again.
- The browser then can hash Part 1 and Part 2 again, and thereby verify the Hash (here: `oqVuAfXRKap7f`)

If the Vendor is incapable to reproduce all documents, the Consent is invalid and hence no more given.

- This forces the Vendor either, to keep all the old references (for example put it into some `git` repo and push it to GitHub)
- Or the old consent must be thrown away and a fresh new consent must be pulled from the user.

The latter requires a properly functioning change management, as there is nothing more annoyingly than some consent, which is re-requested at a steady pace.  (As other who follow this Spec do it less and less, those evil websites get even more pressure).


## Tracking

Tracking is still possible, but needs to keep (waste) a lot more effort.

- You must pre-calculate all those hashes of Part 3 (probably only 1 because you want to track)
- You then must be able to recreate all the documents in question (because you do not know when the consent arrives)
- You must be very clever, as things can be tracked from the outside
  - There are changes allowed for different markets
  - So IPs from different continents could produce different documents
  - But IPs from the same continent/market should create reproducible hashes
- Privacy tools can provide a tracking database where users can donate their hash
  - So a website with thousands of different hashes within a short period of time can be detected
- We can also require that the documents of Part 1 must have a certain format
  - So you can no more easily apply steganography to them, because "hidden" elements are prohibited
- We can also require that Part2 must be in a short format
  - Hence staganography is unavailable here as well, so you must provide some proper text (probably provided by some AI)

## Additional data protection

Targeting users, such that the user has a specific Hash, still is an option.  And there is some really good reason for this.

Your consents can be highly sensitive data (porn preferences, diseases you have).  So there might arise the need to hide them.

As the Vendor can recreate all the data (see requirement above) anybody who gets hold on this short hash can revert everything such, that it is clear, what you have chosen.

That is bad.

But the above easily offers a way to escape this:

- Just add some "random choices" to Part2
  - This randomnizes the Hash of Part2
- When the user consents, you must save the seed which created that randomnization along with the resulting Hash.
  - You can put the seed into the ID field where the user consents to store this seed (to protect the ID from reverse engineering)
- At the end you still conform to the Requirements
  - And the Hash used in the `ADPC` Header no more be correlated with others
  - Only the Vendor can reverse the Hash to what you have consented
- Note that the index still is in clear text.
  - But you do not know what each index refers to
  - As the vendor can randomnize the sequence of indexes
  - And we can have fake indexes, which simply have no effect at all
- Also note that there is absolutely no need to offer the seed to anybody else than the user
  - So only the User and the Vendor have access to the Seed to properly verify everything
  - There is no need for a 3rd party to be able to do the verification.

YMMV but I think, if we introduce a new standard, it must also offer things like that.  Because Consent is not entirely a bad thing.  Perhaps it is used between you and your Health Insurance.  And having a standard, it should protect us in all directions.

> Just my 2ct to this.  I do not claim this is perfect nor complete.  Perhaps I even have forgotten about more important things.
>
> But I hope it is fairly easy to implement and to understand.  As good things should be as simple as possible.


# To sum it up

Using Cryptographic Hashes and `SI` not only protects against abusing this standard by faking documents,
it also gives us some good basic protection against tracking abuse.
Also it gives us the opportunity, to protect sensible consent making from possible correlation attacks.

As we do not know what the future holds, a new standard should be created as resilient against abuse as possible.

PS: ~~Sorry, I do not proof-read it (again).~~ I only edited the major typos I found.  So please bear with me and the typos.
