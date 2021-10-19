> I am just starting with Foreman.
> If I stumble over more WTFs (things badly documented which I managed to fix for myself) I certainly will add more.
>
> No guarantees, though, I wrote this here, after I managed to find out how to do it properly.
>
> Properly for me, but perhaps not for you!

# Foreman

Whew!  [What a smoke grenade!](https://www.theforeman.org/manuals/3.0/quickstart_guide.html) instead of proper documentation.

> Proper for me, not for you!


## Problem

What is the problem?  Security is the problem of course!  They simply do not tell you:

- How to verify that everything is legit
- How to verify that the verification is legit
- What is going on whatsoever when you do what they write.

The result is a security nightmare already at the first step, on how to install Foreman!

By unwraping what really matters, you can read here, how to do it with a bit more confidence.


**WTF why?**

Well, it happens that the old Puppet key expired .. YESTERDAY!  Yes, really!  
And, as usual with GPG keys, **there is no secure upgrade path** defined such that you can verify the new key with the old one.

That's why I wrote this!

**Expired key is not just bad luck!**

The probability for hitting some expired key is above 100%.  So there is nearly no chance that no key expired yesterday!

Uh?

Well, simple mathematics:

- Say, a key is valid for 100 years (I never came across keys which are valid that long!)
- This means a key is valid for 36234 days
- There are more than 36234 keys out there.
- Hence, on average, more than 1 key expires each day.
- Hence it is almost inevitable, that some key expired yesterday!


## Install

Reading through the doc gives several WTFs at once:

- Puppet6 shall be installed via an **unverified binary download**
- Foreman shall be installed via an **unsecured PGP key** which even contains already expired (old an unneeded) material

Whew.  What a shame.  Here is how I did it:

- First, I **installed Ubuntu 20.04 LTS live server** into a VM.
  - When I realized, that Debian Bullseye is supported, too (documentation did not list that), it was too late and I was with Ubuntu 20.04.3
- Second, I fixed the hostname as shown in Foreman configuration.
  - Make sure, that the **hostname resolves to the public IP**, not `127.0.1.1`
  - If you get it wrong, `forman-installer` will tell you what you did wrong

```
vim /etc/hosts
ping "$(hostname -f)"
```

> Beware!  On old systems, `hostname -f` may change the hostname to `-f`.  But we are on a modern Ubuntu ..

- Third add the configuration for apt:
  - `$APTCACHE` is where your apt-cacher-ng runs (or similar)
  - You certainly have one, right?
  - Why?  Well, we are talking about a secure setup here, right?
  - But secure setups need a secure network, right?
  - And a secure network cannot talk directly to the Internet, right?
- See below how I tried to verify the fingerprints

```
wget https://apt.puppet.com/DEB-GPG-KEY-puppet-20250406
gpg DEB-GPG-KEY-puppet-20250406
# Verify fingerprint D6811ED3ADEEB8441AF5AA8F4528B6CD9E61EF26
apt-key add - < DEB-GPG-KEY-puppet-20250406

wget https://theforeman.org/static/keys/5B7C3E5A735BCB4D615829DC0BDDA991FD7AAC8A.pub
gpg 5B7C3E5A735BCB4D615829DC0BDDA991FD7AAC8A.pub
# Verify fingerprint 5B7C3E5A735BCB4D615829DC0BDDA991FD7AAC8A
apt-key add - < 5B7C3E5A735BCB4D615829DC0BDDA991FD7AAC8A.pub

cat >>/etc/apt/sources.list.d/puppet6.list <<EOF
deb http://${APTCACHE}apt.puppetlabs.com focal puppet6
EOF
cat >>/etc/apt/sources.list.d/foreman3.list <<EOF
deb http://${APTCACHE}deb.theforeman.org/ focal 3.0
deb http://${APTCACHE}deb.theforeman.org/ plugins 3.0
EOF
```

> This is what is needed for real.
> But this is well hidden in the documentation, partly behind some `.deb` file or some misleading steps.
>
> Ironically these steps look far more trustworthy to me than what they present in the docs, as this is verifyable ..

- Fourth, the real installation, done the standard way:

```
apt-get update && apt-get install foreman-installer
foreman-installer
EOF
```

- Warning!  Do not use `forman-installer -i`!
  - At my side this exposed major problems when used before foreman is really installed!

## How to verify the keys?

I really have no idea!  What I did is:

- Google for the fingerprint.
  - I got less than a page of results.
  - And as the keys were rotated recently, those results were too young to be trustworthy.
- Went to web.archive.org to verify these keys
  - Read:  I opened some of the search results in archive.org to verify, when the page appeared first
  - As these results were some months ago and contained the same fingerprint, it is very unlikely that this went unnoticed for half a year or so
- Also I examined some of the results, and they looked legit
  - Like issues on GitHub opened a while ago.
- I even tried Virustotal, but I apparently was the first one to check Puppet's `.deb` file with Virustotal ..

**There was no path whatsoever which authenticated all the fresh new keys unsing some old one!**  Checkmate.

But afterwards I was convinced (not: sure) that the keys I used above are likely(!) to be the valid ones.

> Blockchain.  Definitively blockchain.  We need some blockchain-thingie to overcome this.
> 
> OK, only half joking.
> 
> **Why does nobody sign new keys using the old one on the purpose to authorize the new key?**
> Well, right, this is only half of what is needed to authenticate (because an old key could be compromized,
> hence signing an invalid follow-up-key).  But it would be a starter. 
