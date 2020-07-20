# Documentation of `dbus` suxx

I speak fluently C and many other programming languages and even SQL or sendmail config,
have 35 years of detailed intimate Unix experience of kernel-sourcode- and shell-level,
know how to interpret strace, ltrace, stap, gdb, tcpdump/wireshark,
can understand IP, HTTP, BGP, EIGRP, SNMP or similar on protocol level,
also reading and understanding XML, HTML, JSON, SQL, Markdown is a no-brainer for me,
but I have absolutely 0 knowledge of dbus and simply cannot understand it
(like: SystemD).

For example, how can I see what's going on.  Nope, `dbus-monitor` is not the answer, it is where all my `dbus`-problems start!

One question:  Why is the output not in XML or JSON, but something completely incomprehensible.

## Questions

Is `dbus` complete yet?

- According to https://dbus.freedesktop.org/doc/dbus-specification.html the answer is "no" and it is under heavy development.
  - The protocol is frozen which means, it's syntax no more changes.
  - But the protocol is defined by the bleeding edge of the current source code, so the semantics are under heavy development.
  - Right?

Why is something which is under heavy development, far from being stable used for mission critical and security sensible things?

- This question also applies to SystemD


## What I need

- `dbus` from shell.  `bash` only.  Text only.  Remote only.  But everything.
- introspection.  Not snippets.  Everything.
  - How to list everything which is connected to `dbus`
  - How to list every possible endpoint on those thingies connected on `dbus`
  - How to firewall all this shit
  - How to monitor all messages on `dbus`.
  - How to intercept all messages on `dbus` (for debugging like injectin errors)
  - How to fake all messages
  - How to analyze the messages (like in Wireshark.  I want to know about each bit, why it is there, what it does)
- documentation which can be understood
  - 
## Unsorted things

### I really have no idea at all

https://mail.gnome.org/archives/networkmanager-list/2010-January/msg00212.html

    dbus-send --system --print-reply --reply-timeout=120000 --type=method_call --dest='org.freedesktop.NetworkManager' '/org/freedesktop/NetworkManager' org.freedesktop.NetworkManager.GetDevices

https://developer.ridgerun.com/wiki/index.php/How_to_send_Dbus_messages_manually

    dbus-monitor --system 
