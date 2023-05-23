# How To Program

Here is my opinion about how to program.

## What programming languages to learn?

This is not about which language to learn to do theoretically studies about programming languages.

> This would be something completely different.
> Probably only C would be on this list, too, for plain historic purpose.
>
> **So if you scientifically want to learn programming,
> not meant primarily for your everydays use,
> but perhaps for some specific sofware like QGIS or OpenCAD,
> then Python is the best language to start with.**
>
> However if you just want to be able to program just everything and everywhere,
> then you will not find Python as useful as the languages I recommend to start with. 

This is entirely about, what programming language to learn to do
program something in real life.


### Core Programming Languages

Here is the list of the 3 Programming Languages I recommend to learn.
Start with the first and then eventually the others.
Below I will explain it in more detail:

- JavaScript.
  - You have access to a Browser?  Then you are ready to program in JavaScript.
- C
  - You own a Computer?  Then this can only be started thanks to C.
- `bash`
  - and the commandline is yours.

Because 100 years from now, you will be able to successfully complete a programming
task with the use all of only these exact languages.

> I do not say that you can use this language just everywhere out of the box.
> For those, see Honorable Mention below.


#### First language: JavaScript

JavaScript sux.  But it does not suck a lot.  There are some very picky
things in JavaScript, especially automatic type coercion and some antique
historic things, but if you get accustomed to that, JavaScript is probably
the best language to learn first.

JavaScript will help you every day.

Some site has a page which allows you to Opt-Out.  But to opt-out completely,
you must click on hundreds of checkboxes first?  Let JavaScript do it:
  
    for (const a of document.getElementsByTagName('input'))
    { if (a.getAttribute('type')==='checkbox' && a.getAttribute('checked'))
    a.removeAttribute('checked'); }`

JavaScript runs on the server side as well as on the Browser.  And most times
(read: done properly) you can use the same code in the backend as on the frontend.

More important:  Something you wrote 10 years ago will still run in 10 years
from now (provided the API was not removed from the Browser of your choice).

With JavaScript (and if CORS is properly implemented with the service youuse)
you can create (your own!) responsive web pages as you like,
with no server side feature needed at all, because that all is done by your browser.

You can even [run VMs inside your browser](https://bellard.org/jslinux/)
(well, not really useful today, but it works).

So JavaScript is definitiviely useful.  And if you only want to learn and use
a single language (you always should use more, but ..), you probably will
get far more successful with JavaScript than other languages.

I bet (but I never bet) in 100 years from now, if you live long enough,
you will still be able to sucessfully use JavaScript for your projects.


#### Second language: C

C sux.  Because C is so low level.  It has error prone pointer arithmetic.
If you do C, you need to know what you are doing.

But ..

- this is exactly why you should learn C.  It allows you concentrate on the
  low level and allows to [do and understand unexpected things](https://en.wikipedia.org/wiki/Duff%27s_device)

- C is fundamental.  Nearly all Computers out there use code written in C to boot up.

- C is efficient.  If you know what you do.  And with C you always know what you do.
  As you need to do it your own.
  
- C is old and stable.  Do not concentrate to do K&amp;R or ANSI-C.  Instead feel free
  to use the [C17 standard](https://de.wikipedia.org/wiki/Varianten_der_Programmiersprache_C#C17)
  right form the start.
  
- C helps you to understand Linux better.  As the Linux kernel is written in C.

I bet (but I never bet) in 100 years from now, if you live long enough,
you will still be able to sucessfully use C for your projects.


### Third Language: `bash`

Or to be more precise: [Bourne-Again shell variant](https://de.wikipedia.org/wiki/Bash_(Shell))

`bash` is not a language, but a shell.  A shell is some interpreter,
which is commonly referred to as "command line".

Strictly speaking this is not a programming language at all but a scripting language.

> But there is not much of a difference of scripting and programming.
> As well as interpeters and compilation.  YMMV but everything is the same idiom for me.

But why bash?  Because if you know `bash` you also know `dash` which is the
standard shell of Debian.  However `bash` has some additional helpful features
which are lacking in `dash`.

These additional features are commonly called `bashisms` and are often useful
for your scripting.  However `bash` is not fully POSIX compliant, so if you
need to support POSIX only, then better stick to `dash`.

But ..

- If you understand `bash` and know what is a bashism, you can sucessfully write
  scripts for `dash` as well.
  
- All Linux distributions support `bash`.  I never found one, which does not
  include `bash` by default.  `ksh` or others like `csh` might be missing.
  But not `bash`

- `bash` has many useful additional features to make it you default shell,
  like `.bash_aliases`.  It makes it more easy to keep things on a
  level you just expect from all system you work with.

Even the famous `cmd.exe` or `powershell` under Windows are such commandline
interpreters like `bash`.  While under Windows you perhaps rather want to
use `powershell` these days, `bash` also is available for Windows.
Not natively by Microsoft, but through WSL, which has full support from
Microsoft, too.

And with Windows 11 you can run Linux programs seamlessly on the same
desktop with Windows programs.

And for this it is good to know the Standard Linux Shell.  Which is a
Bourne Shell.  `bash` is only one variant, `dash` another.  But lacking
all the bashisms, I recommend `bash`.

I bet (but I never bet) in 100 years from now, if you live long enough,
you will still be able to sucessfully use `bash` from commandline.



### Honorable mention

These are programming languages, you will certainly see on your journey.

But I do not recommend to put your learning effort into these at the first step.


#### Python

If you use GIS, you use Python.  May programs have a Python interpreter built in
at the low level like OpenCAD.

This is because Pyhon is an ideal language for embedding in code,
and Python code always looks a bit like reference code.

> You still can write horrible code in Python.
> But this is not the fault of Python.

Python has some weaknesses for being used as general purpose language,
but this does not necessarily is true the same way for embedding.

> There is the GIL.  The GIL serializes Threads through the Python interpreter.
>
> For the first look this looks bad.  Because you cannot reach more than
> single core speed that way.
>
> But this is not, what Python does.  It more acts like a scheduler.
> And a scheduler needs to be single core, because writing a parallelized scheduler
> is .. a PITA.  You will get many awful problems with parallel execution.
>
> Python natuarlly serializes these codes.  While still being able to
> run things in parallel with threads (which might run their own Python interpreter).
>
> It is like Promises (AKA Futures) in JavaScript, where you only have a single
> execution thread.  But here, JavaScript is not as easy to embed as Python.
>
> Hence all those mighty programs as OpenCAD or QGIS run a Python interpreter below.

So if you use those higher level software, this is a good cause to learn Python.

And learning the basic constructs of Python really is easy.

Also Python follows the "there always is a single best approach" design pattern.
So there, always, is a single common way everybody can agree upon,
about what is most Pythonic or not.

And most times Python also fulfills the "most expected result" pattern.

> Most expected by those who deely stuck in Python,
> not perhaps you when you start learning it.
>
> However it often is very enlighting to understand, why something
> works in Python the way it works there.

I repeat:

**If you scientifically want to learn programming, not primarily for your everydays use,
or you have some specific software which uses Python as embedded interpreter,
then Python is probably the best language to start with.**


#### Java

You own a Mobile Phone?  Then this probably runs Java code.  Android still does.

Java is a horrible language.  From the design aspect.  At the time, Java was designed,
many much better concepts were available.  But some of them were not implemented
in the JVM at those old days, so there was no need to include them into Java.

With the years the JVM was extended and Java with it.  And the people did it right.
But still, Java had to stay Java, which was the main design flaw.

So why Java?

Because of the JVM.  Today there are other virtual code interpreters out there.
And there were other code interpreters before Java.  But the JVM was the first
one which was designed "right" with security in mind and may other things,
most people were not aware of at that time where the JVM was designed.

So Java is a horrible thing on top of something extremely valuable.

> And Java is horrible.  While there is a good cause why C code is as
> unreadable as Java code, Java code usually is N times longer than
> code written in any other modern language.  Where N can reach 10 and more.
>
> This makes things complex, unreadable and hard to understand.
> From a human's view.  From the computer's view Java is just perfect.
> So if you are paid by characters typed or lines of code,
> Java might be good for you as well.
> But if you are paid for writing efficient small easy to understand code,
> you will fail with it.

As Java is still the basic code and (nearly) capable to utilize all the JVM
features, it is and stays the definitive basic language to learn when you
want to target the JVM.

As nearly each device today can run a JVM (there also is one on your SIM card
of you Mobile Phone!), and the JVM is pretty standard, you can have a huge
success with Java.

> And moreover, Minecraft Java Edition could be hacked with Java, too.
>
> But for most things, Minecraft Ressource packs can be used for that purpose today.
> So no need to hack into Vanilla Minecraft anymore.

However, JavaScript is not Java, and Browsers, which natively speak JavaScript,
do not include a JVM these days (they use a JavaScript engine instead).

This means, even that the JVM is very common, it is not available just
on every device you get in contact with.  With this Java does no more
offer the advantage.

> And one of the main big disadvantages of Java is,
> that Java is proprietarily owned by Oracle.
>
> So if you support Java, you support one of the big companies,
> which are known to be evil for Open Source (remember MySQL).
>
> This was different from the old days when Java was designed.
> As Sun Microsystems always was good for Open Source (remember OpenSolaris and ZFS).


#### Assembler (AKA Machine code)

Staying on top of Assembler is a bigger burden.  As each CPU has it's own variant.
And new CPUs come up frequently these days.

But to understand, how something works on the lowest level, Assembler is the starter.

> Assembler is not the lowest level!
>
> - Assembler is like a method to create something out of a chemical formula
> - CPU Microcode is like a method to create something out of Atoms to do Chemistry
> - Computer Hardware then is like the layer of Quarks which make up all the Atoms

Back in the old times you needed to learn Assembler.  So doing it today is still
a good thing.  This is like learn to precisely throw a knife.
This stays true even in times of AI driven autonomous atomic weapons.
(See the prominent quote about knifes in the movie "Starship Troopers".)

For today it probably is enough to understand how Assembler works,
to be able to dig deeper and optimize problems near hardware level.


### Future possible languages to learn

Perhaps in a few years some additional languages will show up which you should learn.

Here is what might show up.


#### AI Language

AI is emerging.  Currently we only see the very first start.

If you ask me, AI is just at the level of a Transistor.  After that we saw
integrated circuits, made out of just a few Transistors.  Then these circuits
started to shrink and become more powerful.  Then Moore's Law arrived and,
today, we see extremely capable multi core CPUs which offer more power
than a Cray supercomputer in the 1980, driven for days by just some low energy
battery power.

So like the programming language C has adopted to the power of our modern CPU,
some new programming language might emerge which is able to utilize the
power of AI.  Not to talk with an AI, as you do not talk C to your Computer.
But to create AIs on some higher level.

This then perhaps will be called Neuronal Programming Language.

> But I have no idea where AI will head in the next 20 years.

Perhaps this language will look more like Prolog or Erlang.
A set of rules which the AI then will fulfill.
But I really have no idea.


#### Quantum Language

Quantum Computing still is Science Fiction.  When the Transistor emerged,
we already knew how to successfully combine millions of them.  Then problem
was not wisdom but practicability.

In contrast of Quantum Computing, we do not even know how to scale Qbits yet.
We can combine multiple Quantum Computers with each others.  But bit into
a bigger Quantum Computer, just a fleet of small Quantum Computers.
And this fleet then loses most of the efficiency found.

The Transistor easily scaled.  Quantum Computing does not.  Perhaps this changes.
But I doubt there will be something new will show up in the next years.
So to scale Quantum Computing will be extremly inefficient.

We will see better Quantum Computers.  But perhaps we will see more quickly
some new Programming Model to create Quantum Computers out of what we can create.
To produce Quantum Computer Hardware for our specific application.

Because there are a few things, Quantum Computers can do for us.  Today.

> I am not in Quantum Computing, so bear with me.  But there are certainly some.

The only problem is, that it is far too expensive to adapt the few Quantum Computers
today to solve those things more efficiently than a modern CPU can do.

As soon as this changes (basic Quantum Computing hardware becomes much cheaper)
we might see more and more products, containing some quantum technology
(which applies Quantum Algorithms, not just only some quantum effects).

And this might lead us to Programming Languages to reconfigure this
standard Quantum Hardware to the application we need.

And it might be worthwhile, to learn and understand this language.
Because it will be based on some completely different thinking model
as current programming languages.


#### GPU language

There is some hardware, is more and more common.  These are GPUs.

GPUs are versatile hardware, not only capable of calculating pixels
or Cryptocurrency.  They are also used for current AI networks.

But GPUs are different.  They are not good for common purpose tasks
like CPUs, but they are extremely efficient to process large datasets
with minimal algorithms.  They can be used to drive AI algorithms,
but they are not AIs themselves.

Hence they are, again, something completely different.  Something
for massive parallel computing in a special way.

Today our most common approach is `CUDA` (from Nvidia).  However this is only a driver,
not a programming language.  You still need to think "GPU wise"
and understand, how the underlying hardware can be used most efficiently.

But with the years there might be some common things show up,
and somebody might create a new language for this.
Something as basic as "C" and as versatile.

This probably is a Meta-Language, so it first is compiled to C and then
is compiled for the hardware.  But there is not much a difference to
something like Java, which is most commonly compiled to JVM code,
not Machine Code.

But GPUs are nearly everywhere.  Many Processors have an integrated GPU today.
Only very small CPUs like the Aduino have not.

This very likely will change.  Just because of Moore's Law.

But if GPU methods are built into each CPU, there probably it is good,
to have some standard programming language, which is able to utilize all
the capabilities.

You won't do it with all the other languages mentioned here.  Because they
lack nearly everything which is needed to use all that features efficiently.

