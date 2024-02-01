> THIS RECIPE currently is just a braindump, SO UNTESTED

# Some SVN howto

I do not use SVN.  But I use WebDAV.  This uses SVN as a backend.

## Getting rid of recent commits

WebDAV creates one revision per change.  If you upload shit to it,
and detect it in time to prune the shitty commits, here is how.

> This is based on https://stackoverflow.com/a/1627648/490291

```
cd /srv/dav/svn           # this is where your SVN service lives
systemctl stop apache2    # stop the WebDAV service
# from here be sure nothing might access your SVN service files

svnlook history . | head  # list the history
# Put the very last SVN revision into a variable
LASTREV=98765

# Now locate the last revision which is sound
for a in {LASTREV..0}; do printf '%d ' "$a"; svnlook changed -r $a --copy-info .; done
# Say the last revision is something like 43210
OKREV=43210

# WARNING!  DANGER FOLLOWS.  This resets the TIP to OKREV
echo $OKREV > db/current

# WARNING!  FOLLOWING REMOVES ALL THE EXZESS REVISIONS, SO THE DATA WILL VANISH!
KICK=$OKREV;
while  let KICK++; [ $KICK -le $LASTREV ]; do rm -f db/revs/$[KICK/1000]/$KICK; done
rmdir db/revs/*

# Now the important last step
svnadmin recover .

# Check that everything is OK now
svnadmin verify .

# Reenable everything again
systemctl start apache2
```

