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
#		python3vim.sh ./python-script.py args..
# Now run vim and in vim press:
#	M
# This then jumps to the first error encounted.
#
# Now also support (a bit): PYTHONPATH=path python3vim.sh -m module args..

OUT="/tmp/$LOGNAME-python3lasterrors.out"

send()
{
printf -v v ' %q' "${@:5}"
printf '#%q' "${@:1:4}"
printf '#%s#\n' "${v:1}"
}

note()	{ send I "$@"; }
warn()	{ send W "$@"; }
err()	{ send E "$@"; }

parseerrors()
{
have=false
awk '
function setfile()
{
sub(/^[^"]*"/,"");
f = $0
sub(/.*",[[:space:]]*line[[:space:]]*/, "");
gsub(/, in.*$/,"");

gsub(/",.*$/, "", f);
e = getline x < f;
close(f);

if (e<0) return;

file  = f;
line  = $0;
armed = 1;
}
function ok()
{
if (!armed) return;

print "#E#" file "#" line "#" length(d[2]) "#" $0 "#";
armed = 0;
have  = 1;
}

/^[^[:space:]]/				{ ok() }
/^Traceback \(most recent call last\):/	{ next }

/^  File/ && $2!~/\/usr\//		{ setfile(); delete d; next }
armed					{ d[armed++]=$0; next }

END			{ ok(); exit(have) }
' || have=true;
$have && note "$OUT" 0 0 location of original error log
$have && note "$0" 82 2 Running python3 "$@"
}

catcherrors()
{
trap 'mv -f "$OUT.$$" "$OUT"' 0
tee "$OUT.$$" | parseerrors "$@"
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
	tail -30 "$OUT"
else
	PYTHONUNBUFFERED=on python3 "$@" 2> >(catcherrors "$@") | cat	# cat waits for (catcherrors) to return
	ret=${PIPESTATUS[0]}
	if [ '.-m' = ".$1" ]
	then
		shift
		# python3vim.sh -m module args..
		module="${PYTHONPATH%%:*}"
		module="${module:-.}/$1/__main__.py"
		[ -f "$module" ] && set -- "$module"
	fi
	[ 0 = $ret ] || warn "$1" 0 0 failed: $ret
	cat "$OUT"
fi

