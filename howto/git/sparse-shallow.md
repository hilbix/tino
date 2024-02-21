# `git`

Missing links:

- How to update to new upstream commits
- How to fetch the complete history of those files
  - But only of those files
- How to improve checkout speed

## TL;DR

The trick is `git clone --no-checkout --depth 1 --filter tree:0` on the origin.  Everything else then is mostly straight forward.

```
git clone -b main --no-checkout --depth 1 --filter=tree:0 https://chromium.googlesource.com/chromium/src.git
unset GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWUNTRACKEDFILES
cd src
git sparse-checkout init --no-cone
git sparse-checkout set 'extensions/common/api/*.json'
GIT_TRACE=1 git checkout --progress
```

With

```
du -sk .git extensions
```

gives

```
77940   .git
416     extensions
```

Which is a good tradeoff.


## Very Sparse and shallow checkout

> Based on <https://unix.stackexchange.com/a/468182/23450>

For a sparse and shallow checkout, we only need

- The commit
- The root tree
- All trees down there for what is sparsly needed
- And the objects which shall be checked out

There is no need to fetch objects, which are besides these area.

It all starts with:

```
git clone -b main --no-checkout --depth 1 --filter=tree:0 https://chromium.googlesource.com/chromium/src.git
```

- With `--depth 1` this only downloads a single topmost commit object
  - This is a single object
  - So this is very shallow and very sparse.
- Without `--depth=1` this does not work as expected
  - For unknown reason it does not download only commit objects, but nearly everything
  - It also is very slow.  It counts around 10k objects per second, with 12 million objects this takes 20 minutes!
- So doing it sparse and shallow seems to be is the only option here.

Output is something like:

```
Cloning into 'src'...
remote: Finding sources: 100% (1/1)
remote: Total 1 (delta 0), reused 1 (delta 0)
Receiving objects: 100% (1/1), done.
```

> With my setting here `git` steadily connects to the network then:
>
> ```
> GIT_PS1_SHOWDIRTYSTATE=yes
> GIT_PS1_SHOWUNTRACKEDFILES=yes
> GIT_PS1_SHOWUPSTREAM=verbose
> ```
>
> To preven this, I switch into a `nonet` network namespace:
>
> ```
> suid nonet-mk	# to create a "nonet" namespace - if it does not exist
> suid nonet	# to enter the "nonet" namespace
> ```
>
> This needs my [suid](https://github.com/hilbix/suid) tool installed with following files:
> 
> - [`/etc/suid.conf.d/nonet.conf`](https://github.com/hilbix/suid/blob/master/suid.conf.d.example/nonet.conf.ex)
> - [`/.fixenv`](https://github.com/hilbix/suid/blob/master/suid.conf.d.example/.fixenv)
>
> Alternatively do following to stop `git` from trying to resolve things with network requests:
>
> ```
> unset GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWUNTRACKEDFILES
> ```
>
> However preventing network acces entirely keeps things tidy at that state, because of things like following:
>
> ```
> $ git show
> fatal: unable to access 'https://chromium.googlesource.com/chromium/src.git/': Could not resolve host: chromium.googlesource.com
> fatal: unable to read tree 7456467aafc93b8739bdea7d37790fdcc4d1c1e6
> ```

If everything is prepared, switch into the clone:

```
cd git
git cat-file -p HEAD
```

This dumps you the current last HEAD commit like:

> `[redacted]` possibly privacy information below:

```
tree 7456467aafc93b8739bdea7d37790fdcc4d1c1e6
parent 6ef29d19143a4b8b377589e8a4a93a6e1be69e9c
author [redacted] 1708509384 +0000
committer [redacted] 1708509384 +0000

[redacted]
```

> If you are not networked, you can also do:
>
> ```
> git rev-list --objects --all
> ```
>
> This will show, that there is only a single object yet:
>
> ```
> f5156283188139e434676fbb4661c0673631cc16
> fatal: unable to access 'https://chromium.googlesource.com/chromium/src.git/': Could not resolve host: chromium.googlesource.com
> fatal: bad tree object 7456467aafc93b8739bdea7d37790fdcc4d1c1e6
> ```
> > Notice `tree 7456467aafc93b8739bdea7d37790fdcc4d1c1e6` above
>
> For some unknown reason `git` seems to try to pull in something from remote here.
> No questions asked.

Now set the sparse checkout information:

```
git sparse-checkout init --no-cone
git sparse-checkout set 'extensions/common/api/*.json'
git sparse-checkout list
```

prints

```
extensions/common/api/*.json
```

Now, outside of the networked namespace:

```
git checkout --progress
```

or if you like to see more:

```
GIT_CURL_VERBOSE=1 GIT_TRACE=1 git checkout --progress
```

Note that this is very very very slow, because it apparently downloads the hierarchies one-by-one.

But it works.

```
find * -type f -ls
```

outputs

```
tino@yeti:~/git/chromium/src2(main|SPARSE=)$ find * -type f -ls
 84974923     20 -rw-r--r--   1 tino     tino        16797 Feb 21 11:44 extensions/common/api/management.json
 84974927      4 -rw-r--r--   1 tino     tino         1144 Feb 21 11:44 extensions/common/api/requirements.json
 84974911      8 -rw-r--r--   1 tino     tino         7347 Feb 21 11:44 extensions/common/api/_behavior_features.json
 84974936      4 -rw-r--r--   1 tino     tino          568 Feb 21 11:44 extensions/common/api/web_view_request.json
 84974913     32 -rw-r--r--   1 tino     tino        31519 Feb 21 11:44 extensions/common/api/_permission_features.json
 84974914      4 -rw-r--r--   1 tino     tino         1384 Feb 21 11:44 extensions/common/api/app_view_guest_internal.json
 84974925      4 -rw-r--r--   1 tino     tino         1394 Feb 21 11:44 extensions/common/api/metrics_private_individual_apis.json
 84974921      4 -rw-r--r--   1 tino     tino         3038 Feb 21 11:44 extensions/common/api/idle.json
 84974917      8 -rw-r--r--   1 tino     tino         7727 Feb 21 11:44 extensions/common/api/extension_types.json
 84974919      4 -rw-r--r--   1 tino     tino         2538 Feb 21 11:44 extensions/common/api/guest_view_internal.json
 84974915     32 -rw-r--r--   1 tino     tino        29917 Feb 21 11:44 extensions/common/api/declarative_web_request.json
 84974930     16 -rw-r--r--   1 tino     tino        15396 Feb 21 11:44 extensions/common/api/test.json
 84974918     16 -rw-r--r--   1 tino     tino        12405 Feb 21 11:44 extensions/common/api/extensions_manifest_types.json
 84974928     40 -rw-r--r--   1 tino     tino        40481 Feb 21 11:44 extensions/common/api/runtime.json
 84974933     48 -rw-r--r--   1 tino     tino        48318 Feb 21 11:44 extensions/common/api/web_request.json
 84974920      8 -rw-r--r--   1 tino     tino         5307 Feb 21 11:44 extensions/common/api/i18n.json
 84974910     28 -rw-r--r--   1 tino     tino        26144 Feb 21 11:44 extensions/common/api/_api_features.json
 84974935     28 -rw-r--r--   1 tino     tino        26912 Feb 21 11:44 extensions/common/api/web_view_internal.json
 84974929     16 -rw-r--r--   1 tino     tino        12944 Feb 21 11:44 extensions/common/api/storage.json
 84974922      4 -rw-r--r--   1 tino     tino          650 Feb 21 11:44 extensions/common/api/incognito.json
 84974912     16 -rw-r--r--   1 tino     tino        13737 Feb 21 11:44 extensions/common/api/_manifest_features.json
 84974916     16 -rw-r--r--   1 tino     tino        14359 Feb 21 11:44 extensions/common/api/events.json
 84974931      8 -rw-r--r--   1 tino     tino         6984 Feb 21 11:44 extensions/common/api/types.json
 84974926      4 -rw-r--r--   1 tino     tino          290 Feb 21 11:44 extensions/common/api/mime_handler_view_guest_internal.json
 84974932     16 -rw-r--r--   1 tino     tino        15682 Feb 21 11:44 extensions/common/api/virtual_keyboard_private.json
 84974924     12 -rw-r--r--   1 tino     tino         8585 Feb 21 11:44 extensions/common/api/metrics_private.json
 84974934      4 -rw-r--r--   1 tino     tino         2089 Feb 21 11:44 extensions/common/api/web_request_internal.json
```


## Sparse and shallow checkout

> I am not completely satisfied, as this also still fetches all objects of the trees,
> not only those, which are needed to do the sparse checkout.
>
> For a better approach look above

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

du -sh extensions/
```

This outputs something like

```
remote: Finding sources: 100% (434375/434375)
remote: Total 434375 (delta 88703), reused 277809 (delta 88703)
Receiving objects: 100% (434375/434375), 1.24 GiB | 10.83 MiB/s, done.
Resolving deltas: 100% (88703/88703), done.
From https://chromium.googlesource.com/chromium/src
 * branch                  main       -> FETCH_HEAD
 * [new branch]            main       -> upstream/main

416K    extensions/
```

So 1.24 GiB downloaded for 416K of data.  I lack the words to comment on this properly.

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
