Eigentlich wollte ich nur folgendes [an ein Ticket anhängen](https://trac-hacks.org/ticket/14001#trac-add-comment) um zu helfen:

```
FWIW I just installed this here into my Trac instance and it worked out of the box (Thanks for the good work!).

> The deployment was straight forward and did not need any tweaks (I just had to add a standard `.gitignore`, because my semiautomated deployment refuses to deploy unclean `git` repos after builds).

But first **I possibly had a similar error like in this ticket**, because I forgot to deploy the HTML, such that in the network tab of !FireFox debugger NginX produced an 404 on the `viewer.html`.  Depending on how the server serves a 404, **this might create a grey page** (in my case the standard 404 page of NginX showed in the `iframe`).

> In this ticket we see that the deploy was done.  However this still does not tell me that the `viewer.html` really was served to the browser intact.
>
> BTW clicking on the "original format button" downloads the PDF and, depending on the browser, then immediately renders the download in the browser itself.  (Newer !FireFox now have builtin PDF rendering, too.)
>
> So this plugin here seems to be redundant.  **However it is not**, as I want to be able to preview the PDF without downloading it (possibly again and again) to the local filesystem.
>
> What is still missing is a PDFpreviewMacro to preview the PDF from within the Track ticket itself.  It looks doable with just a few tweaks, though ..
>
> I do not want to convert things on the server side like done in [https://trac-hacks.org/wiki/PdfImagePlugin].  It is doable in the Browser alone so it should run there.
>
> I.E. with the help of [https://github.com/nokiatech/heif/tree/gh-pages/js Nokia's HEIC lib] I was able to add `.heic` images to display with the normal `Image` macro.  This lib replaces the `<img>` with `<canvas>` on the fly.  Just include their JS and you are done, but it ignores styles, so it still needs a bit improvement.
>
> But I think we can do similar with `PDF` and `SVG` (we could even run `.exe` within a JS based VM emulator) to autoload converters for common file formats to render them with the existing `Image` macro and doing a preview in the attachment section if we combine what is done here and what is done by Nokia.

My setup:

I use Trac from Ubuntu 22.04.4 LTS with [https://trac.edgewall.org/ticket/13404 a small patch] applied.

> It runs behind NginX and some probably highly unusual Extranet setup.  And it uses [https://github.com/hilbix?tab=repositories&q=trac a trainload of other plugins] (only those which use submodules are on !GitHub yet.  Note that the listed `trac` clone is not used, it is just for my personal reference).

Because I provision plugins as `git submodule`, I first converted SVN to `git`.

> This unofficial fork is at [https://github.com/hilbix/tracpdfpreviewplugin GitHub].  (I cannot support nor maintain it, except when I run into errors myself.)

Then I softlinked the plugin into my Trac instance's `plugins/` folder.

> Not all of my multiple Trac instances shall be able to use the same plugins.  So I use relative softlinks in a straight forward fashion to deploy all plugins.

Then I restarted `tracd`.

> As I [https://github.com/hilbix/ptybuffer/blob/master/script/autostart.sh use my own way of autostarting] things (which worked 20 years ago and even survived SystemD unharmed), I use `killall trackd` for restarts.  Yes, sorry, probably too simple, but works.

Then I enabled the plugin under `admin`.

PDF preview did not show up.

I restarted `tracd` again.

Now the PDF viewer was rendered as 404

Then I called `trac-admin $PATH deploy $OUTDIR` (YMMV)

> Note that this is just `make` in my environment.  I like the power of Makefiles, so I do not need to remember anything.

I do not remember if I restarted `tracd` again.  However now PDF preview worked.

In case you are interested, here is how I convert SVN to `git`:

{{{
o git init
o git empty
o git reset empty
o git svn init --prefix=svn/ "${@:2}" "$URL/$SUB"
o git svn fetch
o git merge --allow-unrelated-histories svn/git-svn
}}}

`$URL/$SUB` here was [https://trac-hacks.org/browser/pdfpreviewplugin/1.0]
`"${@:2}"` was empty, it can be used for things like `-T 1.2` or similar if `trunk` is present.

This uses the [https://github.com/hilbix/gitstart/blob/623ed23d9a112608952a3952a496e5c8d817dce3/aliases.sh#L256 empty git commit], which is just one of my less bizarre foibles ([https://github.com/hilbix/bashy/blob/bc2eba3206df3222e99955d7698b1cd836e06020/boilerplate.inc#L63 anotherone is those o in the code]).
```

Anscheinend bin ich halt ein übler Spammer, weil ich tatsächlich helfen will.

# Na dann eben nicht!

Sprich, ich werde **NIE WIEDER AUCH NUR VERSUCHEN** bei Trac-Hacks irgendwie zu helfen.
Achte auf Deine Wünsche, denn sie gehen in Effüllung.

> Hier: Wer anderen die Mithilfe unmöglich macht, der bekommt halt keine.

Einen Kommentar dazu habe ich noch:  **Geht starben!**  Alles andere ist Zeitverschwendung!

> Und sorry dass ihr all eure geleistete Arbeit so unvermittelt vollkommen das Klo runterspült.
> Anders kann ich es leider nicht ausdrücken.

![Captcha gelöst](https://github.com/hilbix/tino/assets/994093/dc706298-9b55-4e5f-9d49-f518f1ea4afd)

![Aber dann das](https://github.com/hilbix/tino/assets/994093/45dee137-4822-40ce-88a2-fb5b28397736)
