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
  prep_script: git submodule update --init
  compile_script: make
  install_script: make install
```

> Compile runs as `root` (at least in container `gcc:lastest`), so `sudo` is not needed.

- `git commit -A`
- `git push`
- Refresh https://cirrus-ci.com/


# `.cirrus.yml` HowTo

T.B.D.

# Other questions

Where Do I find a list of all possible containers?

- I really have no idea yet.

How to compile for Windows or MacOS?

- I really have no idea yet.

How to use with `gbp` and Debian Toolchain?

- I really have no idea yet.
