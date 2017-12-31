#!/bin/bash
#
# Run
#	watch python3vim.sh
# Add in ~/.vimrc:
#	nnoremap M :silent make\|redraw!\|cc<CR>
#	set efm+=#%t#%f#%l#%c#%m#
# Add in Makefile:
#	rule:
#		python3vim.sh command-running-some-python3-code
# Now run vim and in vim press:
#	M

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
/^Traceback \(most recent call last\):/	{ armed=1; next }

armed && /^  File/	{ err=$0; delete have; armed=1; next }
armed			{ d[armed++]=$0; next }

END			{ ok() }
'
$have && note "$OUT" 0 0 location of original error log
$have && note "$0" 14 14 Running python3 "$@" >&2
}

catcherrors()
{
tee "/tmp/$USER-python3lasterrors.out" |
parseerrors
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
	python3 "$@" 2> >(catcherrors) || warn "$1" 0 0 failed
	
fi

