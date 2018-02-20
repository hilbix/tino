# Why Open-Source wastes my time

Please do not get me wrong.  I am a strongly supporter of Open Source.  If it is done right.

However most time, you get a very hard time to use Open Source.
Because .. well, I do not have any other solution to this, except that most Open Source programmers are just plain big idiots.

Sorry.  But .. well, there are trainloads of examples.  If I start here to discuss that all, I'll probably never stop,
because there will show up such type of bullshit faster than I can list it here.

So have a few examples.

## Improper error checking

`/bin/cp` does no more work.  Well, in the ancient times, something went wrong.  And if I see it correctly, this bug still is there.
`/bin/cp` cannot distinguish from empty files and file with 0 bytes due to read errors.  Not always.  But in certain situations.
I did not test it (because I have no matching environment today), but AFAICS this bug might still be there.
So `/bin/cp` is not reliable, as it does not have proper error checking.

This is the very first type of errors encountered with Open Source.
Things are done far too lazy often.
And they never get fixed.

(This might be the same with closed source as well.  But perhaps things are a bit better tested there,
such that these **type of error on common situations** is covered, while it is not covered with Open Source.)


## Too many cooks

[`/bin/grep` does no more work](defunct-grep.md).  WTF?

Some time back somebody thought, that using `mmap` for file access might improve things.
Now this is the default and breaks `grep`.  Because .. well, I just do not know.  But let's speculate:

With Open Source it is easy to improve things.  So people start to discuss, somebody does something and everybody agrees.
So things are changed.  And changed.  And changed.

But not each change neccessarily is an improvement.  Perhaps it has drawbacks.

Changing things in Closed Source is difficult.  You usually have some processes to follow, which are bloaty, slow and expensive.

Hence you will not change things easily.  Hence you will first think and then change.

No, there is nothing which prohibits Open Source to follow some similar path.  The problem is, that this path isn't taken often.

(Linux, for example, has a very good quality assurance.  Or say:  Somebody who cares and looks after his child.
So not everything is bad.  But the majority of Open Source projects are not really a good example on how to create good software.)


## Too many features

- Something is not perfect, if it just supports all.
- Something is perfect, if it just does, what it has to do.  Or in other words:
- Something is perfect, if you are no more able to leave anything away.

However looking at Open Source I always get the impression:

- "If there is a feature, regardles how unimportant, let's support it."
- "Once I had a good idea.  So I started to implement things.  But then I abandoned it."

Most Open Source is between these Edges:  Abandonware and Overfeaturism.

The Opposite is what Microsoft does:  Either you must die of thirst or you will be drowned.

Note that both are likewise bad.

Example:  You want a Glass of water.

- Microsoft:  We either can teleport you into the middle of the desert or in the middle of the open sea.

- Abandonware:
  - Here is the code for the Glass Factory.  It's easy to use and will create as many glasses as you like.  Even one.
  - Here is the code for the Water Pipe.  It's easy to use and will create as many water as you like.  Enough to fill a glass.
  - And here is the adaptor to attach the glass to the pipe .. oh, sorry, not yet ready to use.
    Sorry, nobody came around yet to create that beast.  Just create one yourself.
  - Unfortnuately the interfaces of the Glass Factory and Water Pipe are too incompatible.  So creating this adaptor is a bit difficult.
    Perhaps it would be more easy to just create a new Glass Factory and Water Pipe from scratch which are compatible then.

- Overfeaturism:
  - Here is the Glass Designer.  You only need this simple 1 billion character long command line to create the glass shape.
  - Here is the Glass Fatory.  It takes the Glass design and creates reusable Glasses.
  - Here is the Glass Outlet.  It can take these reusable Glasses and sort out your glass for you.
  - Here is the Generic Pipe.  It is not only a Water Pipe.  It can be any pipe you want.
  - Here is the Water Pipe.  This only 2 bullion character long commandline creates the Water Pipe from the Generic Pipe.
  - Here is the Ocean.  It's not the Ocean of just Earth.  It's the Generic Ocean of any Planet of the Universe.
  - With only this 1 Gazillion byte long commandline, you can create a very small ocean, just fitting through the pipe.
  - And here is the Tap-Code.  It can be attached to the Generic Pipe.  Hence attaching it tot the Water Pipe makes it a Water Tap.
  - Here ist the cryptographical enhanced Tap opener.  It opens the Tap if you present it the right certificate.
  - Here is the CA code.  With this CA code you can register for a certificate.
  - Here is the Enrollment Service.  You get it, it enrolls certificats to things.  With this you can attach the certifiacte to the Glass.
  - Now, see, how easy it is?  Just hold the Glass to the Tap and it fills, automatically!


## Bad clone

Open Source often is a bad clone of the commercial product.  It looks like it.  It even has the same bugs.  But it does things different.

Why?

If you want to create something, think for yourself!  Try to create something new and unique and do not try to copy
all the bad features of Closed Source first.


## Overly complex

If Closed Source is good and easy to use, please try to do things even more simple with Open Source.

For example:

Back in the last Millenium I needed to process Mails.

It took around 5 Minutes to understand how to open VBA in Outlook 2000 to start programming a Mail adapter.

The task was to detect mails from certain senders, extract the attached Word DOC file, detect the embedded Excel sheet,
and extract the data into something machine readable CSV type export.

It took around 4 hours to do so.  Find out how to access the Word component to access the embedded Excel.
Then the Excel component was able to save that data to some Text format.
This then was used as a new mail template, was signed and sent out to the (Linux) database.
Such that the database was able to receive the data and post process them.

Easy and efficient.

And think what?

This code still works in 2017!


Today I tried to do similar with Thunderbird.  Well, not quite.  A much more easy thing.

Receive a Mail, take it and send it out again in a special format, suitable for postprocessing.

And think what:

**After Hours of searching I still do not know how to do it!**

- There is plain no documentation about how to do anything.
- The only way seems to be to create some special Thunderbird extension, which uses some obsuce and very complex setup to do so.
- So I give up.
- Also this code certainly then is no more compatible to newer Thunderbirds, as it must be adopted to each new Version.

WTF?

What are you doing guys?  Why did you do this?  What is that?

Plain unusable as it looks.  Do I really have to go back to `procmail` or `maildrop` to get it done?


