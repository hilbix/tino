*Currently extremely incomplete*

> If you refer to this doc, please use a link with the git GIT-SHA,
> so people easily can look up, what changed since the last time you referred to this.

# Markdown WTFs

In [Markdown](http://commonmark.org/) things are different than you think.

- Markdown is incompletely defined
- Markdown is puzzling at times for humans
- Markdown lacks features
- Markdown has some ambiguous things

But it is so overwhelming handy and usable compared to other markup ideas, that I do not want to use use others.

Some things in Markdown are simply wrong for my taste, so I cannot stand this.
Jence this doc here where I write up, what needs to be changed from my very personal perspective.

> If you can agree to my view, you are welcome.
> If not, you are still welcome, but please abstain from all critizism!


# Augmented Markdown

In short `AD`, this is what I call it.  And the extension shall be `.ad` or `.md` with a header:

    ::: augmented-markdown

And no, it does not try to be Markdown compatible in any way!

> However there shall be a converter to convert `.ad` into `.md` while emulating the most things which are not present.

## Sources and Unsources

I greatly borrow from all Markdown and CommonMark.  So AD tries to be as near on those standards as possible.

However if I cannot stand some things, I will break this standard, without reget.  And I will not look back.

### Things I can adapt to:

- `*` is emphasis, `**` is bold.  I liked `*` to be bold, but `**` is good as well.  And `\*` to escape is OK for me, too.
  - KEEP http://commonmark.org/help/tutorial/02-emphasis.html

- https://talk.commonmark.org/t/generic-directives-plugins-syntax/444

### Overview of things which must change:

- Header syntax
- TAB==4.  TAB = 8 since the computer stone age.  Keep it standard.
- HTML/XML inline.  This can be an extension.  But HTML/XML *MUSTNOT* be in the base standard.
  - CSS is better, however there must be a comon subset defined, such that you can, for example, transform AD into TeX without need to fully implement a HTML/CSS parser
  - So `<div>` is rendered `<div>`, and `&amp;` is rendered `&amp;`.  Period.
- Indent == 4.  Rather Indent depends on the context.
  - Breaks http://commonmark.org/help/tutorial/10-nestedLists.html


## Remove ambiguities.

### Headers

    Header1
    =======
    
    Header2
    -------
    
    Header3
    ???????
    
There is no Header3?  WTF?!? Compare

    # Header 1
    ## Header 2
    ### Header 3

This comes easy and natural.  Also parsing all those second lines is a nightmare.

This also is an ambiguity to `--------` for rulers.

> Proposal head.1:  Drop the first Header variant.  Period.

However, in documents, you perhaps want more augmented ASCII headers.  Things like

    ############
    # Header 1 #
    ############

or

    ## Header 2
    ###########

or 

    ===========
    # Important
    ===========

This can be archived transparently with an easy to understand rule:

> Proposal head.2: An empty header or ruler followed or following a nonempty header is ignored

Simple and straightforward.  So `============` is a ruler, `------------` is it as well, and `#######` is an empty header.

Also the usual multi line definition follows:

    ### Header line 1
    ### Header line 2

renders as

    ### Header line 1 Header line 2

And if you want Linebreaks, then just add at least 2 spaces at the end of the previous line.


## Tabstops

TABs are indenting 8.  Period.  No discussion about this.
Tabstop already was 8 when I was born over 50 years ago and it must remain 8 until I the end of time.
No, I repeat, absolutely no redefinition of TAB to become 4.  Period.  End of talk.

## Unicode and Character Sets

Unicode *MUST* be supported.  By default, all texts *MUST* be `UTF-8` if no other charcter set is given.

This character set specification *MUST* be unambiguous and automatic machine parsable.
The character set *MUST* be derived from the document itself, not from it's name or file extension.

- [BOM](https://de.wikipedia.org/wiki/Byte_Order_Mark) for example is such a valid character set spec.
  - The UTF-8 BOM `EF BB BF` usually is left away.
    - It *SHOULD* be stripped if found.  
    - If it is stripped, there *MUST* be a visual note on visual programs, and *SHOUD* be a visual note on all others.
  - Program *SHOULD* output UTF-8 without BOM by default
    - They *MUST* obey all variants of character set specs in the document
      - If they are not character set spec aware, they *MUSTNOT* change the encoding of the input.
  - Program *MAY* read all BOM variants
    - If they understand BOMs, they *MUST* at least understand UTF-8, UTF-16 and UTF-32
 
A different character set is defined by the setting
 
    :charset "

## Ruleset

```
TAB  := '\t'  # resembles 1 to 8 spaces depending on contents.  It is show as TAB to columns divisible by 8
SPC  := ' '
HEAD := '#'

emptyheader := HEAD+ [SPC|TAB]

# Edit interruption garbage
- `'#'+ [SPC], `##` and so on introduce an empty header.  Note that this must not be followed by 2 spaces.
```


## Reqirements for Editor programs

These requirements are such, that editing resembles the Terminal standard.
This standard was implmented in the 1960s, so we cannot change this.

- Editors which are "aware" can be set such, that they are able to fulfill all "MUST" and "MUSTNOT" requirements out-of-the-box.
  - However, they violate some of the defaults noted.
  - Editors which are "fully aware" can be set such, that they are able to fulfill all "SHOULD" and "SHOULDTNOT" requirements out-of-the-box.
- Editors which are "compliant" implement all the "MUST" and "MUSTNOT" requirements as shown out-of-the-box.
  - Editors which are "fully compliant" also implement all "SHOULD" and "SHOULDNOT" requirements out-of-the-box.
    - Editors which are "complete" implement all the "MAY" features as well.

This documentation can change, so the Editors *SHOULD* refer to the commit ID (SHA) and date of the commmit
of this documentation in respect to if they are "aware", "fully aware", "compliant", "fully compliant" or "complete".

- The presence of trailing Spaces *SHOULD* be indicated by the editor.
  - This representation *MUSTNOT* be distractive.
  - There *MUST* be an easy way to switch this off.
  - There *SHOULD* be a way to present it with a combination of background color and custom characters.

- The presence of a TAB *SHOULD* be indicated by the editor.
  - This representation *MUSTNOT* be distractive.
  - There *MUST* be an easy way to switch this off.
  - There *SHOULD* be a way to present TABs with a combination of background color and custom characters
    in possibly different ways.

- TABs *MUST* be preserved by default.  Editors *MUSTNOT* come preconfigured differently.
  - So if you press the TAB key, a TAB must be inserted, as long as you did not change the setting willingly.

- There *SHOULD* be an option to replace TABs by Spaces.
  - There *SHOULD* be an option to do this on-demand.
  - There *MAY* be an option to switch this on globally
    - This global option *MUST* be off by default.
    - When this option is on, this *MUST* be shown on the screen all time
      - Yes, in Fullscreen non-distractive mode it must be shown as well
    - There *MUST* be an easy way to switch this off again.
      - For example by klicking on this notice.
    - A change of this global option *MUST* be shown prominently.
      - For example by an alert box "do you want to switch it on"/".. off"

- There *MAY* be an option to change TAB presentation from 8 to something else.
  - In that case a range from 1 to 32 *MUST* be supported.
  - This option *MUST* be set to 8 by default.
  - If this option is not at 8, then there *MUST* be a permanent information shown on the screen all time
    - Yes, in Fullscreen non-distractive mode it must be shown as well
  - There *MUST* be an easy way to switch this off again.
    - For example by klicking on this notice.
  - A change of this global option *MUST* be shown prominently.
    - For example by an alert box "do you want to switch TAB representation to X"

- There *MAY* be an option to change the number of Spaces a TAB is replaced by above "replace TABs by Spaces" setting.
  - In that case a range from 1 to 32 *MUST* be supported.
  - This option *MUST* be set to 8 by default.
  - This option *MUST* be independet from the TAB representation option.
    - This means, there *MUST* be a TAB representation option when this option is available.
    - It *SHOULD* be linked with TAB representation setting by default, so you only enter 1 setting to change both.
      - The linking *MUST* be switchable on/off very easily
  - If This option is not at 8, then there *MUST* be a permanent information shown on the screen all time
    - Yes, in Fullscreen non-distractive mode it must be shown as well
  - There *MUST* be an easy way to switch this off again.
    - For example by klicking on this notice.
  - A change of this global option *MUST* be shown prominently.
    - For example by an alert box "do you want to switch TAB space replacement option to X"

- The editor *SHOULD* provide auto-indent option.
  - This option *MUST* be on by default if the editor supports it.
  - Indentation *MUST* copy the previous indentation.  That is, it *MUST* copy SPC/TAB combinations.
  - The setting of this option *SHOULD* be noted on the screen all time.
  - There *MUST* be an easy way to switch this on and off.
    - For example by klicking on this screen note.
    - If the option is shown on the screen, there *MUSTNOT* be a distraction (like a confirmation popup) when changing this option
    - If the option is not shown on the screen, there *SHOULD* be a visual information about the change of this option.
  - When there was an auto-indent, each BACKSPACE removes one indentation level by default.
    - In that case BACKSPACE *MUSTNOT* remove character by character, except that was the indent level to remove.
    - If the editor cannot detect the correct indentation level, one BACKSPACE *MUST* remove all the automatic indetation.
      - An editor *SHOULD* detect the correct indentation level at least 80% of the time.
      - A "complete" editor *MUST* detect the correct indentation level.
        - If BUGs arise, which were unknown before, all versions before the BUG is known still stay "complete"
          - If the BUG is confirmed, existing "complete" editors *MUST* be distributed as "complete with BUGs"
          - Purely security related new versions can be  distributed as "complete with BUGs", too
          - New versions with new features (note purely security related) first must fix all known confirmed BUGs to be "complete"
    - There *SHOULD* be an option to change the BACKSPACE behavior.
      - The default *MUST* be set as noted above
      - If the BACKSPACE behavior differs from the default, there *MUST* be a permanent information shown on the screen all time
        - Yes, in Fullscreen non-distractive mode it must be shown as well
      - There *MUST* be an easy way to switch this off again.
        - For example by klicking on this notice.
      - A change of this option *MUST* be shown prominently.
        - For example by an alert box "BACKSPACE switched to mode X"


# Final words

If you want to help, please feel free to open Issues or Pull Requests on GitHub.
But please keep this documentation free from names, trademarks etc.
This here shall be a purely technical documentation,
let's keep all metadata (like authors) in the `git` history.

> This document *MUST* cover all edge cases thoroughly.
>
> If you found an edge case which is not covered properly, this is a BUG.
> Please fix itor open an Issue for this!

Thanks!

> To be extended when I think there is time for it.
