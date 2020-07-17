# Debian Build System

## HowTo like a FAQ

Clean build environment?

- See https://wiki.debian.org/mk-sbuild
- `mk-sbuild --vg=vgname buster` (as this unpriviliged user) to create a `schroot` on LVM2 VG `vgname` with Debian Release `buster`
  - **WARNING!**  This adds the User to the `schroot` group, which means, the User can become `root` on the `schroot`s without any password.
  - 5GB for the LV, which becomes the master for the snapshots
  - 4GB for each snapshot
- `sudo schroot -c source:buster-amd64` to manually enter this `schroot` for later manipulation (like to update it with `apt`)
  - `source:` means, that you modify the source of sessions
  - As you use `LVM` snapshots, this does not affect other currently running sessions until they are re-created
- `sbuild -A -d buster PACKAGE.dsc` to build a Debian `PACKAGE` from the `*.dsc`.
  - You can give a list of packages to build.
  - You MUST do this to check if the given `PACKAGE`s really can be compiled on a different system than yours (as the `schroot` is a clean envrionment)

More on `schroot`?

- `schroot -c chroot:buster-amd64` to get a shell in the snapshot of this `schroot`.  The snapshot vanishes if you leave the shell!
  - `schroot -c buster-amd64 -u root` to get a root-shell
  - The `chroot` for `sbuild` has no `$HOME` connected
- `schroot -b -c buster-amd64` to start a snapshot.  `schroot` calls this `session:`.  The session `SESSION` is printed on stdout.
  - `schroot --list --all | grep ^session:` to list all current open sessions (this is a WTF for sure)
  - `schroot -r -c session:SESSION` to enter this `schroot` session
  - `schroot -e -c session:SESSION` to kill this `schroot` session

Clean development environment?

- Modify the `sbuild` environment to include `$HOME` as follows:

      sudo cp /etc/schroot/chroot.d/sbuild-buster-amd64 /etc/schroot/chroot.d/build-buster-amd64
      sudo sed -i -e 's/buster-amd64/build-buster-amd64/' -e 's/^profile=sbuild/profile=build/' -e '/^aliases=/d' /etc/schroot/chroot.d/build-buster-amd64
      sudo cp -r /etc/schroot/default /etc/schroot/build
      grep /dev/shm /etc/schroot/sbuild/fstab | sudo tee -a /etc/schroot/build/fstab

- `SESSION=$(schroot -bc build-buster-amd64)` to start a clean working environment
- `schroot -rc session:$SESSION --` enters this `$SESSION` and stays (virtuall) in the same path.
  - Note: All changes of your `$HOME` will be permanent!  Only the environment is temporary!
- `schroot -rc session:$SESSION -u root --` to enter this `$SESSION` as `root` (replaces `sudo`)
- `schroot -ec session:SESSION` to destroy `$SESSION`

Skip packages to build?

- `dh --no-package=package-name`
- Example `debian/rules` (based on a concept from Florian Haftmann, LHM) which allows to skip some packages on build with just a  
  `touch debian/package.skip`:

      SKIP_PACKAGES := $(foreach SKIP,$(wildcard debian/*.skip),--no-package=$(basename $(notdir $(SKIP))))
      %:
      	dh $@ $(SKIP_PACKAGES)
