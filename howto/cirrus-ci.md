> **Very Important!**
>
> Very unusual these days **Cirrus-CI displays the right attitude when it comes to security**!
>
> [In their documentation](https://cirrus-ci.org/examples/#release-assets) they write
>
> > Cirrus CI only requires write access to Check API and doesn't require write access to repository contents because of security reasons.
>
> That's exactly the point!  **Thank you very much, Cirrus CI team, for doing it right!**

# GitHub Cirrus CI micro HowTo

Unfortunately, Cirrus CI is not self explanatory.  You need documentation.  This tries to sum it up.

But if you managed that, it "just works"(tm) as it ought to be.

Benefit: It provides CI for Linux, Windows and MacOS-X.


# Hello World

## Enable it on GitHub Marketplace

Enable [Cirrus CI on GitHub marketplace](https://github.com/marketplace/cirrus-ci).
- Choose the free plan
- Use it for all of your repositories (it does not hurt and makes everything work automagic)

## Open Cirrus CI web UI

Open https://cirrus-ci.com/
- Let it access your GitHub account
- **Keep it open** to see what Cirrus CI is doing.
- Do not be puzzled.  Nothingh shows up there until your first push to a project with a `.cirrus.yml` file.  Then it fills with life, fully automagically!

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

> Compile runs as `root` (at least in container `gcc:latest`), so `sudo` is not needed.

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

Where do I find a list of all possible containers?

- It appears to me, that you can use [any Linux Docker-Container](https://hub.docker.com/explore/)
- On [DockerHUB](https://hub.docker.com/explore/) locate the repo you want
- Often you will find a better readable list of available `TAG`s in the "Description" view already
  - This is only good for orientation, so remember the right `TAG` name
- Switch over to the "Tags" view
- Locate the `TAG` you want
- On the right of the `TAG` you will see something like `docker pull IMAGE:TAG`
  - The `IMAGE:TAG` is what you need for `.cirrus.yml`: `image: IMAGE:TAG`
- [official images](https://github.com/docker-library/official-images) do not have a `/` (like: `debian:buster-slim`)
- [user repos](https://docs.docker.com/docker-hub/repos/) do have one `/` (like: `cirrusci/android-sdk:27`)
- Specials like [Bazel](https://cirrus-ci.org/examples/#bazel) have more `/`es (like `image: l.gcr.io/google/bazel:latest`)
  - I really have no idea if this can pull images from any domain somehow
- I did not find out how to get a machine readable list of docker images.  But there probably is some tool or API for it, too.
  - Note that I am not looking for the `docker` command, as this needs to run in a real computer.
  - What I want to see is something which can be accessed by using `curl` (or AJAX or your phone).

Docker?

- There is a way to create your own (public) Docker image to use in Cirrus-CI.
- [Probably worth reading](https://cirrus-ci.org/guide/docker-builder/), however I do not understand what this wants to tell me.
- Docker (only!) looks worthwhile in the context of a public(!) CI.  
  In over 30 years of intimate experience in IT, networking, computing and software development, and even with an Asperger-IQ above 150, I am still unable to find out how to run Docker, Gradle, Maven and similar in a secure fashion at my own computer (inner+outer+sidechannel+hub should add up to, at least, 399,9999999% security, but AFAICS they add up to -299% security).  So I cannot use it for Me Myself and I to improve things because it is too dangerous to run myself.  Hence I never came around to look into it more deeply, because I do not think, it helps me much.  Hence I doubt I ever can help on how to docker for yourself.

How to compile for Windows or MacOSX?

- All work in the free tier, too.  (At least I think so.)
- [Windows](https://cirrus-ci.org/guide/windows/) executes on Azure `windows_container`s (but I never did this yet, so I am not sure):  
  [`cirrusci/windowsservercore:2016`](https://hub.docker.com/r/cirrusci/windowsservercore/tags/)  
  [`microsoft/windowsservercore:ltsc2016`](https://hub.docker.com/r/microsoft/windowsservercore/tags/)  
  Probably more
- [MacOSx](https://cirrus-ci.org/guide/macOS/) executes on Anka Cloud [example](https://github.com/hilbix/macshim/blob/dev/.cirrus.yml)) [`osx_instance`](https://github.com/cirruslabs/osx-images)s:  
  `high-sierra-base` without Xcode  
  `high-sierra-xcode-9.4` with Xcode 9.4  
  `high-sierra-xcode-9.4.1` with Xcode 9.4.1  
  (This list was compiled in 2018-09, the images [listed there](https://github.com/cirruslabs/osx-images) are now different)
- Android and others [see yourself](https://hub.docker.com/u/cirrusci/) ([examples](https://cirrus-ci.org/examples/) from Cirrus CI)

How to use with `gbp` and Debian Toolchain?

- I really have no idea yet.
- However it should be easy to find out when I find the time to look into it.
