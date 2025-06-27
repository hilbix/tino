#!/bin/bash
#
# vim: ft=bash
#
# Pull GitHub asset links into the repo itself
#
# Version for 2025, YMMV (it was different in past and probably will change in future, too)

cd "$(dirname -- "$0")" || exit

STDOUT() { printf %q "$1"; printf ' %q' "${@:2}"; printf \\n; }
STDERR() { STDOUT "$@" >&2; }
OOPS() { STDERR OOPS: "$@"; exit 23; }
x() { "$@"; }
o() { x "$@" || OOPS fail $?: "$@"; }
v() { local -n ____="$1"; ____="$(x "${@:2}")ERROR" && ____="${____%ERROR}"; }		# removes only the added \n a single time
r() { "${@:2}" < "$1"; }
w() { "${@:2}" > "$1"; }

# Disguise the URL a bit, so grep below does not fetch it just by chance
URL='https://github.com/user-att'achments/

mime-img()
{
  local e="${2##*/}"
  mime="image/$e"		# image/EXT from                  mime */EXT
  out="${1##*/}.$e"		# UUID.EXT  from assets/$UUID and mime */EXT
}

mime-file()
{
  mime="application/${1##*.}"	# EXT      from files/NR/name.EXT
  out="${1##*/}"		# NAME.EXT from files/NR/NAME.EXT
}

while	read -ru6 -d '' file;								# grep sends NUL terminated filenames
do
	while	read -ru6 asset;
	do
		[ -z "$asset" ] && continue;						# remove the safety \n introduced by the asset extraction

		o v TMP1 mktemp;
		o v TMP2 mktemp;
		o v TMP3 mktemp;

		# all OK.
		# asset=assets/UUID		for images
		# asset=file/NR/name.ext	for other uploaded files
		case "$asset" in
		(assets/*)	type=img;;
		(files/*/*.*)	type=file;;
		(*)		OOPS cannot understand: "$asset";;
		esac

		# fetch asset into TMP1 with headers in TMP2 and status in TMP3
		o v CODE curl -g --location --output "$TMP1" --dump-header "$TMP2" -w '%{exitcode} %{size_download} %{content_type}' -- "$URL$asset";
		o read a b c <<<"$CODE";						# exitcode size_download content_type
		o v count r "$TMP1" wc -c;						# real count on filesystem

		mime=MUSTbeSETinMIME-$type
		out=MUSTbeSETinMIME-$type
		o "mime-$type" "$asset" "$c";						# extract the matching mime type

		# this deliberately fails when we do not get an image
		# as this script is not yet prepared for anything else
		o test ".0 $count $mime" = ".$a $b $c";					# check the result being an image of correct size and type
		o fgrep -qix "content-length: $b"$'\r' "$TMP2";				# check the size in headers

		DIR="${file%/*}/$type"
		abs="$URL$asset"
		OUT="$DIR/$out"								# out is set above in mime-$type
		rel="$type/$out"

		[ -d "$DIR" ] || o mkdir "$DIR";					# create the image directory

		# this fails if the image happens to already exist
		x cmp -s "$TMP1" "$OUT" || o cp --backup=t "$TMP1" "$OUT";		# copy the image into repo
		o sync;									# dont become inconsistent on sudden power outage below

		git add "$OUT";								# do not forget to add these

		# now that we have the image in the repo, replace the link in the source to it
		o sed -i "s (${abs//./\\.}) ($rel) g" "$file";				# replace the asset link (git tracks the change, so no backup needed)


		o rm -f "$TMP1" "$TMP2" "$TMP3";					# cleanup (on sudden reboot the reboot does the cleanup for us)

	done 6< <(o sed -n "s .*(${URL//./\\.}\\([^)]*\\)).* \1\\n gp" "$file");	# extract unwanted asset references

done 6< <(x grep --null -l -r "$URL" *);						# iterate over all files with asset links

o git status --porcelain;

