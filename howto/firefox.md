# Firefox Tricks

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


## Disable Firefox Account

	about:config?filter=identity.fxaccounts.enabled

Toggle to `false`


## Use Web-Console

In about:config you need to enable

	devtools.chrome.enabled

first, then use

	Strg+Alt+J

to open Web-Console and enter JavaScript on Browser level.

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

FF56++ (until Mozilla decides to change it .. again .. and again .. as usual):
```
for a in "$HOME/.mozilla/firefox/"*;
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
