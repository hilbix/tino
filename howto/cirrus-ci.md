# GitHub Cirrus CI micro HowTo

Unfortunately, Cirrus CI is not self explanatory.  You need documentation.  This tries to sum it up.

# Hello World

## Enable it on GitHub Marketplace

Enable [Cirrus CI on GitHub marketplace](https://github.com/marketplace/cirrus-ci).
- Choose the free plan
- Use it for all of your repositories (it does not hurt and makes everything work automagic)

## Open Cirrus CI web UI

Open https://cirrus-ci.com/
- Let it access your GitHub account
- **Keep it open** to see what Cirrus CI is doing.
- Do not be puzzled.  It does nothing until you push.  Then it fills with life, fully automagically!

## Create a `.cirrus.yml` in a public Repo

In the root of a public repo, create a file named `.cirrus.yml`.

> This is the biggest drawback of Cirrus CI:  You have to modify your project!

To run `make` probably this is the contents of your `.cirrus.yml`:

```
container:
  image: gcc:latest

make_task:
  prep_script: git submodule update --init --recursive
  compile_script: make
  install_script: make install
```

> Compile runs as `root` (at least in container `gcc:lastest`), so `sudo` is not needed.

- `git commit -A`
- `git push`
- Refresh https://cirrus-ci.com/


# `.cirrus.yml` HowTo

> - https://cirrus-ci.org/guide/writing-tasks/
> - https://cirrus-ci.org/examples/

T.B.D.

# Other questions

Badges?

- Badges and Build history are visible to everybody.  This is usually what you want.
- Markdown:

        [![REPO BRANCH Build Status](https://api.cirrus-ci.com/github/USERorORG/REPO.svg?branch=BRANCH)](https://cirrus-ci.com/github/USERorORG/REPO/BRANCH)
    
  - Replace:
    - `USERorORG/REPO` with your user/repo name (without `.git`, separated by `/`, no blanks)
    - `BRANCH` with the branch you want to tag
    - If you do not need a `BRANCH`, leave away `?branch=BRANCH` and `/BRANCH`, of course.
  - `REPO BRANCH Build Status` is just some arbitrary (ALT) text
  - `https://api.cirrus-ci.com/github/USERorORG/REPO.svg?branch=BRANCH` is the visual image
  - `https://cirrus-ci.com/github/USERorORG/REPO/BRANCH` is the link to build history on Cirrus CI

Where Do I find a list of all possible containers?

- I really have no idea yet.


How to compile for Windows or MacOS?

- This probably needs paid accounts somewhere else.  I really have no idea.
- [Windows](https://cirrus-ci.org/guide/supported-computing-services/#windows-support)?  (Sorry, I do not understand any detail here.)
- [Mac](https://cirrus-ci.org/guide/supported-computing-services/#anka)?  (And I am completely lost.)


How to use with `gbp` and Debian Toolchain?

- I really have no idea yet.
