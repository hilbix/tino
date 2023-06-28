# Bambulab X1 sftp

## First

- Find out your `$ACCESSCODE`.  It is printed on the networking settings on the display of the printer.
- Find out the `$PRINTERIP` of your printer.  It's shown there, too.

Under Unix you can put both into the environment:

```
ACCESSCODE=xxxxx
PRINTERIP=yyyyyy
```

Then the below command works out of the box.


## Linux `lftp`

```
sudo apt install lftp
```

then

```
lftp -e 'set ssl:verify-certificate no' -u "bblp:$ACCESSCODE" "ftps://$PRINTERIP/"
```

I did not find a way to use the self signed certificate's ca cert safely with lftp, sorry.

Perhaps there is a way to just accept the cert of the printer,
but I am apparently too dumb to understand how this can be archived with lftp, sorry.

> Read: As always the documentation does not tell you how to handle the most common case
> "self-signed-certs" properly.  Perhaps because there is none?

Alternatively:

	lftp -e 'set ssl:verify-certificate no' "ftps://bblp:$ACCESSCODE@$PRINTERIP/"

Or (**not recommended**) disable SSL verification entirely:

	echo set ssl:verify-certificate no >> ~/.lftprc

> There are two possible locations of this file:
>
> - `~/.lftprc` (which takes precedence)
> - `~/.lftp/rc`
>
> I only note this here, because there is no manual for `lftp` on my system. YMMV

then

 	lftp "ftps://bblp:$ACCESSCODE@$PRINTERIP/"

> Changing the `rc` is **not recommended**, as this disables verification for all connections!
