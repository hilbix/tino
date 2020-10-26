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

    # dpkg -D2 --configure --pending
    Setting up $PACKAGE (4.0~0lhm2) ...
    D000002: fork/exec /var/lib/dpkg/info/$PACKAGE.postinst ( configure  )
    dpkg: error processing package $PACKAGE (--configure):
    installed $PACKAGE package post-installation script subprocess returned error exit status 10
    dpkg: dependency problems prevent configuration of $OTHERPACKAGE:

Rinse:

    vim /var/lib/dpkg/info/$PACKAGE.postinst
    # add some "set -x" or debugging outputs

Repeat:

    # dpkg -D2 --configure --pending
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

    # DEBCONF_DEBUG=developer dpkg -D2 --configure --pending
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


## Any questions?

Yes.  Why doesn't `dpkg` have a debug switch to run `postinst` and the like with option `-x` or similar?
