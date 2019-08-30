# Linux Icon Editor

I am running Ubuntu 18.04.  And I want to create/edit a `favicon.ico` file.

Nope.  Not possible.

Why?

It's 2019 and all Icon Editors in Ubuntu have been removed.  Yay!  Isn't that nice?

What I need is an icon.  A standard icon.  Something we know for over 20 years.  Nothing fancy.  Just an icon!


## My current solution

- create a 64x64 icon with kolourpaint
- make it transparent in kolourpaint
- Upload this to http://www.xiconeditor.com/
  - make sure all 4 planes are selected
- Download it again (yes, WTF!?!)

There it is.  WTF!?!


## What I did to find something

Googled.  Found links.  All were either outdated, misleading, plain wrong or no more current.  Nothing worked.

Tried alternatives.to.  No result.

Searched for icon editor in GitHub.  Found several.  However they apparently are no icon editors.  They do SVG!  WTF?!?

Is there no Free Software variant of a Linux based Icon Editor out there?  Really?

(It can be JS based, but it must be reusable, such that it does not vanish by chance.)


## Perhaps a script can do it

A script which changes a 64x64 `.ico` into some with all the other layers.

However sometimes you perhaps prefer to preview the result before using it.
This is a bit difficult in case it's just a commandline tool.

Wouldn't it be nice to just have some working and simple to use and secure graphical Icon editor?

> Yes it should be able to do SVG, too.
> But it must target the original `.ico` first, and then everything else later.
>
> And would be nice if it would support every other format (MAC, PNG, Android apps, OS-X apps) as well.
>
> And would be nice if it is secure?
> So does not need security nightmares like NPM, Maven, Grade, Bower, etc.
> Just some `git clone --recursive URL` and you are set up?
>
> Nah, I'm dreaming.
