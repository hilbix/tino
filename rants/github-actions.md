First on, I do not understand why GitHub does not use their own platform for the Survey.
But it is as it is.  Hence I push my answers here.  Because there is nothing to keep secret here.

# My answers to GitHub survey about GitHub Actions

> Overall:

Not At All Satisfied

> Please tell us the reason for your score.

For some unknown reason I cannot understand the docs.  (Note that I usually understand Unix docs after looking into the code.  But I am usually completely lost when it comes to Microsoft docs.  Therefor I do Unix since at least 1986 but only "use" Windows when needed.  Thanks to WSL2 with X11 Windows became quite more usable for me in the last years.)

I already use CirrusCI for my needs.  Their documentation is easy to understand, at least for me.  However your documentation only leaves me puzzling about nearly every detail of "GitHub Actions".  I am not even sure if I understand what "Actions" are or how to utilize them for me.  I.E. how to convert a `.cirrus.yml` into something which works for GH Actions.

I do not understand how to use GH actions at all (perhaps because I do not have the time to create my own tests yet).  Perhaps there should be some very easy to understand examples how to invoke a `make` for all the different platforms supported.

I do not understand how to run a CI stage with GH Actions to support following platforms:

- Linux (AKA GNU-CC)
- MacOS (AKA clang)
- Android (AKA Arm64)
- s390x (AKA Motorola Byte order) - for testing non-Intel compatibility (for example to test optimized cryptographic C code designed to be byte order agnostic)

(CirrusCI offers me 3 out of the box, the latter is done manually with some stupid local VM.)

I do not understand what is in the free tier.  Note that nearly everything I do is from public repositories.  Also I tried to understand GitHub pricing for Orgainizations, but after calculating my costs to be around two times infinity (not kidding!) I stopped considering to pay for GitHub (I need to have an unlimited number of contributors.  According to pricing on GH this is possible on free tier only, as in paid accounts each contributor costs, so an unlimited number costs an unlimited amount of money.  Hence I now host a local TRAC VM on my ProxMox instance for this instead, which costs me less than 5$/Month plus my own labour to keep it up'n'running which is comparable to maintain things on GH instead).

I do not understand what additional costs might apply on Actions.  Or what happens if I exceed my (unknown amount of) free tier.

Hence "I am not satisfied" because I simply do not use it in favour of CirrusCI.

> How could we improve GitHub Actions?

Perhaps provide some cloneable examples of GH Actions for all the most 100 common things you want to do with a CI.  My two are:

- How to run simple `make` workflows against different Platforms (Docker images?)

- How to create your own offline Runner on ProxMox and include it into GitHub Actions (start with something like: "On the Proxmox web console provision a new VM").  Note that it is offline in the sense, that it has all networking except localhost disabled and is only triggerable via some dedicated REST proxy or SSH jumphost through come localhost-socket and only has access to explicitly provided static local Mirrors.  Ubuntu Snaps nor Docker Registry work there.

I do not want to see documentation on details, I just want some reusable raw example for the whole picture.  Something you clone and run with a few clicks and then adapt to your needs.  Detail documentation is probably in place already, but I do not understand how to apply this to my very own needs.

- Like a "hello world" repository which compiles a "hello world" C application against 3 platforms: GCC (Intel), clang (Arm64) and Android Toolchain (yes, for `adb shell` use!) and reports the outcome from the steps which are: `make prepare`, `make all`, `make test`, `sudo make install` (that are the common CI steps I use with CirrusCI).

- And like some "external runner" Action, which allows you to trigger your own created GH Action Runner (preferably on ProxMox or CloudInit) - in my case which would provide s390x for compatibility tests against Motorola Byte order

I do not use the Azure cloud, as I do cannot understand Microsoft pricing either, sorry.  Hetzner Cloud is powerful enough, easily scales, is easy to understand, probably cheap and their documentation is very easy to understand and complete (at least for me), so I have many VMs running there on demand, as well as I use ProxMox.  I even wrote my own API wrapper to their APIs (Hetzner Cloud and my own local ProxMox instance) which was a breeze.  So interesting would be a Action like that:

- Provision some new VM (via some API like the Hetzner Cloud API)
- Install GH runner on it via CloudInit
- Run the action against the VM
- Pull the result
- Decommission the VM completely (so no more costs apply) via API

Note that the first and the last are things which I probably can manage to provide myself (if the needed hooks are explained where you can run your own Python code or REST calls).  But I do not understand how to create the other steps with GH Actions.

Note that I usually use bash/sed/awk, C, JavaScript, Pyhon, Java.  But I can understand and hack programs written in nearly any other common scripting language, including exotic things like Erlang, LISP, FORTRAN and, of course, Basic and PL/SQL.

