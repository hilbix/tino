# Anatomy of a secure backup


## What are backups?

Backups are, basically, a copy of your data.

To be a suitable thing, backups must have following additional properties:

a) Backups must be more than just complete copies.  A backup, which is taken from something on a machine stored on the same machine, is just a copy and not a backup.

b) Backups must be safe.  A backup, which can be possibly destroyed along with the original data, like due to a fire, is not what is meant by a backup.

c) Backups must be available.  A backup, which cannot be found or restored when it is needed, is not usable.

d) Backups must be secure.  A backup, which can be accessed by a 3rd party, are against the law.

e) Backups must be authentic.  A backup, which could be modified after it was taken by some evil force, is just worthless.


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
we need the client to be able to handle asymmetrically encryption.


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

### T.B.D.

> Here is missing a lot about the server

## T.B.D.

> Here probably is missing a lot more about how to do it
