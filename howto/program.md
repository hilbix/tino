# How To Program

Here is my opinion about how to program.

# What programming languages to learn?

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


## Core Programming Languages

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


## First language: JavaScript

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
get far more successful with JavaScript than any other single language.

I bet (but I never bet) in 100 years from now, if you live long enough,
you will still be able to sucessfully use JavaScript for your projects.

> Also note, that eScript (the language of Oracle CRM) and
> Adobe Air/Flex/Flash/Actionscript
> are ECMA Script variants very similar to JavaScript.

And at last, JavaScript is now available as Scripting language of NginX,
and is integral part of Apache's CouchDB database.  
I really have no ide why you ever want to use that,
but hey, this all is available.


## Second language: C

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


## Third Language: `bash`

Or to be more precise: [Bourne-Again Shell](https://de.wikipedia.org/wiki/Bash_(Shell))
which is a variant of the standard Unix Bourne Shell.

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
  But not `bash`  (YMMV, some HP-UX come with `ksh` instead of `bash`,
  as they are too old.  FYI `ksh` and `bash` differ only in a few things.)

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
Bourne Shell.  `bash` is only one variant, `dash` another lacking
all the bashisms.  So I recommend `bash`.

I bet (but I never bet) in 100 years from now, if you live long enough,
you will still be able to sucessfully use `bash` from commandline.



# Honorable mention

These are programming languages, you will certainly see on your journey.

But I do not recommend to put your learning effort into these at the first step.


## Python

If you use GIS, you use Python.  Many programs have a Python interpreter built in
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
> But this is not, what Python does when embedded.  There it more acts like a scheduler.
> And a scheduler needs to be single core, because writing a parallelized scheduler
> is .. a PITA.  You will get many awful problems with parallel execution.
>
> Python natuarlly serializes these codes.  While still being able to
> run things in parallel with threads (which might run their own Python interpreter).
>
> It is like Promises (AKA Futures) in JavaScript, where you only have a single
> execution thread.  But here, JavaScript is not as easy to embed as Python.
>
> Hence all those mighty programs like OpenCAD or QGIS run a Python interpreter for a good reason.

So if you use those higher level software, this is a good cause to learn Python.

And learning the basic constructs of Python really is easy.

Also Python follows the "there always is a single best approach" design pattern.
So there, always, is a single common way everybody can agree upon,
about what is most Pythonic or not.

And most times Python also fulfills the "most expected result" pattern.

> Most expected by those who dived deeply into Python,
> not perhaps you when you start learning it.
>
> However it often is very enlighting to understand, why something
> works in Python the way it works there.

I repeat:

**If you scientifically want to learn programming, not primarily for your everydays use,
or you have some specific software which uses Python as embedded interpreter,
then Python is probably the best language to start with.**


## Java

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


## PHP

PHP is a language mainly used for web services.  Theoretically it is a full featured
language capable to do all things, but practically you won't want to do this.

PHP has some really awful constructs which gives the least expected result.
Thins includes:

- Surprising similarities of strings and numbers.  (BTW, JavaScript is very close to that!)
- Surprising operator precedence on `x ? y : z`.
- No proper way to handle errors after they occurred (recommendation: `die()` on any error and check everything before, so no errors can show up)
- All library functions inherit problems found in the standard C implementation
- Introduction of new bugs of standard functions which later were declared standard (i.E. Posix regexp)
- Nearly no security for externally provided data
- Dangerous basic standard things (like `require`) in case an URL happens instead of a filename (read again:  You must check everything in advance)
- and so on

If you are able to escape all those pitfalls, you can wriite very performant backends with PHP
thanks to `php-fpm` or successors like `hhvm` (even that it no more supports PHP).

Entire Facebook was written in PHP, so if it scales for Facebook, you should not get into trouble
(provided you are an as good programmer as those at Facebook).

So PHP definitively has it's use and it is good to know PHP good enough to change
and secure all those enourmous amount of PHP code out there.

But ..

.. this needs a high level of knowledge, a deep understanding of PHP and the right attitude
to keep things safe with PHP.

With somewhat more complex code you usually will fail.  And you will fail badly.  You have been warned.

However there is nothing against if if you create small, secure, proven scripts which utilize PHP.
Thanks to the standard embedding within Apache (or `php-fpm` with NginX)
**it is relatively easy to quickly write some Middleware scripts**,
and at this point it is probably more versatile than others.

Hence it is good to understand PHP, but it is not a language, I can recommend to be learned as the first language.


## Assembler (AKA Machine code)

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


# Future possible languages to learn

Perhaps in a few years some additional languages will show up which you should learn.

Here is what might show up.


## AI Language

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


## Quantum Language

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


## GPU language

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


# Why not ..

Why not another language.  Like `go`.  Or `rust`.  Or some of the other gazillion of languages out there.


## Perl

I hate Perl.

> This probably is the only programming language I hate.

Do not get me wrong, I know Perl very well.  I know it too good to not hate it.

Perl is extremely powerful.  And it has some interesting automatic polymorphisms.

But that exactly is the problem:

If you write Perl code, after some days you will never going to understand your problem at the first glance again.
(YMMV, but only if you have some idetical brain where you can exactly re-invent the thoughts you had when you wrote the Perl code.)

This is due to the enourmouse freedom on how to express a single thing in Perl in code.  Other languages have, say 5, variants, but Perl gives you thousands.
Literally.  Already for such a simple thing as `1+1`.  And you do not need artificial contests to do it.

> Read: You can write good code in Perl, of course.  But over the time you will detect, that your code starts to become garbage.  For this we can only blame the language itself.

Perl erodes.  I once had the problem that suddenly a Perl script failed after some upgrade.  The fix was quick and easy (for me, not for others, as I wrote: I know perl very well),
and after adding `use utf8;` the Perl code continued to work perfectly.

But this shows the nature of Perl.  Things behave erratic, just because there is no clear upgrade vision of Perl.  They hack things into the language as they seem fit.
This is not always a bad thing.  But with Perl you won't be safe.

In 100 years from now, understanding your old Perl scripts will be so complex, that rewriting them from scratch probably is more easy.  You have been warned.


## Rust

I do not know Rust good enough to tell you anything about it, so I cannot include it.

> But I doubt it can replace one of the 3 languages I have chosen as the core languages.

But all I read sounds interesting and good.  Those people behind Rust apparently had a vision.

Another interesting part is, that Rust can compile to C which then compiles to machine code.
So it offers the speed of C with type safety and less burden.

> In the future Rust probably will be directly compiled.  But that's nothing pro or con Rust.

So if you want to look into interesting languages, Rust is definitively a candidate.

However, if Rust prevails and nobody comes up with something better than it,
then in 100 years, then you will be able to sucessfully use Rust for your projects.

But I am not sure, that Rust will not get some successor.


## go

The `go` language has it's benefits.

- It is modern and stable
- Network and thread enabled
- and can create direct machine code

However I was unable to even compile a single origram of it, like the example.

Why?

Because I always test things in an offline way.  So it must work without networking at all, too.

And `go` failed for me because the includes were not available.

This is a definitive no go.  Even that things might get cached, if you reset your work and start over with it things suddenly fail .. because some external resource vanished.

This feature is built into the language.  Hence the language is to blame for this.  And I do blame.

> Why is this critical?
>
> Because we already have a very good and proven feature which offers all and everything `go` does with this external includes.
> (There are even other languages like JavaScript which offer similar methodology, however these are usually not a language core feature which is advertised.)
>
> If you are puzzled, I refer to `git` and `git submodules`.  With `git` you can safely do things in 100 years you did today (provided that the SHA1 is not broken).
>
> It is right, that you can do with `go` the same way.  But much more difficult.  And nobody lives it this way, while `git` only allows you do use this feature securely.
>
> So if it works with `git` you know you are safe.  However if it works with `go` you first have to check things thoroughly, that you are safe to do it in 100 years from now, too.

Languages which are advertise insecure features and thus **urge you to learn the wrong lifestyle by default, are dangerous**.

Besides of that `go` is very cool.  Just too cool.  You have been warned.


## LUA

LUA is cool.  It is nearly the perfect language to embed.  This is why it was the first language available in HaProxy.

> If you want some Load Balancer, [look at HaProxy](https://haproxy.org).
> This is just some piece of software which reaches out to perfection.  Some indispensable absolutely reliable piece of workhorse.

If you need a small, easy to embed ultra-fast and reliable scripting language, which also offers OO paradigms out of the box,
then you probably end up with LUA.

LUA is not only used in hyper-stable products like HaProxy, it also is used in games and similar, due to it's minimal size predictable execution characteristics.

> Therea are perhaps smaller embedded languages, but these usually come to a price (not money, feature-wise).

But in everyday's life I did not see LUA a lot.  Often the Interpreter is not even installed.  Hence I cannot recommend to learn LUA as on of the first languages.


## TCL/tk

TCL is a special purpose language.  It's old and hence reliable.  And `tk` offers some basic graphic context.  It's part of most Linux distributions,
as it is often used from UI scripting.

But that's all there is.  It is very special purpose (my view), hence I do not recommend it as the first language(s) to learn.


## Bacic

If you own something like the good old C64 (or some other Commodore computer), then Basic comes into mind.

And very well, Basic is so simple, that the C code of a very basic [Basic Interpreter](https://github.com/ioccc-src/winner/blob/master/1990/dds.c) fits into 1536 bytes,
as well as the [Basic Compiler](https://github.com/ioccc-src/winner/blob/master/1991/dds.c) fits into even less 1133 bytes.

However Basic must be considererd too basic these days.  OTOH the builtin VBA for office automation of Microsoft Office comes very handy, too.
But this is no more needed, as nowadays, Microsoft Office can be extended using JavaScript as well.

This, again, points to JavaScript.


## Here be Dragons

Certainly here are many languages missing.  There are [so many out there](https://en.wikipedia.org/wiki/List_of_programming_languages),
that it would take too long to just look at all of them.

