> T.B.D. not ready yet

# Anatomy of a secure backup


## What are backups?

Backups are, basically, a copy of your data.

To be a suitable thing, backups must have following some additional properties over copy:

a) Backups must be more than just complete copies.  A backup, which is taken from something on a machine stored on the same machine, is just a copy and not a backup.

b) Backups must be safe.  A backup, which can be possibly destroyed along with the original data, like due to a fire, is not what is meant by a backup.

c) Backups must be available.  A backup, which cannot be found or restored when it is needed, is not usable.

d) Backups must be secure.  A backup, which can be accessed by a 3rd party, are against the law.

e) Backups must be authentic.  A backup, which could be modified after it was taken by some evil force, is just worthless.

f) Backups must be reliable.  A backup must reliably do the work in the background, and handle all recoverable errors by itself.  On unrecoverable errors it must not stop, instead it must provide all neccessary information how to proceed.  These instructions must be clear, easy to understand and safe to use and must not open new riddles to solve for the user.

g) Backups must keep forensic.  A backup must provide detailed information what it did.  Such that you can read it years later.  So there must not be the need to handle everything immediately, instead you can handle it when you have the time to do so.

h) Backups must be easy to monitor.  No trainloads of messages.  A simple  "ok, note, warn, err, fatal"-thing where only "fatal" means, the backup was not taken and "ok" means "only known warnings and acknowledged read errors occurred but nothing new disastrous happened".  Note that "fatal" must be reserved for really fatal situations like "no CPU installed", "no power, so machine was switched off" or "the drive or path to backup is unavailable".  Somthing like "I cannot connect to my backup server" must not be a fatal error, this must be a transient situation from wich the backup automatically can recover.  Also having no connection to the backup service does not mean that the backup cannot be taken, it must be stored locally and be merged into the backup service as soon as this is back up again.



## Let's look a bit further on this criterias

Point a) is obvious.

If you just duplicate your data on the same harddrive and this dies, all data is gone.
Same is true if you have an ISP and use the backup solution of the ISP, and the ISP goes away
(which can happen within a few microseconds) then your backup is gone as well.

But you have to think a bit further.  Think about somebody evil makes the police seize your data,
then you are offline for quite a while, until you are proven not guilty.  But then your data is old.
Also, without your data, you often cannot prove you are not guilty.  And your data can be manipulated by the same evil.
How will you defend in that case without your backups?

Hence a backup must not be only a copy.  It must be something, which is not avalable to the common disasters.

### T.B.D.

> Here is missing a lot about security and so on

## Common disasters

Common disasters are:

- (b) Fire.  If a fire is able to kill all your data including your backups, you obviously have no backups.
- (c) Accidents.  If your company has some incentive overseas and the plane crashes with most or all of your employees, can you still access your backups?
  This is called disaster recovery, do you have a plan for this?  Perhaps you - the Chief - are the only sole survivor.
- (d) Wrong recipient.  If a backup is transferred, what happens if the wrong person gets access to your backupe (like a tape recording)?
- (e) Virus.  Is a virus able to harm your backup data as well?

Backups are no backups if they are not safe against all those common threats.

do not defend you in that case.  They must be an authentic copy of a point in time,
such that an attacker is not able to make you look guilty in case you are not.

### T.B.D.

> Here is missing a lot about common disasters


## Other threats

There are some other threats, which cannot be solved with backups.

- Like targeted attacks.  
  Targeted attacks are things like being tricked to restore some data and accidentally give that to some unauthorized 3rd.

- Like thieves or spies.  They can install keyloggers, bug your drive to copy all data themself, etc.  
  The only thing which is important here is, that your backups do make it more easy for those people to get access to the data.

- Like saboteurs.  Saboteurs try to change reality by forcing you into harm.  Like they put illegal data on your servers to accuse you.
  Or they alter some data such, that you are harmed.  Backups cannot prevent such a sneaky attacks.  
  But done properly, backups can give you enough forensic, to be able to track down how and when it happened.


## Virtual threats

There are a couple of more threats which cannot be addressed by backups.  Like somebody virtualizing your hardware and sit on top of that.
Then your backups work as normal backups, and you cannot see the attacker at all.

But this is mostly academic.  Because it does not affect your backups.  You cannot see the attacker, but inside of the "Matrix", everything looks pretty normal.
If the attacker is able to virtualize all of your production hardware but is not able to control your backup data, then you still have a working backup in that case.


## What does this all mean?

This just probably means, that you have no backup at all.

- If you have somebody taking the backups for you, you have no backups.  The other one has.  
  If you are fine with this, go for it.  But make sure, the other one really does the job properly.  
  This means, you must verify, that the data taken really works.  Not just today.  Always and in future.  
  Hence you must apply some verification on a regular basis.  
  If you do not, you, at least, need an insurance which covers all the material, immaterial and monetary loss due to not having a verified backup.

- If you do your backups yourself, you need a suitable infrastructure to do so.  
  This probably means, you need to keep your backups at 2 separate locations with a different security setup.
  Such that a single person is not able to destroy both locations at the same time.
  The only persons allowed to access both sites are you and all those, who inherit from you anyway.

- Also you need a suitable backup program.

The latter is why I write this all.


## Backup program criterias

Let's go back to the catalogue above.


### A backup must be a complete copy

This means, you must be able to restore it completely.

Completely means, it must include all the data.  There are several levels of this, and you must think about which level you need:

- Only the data but not the metadata.  In that case you have the names and text, but not the modification dates, access right etc.  
  This is a very poor backup.

- All data plus metadata.  In that case you have the names and text and the access rights or modification times, but are possibly still missing some context.  
  This is suitable backup for file servers, where you only want the contents with all important data.

- All data plus metadata plus environmental data.  This is often called a "full machine backup".  
  This is what you want from your servers.

Notes on "full machine backup":

- `tar` is not able to backup unix domain sockets (which is normally no problem)
  - Also `tar` has some problems coping with hardlinks
- `rsync` is not able to re-create block or character devices of not run as `root`
  - You shouldn't run `rsync` as root on your backup server!  That's far too dangerous.
  - You can use `fakeroot` instead.  However `fakeroot` has a bad habbit as it works on inodes, not file paths.  
    Inodes are insecure, as they might change.  Hence you need somthing better than `fakeroot` to enable `rsync`.
  - `rsync` also is a bit difficult when it comes to hardlinks

What I am into is a backup system, which is able to do a **"full machine backup"** in a suitable way.
Because such a backup allows us to do everything.


## More criterias to a backup program

As you want to run the backup program on a regluar basis, there are more criterias, such that you can use it.


## Delta and Increments

You do not want to do just backups.  You also want to do delta and incremental backups.

- Delta backups are backups, which only backup the data, which has changed since the complete backup.
- Incremental backups are backups, which are based on such a delta or other increment.

This is the traditional view.  Deduplicating backups (like `borg`) make it more easy by not having a means of "Delta" or "Increment".
They are always "full" in a sense, and automatically deduplicate the data, which means, you do not need to think
about how to find a suitable complete backup.  Everything is managed on the fly.

However, thinking of deltas and increments still is interesting, as this gives you an impression about
"what has changed", thereby reducing the size of the data which needs to be "in the backup".

For example in `borg` an increment can be seen as a backup of just a folder or a few files without backing up everything else, too.
(Note that I do not know how to express this in `borg` properly.)


## Interruptible

A backup shall be created such, that it is interruptible any time.
Interrupts mean, you, the admin, stop it again due to something, or just a sudden power outage.
It would be bad if you need to restart the whole backup from scratch.

Hence the backup should keep some transaction points where it can continue from after interruption.
Like it writes all of it's state each 10s in a way where the state can be checked and restarted later on.
Also the "server" side should have a way to detect the state of the backup, if it was complete or not.
And you still shall be able to access all the incomplete data as far as it is availbale.


### Offline capability

So you have a server and the server currently is offline, so the machine is not reachable by the network.

In that case you still want your backups be taken.  Well, the backups cannot leave the machine then,
but as soon as the network


### Network capability

We do not want your backups to be kept on the machine itself.
This means, that the backups are transported away from the machine to a secure place.
If the machine is air-gapped there must be some physically process designed to do so.
Like burning the backups on CD-ROM and move those somewhere else.

If the machine is networked, the probably easiest way to transport the backup is to move it over the network to a secure place.
Usually this means, the backups are taken online using some remote repository.

But online is bad, as we already have the criteria "offline capability".
And for security purpose there should be some "media break", which creates a natural barrier between the backup and the transport.

Hence the backup must not be affected by the transport, while the transport must be independent of the backup.

The most easy way to solve this is to have more than just one backup.  So to do a backup locally and then to copy this to the remote.

But that probably needs double the space than to keep the data locally (one for the data, one for the backup).
This also has following difficulties:

- This is only one-way.  There must be some way to verify the backup ("authentic").
- How about delta backups?  Does this mean you need to be able to store a complete backup locally plus the delta?
- How about incremental backups?  Does this mean you need to keep a complete backup plus the delta plus all increments?

So the backup program must have a way to handle all this:

- There is a local transportation area of a certain size.
- This area then is filled with the "increments" of the backup run
- Those increments can be moved to the server somehow (like over the network or via CD-ROM)
- There must be a way to do this online (or: in parallel while the backup runs)
- And there must be some verification process designed into this, such that you can verify the integrity of the backup taken.

Note that we do not define how this transportation must look like.
You can use `sftp` in either direction.  Or even physically move the data.
Or whatever.


### Server capability

Backups are tasks, which must run on a regular schedule.  Hence there must be some way to control them.
This is crucial, as you want to be sure, that the backups are really available and properly done, right?
And you probably want to do this on some bigger complex network for some bigger, complex infrastructure.

Hence you need some central sever.  Some single place where you can define and supervise everything.

It is nice if you can define everything on the local machine.  You crucially need a local backup control,
as you want your users to be able to do their backup at any time this is needed.

However you also need this central thingie.  In a redundant way, of course.


### Cloud capability

Well, you not only want to keep your Cloud computing backed up.  You probably also want to store the backup in the Cloud.

> What is the Cloud?  Well, it is all and nothing.  There is not only one Cloud, there are many.  And all are the Cloud.
>
> While the Internet is the network of all networks, the Cloud is the Cloud of all Clouds
> where each Cloud is some meta-Network like the Internet.  It's a meta, because a Cloud is a bit more than just the network it has.
> It contains all the computing services and so on, like SLAs which are not part of the Internet but provided over the Internet.
>
> Hence the Internet is just one service of the Cloud.  So the Cloud is a strict meta of the Internet.

But doing this is a PITA if you only have one centralized service.

Hence the "server capabilty" is not just a single server.  It must be some server network.

Like a corporate made of many smaller companies.  You have a central corporate policy about backups.
But each of your companies probably has it's own policy, too.

Hence the central corporate is able to supervise the companies, but the companies are able to supervise their clouds,
and everybody is able to delegate the backups between each of those big cloudy thingie.

And all of this in a failing world, where links can break and worse.


## To sum it up

Here are the criteria for the backup software:

- Client: The software to do the backups
- Server: To provide the backup storage and control
- Offline: A decoupling of transport and backups, such that you can transport backups offline
- Security: Such that everything is kept strictly separated and under control
- Redundancy:  Such that all the parts are able to help each other to keep the backups alive
- Integrity: To verify the integrity of the backups.  On the Client and the Cloud
- Automatic: No action needed to do the backup.  Just start or schedule and forget (do control later)
- KISS: More than just easy to use

And internally:

- Deduplication:  The backup must not store each backup as a copy itself, it just must keep the data needed somehow
- User controlled:  An unprivileged user must be able to do backups


# Anatomy of a secure backup

In the following we define the anatomy of such a backup.  Step by step.  Based on the above criterias.


## Client

A Client program that connects to a Server and transfers the data.
(This does not violate the offline capability, see below.)

The Client is incremental.  It is able to detect changes on the disk and only transfer those changes to the Server.

So the Client only keeps metadata needed to do the increments, but nothing more.  All content data is kept on the Server.

Restore of the Client is done by requesting the data from the Server again.

The Client has following components:

- Gather metadata
- Detect metadata changes
- Send the changes of metadata or files to the Server (without password)
- Verify files (without password)
- Restore files (perhaps needs password)

To be able to do all backup/verification without a password, but a restore with password only,
we need the client to be able to handle Asymmetric Encryption.


## Server

The Server is something, which is working in a hierarchical environment.
Hence we do not have just a single Server.  On each level there is a Server.

- The Client connects to the Server
- The Server decouples the Client from all other servers
- On each machine a Server is started either in Background or on-demand or on-they-fly, depending on the needs.
- Multiple Servers can run in parallel on the same machine

While the Client-Server connection always is online (using loopback, unix domain socket, a pipe or FIFO),
the Server-Server connection can be online or offline/manual or any combination you might think of.
The Server is handling everything needed to communicate.


### Server is On-Demand

When a Client needs a Server, a Server can be run on-demand, based on the infrastructure settings.

- A Server can permanently run in it's own Context on a machine.  
  In that case a single Server is set up to run on the machine and permanently runs in it's own Context.
  This way Clients can be controlled by it to do scheduled backups.  
  (This will be probably implemented last as this is a most complex thing.)
- A Server can be started on-demand (`inetd`-style) if it is needed.  
  In that case it does not run permanently, but still everything can be controlled using `cron` or similar.  
  This supports SystemD way of doing it as well as `inetd` or `sudo`/`suid` style.
  (This probably will be implemented first.)
- The Server can be forked by the Client.  
  In that case it runs in the context of the Client, which probably means the context of the User.
  The data then is kept somewhere (probably `/var/tmp/$USER/backup` or `$HOME/.backup/`)
  where it can be picked up by some other processes to transport it to the "real" server.
  (Note that this just is a special variant of on-demand.)


### Server is hierarchical

There is a Server-Server communication protocol, which basically is offline-capable.

When a Client does the Backup, Data is written into a Server.  This Data then needs to be transferred somehow.
This is done the Server-Server-link.

An important part here is, that this must be independent from the server and offline.
Hence the Server stores the data locally and then some action is triggered to transfer the data upstream.

The local storage itself does not need to be physically local, so it can be networked or replicated as well.
Hence the Server can also use virtual storage.

So the Server just acts as a Cache in a hierarchical sense.


### Server is asynchronous

If a Client needs to restore things, probably data must be requested from the upstream.

The Server then needs to forward the request for data to the upstream and waits until the data arrives locally.

As the transport of the Server-Server communication can be implemented by many means, this is a matter of the infrastructure,
not of the Server itself.

The Server just needs to make sure, that the request is not forgotten (so you need to be able to retry).
This must be part of the Server-Server communication protocol.


### Server uses Asymmetric Encryption

The Server gets data from the Client.  The Client can use Asymmetric Encryption.

Hence the Server needs to be able to understand that.

But the Server-Server-Protocol should be able to utilize that encryption, too.
This is for infrastructure authentication.

- The Server always encrypts the data before it is sent to some upstream with the public key of the upstream.
- The upstream then can decrypt the data again.
- The tranport mechanism in-between can be arbitrary this way.

Think about a CD-ROM which then is mailed.  It may reach the wrong target.

In that case the data on the CD-ROM might be encrypted three times:

- One:  By the Client
- Second: By the Server
- Third: By the transport process (by storing files encrypted)

Usually this should be enough to keep things secure.

If you break the 3rd encryption, you still have an encryption in place.
If properly done, you cannot distinguish the inner encrypted layer from random data.
Hence you have no way to proof, that you have broken the outside key!

As we know which infrastructure was used we do not associate the public keys to the transport
(this only is needed on Client level, not on Server level).
So by using an asymmetrically encrypted transport layer, without keeping file magics inside
(everything can be expressed in the metadata of the file, like the file's name),
we give the attacker no clue on how to decrypt the data.


#### How to securly store a NONCE

> THIS IS T.B.D.

Well, I am no cryptonerd, but I came up with following scheme.  Please note me if this can be done better.

> Please note that 509 and 503 are primes.

    i := a[0]
    j := a[i%256

- You prepend a file with 512 bytes.
- The first byte defines an offset in the first 256 bytes where the second byte is found
- The next byte
- The second byte defines an offset where the 3rd byte is found
- The next 



### T.B.D.

> Here is missing a lot about the server

## T.B.D.

> Here probably is missing a lot more about how to do it


# Reality Bytes

Things I have seen to really happen.


## No encryption locally!

If you want to take a quick backups on some removable media like an USB disk, these are better not stored encrypted.

**Because you can better use something like LUKS (an encrypted volume) to protect these.**

An encrypting Backup then is a major burden which only might add errors and the like.


## Multi Mirrors!

The backup system must allow mirroring of backups.  This is a crucial thing.  That is:

- You take a backup on some storage
- You copy the backup to somewhere else
- And you want to individually test the correctness of those backups

Why?  Because if something bad happens, and trust me, you only have to wait a bit until something really bad happens for sure,
you want to be safe.  For reasons noted here you cannot just take 2 backups.  Those might be different!

Why?  Because they are taken on different point in time.  Also it doubles the burden.  Hence the backup must be able to do so.

> BorgBackup fails utterly in this respect.

And no, this cannot be done on yourself and cannot be done by some 3rd party like LVM mirrors.

ZFS mirrors could, perhaps, provide that.  But you don't want to use that.  Better are ZFS sends with a verification phase afterwards before you do the roll-forward of ZFS.


## Backups must contain their logs, and keep those longer around than the data itself

Happened today:  Backup tells me, it cannot backup one file.  WTF why?  Well, the heuristics of the Antivirus in background (Yes, I am on Linux)
detected some anomaly and quarantined the file.

However (using borgbackup) this only showed up in the logs and not in the Backup Archive.  So after several years you won't notice this fact happened.

Also note that these facts should probably stay even after the Archive was pruned, as long as those paths are active.  Because you probably will find the file in the quarantine area of your Antivirus.  (In my case it was an old file checked out from git which triggered the heuristic detection.  Hence a False Postive.)


## Backup must not not create problems on it's own

2022-08-30 happened today:  `Failed to create/acquire the lock /root/borg/backup/lock.exclusive (timeout).`

This is an absolute no-go.  Either the backup works, or the backup works, or the backup works.

There is absolutely no argument that the backup might crash after it was interrupted in the middle.

The problem was solved with the call to `borg break-lock /root/borg/backup/lock.exclusive`.  Something which not only is unintuitive and a PITA, this exposes a major problem with `borg`:  The backup is not reliable.

What I expect is that in such a case the backup does not give up.  Instead it must continue to do the backup and then start to retry and if that is unavailable, give exact instructions what to do.  The documentation of `borg break-lock` is not only not helpful in that respect, it also creates a new major problem:  No instructions how to use it the safe way.

Here is what they say:

> This command breaks the repository and cache locks. Please use carefully and only while no borg process (on any machine) is trying to access the Cache or the Repository.

"**carefully**"?  Backup carefully?  WTF?

Bombs must be used carefully.  Nitroglycerin must be used carefully.  Candles on Christmas Trees must be used carefully, for example lighting them with a flamethrower probably is a bad idea.

But backups?  Backups handled "carefully"?  Sorry, no way.

If you ever read "carefully" in Backup documentation, run.  Run as fast as you can.  Backups must not be used carefully, they must work even if you are careless.

Backups is a thing you set up and then must be able to forget.  From time to time you should look at it.  Correct.  But there never should be the need to do something "carefully", because Backups are all care you need to do.

So if a backup find a problem, there must be **a clear and best way** to recover from the problem.  With no need to know what you are doing, because this is, what a backup must provide.  The backup must tell you what's going wrong and how to solve it.  And best, on noncritical situations, it allows you to solve it half a year later.

Read:

If Borg cannot get a lock, it must not stop to work.  It must sidestep, do an independent backup with some another lock, and then offer to merge the result.  Or something like that.  It must not stop working and must do the best it can to continue.  Period.

Read:

Bort is no backup solution.  It is a backup problem.


# What is missing?

Well, the most important thing about a Backup is Disaster Recovery.

This was not handled here.  Why?  Because you first must be able to handle everything from above.

On top of that you then must be able to define Disaster Recovery.

This is beyond the scope of this document.  But please keep in mind:  A Backup without Disaster Recovery probably is no Backup at all.

## How must a Disaster Recovery look like

Da Disaster Recovery takes following propositions:

- All people involved in setting up the Backup are dead.
- All information about who, where and how are lost.
- All you have is full granted access to the backup

Then the backup must provice precise information about everything:

- Where or how to find all the missing pieces of backup data
- Where to find and how to reinstantiate the encryption keys
- How to do a bare-bone recovery or how to access all data

This is not a trival task, as encryption keys must be secured.  So there must be a reliable way to reinstantiate them after a Disaster but this way must also be reliable to keep them secure before as long as a single person is alive who wants the keys to stay protected against others.

This probably requires somebody like a notary or fire and disaster proof instructions embedded in multiple locations which are secured from public.

Even that this is a probably most important part of a backup, this is not discussed here.  Sorry.
