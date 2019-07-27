#!/bin/bash
#
# bash2vim ./script args

exec 3>&1
ret="$(
exec 4>&1
{
{ "$@" 2>&1 1>&3 3>&- 4>&-; echo "$?" >&4; } |
awk '
/: line /	{
		n=$0;
		gsub(/:.*$/,"",n);

		sub(/^.*: line /,"",$0);

		l=$0;
		gsub(/:.*$/,"",l);

		sub(/^.*: /,"",$0);

		printf("#E#%s#%d#0#%s#\n", n, l, $0);
		next;
		}
		{ print }
' >&2
echo -n ''
} 2>&1 | cat >&2	# cat synchronizes
)"

[ 0 = $ret ] || printf '#W#%q###returns error code %d#\n' "$1" "$ret"

