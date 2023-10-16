# `sudo` quirks

## `sudo` on Debian takes hours to respond

I run `sudo -i` and .. wait .. wait a bit longer .. after some felt half an hour or so it presents the prompt.

Debian defaults to `fqdn` option.  Which does a network lookup of a name.
Now, if the nameserver infrastructure is failing somehow, this can take hours or even longer(!) until `sudo` responds.

WTF why is such an option present at all?

> Shamless plug:  You won't have any similar problems with my own tool [`suid`](https://github.com/hilbix/suid),
> ever, except in cases where you explcitly implement things which need external sources.

Seems to be a well hidden secret, but following fixes that issue:

```
echo '`Defaults !fqdn' > /etc/sudoers.d/fqdn`
```

The most annoying part is, that errors like this usually do not happen in normal operation,
but exactly when the shitload hits you possibly due to some DoS,
and therefor effectively hinders you to mitigate such operating issues.

Long story short:  Be aware and always apply above fix to all of your systems before you get into trouble.

> Also, due to the insane syntax of /etc/sudoers.  So I do not recommend to rely on `sudo` at all,
> just use it for the most basic part and do not even try to do more things than get superuser.
> 
> Shamless plug:
> 
> Instead better start to use my tool [`suid`](https://github.com/hilbix/suid).
> It has a very well known syntax (same as `/etc/passwd`),
> is less error pone to use, and works very reliable (at all of my machines).
> Also it has a security first guarantee and should be fairly bug free (in contrast to `sudo`).
> Also at the time of writing (2023-10-15) I am actively supporting it, and I probably will do this in future, too.
>
> Perhaps sometimes in the future I manage to add `suid` into Debian as a maintainer (help welcome).

