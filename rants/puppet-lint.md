# `puppet-lint` is unusable

`lint` is for finding syntax errors.  But `puppet-lint` is for style guide conformity.

Hence `puppet-lint` errors out with completely valid Puppet recipes.

This is destructive, because not helpful.
A good `lint` helps to detect syntax errors to protect against accidentally applying invalid recipes.

But this `lint` only helps with uploading puppet-recipes into puppet forge.
With a dubious styleguide.

For example: TAB characters might be crucially important in some cases which lets puppet-lint throw an error.

This makes the style guide dubious.  Hence `puppet-lint` is not usable at all.  Sorry.  Bad work.

## No arguments left

If you try to argue "but `puppet-lint` is for styleguide" then this is invalid.
It is called `puppet-lint` not `puppet-style-lint`.

Calling it `puppet-lint` makes it impossible to create a proper `puppet-lint`.
