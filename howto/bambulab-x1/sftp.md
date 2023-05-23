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