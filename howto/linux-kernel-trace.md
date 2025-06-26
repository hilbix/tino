# HowTo Linux Kernel Tracing

Well, there is good documentation out there.  But it is .. wrong way, like important last.
This here tries to be short and comprehensive.

See also:
  - ​https://lwn.net/Articles/365835/
  - https://lwn.net/Articles/366796/ 

## Kernel Debug (Trace Event)

Everything is below this here:

    cd /sys/kernel/debug/tracing

See the kernel trace (it is a ring buffer, so if traces come in too fast it is truncated):

    cat trace_pipe

Find what you need:

    cat available_events

Disable all events:

    echo > set_event
    
Enable all events

    echo '*:*' > set_event

Enable specific events:

    grep 'wanted' available_events >> set_event

En/Dis event (`available_events`'s `LINE`=`MAIN:SUB` then `EVENT`=`MAIN/SUB`):

    echo "LINE" > set_event         # en
    echo "!LINE" > set_event        # dis
    echo 1 > event/EVENT/enable     # en
    echo 0 > event/EVENT/enable     # dis

https://www.kernel.org/doc/Documentation/trace/events.txt contains more on this:

- Filters (only log interesting things)
- Triggers (do things when some function starts/exits)

https://www.kernel.org/doc/Documentation/trace/ftrace.txt explains

- `trace` file
- Latency and function tracing

See also:

- https://github.com/joeyli/openSUSE_ASIA/blob/master/openSUSE_Asia_2017_Tokyo/
