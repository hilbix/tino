> If you have a clean strictly organised machine Zoo, then probably Puppet is better.  (Note that I do not know Chef nor others.)
>
> With Puppet you do not need to think about the targets or how something is done.  As ist is strictly organized,
> you simply define the Puppet way to be your organization and everything is set up.
>
> However if you have a wild Zoo where each thingie is not strictly organized and perhaps needs special treatment,
> then I think that Ansible is superior to Puppet, as with Ansible you always know the sequence something happens.
> And quite often in the wild, there is a difference about how Puppet would do it and how it must be done.
>
> You can declare the sequence things must run is Puppet, that is right, but this is clumsy and takes away much strengths
> of Puppet.  Hence in a case where you do want certain things to be done in exactly the order you want,
> Ansible is superior to Puppet, because that is how Ansible works.
>
> In a clean strictly organized Zoo this is different.  Nothing must get a special treatment there.  Things must
> be pluggable together and scale, hence special treatment is a PITA.  Here lies the strength of Puppet:
>
> You no more declare how it is done but only what needs to be done and the dependencies.  The rest is handled by Puppet.
>
> While in Ansible you need to explicitly know how it is done, such that you can do things in the right sequence.
>
> Ansible is good to be used on demand while things are implemented.  While Puppet is better for things,
> which are fully designed before they are actually implemented.
>
> **So Puppet is more Cathedral and Ansible more Bazaar.**
>
> However when I read the opinion of others, who know Chef or things like Salt etc., then it looks like Puppet is no
> viable option anymore and others might be better.  Including, but not limited to Ansible.
>
> So I stay with (Open Source) Ansible, because it works, needs no server, needs no client, and is flexible enough.
> Even that I find the YAML way to declare things far too inflated and ridiculously complex.

Impatient? [Have a look into my Playbooks](https://github.com/hilbix/ansible)

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


## Getting started with Ansible

There are 4 basic concepts in Ansible:

- Playbooks AKA YAML files
- [Roles](roles.md), which offer easily reusable parts for Playbooks
- Templates, implemented by Jinja2
- Inventory, which contains the catalog of machines and their configuration variables

The above is sorted by the imporance.

- The most important thing with Ansible are Playbooks.
- The next thing you need are Roles, which is a terrible name for it.  Because these allow you to remove redundancy from all of your playbooks.
- The third thing you need to understand is Jinja2 aka the templating engine, because everything you can use dynamically is based on this.
- Then last important thing is the Inventory, because Ansible contains a default repository for `localhost`

Of course the Ansible documentation starts with the least important thing:  Inventory

This is perhaps because they want to show their ability to replace Puppet and can support a whole infrastructure.
However this is very puzzling if you reallt want to get started with Ansible.

Usually the first thing you want to do is not to understand how to manage a fleet of a billion VMs out there in the cloud.
What you usually want to know is how to do system maintainance with Ansible.  To get rid of the tedious repeating task of setting up something locally.

This is why I write this here.  Usually I'd like to start with something like this on a fresh new machine:

```
# WARNING!  This does not yet exist!
git clone https://github.com/hilbix/ansible.git
ansible/init.sh
# WARNING!  This does not yet exist!
```

Or even more easy from my local workstation it should look like this:

```
# WARNING!  This does not yet exist!
ssh remotevm echo OK
cd ~/git/deploy
ansible/init.sh remotevm
# WARNING!  This does not yet exist!
```

The latter should prepare a remote machine to be managed with Ansible.

- It should install all the usually needed packages
- It should include setup the first part, too
- Such that the machine can manage itself out of the `git` repo in future

There is absolutely no infrastructure needed:

- Everything can be kept on my local workstation
  - It can be pushed to some central `git` server, of course, but this is no requirement
- I can edit configuration on my local workstation
  - and push it to the machine
- The machine then handles the rest


### Notes

The result of the management done locally then should be pushed to some monitoring.

- The monitoring is something completely different and independent and therefor not handled here .. yet.

`deploy/` contains the `ansible/` submodule and `host/`hostname -f`/` submodules

`ansible/init.sh` without parameter operates on `localhost` like that:

```
git init host/`hostname -f`
cd host/`hostname -f`
ln -s ../../ansible .
ansible/setup.sh
```

`ansible/init.sh remotevm` operates on the given VM like that:

```
git init host/remotevm
cd host/remotevm
ln -s ../../ansible .
ansible/setup.sh remotevm
```

- I like things to stay similar and hence easy to remember and use
- There could be some `host/ansible` of course if you name some VM `ansible`
  - Hence the softlink to `ansible` must go two levels up

I am not quite there.  In fact, this here is the first place I found out how I really want it to look like.

> This is why I usually do documentation (somewhat, only the most basic one) before implementation.  To order my thought and get some clear path to follow.
