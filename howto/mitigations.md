> Warning!  I keep a different view to this things.  YMMV.
> If you follow my advice, I am not responsible if this harms you.  You have been warned!

# Linux Spectre Meltdown and other vulnerability mitigations

## Links

> These Links are in German.  Sorry.

- https://www.heise.de/forum/heise-online/News-Kommentare/Neue-Linux-Kernel-schuetzen-vor-ZombieLoad-aka-MDS/Bei-VMs-mitigations-off-unbrauchbar-minimum-ist-mitigations-off-pti-auto/posting-34513427/show/
- https://www.heise.de/forum/heise-Security/News-Kommentare/SWAPGS-Details-und-Updates-zur-neuen-Spectre-Luecke-in-Intel-Prozessoren/Learned-lfence/posting-35012333/show/

## Example

```
# grep . /sys/devices/system/cpu/vulnerabilities/*
/sys/devices/system/cpu/vulnerabilities/l1tf:Mitigation: PTE Inversion
/sys/devices/system/cpu/vulnerabilities/mds:Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state unknown
/sys/devices/system/cpu/vulnerabilities/meltdown:Mitigation: PTI
/sys/devices/system/cpu/vulnerabilities/spec_store_bypass:Vulnerable
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointer sanitization
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
```

## T.B.D.
