# About SSL Certificate Validation

A very easy solution against MitM Boxes.


## Basics

SSL is there to protect your communication.  It is supposed to protect communication from end to end and make MitM (Man in the Middle) impossible.

Today this is done with some easy to understand protocol:

- You create some secret key.
- You create a certificate for the Public Key part of the Secret Key.
- The LetsEncrypt CA signs this Certificate, thus authenticates the Public Key to belong to you.
- You install this signed Certificate in your WebService along with your Public Key

Then:

- The Browser contacts your WebService
- It downloads the certificate from your WebService
- It checks the validity of the Certificate
- This authenticates your Public Key


## MitM

As nobody else has the secret key which matches your public key, nobody else can fake your identity.  Right?

Wrong!  The problem is the "checks the validity of the certificate" step.

To do the verification, the Browser uses a list of trusted CAs.  There are hundreds of them.
Hence a single CA which is not trustworthy breaks the whole thing.

MitM Boxes (like BlueCoat) are one of those CAs which break the whole thing.  The process is as follows:

- Somebody, like a Company, installs a Fake Root Certificate of a MitM Box into the Browser.
- This Browser now wants to reach your WebService
- The request first hits the MitM Box (which usually acts as the Company Proxy).
- The MitM Box connects to the destination instead of your Browser.
- So your WebService talks to the MitM Box instead of the Browser.  The MitM Box this way gets hold of all the decrypted data.
- The MitM box then creats a fake certificate for your WebService.
- It then signs this fake certificate with the Fake Root Certificate.
- It presents the fake certificate to the Browser
- The Browser checks the valididity of the fake certificate
- This check succeeds thanks to the Fake Root Certificate being installed into the Browser

Hence your Browser thinks it directly talks to your WebService, but it talks to the MitM Box which only acts as your WebService.


## Mitigation

There are several mitigations known.

One of them abuses DNS.  This is, parallel to the DNS record of the IP the Public Key is put into the DNS record.
This way the Browser could compare the Public Key from DNS with the Public Key from the Certificate.
If a mismatch is found there is a MitM box.

This has several disadvantages:

- DNS is not meant for security purpose today.  Hence this must be considered a serious abuse of DNS.
- DNS must be available for this.  Hence not only your WebService must be up and running.
  This adds another single point of failure to your Web communication.
- DNS is a heavily cached protocol.  It may take days for information to update after it was changed.
  So you need to plan ahead weeks.  Something which is difficult if your infrastructure is under stress like an DDoS attack.
- If it is based on a standard, the MitM Box can easily follow this same standard and declare the fake certificate's Public Key valid using DNS.
- If it is not based on a standard, the way you do it might break.  Hence you must allow the DNS lookup to fail.  It's easy to interrupt such queries.
  Hence all the MitM Box must do is to filter the DNS queries and thus break all nonstandard DNS lookups.

Try to use DNS for verification opens a can of worms.  Hence this is not a good way.

The probably best way to protect against MitM is to add a second verification step into the Browser:

- The Browser then checks the Certificate against the trusted root certificates.  Which falls for the Fake Root Certificate.
- But your Application, which is running in the Browser, additionally checks the Certificate against some Fingerprint.
- As the Fingerprint usually changes when the Certificate changes the Application can detect the a fake certificate which is signed by the Fake Root Certificate.

For example Google does this in their Chrome Browser.  Hence if somebody tries to impersonate Google using a fake certifciate Google Chrome immediately detects this.

Let's stay with this as it's easy to implement into any application which talks to your WebService.

But this simple idea presents us with a couple of problems.


## LetsEncrypt Problem

LetsEncrypt creates certificates on the fly.  And it comes completely free.  This is a very very good thing.

The problem here is, that LetsEncrypt certificates are cycled each 2 months or so.  Hence there is no direct way to embed a Fingerprint of the Certificate
into your application, unless you plan to update your Application each 2 months along with the Certicate, which is nuts.

Of yourse you can lock on the Public Key.  But this means that you never can change the Public Key again in futures,
as this would break all applications which are not updated but still used out there.

> Think of COBOL.  It should have died at the end of the last millenium already.
> But some COBOL applications written over half a century ago are still running.
> That's quite normal in IT.  Hence either plan ahead for decades or you fail.

Wouln't it be nice to be able to allow to completely change any aspect of the the Certificate and still be able to verify it?

Well, there is a very simple way to do it:  **Add a signature to the certificate yourself.**

Do do this, there are several ways to do so:

- Cross-Sign the Certificate you get from LetsEncrypt.
  There is nothing which hinders you to add your own CA to the certificate chain and check against this CA.
- Put a signature into some dummy domain which authenticates your Public Key.

Maintaining your own CA and do all the certificate chain things might be the "Standard" way, but seems difficult to understand to me.
Luckily there is a quite more easy way of doing it:

- Create a signature of the Certificate's Public Key
- Put the fingerprint of this signature as a domain record into the Certificate.
- You only need to re-create this domain record if you ever change the Public Key of the Certificate.

How might this look like?

- Create a scratch domain like `*.sig.example.com`.
- Create a dummy Web Service serving `*.sig.example.com` on HTTP (Port 80) for ACME HTTP-01 validation of LetsEncrypt.  You do not need HTTPS here at all.
- You can also use DNS-01 verification or any other verification if you like.  I think HTTP-01 is most simple and easy enough.
- Use the signature as the name part instead of the `*` of `*.sig.example.com` in some chosen ASCII lowercase coding which is allowed in domains.

Stay away from the characters `-` and `.` in the encoding.

My recommendation is:

- Use Bech32
- Use human readable prefix `s`.
- to encode a SHA256 into the domain part
- This takes 52 characters (4 bits are padded)

The problem here is that the usual signature algorithm creates a too long thing to stuff in there.  We want to keep it manageable, right?

Hence we must change this a bit to keep everything down to a manageable size:

- Extract the PubKey of the Cert
- Extract some metadata of the Cert
- Create a SHA256 from this
- Encrypt this SHA256 with the private key

Vice versa:

- detect the entry
- decrypt with the public key
- This gives a SHA256
- Extract the PubKey of the Cert
- Extract some metadata of the Cert
- Create a SHA256 from this
- compare the two SHAs

If the SHA256 is too long to fit, use only a portion of it.


## The JS Problem

Sadly JavaScript, today, gives us no way to check the Certicate found from the JS side in the Browser.
Hence we cannot use the very simple approach for Applications shown above.

Or can we?

Yes, we can.  It's seems a bit weird, though.

- As you cannot access the Certificate information from JavaScript, you cannot be sure you talk to a MitM Box or the WebService.
- Hence you have to provide this information in-band.
- As the MitM Box would pass the information in-band as well, you also must sign all those in-band information.
  As the MitM Box cannot create this signature, this protects the information against Fake News coming from the MitM Box.
- If you also want the MitM Box to not being able to read the conversation, you need to reinvent the wheel and create your own secure transport layer.

And if you do the latter you can entirely drop HTTPS as well, except for one thing:  Dropping HTTPS makes it easy for everybody to extract MetaData,
hence not only the MitM Box gets this metadata but each router on the flow between Browser and Web Service.  Quite often this is not important.

> Note that you can still use the same approach as above, as you can implement TLS in JS directly.


## Secure JS Bootstrap

With an Application (the first easy solution) it is easy to provide a Starting Point.  The Application.
You just assume that the Application stems from a trustworthy source and is not fake.

As if it is fake you cannot assume anything and there simply is no way to protect against such fake.

With JS it is a bit more difficult.  As you cannot be sure that the MitM Box outputs fake JS already.

Browsers do not provide a human friendly way to check if something really is valid code.  You must read and understnd the code for this, right?

Sort of.  There is some way to fix this problem.  This is the **Secure JS Bootstrap**.

A Secure JS Bootstrap works as follows:

- Download the Secure JS Bootstrap.
- Verify the Secure JS Bootstrap bit by bit.  You can skip this pass if you got the Secure JS Bootstrap from a trustworthy source.
- With the help of the Secure JS Bootstrap, download the Secure JS Loader of the Application.
- The Secure JS Bootstrap presents the Fingerprint of the Secure JS Loader.
- Compare the Fingerprint with a copy of the Fingerprint from some trustworthy source.
- If both match press "OK" to execute the Secure JS Loader.

This assumes following:

- The reality is trustworthy.
- The Computer and Display combination is trustworthy.
- The JS engine of the Browser is trustworthy.
- The Secure JS Bootstrap is from a trustworthy source.
- The Secure JS Bootstram is executed in the JS engine unharmed.
- The Fingerprint is matching.

Note that the setting of the Browsers do not need to be trustworthy, neither need the network to be trustworthy as well.

If anything of the above does not hold, for example you are living in the Matrix or World on a Wire or your Display connection is compromized,
every bet is off.

But in our current reality, AFAICS, all of the above assumptions hold true:

- It's very likely we do not live in a Matrix.
- Companies usually do not tamper with the JS engine of the Browser.  Because doing this usually opens Pandora's Box.
- Computers are usually only bugged in very exceptional cases.

Anyway YMMV.  Stay secure.


# FAQ

Where can I find a Secure JS Bootstrap and Secure JS Loader?

- I plan to think about working on it.

Can I use a Secure JS Loader with some JS framework like JQuery or Angular?

- Probably not.  AFAICS exactly 0 JS frameworks out there are constructed with real security in mind.

Will there be a Polyfill to make JS frameworks magically secure against MitM attacks?

- I doubt so.  The problem is everybody believes in Bleeding Edge these days.  This voids Security sustainably.
- This also probably needs browser support.  But AFAICS nobody is really interested to do this.  Why?
