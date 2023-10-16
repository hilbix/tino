Notes:

I have no commercial affiliation and I do not do advertisements here.
Everything I write is entirely my true own real opinion.

I do this for my own sake like a diary, to keep it from needing to memoize it myself.
If it is helpful to you, well, be welcome.  But if not, I'm not sorry at all.

Anyway, if you have notes, you can open an issue on GitHub.

My mother tongue is German.  I cannot understand other languages than German and English.

> If in doubt, use English, because most people should understand that.

Everything you read here is preliminary.  Newer stuff (things at the end) may be wrong, because I did not know better.
This will be corrected later, probably.  As we have `git` here I will not maintain a changelog or mark changes.


# State:

This is WiP.  So I start with what needs to be done followed by what already has been done.

The next section then conatains the gory details.


## TODO:

- Move DNS of `scylla-charybdis.com` to <https://desec.io>
- Enable Mailbox on Google Workspace
- Register at <https://mentors.debian.net/accounts/register/>
- Create a private signing key
- Create the `debian/` directory for the package

## Done:

- Domain chosen: `scylla-charybdis.com`
- Mail chosen: `webmaster@scylla-charybdis.com`
- Package code repository


# How to maintain a Debian package

This is something like a step-by-step blog how to, from scratch, get my own package into Debian.


## Start from scratch

- I am not affiliated with Debian in any way.
- There is some security related package I have written in C
- I use this package in all Debian installs and projects
- The decision is to try to get this package into Debian

I wrote the package and already support it, and I also know how to do Debian Packages.
So it would be best to maintain the Debian Package myself.  This also could help Debian,
as if I ever become a Debian Maintainer myself, they would get some additional resources.


## Learn how to package for Debian

Before you even try to become a Debian Maintainer, you should become familiar with the Debian Packaging.

This basically means you must understand the `debian/` directory from such packages.
It also is very helpful if you have some deeper understanding of Debian internal functions and commands.

If you have trouble to understand what `dh` or `quilt` are, better first get accustomed to this.

Because I already know all this I assumes that this is prior knowledge to all this.
Here only is explained, how to get from there to - perhaps - become a Debian Maintainer.


## Chose a mail address

This mail address will be published such, that bots can get hold on them.

> For this reason I use a mail address which already is published everywhere.
>
> However currently this mail address cannot receive mail, so this must be enabled.

At my side I will use `webmaster@scylla-charybdis.com` because this is what I use for my public `git` commits for some years now.

> Note that I'd rater use `tino@geht.net` in future because this pronounces "Tino, et geht net"
> which is German slang for "Tino, it does not work".  A joke.  But a very old one.
>
> This address cannot receive mail currently, either.
> But I am unable to move DNS for this domain, so this address cannot be used.

This address must be able to receive mails and you must be able to send out mails from this mail address.

> Using a mail address as "From" formerly was no problem at all.  But nowadays with SPF and DKIM in place,
> you will quickly get into trouble if you do not follow the BCP.

Also you must accept to actively receive mails and respond to messages sent to this address,
as you need that for communication with the Debian Project.


## Use a Domain with public DNS

Because the mail address is exposed to the public, you should use some DNS provider, which is capable to survive a DoS.

My choice is <https://desec.io> which is a public charity which offers free public DNS service to everyone.

> Note that I already donate money on a monthly basis there.  This is no requirement, but I think everybody who uses it should do,
> because what they do is a very valuable public service!


## Use a good mail provider

Because the mail address is exposed to the public, you should use some mail provider, which is capable to survive a DoS.

My choice for this is Google Mail.  But only because I still have a free old service from the old "Google Apps for Domains" there.

> If Google ever stops serving this for free, I will probably move on to Microsoft, because I also have access to Microsoft Family.
>
> And if this stops, too, I probably will move on to <https://mailbox.org/>


## Register with Debian

- Open <https://mentors.debian.net/accounts/register/>
- Enter your real name
- Enter the chosen mail address to use with Debian
- Use `Maintainer` as the account type (I think)
- Click "Register"

You will receive a mail.  In the mail there is a link.

- Open the link in a JavaScript capable browser
- Enter your password
- Enter your password again
- Create your login

Now head over to <https://mentors.debian.net> and login.

Head over to <https://mentors.debian.net/accounts/profile/> and scroll down to "Change other details".

- Enter your Country
- If you have some IRC nickname (I haven't) enter it there
- Enter your Jabber address if you have one (for unknown reason this is called "Deutsch" when the language is set to "German")
- Set your preferred language
- Leave "Status" to "Contributor"
- Click "Submit"


## Get a secured computer

AFAICS Debian does not allow 2FA.  So everything you do needs to be signed by some GnuPG key.

It is crucial to secure such a key.  Read:  Never store it publicly (except for the public key part, of course).

For my part I will keep it on my secure computer.  This is a device solely designated for secure use.

- I do not surf on this machine
- I do not run foreign software on this machine
- It has no way to be accessed from the outside

Best is to run it from some encrypted device (like ZFS) and you have to enter a password to boot the computer.
You also can use secure boot, such that nobody can tamper with the boot process.

> Sadly I have no Coreboot capable device yet, so secure boot is out of my reach yet.
> However everything I do on this device already is passphrase protected.
>
> The next device probably will become entirely encrypted from scratch.

On this computer you will:

- Keep your keys secure
- Keep the (signed) source repository
- Sign and upload your package

Note that building, testing etc. should be done externally, because the secure computer usually has no much CPU power.
However the `git` repository should be kept on this computer and pushed to a git server (like GitHub),
such that any unauthorized code changes or commits will be detected.


## Create a private key

You need to create a GnuPG private key for use with Debian.
Best is to create this on your secured computer and protect it with a passphrase.

> Even use a passphrase in case your system is encrypted.
> This is because somebody may be able to access your system while it is unlocked.
