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
    # add some "set -e" or debugging outputs

Repeat!
