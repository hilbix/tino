# Cookies, JavaScript, CSS

Hello Folks,

here is my policy on how I treat Cookies, JavaScript and CSS.

## My rules

### Do not expect CSS to be enabled

If you want to do it right, please do not rely on CSS!  CSS is quite often disabled at my side.

So if notes aren't readable on the top of the page with CSS disabled, due to shitty page design or whatever, **I will not scroll to the bottom** to search for it.  I will just leave your page.

So if you want to reach me, test your page with CSS, Cookies and JavaScript disabled, best **test using `lynx` as a browser with an 80x24 screen**.

If you then can understand what's going immediately without scrolling, you did right.  If not, you failed.


## If you need Cookies, specify them

If your page tells, that it needs Cookies, I will enable Session-Cookies.  If you do not, Cookies stay disabled very likely.

If you need more than Session-Cookies, like permenent Cookies, then please exactly specify which cookies you need.
This includes at least following:

- Domains of the Cookies
- If you need more than one Cookie, list the Paths 
- If you need the Cookies to be stored longer than a session lifetime, please add the Lifetime

Note that you do not need to specify this for Session-Cookies.  Only permanent ones.

If you fail, permanent Cookies are likely not enabled or they are treated like Session Cookies.


## If you need JavaScript, specify it

If your page tells, that it needs JavaScript, I will enable JavaScript for this page.  This means, **embedded JavaScript will be loaded, but not more**!

If your page needs JavaScript from your site, you need to tell that fact.  In that case I can enable JavaScript to your site.
Note that "site" means "relative URLs" without a Host part.  If you give absolute URLs, you need to specify the URLS, see next.

If your page needs JavaScript of another site (any URL with a host part applies to that), then please list all the needed domains.
If you fail to do so, I will not enable those sites.  "Fail" includes the case that you unneccessarilys specify domains as needed, which are in-fact not needed at all (like `google-analtics`).
So if your page happens to need something like `google-analyics` for some case and cannot run without, please tell the cause, such that I can understand, that this is not just SPAM.


### These are the relaxed rules already

Please note that we are living in a time of subresource integrity.  This means, you should use it.

For now I do not enforce this yet (mainly because there is no such extension for Firefox and Chrome which supports that).

However in future it may be that I enforce that you use subresource integrity, in case you use something like a CDN, to protect against 3rd party errors.
Because it is your page I am looking at, and do not want to be tricked by others.


# TL;DR

It is easy to provide information on how your site works for all users.  **Just use `lynx http..` to look at your page.**  If this makes you and others happy, you are set.

To get Lynx:

- GNU/Linux and GNU/Windows Users: Start `bash` and then `sudo apt-get install lynx`
  - For Windows 10 see https://docs.microsoft.com/en-us/windows/wsl/install-win10 on how to get GNU/Windows
    - Follow "Install the Windows Subsystem for Linux"
- MacOS users:  `brew install lynx`

Perhaps I once will create some VM to render the first screen of a pages textwise, such that you can see how it looks like just with your browser.
