TL;DR:

    DEBCONF_DEBUG=developer dpkg -D2 --configure --pending

> WTF?  I could not find any suitable documentation about this matter?!?
> Only some broken bits of more or less broken parts which do not fit together at all.
>
> So here is how.


# Debugging Debian `postinst` and similar

> `$PACKAGE` or `${PACKAGE}` stands for the package to debug

    dpkg: error processing package $PACKAGE (--configure):
    installed $PACKAGE package post-installation script subprocess returned error exit status 10

And now?


## Debugging steps

Wash:

    # DEBIAN_FRONTEND=readline dpkg -D2 --configure --pending
    Setting up $PACKAGE (4.0~0lhm2) ...
    D000002: fork/exec /var/lib/dpkg/info/$PACKAGE.postinst ( configure  )
    dpkg: error processing package $PACKAGE (--configure):
    installed $PACKAGE package post-installation script subprocess returned error exit status 10
    dpkg: dependency problems prevent configuration of $OTHERPACKAGE:

Rinse:

    vim /var/lib/dpkg/info/$PACKAGE.postinst
    # add some "set -x" or debugging outputs

Repeat:

    # DEBIAN_FRONTEND=readline dpkg -D2 --configure --pending
    Setting up $PACKAGE (4.0~0lhm2) ...
    D000002: fork/exec /var/lib/dpkg/info/$PACKAGE.postinst ( configure  )
    + . /usr/share/debconf/confmodule
    + [ !  ]
    + PERL_DL_NONLAZY=1
    + export PERL_DL_NONLAZY
    + [  ]
    + exec /usr/share/debconf/frontend /var/lib/dpkg/info/$PACKAGE.postinst configure 
    dpkg: error processing package $PACKAGE (--configure):
    installed $PACKAGE package post-installation script subprocess returned error exit status 10
    dpkg: dependency problems prevent configuration of $OTHERPACKAGE:

So the problem in this case is with Debconf parameters.

## Debugging Debconf parameters

Wash:

    # DEBCONF_DEBUG=developer DEBIAN_FRONTEND=readline dpkg -D2 --configure --pending
    Setting up $PACKAGE (4.0~0lhm2) ...
    D000002: fork/exec /var/lib/dpkg/info/$PACKAGE.postinst ( configure  )
    + . /usr/share/debconf/confmodule
    + [ !  ]
    + PERL_DL_NONLAZY=1
    + export PERL_DL_NONLAZY
    + [  ]
    + exec /usr/share/debconf/frontend /var/lib/dpkg/info/$PACKAGE.postinst configure 
    debconf (developer): frontend started
    debconf (developer): frontend running, package name is $PACKAGE
    debconf (developer): starting /var/lib/dpkg/info/$PACKAGE.config configure 
    debconf (developer): <-- INPUT $PARAMETER
    debconf (developer): --> 20 Incorrect number of arguments

Rinse:

     vim /var/lib/dpkg/info/$PACKAGE.config
     # correct db_input looks like:
     # db_input medium $PACKAGE/$PARAMETER

Repeat!

## Debugging strange parameters

Sometimes updates introduce new errors due to parametrization which worked before.  Then you need to do more, here an example with `couchdb`:

```
DEBIAN_SCRIPT_DEBUG=true DEBIAN_SCRIPT_TRACE=true DEBCONF_DEBUG=developer dpkg -D2 --configure --pending
```
```
Setting up couchdb (3.5.0~jammy) ...
D000002: fork/exec /var/lib/dpkg/info/couchdb.postinst ( configure 3.4.3.2~jammy )
+ set -e
+ . /usr/share/debconf/confmodule
+ [ !  ]
+ PERL_DL_NONLAZY=1
+ export PERL_DL_NONLAZY
+ [  ]
+ exec /usr/share/debconf/frontend /var/lib/dpkg/info/couchdb.postinst configure 3.4.3.2~jammy
debconf (developer): frontend started
debconf (developer): frontend running, package name is couchdb
debconf (developer): starting /var/lib/dpkg/info/couchdb.config configure 3.4.3.2~jammy
+ DEBIAN_SCRIPT_TRACE=1
${DEBIAN_SCRIPT_TRACE:+ echo "#42#DEBUG# RUNNING $0 $*" 1>&2 }
+ echo #42#DEBUG# RUNNING /var/lib/dpkg/info/couchdb.config configure 3.4.3.2~jammy 1>&2
#42#DEBUG# RUNNING /var/lib/dpkg/info/couchdb.config configure 3.4.3.2~jammy 1>&2

# prompt for password + confirmation until we get matching entries
# or an empty password
promptpass() {
  while :; do
    RET=""
    db_input high couchdb/adminpass || true
    db_go
    db_get couchdb/adminpass
    # if password isn't empty we ask for password verification
    if [ -z "$RET" ]; then
      break
    fi
    ADMIN_PW="$RET"
    db_input high couchdb/adminpass_again || true
    db_go
    db_get couchdb/adminpass_again
    if [ "$RET" = "$ADMIN_PW" ]; then
      ADMIN_PW=''
      break
    fi
    db_fset couchdb/adminpass_mismatch seen false
    db_input critical couchdb/adminpass_mismatch
    db_set couchdb/adminpass ""
    db_set couchdb/adminpass_again ""
    db_go
  done
}

promptbind() {
  while :; do
    RET=""
    db_input high couchdb/bindaddress || true
    db_go
    db_get couchdb/bindaddress
    # don't allow whatever is passed in
    if [ "$RET" != "$1" ]; then
      break
    fi
    db_fset couchdb/bindaddress seen false
  done
}

promptcookie() {
    while :; do
        RET=""
        db_input high couchdb/cookie || true
        db_go
        db_get couchdb/cookie
        if [ -z "$RET" ]; then
            db_input critical couchdb/no_cookie
            db_fset couchdb/cookie seen false
        elif [ "$RET" = "monster" ]; then
            db_input critical couchdb/no_cookie_monsters
            db_fset couchdb/cookie seen false
        else
            break
        fi
    done
}

# if they exist, make current settings debconf's defaults
if [ -e /opt/couchdb/etc/vm.args ] ; then
  cookie="$(grep '^-setcookie' /opt/couchdb/etc/vm.args | cut -d ' ' -f 2 | stripwhitespace | stripquote)"
  nodename="$(grep '^-name' /opt/couchdb/etc/vm.args | cut -d ' ' -f 2 | stripwhitespace | stripquote)"
  if [ -n "$cookie" ]; then
      db_set couchdb/cookie "${cookie}"
  fi
  if [ "${nodename}" != "couchdb@127.0.0.1" ]; then
    db_set couchdb/nodename "${nodename}"
  fi
fi
+ [ -e /opt/couchdb/etc/vm.args ]
+ grep ^-setcookie /opt/couchdb/etc/vm.args
+ cut -d   -f 2
+ + sed -e s/^[[:blank:]]*// -esed s/[[:blank:]]*$// -e
 s/^\x27*// -e s/\x27*$//
+ cookie=COOKIECOOKIE
COOKIECOOKIE
+ grep ^-name /opt/couchdb/etc/vm.args
+ cut -d   -f 2
+ sed -e s/^[[:blank:]]*// -e s/[[:blank:]]*$//
+ sed -e s/^\x27*// -e s/\x27*$//
+ nodename=couchdb@127.0.0.1
+ [ -n COOKIECOOKIE
COOKIECOOKIE ]
+ db_set couchdb/cookie COOKIECOOKIE
COOKIECOOKIE
+ _db_cmd SET couchdb/cookie COOKIECOOKIE
COOKIECOOKIE
+ _db_internal_IFS= 	

+ IFS= 
+ printf %s\n SET couchdb/cookie COOKIECOOKIE
COOKIECOOKIE
+ IFS=

+ read -r _db_internal_line
debconf (developer): <-- SET couchdb/cookie COOKIECOOKIE
debconf (developer): --> 0 value set
debconf (developer): <-- COOKIECOOKIE
+ IFS= 	

+ RET=value set
+ return 0
+ [ couchdb@127.0.0.1 != couchdb@127.0.0.1 ]
if [ -e /opt/couchdb/etc/local.ini ]; then
  addr=$(sed -n '/^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; }' /opt/couchdb/etc/local.ini | stripwhitespace | stripquote)
  if [ -n "$addr" ]; then
    bindaddress=$addr
    db_set couchdb/bindaddress "${bindaddress}"
  fi
fi
+ [ -e /opt/couchdb/etc/local.ini ]
+ sed -n /^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; } /opt/couchdb/etc/local.ini
+ sed -e s/^[[:blank:]]*// -e s/[[:blank:]]*$//
+ sed -e s/^\x27*// -e s/\x27*$//
+ addr=
+ [ -n  ]
# might be overridden by a local.d file
if [ -d /opt/couchdb/etc/local.d ] && ls /opt/couchdb/etc/local.d/*.ini >/dev/null 2>&1; then
  for f in $(ls /opt/couchdb/etc/local.d/*.ini); do
    addr=$(sed -n '/^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; }' $f | stripwhitespace | stripquote)
    if [ -n "$addr" ]; then
      bindaddress=$addr
      db_set couchdb/bindaddress "${bindaddress}"    
    fi
  done
fi
+ [ -d /opt/couchdb/etc/local.d ]
+ ls /opt/couchdb/etc/local.d/10-admins.ini /opt/couchdb/etc/local.d/90-tino.ini /opt/couchdb/etc/local.d/99-tino.ini
+ ls /opt/couchdb/etc/local.d/10-admins.ini /opt/couchdb/etc/local.d/90-tino.ini /opt/couchdb/etc/local.d/99-tino.ini
+ sed -n /^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; } /opt/couchdb/etc/local.d/10-admins.ini
+ sed -e s/^[[:blank:]]*// -e s/[[:blank:]]*$//
+ sed -e s/^\x27*// -e s/\x27*$//
+ addr=
+ [ -n  ]
+ sed -n /^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; } /opt/couchdb/etc/local.d/90-tino.ini
+ sed -e s/^[[:blank:]]*// -e s/[[:blank:]]*$//
+ sed -e s/^\x27*// -e s/\x27*$//
+ addr=
+ [ -n  ]
+ sed -n /^\[chttpd\]/, /^\[/ { /^;/d; /bind_address =/ s/.*=//p; } /opt/couchdb/etc/local.d/99-tino.ini
+ sed -e s/^[[:blank:]]*// -e s/[[:blank:]]*$//
+ sed -e s/^\x27*// -e s/\x27*$//
+ addr=
+ [ -n  ]

db_input high couchdb/mode || true
+ db_input high couchdb/mode
+ _db_cmd INPUT high couchdb/mode
+ _db_internal_IFS= 	

+ IFS= 
+ printf %s\n INPUT high couchdb/mode
+ IFS=

+ read -r _db_internal_line
debconf (developer): <-- INPUT high couchdb/mode
+ IFS= 	

+ RET=20 Unsupported command "COOKIECOOKIE" (full line was "COOKIECOOKIE") received from confmodule.
+ return 20
+ true
db_go
+ db_go
+ _db_cmd GO 
+ _db_internal_IFS= 	

+ IFS= 
+ printf %s\n GO 
+ IFS=

+ read -r _db_internal_line
debconf (developer): --> 30 question skipped
debconf (developer): <-- GO 
+ IFS= 	

+ RET=30 question skipped
+ return 30
debconf (developer): --> 0 ok
dpkg: error processing package couchdb (--configure):
 installed couchdb package post-installation script subprocess returned error exit status 128
debconf (developer): frontend started
debconf (developer): Trying to find a templates file..
debconf (developer): Trying /usr/share/debian-security-support/check-support-status.hook.templates
debconf (developer): Trying /usr/share/debconf/templates/check-support-status.hook.templates
debconf (developer): Couldn't find a templates file.
debconf (developer): frontend running, package name is 
debconf (developer): starting /usr/share/debian-security-support/check-support-status.hook
Errors were encountered while processing:
 couchdb
```

What happened?  Well the `COOKIECOOKIE` cookie was doubled in the parameters and the script apparently fails (bug!) with Newlines in parameters!  As this fails, too, we need something else:

```
root@neuron-ubuntu:~# dpkg-reconfigure couchdb
/usr/sbin/dpkg-reconfigure: couchdb is broken or not fully installed
```

This:

```
# debconf-show couchdb
* couchdb/adminpass: (password omitted)
* couchdb/adminpass_again: (password omitted)
  couchdb/nodename: couchdb@localhost
* couchdb/cookie: COOKIECOOKIE
  couchdb/adminpass_mismatch:
* couchdb/mode: standalone
  couchdb/no_cookie:
  couchdb/error_setting_password:
* couchdb/bindaddress: 127.0.0.1
  couchdb/postrm_remove_databases: false
  couchdb/no_cookie_monsters:
  couchdb/have_1x_databases:
```

No newline here!?!  Now check the wrong line above, this is following in the script:

```
  cookie="$(grep '^-setcookie' /opt/couchdb/etc/vm.args | cut -d ' ' -f 2 | stripwhitespace | stripquote)"
```

For some unknown reason, the line was doubled in the argument file:

```
grep '^-setcookie' /opt/couchdb/etc/vm.args
```
```
-setcookie 'COOKIECOOKIE'
-setcookie 'COOKIECOOKIE'
```

Fixing that (`vim /opt/couchdb/etc/vm.args`) and it works again!  Hooray!


## Any questions?

Yes.  Why doesn't `dpkg` have a debug switch to run `postinst` and the like with option `-x` or similar?
