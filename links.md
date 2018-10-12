# Unsortierte gemerkte Links

https://www.tab-beim-bundestag.de/de/pdf/publikationen/buecher/petermann-etal-2011-141.pdf

# Processor God Mode

https://www.youtube.com/watch?v=_eSAF_qT_FY

- On embedded VIA C3 Nehemiah processor there is a RISC core which is enabled by default by MSR (Model Specific Register)
- The RISC instructions can be run with a BRIDGE command from X86 0x0f3f and 
- The RISC core shares X86 registers and memory, such that it enables to circumvent memory protection of Ring 0
- So Ring 3 can change data in Ring 0 like modify Kernel structures to give root access

This might be not a hidden feature but openly available in this case, but this shows, how hardware backdoors could be hidden in processors.
