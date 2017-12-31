# Notes and rants about VIM

I really do not understand.  Why is it so complex to explain things?  Or is it only me, perhaps?

## errorformat

Errorformat comes very handy if you work with `vim`.  Vor example if you have following in your `.vimrc`

	nnoremap M :silent make\|redraw!\|cc<CR>

then just pressing `M` lets you jump to the first error encountered.
Which might only take some milliseconds depending on how you constructed your Makefile.

> This can extremely improve your development speed if properly used!

However this needs some output format of the Makefile which can be understood by `vim`.
The definitions are in the variable `errorformat`, which is more or less some mystery.
There is documentation about that, but .. it is far too lengthy for my taste.

First on, how you see the format.  Just do:

	:set errorformat

This displays the format.  Now you can see how it looks like.

I do not think you shall change this format.  Instead it probably is far more efficient,
to just let `make` output something, which `vim` understands.
But to be able, we need to understand, what this beast does.

At my side, I get following

		%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m

WTF?!?  So let's decipher this.  It is a comma separated list, so do

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

