# HowTo

## Docker from Scratch

I really do not understand.  I will never understand.  Period.

There is something like a `Dockerfile`.  But nobody explains how to use it.

Nobody.  Really.  Every recipe fails.  Everywhere.  None works.

So here is how to do it.  From scratch.  With really all necessary steps included.


### Part 1: Get a minimal Debian up and running

The easiest way today to install Debian as as follows:

- Buy some Windows 11 Laptop
  - with 8 GB of RAM
  - and 1 TiB of disk
- Then open Microsoft Store.
  - Search for "Debian"
  - Install the one from "The Debian Project"
  - Everything else would be fake
- Then open the Windows menu and type "Debian"
  - click the "Debian App"
  - Answer a few questions
- Restart Debian App

There are trainloads of other options like buying a Raspberry PI with 4 or 8 GB RAM like a PI400.

> Smaller PIs will not be of much help for Docker due to the limited RAM.

Or installing it onto a VM running with ProxMox or VmWare.  Its all up to you.

> Please do not expect that "from scratch" means to explain how to create a PCB, CPU die or Power Plant by digging out some dirt.
>
> Or how to start with a big bang, create the planets and upcale from there.  I could explain that, too.
> But it would be a bit lengthy and take a few billion years.  The above should only take a few hours.
> Depending how fast you can drive to a suitable store and how fast your Internet is.


### Part 2: Update Debian with the needed Packages

Add some basics:

> `etckeeper` helps you in understanding how to revover if something did not work out.

```
sudo apt update
sudo apt install -y etckeeper
sudo apt dist-upgrade
```

> Answer the questions as you need them.  Usually `Y`

Now install `/usr/bin/docker`:

```
sudo apt install docker.io
```

> Usually answer `Y` to all questions.

Now add your user to the `docker` group:

```
sudo adduser $USER docker
```

> Easy enough.  So why does nobody explains this in the `README`?


### Part 3: Docker build via Dockerfile

```
docker build -f Dockerfile .
```

Yes, that's not much magic.  However you will not know this if you never did it before!

> Very easy, if you know it.  But why does nobody put this simple line into the `README`?


### Part 4: If it does not work

#### Common error: Disk full

Be sure there is plenty of free disk space.  Not only on the VM (WSL), as well on the host (Windows etc.).

As Docker uses enourmous amounts of disk space quite often.

Hence disk full is a very common source when it comes to docker.

#### Bad design: Perhaps some Options are needed

Try if it is not a complete image build.  Sometimes the build just a TAR file, like this:

```
DOCKER_BUILDKIT=1 docker build -f Dockerfile -o type=tar,dest=output.tar .
```

> Of course BUILDKIT is not automatically enabled and  
> of course Docker does not tell you, that it ignored the `-o` option, because you forgot to enable `DOCKER_BUILDKIT` in the environment.

If you do not add the `DOCKER_BUILDKIT=1` as shown, you will not see any output at all.

> YMMV.  The Docker docs say something about that BUILDKIT is automatically enabled on Docker 23.x and above.
> I cannot verify that, as I only work what is part of the current official stable distro I work with, not some more or less dangerously downloaded thingie from some obscure third party website, where I do not have even the slightest way to automatically verify, that the download from there is legit and not trojaned by some MitM.
>
> It only is legit if:
>
> - There is a well known public key
> - This public key can be verified
> - And the verification comes from some third party you not only can trust but you can also verify that the verification is indeed from this party.
>
> As I cannot find this anywhere for Docker, this rules out the repositories from Docker.
> Sorry guys, please have your keys included in some keyring which is part of Debian, or similar.

#### Bad or no documentaton

Perhaps you have to look somewhere in or near the `Dockerfile` (i.E. a README) to find the right docker options needed to build it properly.

But that hassle is entirely not your fault.  **It is the fault of the Author of the `Dockerfile` not documenting it right.**

Reach out and blame them.  Or fix it, if you can.  And then reach out and blame them (AKA send a Pull request).

> Especially they need to mention that they use BUILDKIT if they do!  The presence of some `-o` is an indication for this.
> Not a clear one.  But a probable one.

# Final words

All I write here I found out the hardest possible way.  Because nobody made it easy to understand.  It took several hours to complete this here.

Writing this text here took nearly no time compare to find out what I wrote here.  **Thank you very much, Docker, to make things a horrible experience like that.**

I consider that very very very bad design.

If you try to invent something new, make it as easy as it can get.  Right from the start.

If you do not do this, you fail in scaling it up to the world.

This is OK to invent complex things like I do for just myself.  But a high complexity certainly is not OK for things, which are meant to be used everywhere by everybody.

Things can be complex in the inside, but outside must have the possibly most easy start as there is possible to archive!

> Why not just `docker make [-f Dockerfile]`?  Compare: `make [-f Makefile]`.
>
> Basic `make` is quite as easy as it probably can get.  Why is Docker so complex (at the outside) in contrast to `make`?
