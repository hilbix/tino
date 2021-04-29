> Sorry, no real solution yet.  If I thin of security, composer still looks like a big pile of ugly shit to me.

# HowTo Composer

When looking at composer, the documentation sucks.  It not only sucks, it's even worse:

Citing https://getcomposer.org/doc/01-basic-usage.md#installing-without-composer-lock

> Tip: If you are using git for your project, you probably want to add `vendor` in your `.gitignore`.
> You really don't want to add all of that third-party code to your versioned repository.

So what is Composer telling me here?

- To become faster I shall speed up to 250 MPH in my City (speed up dev using unverified 3rd party like GitHub)
- but this is not enough, I also shall do this completely blindfolded (remove vendor from `git` control)

Then it is consistent with Composer having following properties:

- **Tells everybody in the world what you are currently doing** (AKA phones home) by default. 
- Does not help to secure your environment (does not populate the `shasum` entries on `update`)

So, nope, **composer fails in every single aspect of doing it right**.

Hence it is - security wise - a huge pile of ugly shit.

## Caveats

I do not use `composer` coming from some obscure Web URL.  I always only use the variant which comes with the OS.

> Poor you, who use Windows.  However you can use WSL these days.  Do it!
>
> But choose wisely.  I stick to [Debian](https://debian.org/).
> 
> However I consider [Ubuntu](https://ubuntu.com/) to be ok, too, and perhaps [Devuan](https://devuan.org/).
>
> Others like [Arch](https://archlinux.org/) are safe, too, but what I present mostly does not work there (lacking `apt`).

See `make debian` in the `Makefile` below.


## `composer.json`:

```
{
    "prefer-stable": true,
    "config": {
        "autoloader-suffix": "WTFwhyDoesntThisDefaultToContentHash",
        "notify-on-install": false,
        "discard-changes": "stash"
    },
    "require": {
    }
}
```

This all should be the default, but isn't, of course!  (The default must to do it right.)

- `prefer-stable` should always be the default, but isn't.
  - I know, not living the bloodiest live possible on the most bleeding edge nowadays is considered to be extremely lame.
  - But I think otherwise (and this did not came with age.  It's due to my nature on computing systems) for a good reason.
- `autoloader-suffix` implements a reproducible `vendor/` directory.
  - Hence you can reove it and recreate it with the same files again and again
  - Without this the contents of `vendor/` will always change if you re-create it
  - Ever changing directories prohibit this to put the code under version control
  - But, as composer does not implement security, you need a VCS to get back to safe grounds! 
- `notify-on-install`  set to `false` prevents Composer from phoning home.
  - At least I hope so.
- `discard-changes` helps in case you happen to edit something in the upstream.
  - You shouldn't.  But as ususal, be safe if things go wrong.
  - As always, this is not the default, even that it cannot hurt.
  - So, again, a safe setting, which never hurts, is not used by composer.  As usual these days.

Now add `vendor/` under `git` control.  This allows you to track changes in upstream more easily.

- If you are concerned, create `vendor/` as a `git submodule`
  - Regardless what others tell you:  Get accustomed to `git submodule`.  Get accustomed NOW.
  - `git submodules` are often a lifesaver.


## Running `composer`

Example `Makefile` for this:

```
#

COMPOSER=composer --no-interaction --no-plugins

.PHONY:	love
love:	all

.PHONY:	all
all:	vendor

# This should be safe to use if composer is done right
# (I do not know if composer is done right!)
vendor:	stash
	$(COMPOSER) --no-scripts --prefer-source install

# Do you spot some unneccesary redundancy in following?
.PHONY:	update
update:
	$(COMPOSER) --no-scripts --prefer-source update
	@echo Use with care, this might update to something completely different

.PHONY:	clean
clean:	distclean all

.PHONY:	distclean
distclean:	stash
	rm -rf vendor

.PHONY:	realclean
realclean:	cacheclean clean

.PHONY:	cacheclean
cacheclean:
	$(COMPOSER) clear-cache

.PHONY:	stash
stash:
	-git stash push vendor

.PHONY:	debian
debian:
	sudo apt-get install composer
```

> **Important:** This `Makefile` assumes that you have not renamed the `vendor/` directory
> in `composer.json` using 
What does this do?

- `--no-plugins` protects you against malicious plugins
  - At least I hope so
  - I really have no idea why you ever want to use plugins.
  - Reading the docs about those gives me the creeps.
  - Hence I do not even think about ever using something as horrible as this.
  - Better be safe than sorry.
- `--no-scripts` protects you against malicious scripts
  - At least I hope so
  - Be alerted if some package needs a script.
  - Try to find something which works without such shit.
  - Or call the script yourself (after looking at it) in the Makefile
  - Of course you cannot set this globally as this is an error-prone per-command option.
  - Read: **Security is no global design choice with `composer`.**  Go figure.
- `--perfer-source` shall use `git` for download
  - As `shasum`s are not populated by `composer` this seems to be the better choice
  - However AFAICS this has no effect at my side whatsoever
  - Of course `composer` does not use nor support it's own security implementation, right?

Note to `make realclean`:

- This kills the Composer download cache
  - At least I hope so
  - `composer` still tells me that it uses the cache, even after it has been dropped.
  - I really have no idea whatsoever why it does this
- Then it invokes `make clean`

Note to `make clean`:

- This stashes changes in `vendor/`
  - At least I hope so
- Then it removes `vendor/`
- Then it re-populates it
  - This is because I assume it is under `git`'s control
  - Hence you want to have a clean `git status` after `make clean`

Note to `make distclean`:

- This stashes changes in `vendor`
  - At least I hope so
- Then it removes `vendor`
  - The idea here is to minimize the size.
  - As I assume that `vendor/` is under `git`'s control, you can re-create it any time.


# Unsolved mysteries

I still have no idea why `shasum` in `composer.lock` isn't populated.

And I have absolutely no idea how to populate it.

I tried to find out reading the docs.

- I failed miserably.

I tried to find out Googling around.

- I failed miserably.

I tried to find out how others do it.

- I failed miserably.

Help!  I am trapped in a `composer` not-documented-loop!
