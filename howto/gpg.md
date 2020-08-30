# `gpg`

GPG is plain unusuable shitty crap.  But we do not have something better.

> Why?  Because even the most simple thing is implemented the worst way you can imagine.
>
> There is not even any trace of an explanation of what GPG does if called as `gpg file`.
> Anything can happen.  It even might run things, which you cannot express on commandline
> with options.
>
> **Hence you are required to build your scripts on the hope that gpg guesses correctly**
> as nothing is guaranteed nor provided nor granted for sure, now and in eternity.
>
> What I want to write are scripts.  Which can run today.  And can run in 50 years from now.
> Because they are based on a STANDARD.  `gpg` is not a standard.  `gpg` is the problem to solve.
>
> WTF!?!

## How to find keys

On Ubuntu 20.04 `mmdebstrap buster "$TARGET"` gives:

```
W: GPG error: http://deb.debian.org/debian buster InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY EF0F382A1A7B6500 NO_PUBKEY DCC9EFBF77E11517
```

And now?

> Some pages recommend keyservers.  **DO NOT DO THIS.  NEVER NEVER NEVER!**
>
> Using keyservers is like recommending an atomic bomb to open your front door.
> It just blews away all of your protection.  For sure!
>
> Some pages recommend to `curl | apt-key` or similar.  **DO NOT DO THIS.  NEVER NEVER NEVER!**
>
> Using this line is like leaving all your valuables at some lonly place with no protection
> nor survaillace at all and publicly telling every single person on this planet of where those
> valuables are.  Hence you trust every single person on this planet not taking away anything.
>
> Both ist just plain stupid.  Or worse.

Try to find where the key resides on your machine, like:

```
for b in 04EE7237B7D453EC 648ACFD622F3D138 EF0F382A1A7B6500 DCC9EFBF77E11517; do for a in /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/*.gpg /usr/share/keyrings/*.gpg; do gpg --list-keys --keyring "$a" "$b" >/dev/null 2>&1 && echo "===> $b in $a"; done; done
```

gives

```
===> 04EE7237B7D453EC in /usr/share/keyrings/debian-archive-keyring.gpg
===> 04EE7237B7D453EC in /usr/share/keyrings/debian-archive-stretch-automatic.gpg
===> 648ACFD622F3D138 in /usr/share/keyrings/debian-archive-buster-automatic.gpg
===> 648ACFD622F3D138 in /usr/share/keyrings/debian-archive-keyring.gpg
===> EF0F382A1A7B6500 in /usr/share/keyrings/debian-archive-keyring.gpg
===> EF0F382A1A7B6500 in /usr/share/keyrings/debian-archive-stretch-stable.gpg
===> DCC9EFBF77E11517 in /usr/share/keyrings/debian-archive-buster-stable.gpg
===> DCC9EFBF77E11517 in /usr/share/keyrings/debian-archive-keyring.gpg
```

On your side you probably need `apt-get install debian-archive-keyring` first to be able to see this.

> The interesting part ist that neither `gpg --list-keys` nor `gpg --fingerprint`
> shows these keys such that you can grep for the or create some index database
> of your own.  I haven't found any command which is able to reveal all(!)
> of the keys outside of gpg.  Hence `.gpg` files stay a mystery as you cannot
> dump them in a format like they are used in `gpg`.  `gpg` is not a tool,
> it's just a black box which you only can hope that it works as expected.

Now that you found it you can do it:

```
DIR="$(mktemp -d)"
cp /usr/share/keyrings/debian-archive-keyring.gpg "$DIR/"
mmdebstrap --aptopt="Dir::Etc::TrustedParts \"$DIR/\";" buster "$TARGET"
```
