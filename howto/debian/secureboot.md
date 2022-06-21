# SecureBoot catastrophe

> This is not a HowTo.  This is a catastrophe in case you cannot disable SecureBoot for some reason.

I bought a new portable computer.  This has SecureBoot enabled.  This usually is not a problem.  Just disable it.

However this here is a bit different.  Disabling SecureBoot disables some hardware devices, too.  Without keyboard, touchpad and USB the device is unusable.

The problem is:  With SecureBoot enabled, the kernel is unable to load necessary modules like the WiFi driver.  So I have no chance:

- I cannot disable SecureBoot
- So I need to sign the drivers

Doing this is not easy, not user friendly and more than just a catastrophe, as this is not automatically done on kernel upgrades.
But I am using Ubuntu.  This means, you can see a kernel upgrade each day, or even more often.  And have to sign drivers over and over again.

**This is complete bullshit!**  Due to SecureBoot with frequent kernel updates you need automated driver signing.
But automated driver signing thwarts security.  Hence you lose all benefits of SecureBoot this way.

> Or said differently:  SecureBoot is poisoned SnakeOil.  It does not help.  In best case it does not provide trouble.  But not in my case.

Note:  I'd like to use SecureBoot.  In a sense, that it could be used to protect your computer against somebody else tampering with it.

But it is not implemented that way.  It does not help you to protect yourself, it only protects others against you.

> Luckily not completely, as you are able to circumvent SecureBoot with some major burden.  If you are able to grok and willing to do.

Enough said, to the work.

## StackOverflow

> If you find something on SO, be very careful.  If you do not fully understand what you find there,
> better do not use it.  Often, programming hints are not even wrong, they can be extremely dangerous.
> Same with administrative tasks, like this here.
> 
> What you read below will get rid of all security features of SecureBoot!
> **You have been warned!**

A possible solution is found via

- <https://askubuntu.com/a/1114889/164798>
- <https://askubuntu.com/a/768310/164798>

But it is TMI, so I put it here together into one simple script

T.B.D.
