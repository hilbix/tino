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

Try if it is not a complete image build.  Sometimes the build just a TAR file, like this:

```
docker build -f Dockerfile -o type=tar,dest=output.tar .
```

> I haven't yet found out how to access `output.tar` afterwards.
>
> This seems to be a very well hidden secrets by all the docker conspirers.

Look somewhere to find something which docker options are needed to build it.

But that hassle is not your fault.  It is the fault of the Author of the `Dockerfile`.

Reach out and blame them.  Or fix it, if you can.  And then reach out and blame them (AKA send a Pull request).
