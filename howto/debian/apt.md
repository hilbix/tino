# HowTo apt

Some quirks about `apt`

## `apt-key update` does not work

Symptom after some debian-buster-minimal install:

```
# apt-get update
Get: 1 http://deb.debian.org/debian buster InRelease [121 kB]                                                                                              
Err http://deb.debian.org/debian buster InRelease                                                                                                          
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517    
Fetched 121 kB in 0s (331 kB/s)                                                                                                                                              
W: GPG error: http://deb.debian.org/debian buster InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBK
EY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517                                                                                                    
E: The repository 'http://deb.debian.org/debian buster InRelease' is not signed.                                                                           
E: Failed to download some files                                                                                                                                             
W: Failed to fetch http://deb.debian.org/debian/dists/buster/InRelease: The following signatures couldn't be verified because the public key is not availab
le: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY DCC9EFBF77E11517                                                                                         
E: Some index files failed to download. They have been ignored, or old ones used instead.                                                                                    
```

And

```
# apt-key update
Warning: 'apt-key update' is deprecated and should not be used anymore!
Note: In your distribution this command is a no-op and can therefore be removed safely.
```

It only looks like only 250% of all tutorials about `apt NO_PUBKEY` in the Internet reference `apt-key update`, hence you disable this command.
Wohooo!  Very well done!  

> Spoiler: This was sarcasm.
>
> Looks like SystemD has gone a bit too viral now, no?

The trick is, to do it as follows now:

```
# apt-key add /etc/apt/trusted.gpg.d/*.gpg
OK
```

Now it works:

```
# apt-get update
Get:1 http://deb.debian.org/debian buster InRelease [121 kB]
Get:2 http://deb.debian.org/debian buster/main amd64 Packages [7906 kB]
Get:3 http://deb.debian.org/debian buster/main Translation-en [5968 kB]
Fetched 14.0 MB in 3s (5563 kB/s)
Reading package lists... Done
```

A last word to say:  **WTF?!?**
