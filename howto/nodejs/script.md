# Howto `nodejs` scripting

What is scripting?  Scripting is usually done using a shell.  However you also can script with nodejs.

Here is a quick skeleton example script:

```
#!/usr/bin/env nodejs
'use strict';

function OOPS(...s) { console.error('OOPS', ...s); process.exit(23) }
function LOG(...s) { console.log(...s) }
function ASSERT(b, ...s) { if (!b) OOPS('assertion failed:', ...s) }
function FATAL(b, ...s) { if (b) OOPS('FATAL', ...s) }
function STDOUT(...s) { process.stdout.write(s.join('')) }
function STDERR(...s) { process.stderr.write(s.join('')) }
function Sleep(ms) { return new Promise(_ => setTimeout(_,ms)) }

async function main(...args)
{
//  throw 'hw';
//  return 1;
  console.log('[START]', args);
  while (running) await Sleep(333).then(_ => STDOUT('.'));                                                                                                      
  console.log('[END]');
}

var running=1; process.stdin.on('data', _ => running = 0);
main(...process.argv.slice(1)).then(_ => process.exit(!_ ? 0 : (_&255) ? (_&255) : 1)).catch(OOPS);
```

This does following:
- It calls `main(...args)` like in `C` or in shell: `args[0]` is `$0`, `args[1]` is `$1` and so on
- Asynchronous code is fully supported
- return value of `main()` is used for exit purpose.
  - If the return value of `main()` is falsey, 0 is returned
  - If the return value of `main()` is truthy, return is kept in the range 1..255 (with 1 as default)
- If `main` returns, it tears down the whole process
  - This is usually what you want.
  - Let `main()` return a promise if you need to wait for asynchronous stuff
- There are some helping wrappers for things you usually want.
- It suppresses ugly stack traces in case `main()` throws
- It registers some global variable `running`.
  - This variable becomes `false` when you press `Return`.
  - Note that it reacts on any input, but by default the terminal is line buffered, so stdin is sent to `nodejs` on `Return`.
  - You can enter `SPC` (or some other character) followed by `Ctrl+D` (AKA `EOF`) as well to make `running` become `false`.
