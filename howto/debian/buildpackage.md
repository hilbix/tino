> See also: <https://github.com/hilbix/nuke-packages>


# Debian buildpackage

As always, the guides out there only tell you 10% of the story.
Here I try to do something complete and easy to follow.


## TL;DR

Prepare the destination to build from source:

	cat <<'EOF' >> ~/.devscripts
	# see https://www.debian.org/doc/manuals/maint-guide/build.en.html

	DEBUILD_DPKG_BUILDPACKAGE_OPTS="-us -uc -I -i"
	DEBUILD_LINTIAN_OPTS="-i -I --show-overrides"
	EOF

	sudo apt install build-essential devscripts equivs git-buildpackage

On some trusted current environment, fetch the existing package:

	PACKAGE=bup
	VERSION=0.32
	apt source "$PACKAGE=$VERSION"
	cd "$PACKAGE-$VERSION"

> List availables versions use: `apt-cache policy $PACKAGE`

If the source is not available through `apt` but in `git` instead:

	REPO=https://github.com/mobile-shell
	PACKAGE=mosh
	VERSION=1.4.0-1

	git clone -b master "$REPO/$PACKAGE.git"
	cd "$PACKAGE"
	BRANCH="$(git rev-parse --abbrev-ref HEAD)" || exit
	rm -f ../"$PACKAGE"_*
	gbp buildpackage --git-debian-branch="$BRANCH" --git-upstream-branch="$BRANCH" --git-upstream-tree=branch -S

> From `git` often you will get improper "Quilt" sources.  This is, the version is not native Debian (contains a `-`)
> but does not contain the patches in `debian/patches` but in `git` instead.  We could fix that, but this is complex.
> Hence above does not meet the Debian standard for proper packaging!
> 
>  Be sure to:
>
> - be aware that **this does not create a correct **`../$PACKAGE_*.tar.gz`**.  But it should work for non-source builds.
> - set `debian/changelog` correctly.  The first line of `changelog` must start with `$PACKAGE ($VERSION) ` (here: `mosh (1.4.0-1) `)
> - have a clean worktree as in `st="$(git status --porcelain)" && [ -z "$st" ] && git clean -ifdx`
> - If building the source, this fails for some reason, try to do `rm -f ../${PACKAGE}_*` to remove the wrong source
>
> You can build the package including source, too, if you leave away the `-S`
>
>     gbp buildpackage --git-debian-branch=master --git-upstream-branch=master --git-upstream-tree=branch
>
> Note that AFAICS this will ignore your `~/.devscripts` as this does not use `debuild`.

Then transfer to some destination you need the missing package, and fix the errors until following succeeds:

	sudo mk-build-deps -i
	debuild


## Example 1: `bup`

	PACKAGE=bup
	VERSION=0.32

- You have Ubuntu 20.04 LTS
- You want [`bup`](https://github.com/bup/bup) on this
- However there is no `bup` for this
  - `bup` is only in Ubuntu 22.04 LTS, but you cannot upgrade
  - perhaps because the machine [has a bunch of disks](https://www.qnap.com/de-de/product/tl-d1600s) attached which are only support by a certain HWS of Ubuntu 20.04

What are the options?

- You do not trust others, only yourself, Debian and Ubuntu
- You do not want to trust git repositories like <https://github.com/bup/bup>
- You do not want to trust third party PPA packages
  - Which are not providing the latest bup anyway

Well, Debian and `dpkg-buildpackage` to the rescue.

But how?


### First: Get the sauce, Luke!

Luckily you trust Debian.  Or Ubuntu 22.04 LTS.  Or somethings similar which includes `bup`.
Hence you have some trusted source.  Get it from there:

In this case I use Debian 11 (Buster).  You can use Ubuntu 22.04 LTS, of course.

**On your Debian 11** enter some scratch directory and do:

	buster$ mkdir bup && cd bup && apt source bup

> `buster$` should remind you that this runs on another machine than the target.  
> If such a marker is missing, this means, this runs on your target Ubuntu 20.04 LTS.

This downloads a bunch of files from your trusted source.

> TBD: Does this verify the cryptographic checksums?  I am not entirely sure!

As this is a trusted source, you do not have to worry.

> If you do not trust the source completely, that is, you would not place a bet of your life on the integrity of the source, do not use it!
>
> I, for my part, do trust in Family, Debian, Ubuntu, Microsoft, Google, Samsung and Deutsche Telekom.  Why?
>
> - Mostly because I have no choice.
>   - Except for Debian and Ubuntu
> - The Family is some obvious choice.
>   - Poor you if you cannot trust your family.
> - Debian (like Ubuntu) and Microsoft are the main OS vendors I use.
>   - Debian for me
>   - Microsoft for work
>   - While Debian is a personal choice (backed by over 20 years of confidence), I must trust Microsoft because I need it to make a living and therefor all valuable assests are on Windows.
> - Google, Samsung and Deutsche Telekom because these are the vendors of my Android Phone
>   - This phone is the only protection of all my money and communication (like Threema).
>   - Hence I must trust it
>   - Google is the OS vendor.  Hence Google has more control over my phone than me.
>   - Samsung is the hardware vendor.  Hence Samsung has even more control over the phone than Google.
>   - Deutsche Telekom is the carrier my phone uses.  Hence the SIM is from Deutsche Telekom.  Hence Deutsche Telekom has more control over my phone than me, too.
>   - As I need to trust my phone as it protects access to all my valuable assets, I have to fully trust these 3, too.  I simply have no choice.
>
> But why trust some other 3rd party, without force?  These are already enough, you should not add more than needed.
>
> Note that there are a few more to ultimatively trust.
>
> - For example I trust my local authorities who, for example, provide water to my house, which hence shouldn't be poisoned.
> - And I probably trust Intel, because they provide the IME which runs on nearly all of my machines
>   - The IME controls every aspect of your machine, including every data bit which is received, sent, stored or transferred on your machine, including all of the displays
>   - As the IME runs even if the machine is switched off, it has more control over the machine than you (as long as it is powered)
> - And I probably trust AMD, because they provide something similar like the IME on the other type of machines
> - And the manufacturers of computing parts like mainboards, RAMs, harddrives etc.
> - And the manufacturers of some Internet equippment like Switches, Routers and [cables](https://shop.hak5.org/collections/mischief-gadgets/products/omg-cable).
>
> However these are less important in a software security context.  The IME could do nasty things, though,
> but the above are the main active actors in the play which are contacted for software updates or connectivity on a more or less daily basis.

Now copy over the download onto your target machine:

	buster$ rsync -avhP . target:build/bup/

Now the rest runs on your target Ubuntu 20.04.

> You can use another directory than `build/bup/` on `target` of course.

So for everything else below it assume that you are

	ssh target
	cd build/bup


### Compile preparation

The problem is, you are on another machine now with some trusted source which does not fit your system entirely.

Also you have no idea how to compile it (else you would not read this here, right?).  Well, let's do it from scratch then.

To be able to build a debian package you need some packages to do so, so let's install them:

	sudo apt install build-essential devscripts equivs

> There might be a few more, I was not able to try this from a minimal Ubuntu 20.04 LTS install yet.

Following popular command will fail for now:

	dpkg-buildpackage -us -uc

This probably shows something like following:

```
dpkg-buildpackage: info: source package bup
dpkg-buildpackage: info: source version 0.32-3
dpkg-buildpackage: info: source distribution unstable
dpkg-buildpackage: info: source changed by Robert Edmonds <edmonds@debian.org>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --before-build .
dpkg-source: info: using options from bup-0.32/debian/source/options: --single-debian-patch
dpkg-checkbuilddeps: error: Unmet build dependencies: dctrl-tools debhelper-compat (= 13) dh-python python3-dev python3-pylibacl pandoc (>= 1.11.1-4~) pandoc-data (>= 1.11.1-4~)
dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
dpkg-buildpackage: warning: (Use -d flag to override.)
```

> That's ok.

But I will not use that thing as it's probably more easy to use a higher level command `debuild`.
But to use that, we first need to add some defaults:

	cat <<'EOF' >> ~/.devscripts
	# see https://www.debian.org/doc/manuals/maint-guide/build.en.html

	DEBUILD_DPKG_BUILDPACKAGE_OPTS="-us -uc -I -i"
	DEBUILD_LINTIAN_OPTS="-i -I --show-overrides"
	EOF

YMMV, but this is what I used straight of the docs without much thinking.

Now try

	debuild

This will usually fail for missing dependencies.  Example:

```
tino@delle20:~/git/bup/bup-0.32$ debuild
 dpkg-buildpackage -us -uc -ui -I -i
dpkg-buildpackage: info: source package bup
dpkg-buildpackage: info: source version 0.32-3
dpkg-buildpackage: info: source distribution unstable
dpkg-buildpackage: info: source changed by Robert Edmonds <edmonds@debian.org>
 dpkg-source -I -i --before-build .
dpkg-buildpackage: info: host architecture amd64
dpkg-source: info: using options from bup-0.32/debian/source/options: --single-debian-patch
dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper-compat (= 13) dh-python python3-dev python3-pylibacl pandoc (>= 1.11.1-4~) pandoc-data (>= 1.11.1-4~)
dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
dpkg-buildpackage: warning: (Use -d flag to override.)
debuild: fatal error at line 1182:
dpkg-buildpackage -us -uc -ui -I -i failed
```

Now to the fix-and-compile step.


### Build package

The next step is to list or auto-install the dependencies:

	sudo mk-build-deps -i

This will do following:

- Create a package with all of the dependencies
- Tries to install the package
- Removes the package again

> Note that you must allow the package to be removed again, else your future upgrades could be failing.

This probably will fail due to some unmet dependencies.

Now fix the missing links.  For example in this case we need to downgrade the debhelper-compat in file `debian/control`:

In `debian/control` change:

	 debhelper-compat (= 13),

into (please remeber, the first character of the line is a space):

	 debhelper-compat (= 12),

Now

	debuild

If this fails with something like

	dpkg-source: error: cannot represent change to bup-build-deps_0.32-3_amd64.deb: binary file contents changed
	dpkg-source: error: add bup-build-deps_0.32-3_amd64.deb in debian/source/include-binaries if you want to store the modified binary in the debian tarball
	dpkg-source: error: unrepresentable changes to source

then you have some leftover from experiments (like `mk-build-deps` without options).  Silly you.  Clean the directory and remove the file and try again:

	rm bup-build-deps_0.32-3_amd64.deb


### Install

Now, when the build is successful, you probably want to install it.

	cd ..
	ls -1 *.deb

You will see something like

	bup-doc_0.32-3_all.deb
	bup_0.32-3_amd64.deb

Just install what you want:

	sudo dpkg -i bup_0.32-3_amd64.deb


## Example 2: `mosh`

	REPO=https://github.com/mobile-shell
	PACKAGE=mosh
	VERSION=1.4.0-1

- You want to install newer version or a patched version of `mosh`
- `mosh` comes from <https://github.com/mobile-shell/mosh>
- Luckily, there already is a `debian/` subdirectory

Hence the first thing is to checkout the `git`:

	git clone https://github.com/mobile-shell/mosh.git

Then we want to create the Sources

	cd mosh
	./build-source-package.sh
	
This essentially runs following (as usually you won't have this shell script):

	gbp buildpackage --git-upstream-branch=master --git-upstream-tree=branch -S

This creates the needed sources, like `apt source` did, so you can use above recipe.

> If this fails, be sure there is no wrong source: `rm -if ../mosh_*`

Note that there also is

	./build-package.sh

which essentially runs the same command without `-S`:

	gbp buildpackage --git-upstream-branch=master --git-upstream-tree=branch

So this includes the build process of the binary package, however without the `debuild` settings (I think).

Also note that this only works if the build tree is absolutely clean.  So to run it, perhaps following is needed:

> **WARNING!** Following wipes everything which is not checked into `git`!

	git clean -i -xfd



## FLW

It may be that there is more to fix.  This can be complex.

However this is beyond the scope of this document.  This here only explains how to build a Debian package from Debian package source when the source stems from somewhere else.

Because I think this is the main use:  Grab a package from some existing Debian etc. distro and implant it into some older or other (Debian based) system.  Or checkout an existing Debian package from `git` and compile it.

