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

- I am really not sure, as this is not really explained good.
- It appears to me, that you can use [any Linux Docker-Contaner](https://hub.docker.com/explore/) via `image: DOCKERIMAGE/TAG`
  - `https://hub.docker.com/_/DOCKERIMAGE` can be accessed with `DOCKERIMAGE` directly
  - `https://hub.docker.com/r/OWNER/IMAGE` can be accessed with `DOCKERIMAGE` given as `OWNER/IMAGE`
  - `TAG`s are listed on the "Tags" page of the Docker image on hub.docker.com (page `https://hub.docker.com/r/OWNER/IMAGE/tags/`)
- I did not find out yet how to do this machine readable.  But there probably is a way.

Docker?

- Sorry, I really have no idea, yet.  
- Docker looks worthwhile in the context of a public CI.  But in over 30 years of intimate experience in IT, networking, computing and software development, and even with an Asperger-IQ above 150, I still was unable to find out how to run Docker, Gradle, Maven and similar in a secure fashion (inner+outer+sidechannel+hub should add up to, at least, 399,9999999%) at my side.  So I cannot use it for me myself and I to improve things.  Hence I never came around to look into it, because I do not think, it helps me much.

How to compile for Windows or MacOS?

- Both work in the free tier, too.
- [Windows](https://cirrus-ci.org/guide/windows/) executes on Azure (untested so far) `windows_container`s:  
  [`cirrusci/windowsservercore:2016`](https://hub.docker.com/r/cirrusci/windowsservercore/tags/)  
  [`microsoft/windowsservercore:ltsc2016`](https://hub.docker.com/r/microsoft/windowsservercore/tags/)  
- [MacOSx](https://cirrus-ci.org/guide/macOS/) executes on Anka Cloud [example](https://github.com/hilbix/macshim/blob/dev/.cirrus.yml)) [`osx_instance`](https://github.com/cirruslabs/osx-images)s:  
  `high-sierra-base` without Xcode  
  `high-sierra-xcode-9.4` with Xcode 9.4  
  `high-sierra-xcode-9.4.1` with Xcode 9.4.1  
- Android and others [see yourself](https://hub.docker.com/u/cirrusci/)

How to use with `gbp` and Debian Toolchain?

- I really have no idea yet.
- However it should be easy to find out when I find the time to look into it.
