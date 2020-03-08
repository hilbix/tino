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

> This is the biggest drawback of Cirrus CI:  You have to modify your project by adding just one single small file!

Example `.cirrus.yml` to run `make` on GCC/Linux and Xcode/MacOS:

```
make_task:
  matrix:
    - container:
        image: gcc:latest
    - osx_instance:
        image: catalina-xcode
  prep_script: git submodule update --init --recursive
  compile_script: make
  install_script: make install
  test_script: make test
```

> Compile runs as `root` (at least in container `gcc:latest`), so `sudo` is not needed.

To enable and run the build, on the `master` branch do:

- `git add .cirrus.yml`
- `git commit`
- `git push`

(Or create the `.cirrus.yml` file directly on GitHub in the `master` branch.)

Refresh https://cirrus-ci.com/

- It may take a second for Cirrus-CI to recognize the change.
- Only repositories with a `.cirrus.yml` on the `master` branch with recent activities on the `master` branch are shown there
- An unlisted repo `https://github.com/{USERorORG}/{REPO}` (or `{REPO}.git`) can be accessed as `https://cirrus-ci.com/github/{USERorORG}/{REPO}` on Cirrus-CI
  - If it still does not show, it has no `.cirrus.yml` in any branch


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
  - I have no idea how to explain to a human how to create the correct `image:` line for `.cirrus.yml` in this case
  - And I really have no idea if this can pull images from any domain somehow
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
  - [`cirrusci/windowsservercore:cmake`](https://hub.docker.com/r/cirrusci/windowsservercore/tags/) uses 2019 currently and includes dev env
  - [`microsoft/windowsservercore:ltsc2019`](https://hub.docker.com/_/microsoft-windows-servercore) includes no dev env  
    [list of all tags](https://mcr.microsoft.com/v2/windows/servercore/tags/list) like `ltsc2019`

- [MacOSx](https://cirrus-ci.org/guide/macOS/) executes on [Anka](https://veertu.com/anka-technology/) Cloud ([example](https://github.com/hilbix/macshim/blob/dev/.cirrus.yml))
  - Current images [listed from Cirrus-CI](https://github.com/cirruslabs/osx-images) may be different  
    `catalina-base` without Xcode (automatically uses latest OS without Xcode)  
    `catalina-xcode` with xcode (automatically uses latest OS and Xcode)
  - Sadly you cannot test backward compatibility, as older Xcode/OS-X-images seem to automatically be upgraded to Catalina.  
    Image history (compiled 2020-03. `*`: vanished and auto-upgrades to latest OS/Xcode, `?`: not tested):
  
		catalina-xcode-11.3.1
		*mojave-xcode-11.3
		*mojave-xcode-11.2.1
		*mojave-xcode-11.2
		*mojave-xcode-11.1
		*mojave-xcode-11
		*mojave-xcode-11.0
		*mojave-xcode-10.3
		*mojave-xcode-10.2
		*mojave-xcode-10.1
		*mojave-xcode-10.0
		*high-sierra-xcode-10.0
		*high-sierra-xcode-9.4.1
		*high-sierra-xcode-9.4

- Android and others [see yourself](https://hub.docker.com/u/cirrusci/) ([examples](https://cirrus-ci.org/examples/) from Cirrus CI)

How to use with `gbp` and Debian Toolchain?

- I really have no good idea yet.
- However it should be easy to find out when I find the time to look into it.
