# `git`

I am not completely satisfied, as this also still fetches all objects of the trees,
not only those, which are needed to do the sparse checkout.

For a sparse and shallow checkout, we only need

- The commit
- The root tree
- All trees down there for what is sparsly needed
- And the objects which shall be checked out

There is no need to fetch objects, which are besides these area.

But I found no way to express that for now.  Perhaps I am doing something wrong?

## Sparse and shallow checkout

So there is some huge MonoRepo out there.  And you only need a very very very small fraction of the files.

Here is a first approach.  It is not perfect, though, because I did not find a way to limit the initial `fetch`.

Here is an example.  This should be easy to adapt to your needs:

```
git init sparse-shallow
cd sparse-shallow

git sparse-checkout init
git sparse-checkout set 'extensions/common/api/*.json'

git remote add upstream https://chromium.googlesource.com/chromium/src.git
git fetch --depth=1 upstream main

git sparse-checkout list
git checkout main
```

Hints:

- Do not use `git sparse-checkout init --cone` if you do not need it
  - Most tutorials out there use this, however to request only certain files this is not what you want
  - Also it checks out files on all levels which are visited
- Use `git sparse-checkout set` for the first pattern to remove the default patterns
  - This is what I usually need
- `git fetch --depth=1` fetches everything from the upstream which is in the given branch
  - but without history
  - This is far more
- Use `git sparse-checkout list` before the checkout to see if everything is setup correctly
- `main` is the master branch here
  - I do not understand what `main` actually wants to tell me
  - A `main` branch is some fundamental different concept than a `master` branch and does not apply here.
  - If you do not get the difference, think of a "main DVD" and a "master DVD".
  - If you still do not get it, think a bit about why mains are called "mains" and not "masters"!
  - And think about the nature of a "main" and a "master".  What is "the main"?  What is "the master"?
  - Also think about studies.  There is a very fundamental difference between "master" studies and "main" studies!
  - And what is the difference between a "master" degree and a "main" degree?
  - So if you still refuse to use "master", then only following question remains for me:  **ARE YOU REALLY THAT STUPID?**
  - But nevertheless it is called `main` now ..
  - Looks like some misconcieved overburdened political correctness has beaten all the brains now.  All the idiots have won.  Ultimatively.
  - And if `master` is banned now, shouldn't we ban all people with `master`-degree, too?
  - Shouldn't we start to do `main` studies after `bachelor` studies to archive a `main` degree?
  - Do we now "main" a profession instead of mastering it?
  - And, isn't the misogynistic word `bachelor` not even less politically correct than `master`?
  - Also "bachelor" is so discriminating, just think about those poor ones who do not have a bachelor degree!
  - Read:  No, sorry, I simply refuse to ever understand or accept concepts like this!  Period.
