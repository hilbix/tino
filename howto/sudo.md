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
