#!/bin/bash
#
# Run
#	watch python3vim.sh
# Add in ~/.vimrc:
#	nnoremap M :silent make\|redraw!\|cc<CR>
#	set efm+=#%t#%f#%l#%c#%m#
# Add a first rule to Makefile:
#	.PHONY:	love
#	love:
#		python3vim.sh ./python-script.py
# Now run vim and in vim press:
#	M
# This then jumps to the first error encounted.

OUT="/tmp/$USER-python3lasterrors.out"

send()
{
{
printf -v v ' %q' "$@"
printf '#%q' "${@:1:4}"
printf '#%s#\n' "${v:1}"
} >&2
}

note()	{ send I "$@"; }
warn()	{ send W "$@"; }
err()	{ send E "$@"; }

parseerrors()
{
have=false
awk '
function ok()
{
if (!armed) return;

sub(/^[^"]*"/,"",err);

file=err

gsub(/",.*$/, "", file);
sub(/.*",[[:space:]]*line[[:space:]]*/, "", err);
gsub(/, in.*$/,"", err);

print "#E#" file "#" err "#" length(d[2]) "#" $0 "#"
}

/^[^[:space:]]/				{ ok(); armed=0; }
/^Traceback \(most recent call last\):/	{ next }

/^  File/ && $2!~/\/usr\//	{ err=$0; delete have; armed=1; next }
armed		{ d[armed++]=$0; next }

END			{ ok() }
'
$have && note "$OUT" 0 0 location of original error log
$have && note "$0" 14 14 Running python3 "$@" >&2
}

catcherrors()
{
trap 'mv -f "$OUT.$$" "$OUT"' 0
tee "$OUT.$$" >(parseerrors)
mv -f "$OUT.$$" "$OUT"
trap '' 0
}

if 	[ 0 = $# ]
then
	# run this without arguments as watch, probably

	parseerrors < "$OUT"
	echo
	echo -------------------
	echo
	cat "$OUT"
else
	( python3 "$@" 2> >(catcherrors) || warn "$1" 0 0 failed ) | cat	# cat synchronizes
	sed 's/^/### /' "$OUT"
fi

