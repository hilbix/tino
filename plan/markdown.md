> This text is currently far from being completed.  It's just a stub ..

# My opinion on Markdown

I like Markdown.  However I do not like all of it.

However I did not find a good JavaScript driven Markdown implementation which is

- Extensible
- And can have features turned off

## Things which should be turned off (or missing)

### Headlines due to 2nd line

```
Headline
========
```

I do not like that.  While I understand why it is there, I do not think it is worthwhile, as I never use it.

### HTML

I do not like HTML tags to be rendered in Markdown.

This makes Markdown difficult to render in some non-HTML-environment like VT100 terminals.
Or say it differently:  Please no MarkUP in MarkDOWN.  Thanks.

### TABs

TABstops are at 8.  Period.  This is VT100 standard.  And I'll never accept anything else.  Sorry, call me a hardliner there.  I am.

### Tables

```
| this | is | a | table |
```

I do not like that as it is clumsy.  I'd rather like:

	this<TAB>is<TAB>a<TAB>table

So tabular data is then presented .. as a table.

So how do you enter an empty cell at the start of the line?

	<SPC><TAB>..

As double `SPC` at the end of a line is already used for `<br/>`, unseen characters already have a meaning in Markdown.

### Redundant representation of the same thing

T.B.D.

### Emphasizes


### ..

> Here probably some things are missing


## Extensibility

Markdown is OK for things like short documentation.  However it should be capable of more.

The problem here is:  There is no standard for extending Markdown.  However it would be good to have things like `[[TOC]]` or similar.

> --------------------
>
> Rest is T.B.D.
>
> --------------------


# Summary of all Features

This is a bit like the definition on how I like MarkDown to look like.

## Main features


