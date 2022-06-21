# SecureBoot catastrophe

> This is not a HowTo.  This is a catastrophe in case you cannot disable SecureBoot for some reason.

This was done with Ubuntu 20.04 LTS.  Probably it works for Debian similarily.


# Disable SHIM validation

- See also: <https://askubuntu.com/a/1198351/164798>

My recommended variant for Ubuntu (and hopefully others, too) is to disable the signature verification algorithm in the Kernel.

This is a overengineered needlessly complex designed method, and you probably need to go through it several times until you succeed.
However you only need to do this a single time, not each time the Kernel is updated.

> People always mistake complexity with seurity.
> They do not understand, that complex things cannot provide any security,
> only simplicity keeps you secure.
>
> This process here just archives one thing:  Stealing your precious lifetime.


## Check SecureBoot is enabled

This follows <https://wiki.debian.org/SecureBoot>

	mokutil --sb-state


It this says

	SecureBoot disabled

you do not need this all here.  If it says

	SecureBoot enabled
	SecureBoot validation is disabled in shim

you already have appplied this fix.

> MOK stands for Machine Owner Key

Disable validation:

	mokutil --disable-validation

Enter password `12345678`.  You need this password to solve the password riddle which follows after reboot.

	reboot

For 10 seconds a blue screen with the MOK tool shows up.

> **WARNING** if you do not press a key here, it boots and you need to start with `mokutil --disable-validation` again all over.

After reboot:

- Press a (normal) key (within 10 seconds)
- Choose `Change Secure Boot state`
- Solve the password riddle
  - I was unable to solve it because my password was too complex, so the system rebooted and I had to start from the beginning
  - I had to press the enter key on each step after inputting the password number.
- Then a `No`/`Yes` question shows up (on the top of the screen stands something like `Disable secureboot`)
- Now choose `Reboot`

Let it boot and then do the verification:

	mokutil --sb-state

says

	SecureBoot enabled
	SecureBoot validation is disabled in shim

Congratulations.  SecureBoot now is still enabled in BIOS (so that all hardware is available) and disabled within Ubuntu.

> This makes no sense to me.  If such a setup is allowed, the construction of SecureBoot lacks any logic.


# Use SecureBoot Signing

> THIS IS T.B.D. and untested by me, only kept as a reference

## Create a key

	ls /var/lib/shim-signed/mok/

If you see a key here (`MOK.der`, `MOK.pem`, `MOK.priv`) skip this step and use the key.

	mkdir -p /var/lib/shim-signed/mok/ &&
	cd /var/lib/shim-signed/mok/ &&
	openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -days 36500 -subj "/CN=$(hostname -f)/"
	openssl x509 -inform der -in MOK.der -out MOK.pem



# Rants

I bought a new portable computer.  This has SecureBoot enabled.  This usually is not a problem.  Just disable it in BIOS.

However this here was a bit different.  Disabling SecureBoot on this device disables some hardware devices, too!
Without keyboard, touchpad and USB the portable computer simply becomes unusable.

> Not funny:  If you disable SecureBoot and set the BIOS timeout to 1 second you effectively brick the device.
> Afterwards, the device has no USB, no keyboard, no touchpad, and you cannot enter BIOS the normal way as well.
> Luckily I happened to set the timeout to 2 seconds, and after 100 boots or so the keyboard worked once to get into BIOS again to rise the timeout.

The problem is:  With SecureBoot enabled, the kernel is unable to load necessary modules like the WiFi driver.  So I have no chance and cannot disable SecureBoot.

Enabling drivers signing is not easy, not user friendly and more than just a catastrophe, as this is (probably) not automatically done on kernel upgrades.
I am using Ubuntu.  This means, you can see a kernel upgrade each day, or even more often.  So you need to sign drivers over and over again.

**This is complete bullshit!**  Due to SecureBoot with frequent kernel updates you need automated driver signing.
But automated driver signing thwarts security.  Hence you lose all benefits of SecureBoot this way.

> Or said differently:  SecureBoot is poisoned SnakeOil.  It does not help.  In best case it does not provide trouble.  But not in my case.

Hence the solution is not to disable SecureBoot, but to do the next best thing:  Disable driver verification.

## I'd like to use SecureBoot

Note that I'd like to use SecureBoot.  In a sense, that it could be used to protect your computer against somebody else tampering with it.

But it is not implemented that way.  It does not help you to protect yourself, it only protects others against you.

> Luckily not completely, as you are able to circumvent SecureBoot with some major burden.  If you are able to grok and willing to do.

Enough said here.


## StackOverflow

As usual, I found some ideas on StackOverflow.  But again, as usual, things there were a bit difficult to follow.

> If you find something on SO, be very careful.  If you do not fully understand what you find there,
> better do not use it.  Often, programming hints are not even wrong, they can be extremely dangerous.
> Same with administrative tasks, like this here.
> 
> What you read below will get rid of all security features of SecureBoot!
> **You have been warned!**

Here are the links:

- <https://askubuntu.com/a/1114889/164798>
- <https://askubuntu.com/a/768310/164798>

All this is TMI, too complex and not sufficient either.
Also many of the information links are already gone,
so I put it here to keep it for my future.

Sigh.
