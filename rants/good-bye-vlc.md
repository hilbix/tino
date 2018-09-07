Also read: https://www.omgubuntu.co.uk/2017/02/swap-vlc-mpv-ubuntu

# Good bye VLC

Good Bye VLC!  With all those upcoming 4K videos VLC on my machine started to act strange,
because VLC is unable to cope when the machine is not fast enough to provide the data in-time.
However that's normal with 4K if you use network on a machine which is busy doing other things,
like compiling, working with IDEs and so on.

That's extremely annoying.  So I actively looked for some alternative,
and what I found not even was able to replace VLC, it solves many other problems as well,
which I had with VLC.

I stumbled over the article https://www.omgubuntu.co.uk/2017/02/swap-vlc-mpv-ubuntu which told me about `mpv`.
Something I had never heared before.  So I gave it a try.  And it works.  Way better than VLC.

Following problems are solved:

- No more choppy video.

  When the machine is not fast enough to play the Vidoe a the wanted speed,
  it just plays slower.  The picture can be a bit jumpy then, but no artifacts whatsoever.
  Each picture is clear an correct.  That's not only an improvement, it's a bugfix compared to VLC.
   
- Fast, really fast manual seek.

  If I use the keyboard or the mouse, MPV does a very good job in following the video position.
  Sometimes it takes a while, but this is only because the IO subsystem is handling other demands.
  So the player does, what you expect from it.
  
  I think, it does buffering, but VLC waited to play until the buffer was filled, which can take
  ages with a big buffer which is needed if the network is a bit slower than the stream data.
  At least this is my impression.

  OTOH, MPV seems to start playing immediately when enough data is available.
  And buffering is done in the background, as it ought to be.
  
  You can even see the ongoing buffering in the UI of MPV, which I was not able to see with VLC,
  so it was hard to explain all those problems I found wiht VLC.

- Stepping backward.

  VLC only allows you to step forward.  There is no way to step backward.
  
  MPV seems to do a good job there.  Yes, sometimes it takes a second (or more!) to just step back a single frame.
  But this is ok, as it cannot do better.  To step back a single frame, it must step back to the last full frame.
  With highly compressed video this can be several seconds in the past.
  Then it must play forward (internally,
  you cannot see this) until the right frame is reached,
  which then can be displayed.
  
  Yes, this simple action has a high IO, CPU and algorithmic demand!
  Something VLC does not even try to do.
  MPV does it.  Great Job, really!

- MPV is commandline controlled.
 
  Some people find this annoying.  Video players from commandline.  Eek!
   
  However, think again.  You do need it, so you want it, even if you do not know!

  VLC has a backend for this, too.  Right.
  But I did not find a way, to utilize this form shell level easily.
  There are several steps involved, which are not only difficult to do, as documentation sucks as usual,
  they are also a security nightmare (opening ports, doing some connections, reconfigure VLC and so on).
   
  We live in some horribly hostile environment today.  Everything must cope with this.
  Hence we need software, which is safe to use, by default.
  VLC probably is.  But if you want to use it, you need to customize it.
  And to be able to control it, you need to do things, which quickly might become dangerous.

  However with MPV this will not happen.  The interface is the basicst ever.
  Just a commandline.  Just stdin/out.  All you need, alrady is there, at your fingertip.
  So you can immediately and naturally start to improve things as you want.

  Again: Gread job, thanks!

- Just works.

  VLC usually has some good defaults.  But if it does not play well, you start to change things.
  Probably you change things the wrong way.

  But not only this.  VLC saves the settings when you close it.  WTF?

  So if you experiment with settings and accidentally close th beast,
  all your good settings just vanished.

  MPV has no settings.  It's entirely commandline.  You must give options.
  Something which is easy to do.  Very easy.  It is from 1940 you know.  Something everybody knows,
  except perhaps those people who think,
  a computer mouse or touchscreen is the most important input device on a computer.

  Well, wrong.  The most important basic IO-devices for a computer are:

  - A reset button
  - And a single hard drive LED

  You do not need more to fully control a computer.

  But .. well, there are not many others who will understand that.
  It's even worse, on many computers today, both are missing!
  But without those two, you can no more fully control a computer!
  (Neither the "long power press" nor a power switch are replacements for a proper reset button.)

Until now I did not find any feature I miss from VLC.  Except perhaps for one thing:

## Please do not get me wrong

VLC still has it's purpose.  If you do not know what's ahead, if you need some tool,
which is more than just some video player, then VLC is the beast you need.

It can capture and stream things, it can access nearly any hardware and play to anything else.
And it has an UI for this, which is probably quicker to use than doing it with commandline.

Once.  So you will have a head start when it comes to "I really do not know how this can be done.
just head into it."

But afterwards, when things settle and you want to become productive, you probably want to switch to something which was designed to the job, to do just this job and do it right.

Like a Swiss Army Knife.  It's suitable for nearly everything, when things happen on-demand.
But it is not the best tool if you want to mass-produce things.
