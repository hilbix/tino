> This is a pre-draft.  Not ready yet.  More than incomplete.

# WIKI needs

> A Wiki with a login is like having sex without orgasm.  (me)

"wikiwiki" means "fast" in hawaiian.  If you require a login befor editing, this is the oppsite of fast.
Hence, if you add a login to a Wiki it is no more a Wiki, it just becomes a CMS.

So here is, what I want from a Wiki.

## It must be fast

Fast means:  No login.  No complex UI.  Some very easy to understand text encoding.  And best is full inline page editing.

That basically is the tip of the iceberg.  As a consequence of this, there is coming more, much more.

## Wiki Parts

### Fast and easy editing

[Markdown](markdown.md) is far too complex and not powerfull enough at the same time.

For example you need tables, toc, media, floats, boxes and notes, backlinks, automatic forward links, comments, etc. pp.
Also you certainly do not want HTML support, as this adds vast incompatibilities.
(For example: How do you render any HTML into LaTeX?)

So what I need probably is some variant of Markdown, with some clutter removed and enough features added, such that you can leave HTML away.

Idea of the rendering process:

    Markdown
       !
    Template <--+
       !        !
       X -------+
       !
     Page

- Something Markdown-like is compiled into a Template.
- These Templates are rendered with the help of other Templates into a new Template.
- If no more Template can be applied, the final template is the output.
- There can be other inputs instead of Markdown.

So we can have several different input variants, all rendered into the same templates, which then is processed by the backend.

Note that Markdown rendering into a template can be done on JavaScript, as Editing can be based on JavaScript.
The output then still is static data.  All we need in Markdown is, how to address the templates an easy way.

Recommendation:

- `{+template argument}` starts output to template.
- `{}` or `{-template}` ends output to template.
- `{function xxx}` runs some well-known function.  By default `{template xxx}` does `{-template xxx}`.
- The default template is `{page}`
- The default rendering language is `MMM` (My-Modified-Markdown)

### `git` Version Control

Backend is fully `git` aware.  `master` branch is the published data.

Note that there is more than one `git` repository.

- user input.  The entered markdown.
- site config.  Templates etc.
- media files.  Each file is in it's own branch.
- page output.  The rendered pages.
  - `master` is publicly published data.
  - `future` branch allows time based publishing.
  - Branches allow targeted publishing.

### REST API

Backend is reachable with easy REST.  You can edit using REST.  REST does not need passwords.

However, pushing to the `master` branch is usually prohibited without proper authorization.

### Free of Databases

There are databases.
- They are only used in a cache way.
- If databases are down, most things (like pages) work.
- Some features (search) may be unavailable without databases.

### Free of JavaScript

Pages can be rendered with JavaScript turned off.
- Some features (online edit) are unavailable with turned off JavaScript.
- Some features (search) may be unavailable with turned off JavaScript.

### Readable without CSS

CSS only is optical, not technical.
- Pages must be text-browser aware.
- Pages must be rendered good without CSS.

## Online Edit Consideration

Online WYSIWYG editing shall be supported as far as possible.  Everything runs in the browser.

- Normal input is rendered into Markdown.
- Markdown and Templates are rendered by JavaScript.
- The result then updates the page.

This works paragraph wise.  So if you edit some text block, only this block is edited.  Everything else is not touched.

The input is compiled into a template:
- This must reference all the input in the markdown.
- This breaks up the references into editable text blocks and metadata.
- When editing, this is based on the templates.  You can edit text blocks and metadata.
- The changes then are transparently processed back into the markdown.

As we have `git`, there cannot be inconsistencies, as we always can add references.

This is a bit tricky in `git`, as we can only reference external `commit`s directly
(I do not want to add business logic, which is not already present in `git`).

This way the backend can, asynchronously, render user driven branches without the fear to interrupt ongoing edits.

Also we can have concurrent edits (as each editor has her own branch).

Merge conflicts can only arise when we do publishing.  This then can be handled by the editor.

For a start we do not need backend rendering at all.  We can save the browser output to the backend.
Hence a pure static git base file backend is enough.
