# HowTo Ansible

I am always looking for doing things the most easy way.  With ease means "I do not have to think about it".

Sadly I mostly fail in this.  Automation is one of these kinds.  Usually I end up writing my own scripts.

There are several different ways of doing system maintainance.  Like Chef, Puppet and Ansible.

I tried to get started with Puppet .. and failed.  Mostly perhaps because it is Ruby.  I usually do not have Ruby on my machines.
Because my philosophy is to leave away what is not ultimatively needed.  Needed by me, not you.  Hence trainloads of commands are installed on every system.
But Ruby is no part of these.  Running Ruby applications (like GitLab) is OK, as I can hack them to my needs.  But I do not want it on all my systems.

Chef is written in Ruby, too.  So as I failed with Puppet, I did not consider looking into it, because I have to install Ruby first before getting started with it.

Ansible however uses Python3 these days.  Something which is always on my computers.  Not because Python is so cool, but because it is in the default install.
Also Python is one of my fallback languages when something more is needed than a plain `bash` script.

> My fallback languages are C, Python and JavaScript.  JavaScript usually targets asynchronous applications and is only installed when needed.
> Python however, due to the GIL, covers mostly synchronous code.  And C is for writing toolkits and system coded to support shell scripting.

Hence I tried Ansbile and .. somewhat succeeded.  Understanding Ansible is not easy, and getting started is some Hell of its own.

This here is to cover Ansible.  As my focus is on infrastructure free system mainainance Semaphore is not within my focus.
But I am aware of it and keep things in a way, which hopefully allow everything to integrate with Semaphore in future.

Ansible also offers some form of infrastructure.  However if you want something which is based on some infrastructure, perhaps Puppet is better.

However I like systems to be maintained locally in some secure, unintusive, clean and easy to understand way.
Ansible on top of signed `git` repositories exactly offers this.

- You change something in the `git` repository
- You sign it
- You push it
- The system in question is notified that something changed
- The system pulls the changes from the `git` repo
- It checks the signature
- Then it runs Ansible to incorporate the changes
- And reports back the result to the monitoring

Everything is maintained by the system itself this way.  There is no need for connections to the system.  Connections which possibly can be abused.
And everyhing is secured by some cryptographic infrastructure.  So all you need to keep secure is your signing process.
Attackers can possibly still disturb things.  However, provided that the signing process stays secure, they can only harm systems, they have cracked.
But there is no central management which can be cracked, because there simply isn't one.  That's the whole idea behind that.

I am not completely set up this way yet.  I am just at the begining.  This here is not to keep record, but to free my brain from the need to keep every detail.
