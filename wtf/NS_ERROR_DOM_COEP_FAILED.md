# WTF `NS_ERROR_DOM_COEP_FAILED`

Something does not work and `NS_ERROR_DOM_COEP_FAILED` shows up in the network Tab of Firefox for some foreign URL?

> Perhaps some people are born with the knowledge what `COEP` means.
> I haven't heared of this before and had not the slightest idea what this error wanted to tell me.

Googling for it revealed 7(!) hits, and nothing really helpful.  Well, apparently I am very alone with this error.

> This still does not explain, why this error is nowhere explained!

The culprit at my side was my HaProxy configuration, which, by default, sets some headers:

```
        http-response   set-header      Cross-Origin-Embedder-Policy    require-corp
        http-response   set-header      Cross-Origin-Opener-Policy      same-origin-allow-popup
        http-response   set-header      Cross-Origin-Resource-Policy    same-site
        http-response   set-header      Referrer-Policy                 "same-origin, strict-origin-when-cross-origin"
        http-response   set-header      X-Frame-Options                 SAMEORIGIN
        http-response   set-header      X-Content-Type-Options          nosniff
        http-response   set-header      X-XSS-Protection                1;\ mode=block
```

> Of course it does, because I really do not understand, why those headers are not active by default.
>
> The browser should always be set up with maximum security in mind, such that only options can lower it.
> And then the user should get the choice of accepting the lower security or not.
>
> However it is the opposite around:
>
> - The user does not get into any control of anything
>   - Like Manifest v3 even takes away the last bit of freedom from users.
> - And the default is always to do thing as insecure as possible
>   - At least that is my impression
> - And the Dev is left alone in the complete dark if something breaks (like in my case)
>   - Well done.  Billions of years of manpower wasted.  No wonder mankind goes nuts.

The solution was to remove headers in the backend.

> Note that I did not check which one.  As it is `COEP` it possibly is `Cross-Origin-Embedder-Policy`.
>
> How to do it right is left for the future!

```
       http-response   del-header      Cross-Origin-Embedder-Policy
       http-response   del-header      Cross-Origin-Opener-Policy
       http-response   del-header      Cross-Origin-Resource-Policy
       http-response   del-header      Referrer-Policy
       http-response   del-header      X-Frame-Options
```
