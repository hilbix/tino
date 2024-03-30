# Hyper-V

## Activate Hyper-V under Windows 11

This is only needed for Windows Home variants.  In Windows Pro you can add it via Optional Features.

> From <https://www.deskmodder.de/blog/2018/08/23/windows-10-home-hyper-v-aktivieren/>

Save following file to `c:\temp\hyper-v.bat`:
```
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
```

- Run it as Administrator.
  - It runs 10 minutes or so.
- Afterwards restart your computer
