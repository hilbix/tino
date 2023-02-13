# WebDav

WebDAV is a filesystem which works with many clients.

> But I did not manage to get it running with Windows 11


## Linux Server with SVN

There is some interesting package:

- Apache
- WebDAV
- SVN

The interesting part here is, that it comes with Autoversioning.

Hence even if it is anonymously writable, no harm can be done as I always have the full history.


### Notes

If you have some proxies in front of Apache, be sure to configure big enough data sizes to allow WebDAV-Clients to store bigger files.

- NginX needs something like `client_max_body_size 1G;`
  - It can go in the top of your file in `/etc/nginx/sites-enabled/`, right before `server {`.
- According to the Apache Manual `The "normal" LimitRequestBody directive has no effect on DAV requests.`
  - Hence you do not need to change anything in Apache itself


### Apache

> This is not really complete

At my site Apache always sits behind HaProxy, NginX or both:

`/etc/nginx/site-enabled/web`
```
server {
	listen 80 default_server;
	listen [::]:80 default_server;
	server_name _;

	root /var/www/html;

	index index.html;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

	location /pub/ {
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_pass http://127.0.0.1:8000;
	}
	location ~ /\.ht {
		deny all;
	}
}
```

`/etc/apache2/site-enabled/100-dav-svn.conf`
```
<VirtualHost 127.0.0.1:8000>
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        TKTAuthSecret -

        SVNCompressionLevel 9
        
        <Location /pub>
                DAV svn
                SVNPath /srv/dav/svn
                SVNAutoversioning On

# WTF https://serverfault.com/a/205608/59497
                AuthType None
                require valid-user
                TKTAuthGuestLogin on
                TKTAuthGuestUser tino

                ModMimeUsePathInfo On
        </Location>
</VirtualHost>
```

Init:

```
cd /opt/dav &&
svnadmin create svn &&
chown -R www-data:www-data svn
```

## Linux Client

### DAVfs2

> **I do not recommend to use DAVfs2, because it looks very broken to me.**  
> In contrast GVFS (Nautilus) works as expected!

This goes on the client (Linux)

`/etc/davfs2/davfs2.conf`
```
ask_auth 0
use_locks 0
delay_upload 1
minimize_mem 1
```

> **WARNING!** If these options are not set, **DAVfs2 will destroy data**!
> It only creates empty files, but pretends that everything is OK.  
> It even allows to verify the contents for long enough that you will not notice data is lost! 
> **I am not sure that I found the correct settings, there might be still things missing!**  
> For me it looks like the defaults of DAVfs2 are set to cause maximum possible harm!
>
> Also DavFS2 is extremely asynchronous.  It may take years for your files to make it correctly to the other side.
> So always verify through other means (i.E. curl), and **do not trust DAVfs2**!

Also DavFS2 seems to suffer from some Highlander problem:

- From all the billion of different mounts
- which all have different incompatible options
- only a single global option can survive.

I do not know how to solve that.  Sorry.

Then:

`mount -t davfs2 -o allow_others,uid=1000,gid=1000 http://192.168.0.1/pub /mnt/dav`


### `gvfs`

In Nautilus:

- Click on `+ Other Locations`
- At "Connect to Server" enter `dav://192.168.0.1/pub`
- This mounts `/run/user/1000/gvfs/dav:host=192.168.93.1,ssl=false,prefix=%2Fpub`

And it looks like this works flawlessly in combination with Nautilus.
However, as usual, you cannot see what is going on behind the scenes.


## Windows

## Windows 11

> Sorry, I did not manage to get it working.  It still fails with code 0x80070043

Things done:

- Service "WebClient" crashed and needed a restart
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\BasicAuthLevel` is set to `2` already

Still does not work.


## Missing links

What I am missing is something which just works and does not leave you in the dark about what happens in the background.
Because mapping WebDAV into the filesystem is the Unix way, right, but it has too few ways to keep you in control.

For example:

- Wat if connection break during the transfer etc.?
- How to limit upload speed.

And so on.  There should be some program/output which shows you the progress of the interface to WebDAV and keeps you informed.

But there isn't.

> Also zillions of such user processes should be able to run in parallel with distinct incompatible options, each,
> without any requirement for the admin to approve all those mounts.

So what I perhaps do:

- Look for some suitable FUSE module in Python
- Mount this into WSL under Windows
- And let Windows access it from the outside

Note that it might be because I want to run WebDAV with SVN without any credentials,
and everything (including Windows) pretend that some authentication must be there.

WTF why?

I really do not get it.  This all is completely false sense of security.

> If puzzled, read why Windows requires you to use SSL.  Because the password else is transmitted unencrypted.
> Which is not needed at all if there is no password at all.  So this is the completely wrong way of reasoning!  
> (If a password is in the way, the default should be to leave it away instead of requiring transport level encryption for just plain everything!  But if you are a nail, you must neglect the existence of screws .. or something like that.)

**If you need access control, implement it on top of WebDAV, not below!**
Authorization is good, but

- it must stay an option
- and it must work without re-inventing your own builtin Authentication, too.

So for me the burden of builtin mandatory authentication as a requirement for WebDAV is a major Bug.
