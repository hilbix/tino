# NginX HowTo

## `$uri` within location that differs from `/`

Sometimes you have something like that:

```
	location /something/ {
		root /srv/whatever;
		try_files $uri $uri/ =404;
	}
```

If you access `https://example.com/something/image.gif` this tries to load
`/srv/whatever/something/image.gif` but usually you expect the image to be
in `/srv/whatever/image.gif` instead.

How to get rid of the `/something/` prefix?


### TL;DR add `rewrite .. break`

The fix is easy, but AFAICS very well hidden in the documentation:

We just need to add following to the location block:

	rewrite ^/something/(.*)$ /$1 break;

The `break` prevents, that this rewrite makes it outside of the current location block.

> Without the `break` flag, like `last` or even worse without no flag,
> the processing would try other location blocks as well.
>
> This usually is not what you want here.
>
> Please not that [missing or other flags](http://nginx.org/en/docs/http/ngx_http_rewrite_module.html#rewrite)
> come handy, if some ressource must be accessed by several different URLs,
> or you want to hand out 301 or 302 redirects to the browser.


### How to diagnose

The above configuration is simple enough, so that we probably can figure that out by looking at it.

But often you have far more complicated setups where you cannot spot the outcome that easy.
Hence we need a way to debug it.  The trick is to add some header such, that we can debug the variable in question.

> How to do this, again, is very well hidden in the documentation.

Just add `add_header X-uri $uri always;` (where the `always` does the trick and makes the header show up at 404)
so it looks like:

```
	location /something/ {
		root /srv/whatever;
		add_header X-uri $uri always;
		try_files $uri $uri/ =404;
	}
```

`curl -I https://example.com/something/image.gif` tells you:

```
HTTP/1.1 404 Not Found
Server: nginx/1.18.0
Date: Fri, 22 Dec 2023 14:29:00 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive
X-uri: /something/image.gif
```

Now you know the value of the `$uri` variable and as we know that `try_files` looks for `$root$uri`
we now can clearly see that the file `/srv/whatever/something/image.gif` does not exist.

As we now understand, that `$uri` must be changed from `/something/image.gif` to `/image.gif`,
we can deduce the correct `rewrite` rule which affects `$uri`:

```
	location /something/ {
		root /srv/whatever;
		rewrite ^/something/(.*)$ /$1 break;
		add_header X-uri $uri always;
		try_files $uri $uri/ =404;
	}
```

`curl -I https://example.com/something/image.gif` tells you (in case `/srv/whatever/image.gif` exists) this time:

```
HTTP/1.1 200 OK
Server: nginx/1.18.0
Date: Fri, 22 Dec 2023 14:32:03 GMT
Content-Type: image/gif
Content-Length: 308
Last-Modified: Tue, 16 Sep 2003 22:52:32 GMT
Connection: keep-alive
ETag: "3f679430-134"
X-uri: /image.gif
Accept-Ranges: bytes
```

### Do not forget to remove the header!

In the above example the

	add_header X-uri $uri always;

does not contain something bad.  But you might leak important information if you leave it in.
For example if you put

	add_header X-uri $root$uri always;

then you expose your (unknown) local path to the outside world, which might give hints to attackers.

Just clean up afterwards and never return unnecessary information from production code.
