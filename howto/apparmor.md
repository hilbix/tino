> Incomplete, not ready, just a start

# AppArmor

Why this?  Because all(!) guides to AppArmor which I found on the Web left you in the dark.
What I need is a short detailed expressive (pick 3) guide how to get started with apparmor,
in the case that it is already running on a distribution and something does not make sense.

This here is for the experienced sysop, who groks Unix for longer than Linux exists,
but stumbles of something pointing to apparmor in dmesg for the first time
and wants to solve the riddle without the need to read bible^bible
more or less obsolete documentation found on the web.

This is Debian/Ubuntu centric.  Adapt yourself.  Once and for all final warnings:

> - **Warning!**  This guide is detailed, which means, it lists extremely dangerous things.
> - **Warning!**  This guide is short, so it leaves away warnings about dangerous things.
> - **Warning!**  This guide is for the experienced sysop, so your belly knows about dangerous things in advance.
> - **Warning!**  This guide is expressive, so it just lists commands for copy'n'paste without explanation.
> - **Warning!**  This guide is short, so it assumes, you can follow the yellow brick road, together with `strace` and `man`.
> - **Warning!**  This guide is for the experienced sysop, so it assumes that you understand how to be careful.

## Rants

`apparmor` is very badlty designed.  There are tons of commands, and the documentation is only a skeleton, barely explained and often misleading, outdated or plain wrong.

All commands do not really do what you would expect and leave you completely alone in the dark if they fail, so thanks for the fish, but you have been eaten by a Grue.


## Get started

    sudo apt-get install apparmor-notify apparmor-utils
    ( exo-open /etc/xdg/autostart/apparmor-notify.desktop & ) # https://askubuntu.com/q/5172

    sudo apt-get install apparmor-profiles apparmor-profiles-extra
    sudo aa-enabled

>     Yes

    sudo aa-status

## Enable everything

    sudo aa-status

No clue what to do.  `aa-enforce` fails for 11 profiles which are listed as "complaining",
because what is presented there cannot be enabled.

> So the obvious way to do it just fails, still searching for a solution ..


## Fix things

    sudo 

## WTFs

- `aa-*`-tools act on `executables`, but `aa-status` lists things which cannot be used as `executables`
  - Documentation on `aa-status` is wrong (or misleading or outdated).
  - So you are left in the dark how to interpret what `aa-status` shows.

- Names in `/etc/apparmor.d/` are neither related to `exectuables` nor profile names
  - `grep` is your friend.
  - But you are left in the dark how to do it properly.

- `apparmor` is using `executables` for reference.
However this is neither related to the profiles nor to the files where the information is stored.
Hence you cannot use `aa-*` tools to manage things as it ought to be.
to access these profiles, because you simply cannot address them.
  - `vi` is your friend.
  - But you are left in the dark how to do it properly.


## Quick Ref

- `aa-enforce` enable rule.  Do not forget `aa-audit` afterwards!
- `aa-audit` unmute rule - without, you might not get any bit about why something fails

Editing:

- `aa-cleanprof` something like `lint`

## Unsolved

Note that this shall be very easy to use 1-liners:

- How to enable all dist-rules?
- How to unmute all rules?

Other unknowns:

- How to fix rules properly?  (`aa-logprof` does not allow to do it properly)
  - How to do this locally, such that dist-rules are not altered?
