> I am just starting with Foreman.
> If I stumble over more WTFs (things badly documented which I managed to fix for myself) I certainly will add more.
>
> No guarantees, though, I wrote this here, after I managed to find out how to do it properly.
>
> Properly for me, but perhaps not for you!

# Foreman

Whew!  [What a smoke grenade!](https://www.theforeman.org/manuals/3.0/quickstart_guide.html) instead of proper documentation.

> Proper for me, not for you!

## Goal

In an **Offline Environment** (like an Intranet, firewalled DMZ or highly protected Extranet):

- Install Foreman
- [Apply SSL certificate from LetsEncrypt](https://github.com/hilbix/dehydrated/wiki)
- (Nothing more yet, as this is where I am now.)

```
root@foreman:/# dpkg -l foreman puppet-agent | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version       Architecture Description
+++-==============-=============-============-==============================================================================================================
ii  foreman        3.0.0-1       amd64        Systems management web interface
ii  puppet-agent   6.25.0-1focal amd64        The Puppet Agent package contains all of the elements needed to run puppet, including ruby, facter, and hiera.
```

- My installation lives in a DMZ with private IPs without a direct nor open nor transparent connetion to the Internet.  Nevertheless I want proper SSL.
- Hence the SSL certificate is pulled from LE.  This is done with the help of a dummy entry in global DNS and a dummy server which answers just the Challenge.
- Note that LE (dehydrated) also runs in a DMZ on a separate host, and is only able to contact LE and deploy the certs to the servers (using SFTP).
- For me this is a bare minimum setup when it comes to security.  I'd never run LE on the server itself nor have Foreman reachable from or talk to the outside.


## Problem

What is the problem?  Security is the problem of course!  They simply do not tell you:

- How to verify that everything is legit
- How to verify that the verification is legit
- What is going on whatsoever when you do what they write.

The result is a security nightmare already at the first step, on how to install Foreman!

By unwraping what really matters, you can read here, how to do it with a bit more confidence.

> The problem would not exist if a somewhat current version of Foreman or Puppet would be part of Ubuntu (or Debian etc.).
> But this is not the case, apparently.  Hence we have a bootstrapping problem here.  Bootstrapping Security, not bootstrapping Foreman!
> 
> Such a bootstrapping problem is not new.  In contrast, it is more or less the usual case today if it comes to security.  
> Compare: The S in IoT stands for Secuity.  I hate it.
> 
> said otherwise:  
> To do things the right and secure way is not enough for me.  I want to be enabled to verify, that I am indeed doing it the right and secure way.  
> (Verification itself then is just left over as an excercise to the reader.)


**WTF why?**

Well, it happens that the old Puppet key expired .. YESTERDAY (when I was starting to write that)!  Yes, really!  
And, as usual with GPG keys, **there is no secure upgrade path** defined such that you can verify the new key with the old one.

That's why I wrote this!

**Expired key is not just bad luck!**

The probability for hitting some expired key is above 100%.  So there is nearly no chance that no key expired yesterday!

> Uh?

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
  - The VM had 2 CPU and 3 GB of RAM.  (2 GB of RAM is not enough for a succesful install.)
  - When I realized, that Debian Bullseye is already supported, too (documentation did not list that), it was too late.  Hence I go with Ubuntu 20.04.3
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


## SSL

After the first installation (with the default standard setup!  Everything else failed by me for unknown reason) some settings must be changed.

Here: Enabling SSL.

So you have [a LetsEncrypt certificate for your domain which is used for Foreman](https://github.com/hilbix/dehydrated/wiki), but nobody tells you, how to install it into Foreman?  WTF why?

> As usual, documentation does not state anything, and searching the whole Internet does not help either.
>
> There is documentation, but for an outdated foreman version, which is no more valid for the current one.
> Also this blog post apparently is wrong, as the files to edit are managed by Puppet.
> 
> I really do not get it.  Why don't they tell how it is done?

The documentation of `foreman-installer` does not help either.  Why?  `foreman-installer --full-help`, that's why!  That is not helpful at all, just a list of more than 1000 lines.  More than 1000!  Good luck, probability of success with a lottery ticket of a bazaar is much higher than with such a help.

Definitively, some of the mosst obvious things to do must be explained.  And all explanation of "edit some files" which then might be right or not and might get overwritten later on by some other means does not seem wortwhile.  However it looks like this is the only thing you can find out there.

My strategy for a proper trial and error loop looks like following:

- Edit `/etc/foreman-installer/scenarios.d/foreman-answers.yaml`
  - Is is under `git` control, thanks to `etckeeper`, right?
  - And nope, I do not think **that this is a portable way** to be compatible to the future.
  - However some obscure commandline options to foreman-installer can change incompatibly as well in future.
  - And commandlines are not under `git` control.  Hence this is even less than a solution for me.
- Then run `foreman-installer` to apply the changes done to this file
- Then check the outcome

Sigh!

Following assumes that your **certificates are deployed under `/etc/letsencrypt/certs/$(hostname -f)/`** (which is my recommendation, as this path explains everything on itself, no need for documentation whatsoever.  AFAICS doing things always the most straight forward way is the masterkey to succeess):

- `644` `cert.pem` is the cert
- `644` `chain.pem` is the chain certificate
- `644` `fullchain.pem` is `cert.pem` combined with `chain.pem`
- `640` `privkey.pem` is the private key
- `640` `privkeyfull.pem` is `privkey.pem` combined with `fullchain.pem`
- `^^^` those numbers are the permissions owned by `letsencypt`:`letsencrypt`

This is how I do it.  YMMV.

Now [some very outdated documentation suggests](https://theforeman.org/2015/11/foreman-ssl.html) to change following values. `hostname -f` is shown below as `EXAMPLE.COM`:

```
foreman::ssl: true

puppet::server_foreman_url: 'https://EXAMPLE.COM'
foreman::servername: 'EXAMPLE.COM'
foreman::foreman_url: 'https://EXAMPLE.COM'

puppet::server_foreman_ssl_ca: '/etc/letsencrypt/certs/EXAMPLE.COM/chain.pem'
foreman::server_ssl_key: '/etc/letsencrypt/certs/EXAMPLE.COM/privkey.pem'
foreman::server_ssl_cert: '/etc/letsencrypt/certs/EXAMPLE.COM/cert.pem'
foreman::server_ssl_chain: '/etc/letsencrypt/certs/EXAMPLE.COM/chain.pem'
foreman::websockets_ssl_key: '/etc/letsencrypt/certs/EXAMPLE.COM/privkey.pem'
foreman::websockets_ssl_cert: '/etc/letsencrypt/certs/EXAMPLE.COM/fullchain.pem'
```

> Note that this was adapted from the documentation and is in hiera-notation with no trace whatsoever how to apply this notation correctly using hiera.
> 
> At my side I was unable to apply this using hiera, probably because I am lacking the correct command skillset due to the docu just states raw incomprehensible info.  (I am new to Puppet, and the Puppet documentation is even worse than foreman's!  Not even a single page explains what the difference is between `foreman::ssl` and `forman.ssl` and why you sometimes see the one and other times the other.)

This assumes that you use the default install with the puppet server served by the host with foreman, too.

If you look a bit more closely into `/etc/foreman-installer/scenarios.d/foreman-answers.yaml`, you will observe following:

- `foreman.ssl` already is `true`
- `foreman.servername`, `foreman::foreman_url` and `puppet::server_foreman_url` are already set correctly
- We cannot locate any trace of something like `puppet::server_foreman_ssl_ca` in `foreman-answers.yaml`
- `foreman.websockets_ssl_key` and `foreman.websockets_ssl_cert` are empty (at my side, as it is unconfigured yet)

Hence this leads to following script (with the help of some suitable [`edit.py`](foreman/edit.py).  It takes `file`, then `path`, then JSON value to write):

```
cd /etc/foreman-installer/scenarios.d
~/bin/edit.py foreman-answers.yaml foreman server_ssl_key      "\"/etc/letsencrypt/certs/$(hostname -f)/privkey.pem\""
~/bin/edit.py foreman-answers.yaml foreman server_ssl_cert     "\"/etc/letsencrypt/certs/$(hostname -f)/cert.pem\""
~/bin/edit.py foreman-answers.yaml foreman server_ssl_chain    "\"/etc/letsencrypt/certs/$(hostname -f)/chain.pem\""
~/bin/edit.py foreman-answers.yaml foreman websockets_ssl_key  "\"/etc/letsencrypt/certs/$(hostname -f)/privkey.pem\""
~/bin/edit.py foreman-answers.yaml foreman websockets_ssl_cert "\"/etc/letsencrypt/certs/$(hostname -f)/fullchain.pem\""
chmod 600 foreman-answers.yaml
foreman-installer
puppet agent --test
```

- Nope, my [`edit.py`](foreman/edit.py) is not a solution.  It is just an evil quickhack to overcome my lack of knowledge about some suitable YAML editor for commandline, which must be part of Debian, of course.
- Note that I tried Augeas' `augtool` but failed, probably because Augeas does not support YAML?  "Augeas is a configuration editing tool."  Therefor it does not support common configuration files like `.yaml`.  Allright, if this is how our future must looks like, I do not want to be part of it!

## .. and the winner is .. unknown

The webservice now serves with the certificate of LE.  Yay!

However I am a bit worried about the fact that I did not update something like `server_foreman_ssl_ca` to the chain certificate of LE.
This might cause trouble in future when it comes to Puppet.  But I (hopefully) will fix that when I stumble over it.
Also note that the Websocket module is not enabled yet, so I do not know if configuration is correct (using `fullchain.pem` instead of `cert.pem`).

For now, all I have is a bare Foreman's install which waits for being used.  That's enough for today.

> Really, **I do not have the slightest idea if it makes any sense what I am doing here**.
> 
> The only thing I know is that all other Blogs/Solutions/etc. out there even make a lot less sense than what I did at my side!
> 
> If you ask me, the makers of Foreman should state the most obvious things and define how to do it portably and properly the right way.

So I am just at the beginning.  Foreman is installed.  And gives a login prompt.  And that's all.  And **I do not have any clue what comes next**.

> Perhaps will be continued in case I find the time, solution and mood.
