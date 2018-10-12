# RTFM

Please **Read The Fucking Manual** before you yell out about something, which is well documented.  Google is your friend!

## Processor God Mode

- On [2004-09-29](http://datasheets.chipdb.org/VIA/Nehemiah/VIA%20C3%20Nehemiah%20Datasheet%20R113.pdf) VIA documented the RISC mode on VIA C3 Nehemia processor.
  Start reading at page 82

- On [2018-08-09](https://www.youtube.com/watch?v=_eSAF_qT_FY), 14 Years later, somebody suddenly called this "GOD MODE".

It's an intersting excercise on how he did investigate this without consulting the processor's manual.
And it is interesting, how he exploited this well documented feature to gain root access.
**However this was an openly, well known documented feature.**

Background:

- On embedded VIA C3 Nehemiah processor there is a RISC core which is enabled by default by MSR (Model Specific Register)
- The RISC instructions can be run with a BRIDGE command from X86 0x0f3f and 
- The RISC core shares X86 registers and memory, such that it enables to circumvent memory protection of Ring 0
- So Ring 3 can change data in Ring 0 like modify Kernel structures to give root access

And this is well documented.
