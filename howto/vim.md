# Notes and rants about VIM

I really do not understand.  Why is it so complex to explain things?  Or is it only me, perhaps?

## VIM Keyboard shortcuts

(Keyboard-shortcuts which are not found as first hit on Google)

- `K` show `man` of the word under the cursor

## VIM modeline

- `# vim: ft=sh` or `# vim: set ft=sh:` changes file type to `sh`
- `:mks [file]` write current settings to given `file`, default `Session.vim`
- `:map` see keyboard map which differs from standard map
- `:help index` complete keyboard map is in the complete help
- `:set modeline` to enable modeline, see example `.vimrc`

## `.vimrc`

Here is [my somewhat current `.vimrc`](.vimrc)

Install it like this:

	"git" clone https://github.com/hilbix/tino.git "$HOME/git/tino-rants/"
	"ln" --symbolic --backup=t --relative "$HOME/git/tino-rants/howto/.vimrc" "$HOME/.vimrc"


## errorformat

> In Quick: [see script `python3vim.sh`](python3vim.sh)
>
> To your `~/.vimrc` add following two lines:
>
>     nnoremap M :silent make\|redraw!\|cc<CR>
>     set efm+=#%t#%f#%l#%c#%m#
>
> Then create a `Makefile` which runs/tests your code
> and outputs something like:
>
>     #E#filename#line#column#message#
>
> If you press `M` in `vim` (in normal mode) this quickly jumps to the first reported error.
>
> Example `Makefile` using [python3vim.sh](python3vim.sh) to `make love`:
>
>     .PHONY:	love
>     love:
>     	python3vim.sh ./script.py

Errorformat comes very handy if you work with `vim`.  For example if you have following in your `.vimrc`

	nnoremap M :silent make\|redraw!\|cc<CR>

then just pressing `M` lets you jump to the first error encountered.
Which might only take some milliseconds depending on how you constructed your Makefile.

> This can extremely improve your development speed if properly used!

However this needs some output format of the `Makefile` which can be understood by `vim`.
The definitions are in the variable `errorformat`, which is more or less some mystery.
There is documentation about that, but .. it is far too lengthy for my taste.

First on, how you see the format.  Just do:

	:set errorformat

This displays the format.  Now you can see how it looks like.

> I tried to grok http://vimdoc.sourceforge.net/htmldoc/quickfix.html but apparently failed to some extent

I do not think you shall change this format.  Instead it probably is far more efficient,
to just let `make` output something, which `vim` understands.
But to be able, we need to understand, what this beast does.

At my side, I get following

	%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m

WTF?!?  So let's decipher this.  It is a comma separated list of `scanf` type formats (it has few to do with `scanf`, but probably stems from this origin), so do

	tr , '\n' <<'EOF'
	%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m
	EOF

that prints:

	%*[^"]"%f"%*\D%l: %m
	"%f"%*\D%l: %m
	%-G%f:%l: (Each undeclared identifier is reported only once
	%-G%f:%l: for each function it appears in.)
	%-GIn file included from %f:%l:%c:
	%-GIn file included from %f:%l:%c\
	
	%-GIn file included from %f:%l:%c
	%-GIn file included from %f:%l
	%-G%*[ ]from %f:%l:%c
	%-G%*[ ]from %f:%l:
	%-G%*[ ]from %f:%l\
	
	%-G%*[ ]from %f:%l
	%f:%l:%c:%m
	%f(%l):%m
	%f:%l:%m
	"%f"\
	line %l%*\D%c%*[^ ] %m
	%D%*\a[%*\d]: Entering directory %*[`']%f'
	%X%*\a[%*\d]: Leaving directory %*[`']%f'
	%D%*\a: Entering directory %*[`']%f'
	%X%*\a: Leaving directory %*[`']%f'
	%DMaking %*\a in %f
	%f|%l| %m

Reformat this a bit to re-introduce escaped `\,` pairs (that are the stray `\` at the end of the lines):

	%*[^"]"%f"%*\D%l: %m
	"%f"%*\D%l: %m
	%-G%f:%l: (Each undeclared identifier is reported only once
	%-G%f:%l: for each function it appears in.)
	%-GIn file included from %f:%l:%c:
	%-GIn file included from %f:%l:%c\,
	%-GIn file included from %f:%l:%c
	%-GIn file included from %f:%l
	%-G%*[ ]from %f:%l:%c
	%-G%*[ ]from %f:%l:
	%-G%*[ ]from %f:%l\,
	%-G%*[ ]from %f:%l
	%f:%l:%c:%m
	%f(%l):%m
	%f:%l:%m
	"%f"\,line %l%*\D%c%*[^ ] %m
	%D%*\a[%*\d]: Entering directory %*[`']%f'
	%X%*\a[%*\d]: Leaving directory %*[`']%f'
	%D%*\a: Entering directory %*[`']%f'
	%X%*\a: Leaving directory %*[`']%f'
	%DMaking %*\a in %f
	%f|%l| %m

Now, what does this want to tell us?

Interesting things:

- literal characters: `%%` is a `%`, `\,` is a single `,`, everything else matches nearly identical.
- `%-G` are lines which are ignored.
- `%f`, `%l`, `%c` and `%m` are `FILENAME`, `LINE`, `COLUMN` and `MESSAGE` respectively
- `%D` enter directory, so we can track relative filenames
- `%X` leave directory, so we can track relative filenames
- `%t` error type (1 character).  This (probably) is `e` for error, `w` for warning, so `vim` knows what's more important.

Regexp (I am not completely sure that I understood this correctly.  By typing `%` in front of a character it becomes a meta-character?!?  Or is it escaped?):

- `%#` for `*`, `%.` for `.`, `%\\` for `\`, `\^` and `\$` for `^` and `$` (which are not needed), `%[` for `[`, `%~` for `~` (well `~` in regexp?  Does it have a special meaning?).  What is miss is `%{` and `%(`.  Well oh well, confusing: "The \(...\) grouping of sub-matches can not be used in format specifications because it is reserved for internal conversions."  (Doh!?  WTF?!?)

- `"%\\d%\\+" ("\d\+", "any number") is equivalent to "%*\\d"` here you got me naked even without skalp.  Ouch, I do not understand, sorry.

Multiline error formats:

- `%E` starts a multiline error (`%W` for warning, `%I` for info, `%A` for .. what?).  Now more formats follow until the last one, which is marked with `%Z`

Less interesting things:

- `%v` is the same as `%c`, but when TABs are expanded (**v**isual column)
- `%n` error number (number)
- `%p` pointer (interpolates a pointer like `--------------------^` to find `%c`)
- `%*{conf}` ignored data of a certain format in `scanf` like notation

What I did not understand from reading the VIM manual:

- `%P`, `%Q` are somewhat understandable, but `%O`?!?  Also why `%+P`..`%-Q`
- `%+` and `%-` looks quite puzzling, as they tell from "include/exclude in output", but in the examples there is nothing showing up which might represent that fact.
- `%r` "matches the rest of a single line file message %O/P/Q" *wants to tell me .. what?*
- `%s` "search text" *seems to be used to locate the error and then applies some more or less incomprehensible magic*
- `%>` "for next line start with current pattern again" *wants to tell me .. what?*  The explanation section leave me in the dark, completely, I simply do not understand what they want to tell me and what I find there raises more questions without answering any.

What I could not find or is very badly explained:

- `%*\a` and similar: WTF is this?  Where can I read about it?
- `%*[chars]` optional chars.  (single or multiple?  Not explained.  Seems to depend on some context which is not explained either.)
- `\d` seems to be "digit"
- `\D` seems to be "anythings but digit"
- `\a` seems to be "anything"

Now to the major formats:

- `%*[^"]"%f"%*\D%l: %m`: `nonquotes"FILENAME"nondigitsLINE: MESSAGE`
- `"%f"%*\D%l: %m`: `"FILENAME"nondigitsLINE: MESSAGE` (apparently the same without leading trash)
- `%f:%l:%c:%m`: `FILENAME:LINE:COLUMN:MESSAGE` - well known for C
- `%f(%l):%m`: `FILENAME(LINE):MESSAGE`
- `%f:%l:%m`: `FILENAME:LINE:MESSAGE`
- `"%f"\,line %l%*\D%c%*[^ ] %m` is `"FILENAME",line LINEnondigitsCOLUMNnonspc MESSAGE`
- `%f|%l| %m` is `FILENAME|LINE| MESSAGE`

Conclusion:

I do not know why `errorformat` looks like that.  And I think it may change for some reason or another by some magic happening in the background.  Hence I cannot rely on it.

My goal was to just transform the output to something, VIM understands reliably.  But I failed.
Sadly there seems to be no really generic guaranteed line format in there, so I had to introduce some myself.


## FAQ

How did you find out?

- I didn't.  This was created the hard way with just trial and error after giving up.

Why `#` as a separator?

- Because `:` would match other messages quite too easliy, and I did not find out how to work around this.
- Also `#` protects the output against accidental pasting in a shell
