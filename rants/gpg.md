# `gpg` is unusable cryptography

Well, there is `gpg`.  But it must be initialized.  I really have no idea why.  So I try it with Google.

Use the first hit:

    gpg --full-generate-key

But this does not work, because option `--full-generate-key` is unknown.  If this does not work, it is told to use this:

    gpg --default-new-key-algo rsa4096 --gen-key

However it does not work either, because option `--default-new-key-algo` is not understood.

A later search then returns

    gpg --gen-key

This outputs with following riddle:

    Please select what kind of key you want:
       (1) RSA and RSA (default)
       (2) DSA and Elgamal
       (3) DSA (sign only)
       (4) RSA (sign only)

I try option `(1)`.  This gives me following:

    RSA keys may be between 1024 and 4096 bits long.

WTF?  It is 2018!  Keysize of 2048 is considered to be broken until 2030, so it shall no more be offered.

And DSA is considered insecure is some of the bits used for NONCEs are known, which (according to my reading)
gets more and more likely if you can observe enough signatures done with DSA.  So DSA must be droppe for public things.

Hence the only thing left is the default thing.  So why bother the user with some questions, which can be answered the wrong way?
(Note: GPG shall support everything as before.  However the default should stay secure and hence only offer the most secure way.)

Then later:

    You need a Passphrase to protect your secret key.
    
WTF?  This is an automatich signing key.  So why bother with a passphrase?  This is far too complicated!

Read, it should be done as following:

- If just invoked, it shall abort and tell you, that you either must allow a passphrase or you must tell that there is no passphrase which is insecure.
  However, asking for a passphrase all the sudden is absolutely the wrong way.
- So please, add 2 options to GPG and document those two options if you just call it with `gpg --gen-key`

Now, after all this hassle, I now have a key:

    gpg --list-secret-keys

outputs

    sec   2048R/A62751DD 2018-05-20
    uid                  Valentin Hilbig (Temporary signing key) <webmaster@scylla-charybdis.com>
    ssb   2048R/4976C9BA 2018-05-20

But this

    gbp buildpackage

then still fails:

    Now signing changes and any dsc files...
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    gpg: skipped "Valentin Hilbig <webmaster@scylla-charybdis.com>": secret key not available
    gpg: /tmp/debsign.dqXac67a/json2sh_1.dsc: clearsign failed: secret key not available
    debsign: gpg error occurred!  Aborting....
    debuild: fatal error at line 1295:
    running debsign failed
    gbp:error: 'debuild -i -I' failed: it exited with 29
    
After hours (at least if felt this long) of Googling I found out that this is due to

    $ debsign json2sh_1.dsc
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    gpg: skipped "Valentin Hilbig <webmaster@scylla-charybdis.com>": secret key not available
    gpg: /tmp/debsign.e4uYKsEH/json2sh_1.dsc: clearsign failed: secret key not available
    debsign: gpg error occurred!  Aborting....

WTF?  Why isn't this command printed complete?  Why do you have to first scrape some billion terabyte of documentation (this is what Google does) just to find this?

Now the problem is, how to make

    "Valentin Hilbig <webmaster@scylla-charybdis.com>"
    
out of

    "Valentin Hilbig (Temporary signing key) <webmaster@scylla-charybdis.com>"
    
I really cannot present the correct way how to fix this, but I somehow managed it after an enormous amount of incomprehensible commands.
What I did was (partly):

     gpg --edit-key 4976C9BA
     adduid
     deluid 1
     save

And with "adduid" I needed to re-enter just everything as before, but leave away the comment.
SIGH.  I know what caused this mega-GAU of usability.  I understand what the programmers did.
However I do not accept that.  This is more than plain wrong, this is not only ridiculous, it is plain crap as it is unuable.

Hence, again, a major fail here.  Things must not happen this way.  Period.  And no discussions about that.  This is wrong.
This already was wrong 20 years ago.  It shall never happend this way.  Period.  Again.

Now it works:

    debsign json2sh_1.dsc
     signfile json2sh_1.dsc Valentin Hilbig <webmaster@scylla-charybdis.com>
    Successfully signed dsc file

Who is responsible for this shit and who should be beaten (badly!) due to his major fail?
