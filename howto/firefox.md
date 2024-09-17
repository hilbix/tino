# Firefox Tricks

## TL;DR

`about:config` (like Windows you often need to restart FF to allow changes to take effekt)

- `identity.fxaccounts.enabled`: `false` (disable FF account)
- `signon.management.page.fileImport.enabled`: `true` (allow import of logins)
  - `about:logins`: "Import from a File..." shows up at the `...` menu
- `devtools.chrome.enabled`: `true` (enables Dev-Console Ctrl+Shift+J)
  - `Components.utils.import("resource://gre/modules/AddonManager.jsm", null).AddonManager.getAllAddons().then(_ => _.filter(addon => addon.type == "extension")).then(_=>_.forEach(_=>console.log(_.name,_.getResourceURI().spec)))` to show all extensions (there are trainloads of hidden ones)
- `extensions.sdk.console.logLevel`: `all` (enable all output to console for:)
  - `about:debugging#/runtime/this-firefox` then click on `Inspect`
- `toolkit.legacyUserProfileCustomizations.stylesheets`: `true` to enable `userChrome.css`

`"$HOME"/.mozilla/firefox*/*/chrome/userChrome.css` [hacks](https://www.userchrome.org/how-create-userchrome-css.html):

- `#tabbrowser-tabs .tabbrowser-tab .tab-close-button { display:none!important; }` remove `x` on Tabs (must be tested again)
  - still closes Tabs on middle mouse button (missed the `+` button by a fragment of a pixel?  You are doomed!  Thanks, Mozilla!)
- `toolbarbutton.bookmark-item > .toolbarbutton-icon { display:none!important; }` kill all icons on bookmark toolbar
  - Either be drowned or die from thirst; As a glass of water is disallowed!  (the default Microsoft strategy)


## Unsolved

### Let FF ESR stay aliave

My FF ESR permanently crashes.  Even if completely idle.
I am still looking for a solution.

### Restore windows as they were after restart

I have 5 virtual desktops on 3+ monitors.
Chrome restores the windows and their position (nearly) perfectly
(it just wrongly calculates their size, but not their position).

However if FF restarts, it does not open the windows where they were,
but instead somewhere else.   And where is completely unpredictable.


## Local Login transfer between FF

Here is how to import your logins from another FF without data leaving your computer:

> Be sure to export the logins to something like a RAM disk:
> 
> - On Linux there is one in `/run/user/$UID/` nowadays.
> - Remove the exported file afterwards
>
> You have crypt enabled for swap?  Right?

- Before import
  - `about:config`
  - `signon.management.page.fileImport.enabled`
  - `true`
- `about:logins`
  - "Import from a File..." shows up at the `...` menu
- After import
  - `about:config`
  - `signon.management.page.fileImport.enabled`
  - `false`

Why?

**I am legally bound not to use features like `sync` in Firefox, because I am legally bound not to allow certain data to be transferred to a 3rd party.**
Encryption makes no difference here.  As I am not able to understand what sync really does or not does, enabling Sync means that I commit a truly crimnal act.

> Live with this.  YMMV.

Hence to transfer logins from one FF to another, this data must not leave my controlled area.  Read:  It must be done in an offline fashion.

However Mozilla [**disabled import** due to "performance issues"](https://support.mozilla.org/en-US/kb/import-login-data-file).

WTF?  How can a feature, which you only use on demand, cause any performance issue?  It is built in already, so it cannot be code size,
as the code size increases if you implement enable/disable on demand.  And as you can enable it on-demand, there cannot be any performance
impact if you do not use it, else it would be illogical that this feature can be enabled/disabled on demand.

> You can enable it, import, then disable again.  So this can be the workflow and makes performance issues impossible!
>
> Logic, please!
>
> BTW:  If file import causes performance issues to Sync, then disabling the non-culprit is the probably most horribly wrong solution you can chose.  Ever.

This means:  **Either Mozilla lies to us** or **Mozilla is horribly incompetent**.  Chose one or both, but you cannot evade.  As its proven now.

> As I cannot trust anybody who lies to me for no good reason, I hope that Mozilla only is incompetent.  YMMV.


## Disable Firefox Account

Open `about:config` and toggle `identity.fxaccounts.enabled` to `false`


## Debug extensions

Debugging is very well hidden:

Open `about:debugging#/runtime/this-firefox`, then click on `Inspect` on the extension.

> The following might be outdated:

**But wait**, there is more, because things are still hidden!

Open `about:config` and set `extensions.sdk.console.logLevel` to `all`

This allows `console.log()` to show up in the console.


## Use Web-Console

In about:config you need to enable

	devtools.chrome.enabled

first, then use

	Ctrl+Alt+J

to open Web-Console and enter JavaScript on Browser level (or is it `Ctrl+Shift+J` now?)

> I really have no idea why such important settings are disabled

Example from <https://stackoverflow.com/a/6579979>

```
var {AddonManager} = Components.utils.import("resource://gre/modules/AddonManager.jsm", null);
AddonManager.getAllAddons().then(addons => {
    for (let addon of addons.filter(addon => addon.type == "extension"))
        console.log(addon.name, addon.getResourceURI().spec);
});
```

which shows at my side, that these shitty new Firefox Snap under Ubuntu ignores
`/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/`
which endangers people by downloding possibly trojaned version from the web instead.

> I really have no idea why it was this stupidly implemented.


## Remove close button on all TABs

> This is probably outdated, see TL;DR above for update

FF56++ (until Mozilla decides to change it .. again .. and again .. as usual):

```
for a in "$HOME"/.mozilla/firefox*/*;
do
  mkdir -p "$a/chrome";
  f="$a/chrome/userChrome.css";
  [ -f "$f" ] || echo '@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* only needed once */' >> "$f";
  line='#tabbrowser-tabs .tabbrowser-tab .tab-close-button { display:none!important; }';
  fgrep -x -- "$line" "$f" || echo "$line" >>"$f";
done
```
(Source https://support.mozilla.org/de/questions/1177825)

It's an annoyance.  You zoom through TABs with the mouse and happen to hit the close button.  Every. Single. Time.
WTF?  Why was the FF option removed to change where this button sits?  I really do not get it!

Am I the only one on this planet who prefers a static interface, where all elements always keep their globally fixed position?

The last time I was in a forest, I did not notice that trees grow with their own chainsaw attached, just in case I want to cut them!

Such a TAB attached button is extremely error prone and hence an extreme stress factor, because you need to avoid it at all cost
when interacting with the TAB bar.  No way!  This is not "form follows function", this just is plain crap!

"Close tab" (on the context) or Ctrl+W are no proper replacement for a missing close button (AKA chainsaw).
But missing this detail (not having a Chainsaw at all) is a far better solution,
than to keep this default major design fault in place.

Now there is still missing:  How to bring back a global close button for TABs, which lives on a fixed interface position.
(Like keeping a Chainsaw somewhere in a hut in the forest, just in case you want to cut a tree.)

BTW: There once was a time, where extensions existed, which brought back the feature which was removed by Mozilla a long time ago.  However this was for the great ancient times, where extensions of such kind still were allowed.  These times now have
passed, since FF 56, winter has come and the ecosystem has died.  You decide if this is good or bad.
But one thing cannot be denied:  The world lost some freedom.  Freedom to do good.  And freedom to do evil.

If you think, this is good, then think again.  As Entropy cannot get lower, it is impossible to make the world more easy.
All you can do is to increase the disturbance.
As Mozilla did.  They cannot deny this fact.  And they cannot deny, that they are the only one, who is responsible for this.
