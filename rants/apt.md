# `apt` rants

`apt` is nice.  As long as it works.

`apt` is a catastrophe, if something does not work flawlessly.  Because documentation sucks.
It does not only suck, it defines a new yet unknown variant of vacuum.

Because of this, here are my rants and catches about `apt`.

## Missing bits

This is what should be the default configuration.  Always.
(Sorry that this is terribly incomplete, I will append as soon as I have the bits together.)

If I discuss it, this is below.  For now you just get the plain undocumented solution.

```
rm -f /var/lib/apt/lists/partial/*;

fgrep -vxf /etc/apt/apt.conf.d/99tino >> /etc/apt/apt.conf.d/99tino <<'EOF'
Acquire::PDiffs "false";
EOF
```

- As this `rm` is automated at my side due to need, PDiffs actually increase the load on Debian servers.  
  Go figure.

See also:

- https://raw.githubusercontent.com/hilbix/tino/master/howto/.apt (apt helper)
- https://debian-administration.org/article/439/Avoiding_slow_package_updates_with_package_diffs
  - Actually `PDiffs` is a nice idea.  But it shall be optional, not default.
  - And it is badly documented.  You simply cannot find it in case it hurts.  Because it hurts stealthily.


## Missing Links

### `apt-get autopurge`

Where is `apt-get autopurge`?

I cannot use `apt-get autoclean` because this leaves traces of configuration files behind.
This might accumulate to Terabytes over the years.

Hence I always have to manually do `apt-get purge` those packages.  I don't want that.
I want to automate things.  Such that they can live, without need for any manual intervention.
At least that is the goal.  `apt` still is very far from this.

> Even worse with SystemD.  Since SystemD automated upgrades of systems are plain impossible.
> It worked (mostly) flawlessly before.  But with SystemD not even the most basic things continue to work.
> (which probably is because SystemD broke^Wchanged nearly all fundamental basic designs of an Init system).
>
> Note that even upgrades of SystemD -> SystemD fails, due to heavy changes in SystemD.
>
> It is OK to migrate to a new Init system.  But only if the target is mature.
> This means, upgrades must work seamlessly and it must not break existing things.
> In contrast, SystemD is under heavy development.  It is neither stable nor mature.
> So it is not ready for production.
>
> Production means:
> Systems which have to run the next 20 years - or more - unchanged.
> And yes, I have such systems, which are older than 20 years.
> And no, they never were changed because "some Init" demanded it.
> Upgrade only have to happen because the Production requires it.
> Upgrading the Base System must not have demands on changing Production.
> Period.  If you do not follow this, you are not implementing a Base System.
> Actually you are implementing plain Crap.  Crap which is, perhaps, suitable for some Desktop.
>
> But not for Production.
