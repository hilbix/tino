> STILL NOT COMPLETELY SOLVED!
> 
> I have bell on X11 but still not on Console.


# HowTo Audio

Problem: Following is mute

    echo -e '\a'

> This seems to be the really hard thing, hence I use this as the indicator.
>
> In the 1980s every mainboard had a beeper.  And it was easy to let it beep.  And I was happy.
>
> - But then idiots started to use Computer, and they started to complain for this terrible sound the beeper does.
>   - And now I am angry what they did to my environment!
>   - Because they steadily try to change Internet Culture (but fail because they do not understand what Internet means, which makes them go wild)
>   - Because they killed of the beeper (such that my Terminal now is mute).
> - I really have no idea why humans always repeat history!
>   - They started to settle in America.  Result:  Indians were killed off.
>   - They started to use Computers.  Result: Beeper was killed off.
>   - If humans start to show up in groups, they start to kill off everything else.  You cannot change their nature.

Environment: Standard Ubuntu install, standard terminal

> Typical for humans, bad things evolve far more quickly than proper solutions.
>
> I hat all humans for that.

## Solution

`/etc/pulse/default.pa`:
```
load-sample-lazy x11-bell /usr/share/sounds/Oxygen-Window-Shade-Up.ogg
load-module module-x11-bell sample=x11-bell
```

Notes:

- PulseAudio need to be restarted for changes in `/etc/pulse/default.pa`
  - The manual does not state how to restart PulseAudio, but see below how I restart it from scratch
- The sample must be long enough to wake up your sound system (which takes 0.3s on my system with HDMI)
  - check it with `pactl play-sample x11-bell`
  - check it again after your Sound System went to sleep, which is completely random at my side

Perhaps you want to reset PulseAudio (drop your User settings) and restart it from scratch.  To do that:

    mv -Tf --backup=t "$HOME/.config/pulse" "$HOME/.config/pulse.old"
    pulseaudio -k
    sleep 1
    sudo killall -9 pulseaudio
    sleep 2
    pulseaudio -D

Note that it then comes up in some random state.  **Be sure check correct sound settings afterwards!**


## Recipes **tried but failed**

- <https://wiki.archlinux.org/title/Professional_audio> gives no hint about how to unmute the bell in terminal
- <https://unix.stackexchange.com/questions/1974/how-do-i-make-my-pc-speaker-beep> (all of it up to 2022-02-27)
- <https://unix.stackexchange.com/questions/401156/why-ctrlg-doesnt-produce-a-beep> (good hints but no solution)


## System state

Tings to consider and diagnose:

- `echo -e '\a'` mute
  - On console TTY
  - Note that `ssh` sounds work with Putty on Windows!
  - Note that `ssh` sounds are mute with Putty on Linux!
- Terminal's `Edit` :: `Preferences` :: `Default` :: `Terminal bell` is enabled
- `Settings` :: `Sound` :: `Volume Levels` :: `System Sounds` is on max  
  `Settings` :: `Sound` :: `Output` :: `Balance` is on middle  
  `Settings` :: `Sound` :: `Output` :: `Test` works  
  `Settings` :: `Sound` :: `Alert Sound` :: `Glass` works  
  `Settings` :: `Notifications` :: `Do not Disturb` is off
- `Sound settings` :: `Sound Effects` :: `Alert volume` is on max  
  `Sound settings` :: `Balance` is on middle  
  `Sound settings` :: `Test Sound` works  
  **Be sure to have selected  the right sound output!**
- `rmmod pcspkr`
  - In former times this allowed a beep with `beep`
  - Today it stays mute, so it is worthless
- `rmmod snd-pcsp` is no help either
  - same as with `pcspkr`
  - also it is wrong direction:  I need output of bell on soundcard, not output of soundcard on pcspeaker

And (but this seems to have no effect):

`xset q | grep bell` gives
```
  bell percent:  50    bell pitch:  400    bell duration:  100
```

## Test state

- `works`: I can hear it
- `mute`: I can hear nothing
- `fails`: gives some error (not necessarily as error code, STDERR is enough)

State:

    works echo -e '\a'  # on X11
    works tput bel      # on X11
    mute  echo -e '\a'  # on Console
    mute  tput bel      # on Console
    works speaker-test
    fails /usr/bin/play -qn synth 0.02 sin 880   # /usr/bin/play WARN alsa: under-run
    mute  /usr/bin/play -qn synth 0.3 sin 880
    works /usr/bin/play -qn synth 0.4 sin 880
    mute  /usr/bin/beep # on Console
    fails /usr/bin/beep # on X11: beep: Error: Could not open any device
    mute  /usr/bin/beep # after modprobe pcspkr which provides /dev/input/by-path/platform-pcspkr-event-spkr
    works pactl play-sample x11-bell

While running `usr/bin/play -qn &` in backround following changes:

    works  /usr/bin/play -qn synth 0.02 sin 880

> This really is a WTF!  The sound system should be initialized BEFORE playing the sound,
> so running things with and without `usr/bin/play -qn &` should absolutely be the same!
