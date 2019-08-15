# `git-extras`

This are my rants to package `git-extras` found in Ubuntu 18.04 and why it is mostly harmful

## `git-alias`

This is a completely defunct implementation.  It not only is wrong, it also is harmful.

- `git alias a b` globally kills your alias `a`.
- `git alias` simply outputs complete nonsense, this is what I get if I run this command,
  and no, my git aliases are all working perfectly and as intended:

  ```
  /usr/bin/git-alias | wc -l
  448
  $ /usr/bin/git-alias | tail
  }
  } = 2>&1 |
  } = >&2;
  } = >&2;
  } = |
  } = |
  };
  };
  };
  };
  ```

Compare the [output of my own variant](https:/github.com/hilbix/gitstart/) of `git alias`:

```
               # 			}
               # 	}
               # END	{ for (a in f) printf("%s %-*s %s\n", a, mx, f[a], m[a]); }
               # '\'' |
               # sort' --
tv.ign:          !LC_ALL=C.UTF-8 bash -c  'for a; do git config --local --get-all igno\
               # re.tv | fgrep -qx "$a" || git config --local --add ignore.tv "$a"; do\
               # ne' --
udiff:           !git sdiff -u
up:              status
```

This not only is readable, it also is broken up into handy terminal-wide lines and protected against accidental copy'n'paste.

> No, I do not think my variant should be included instead, it is my variant and solely mine!
> I think `git alias` should do something reasonable, stable and should not do any harm ever,
> so **please leave out** such a bullshit as found in `git-extras`

## `git-archive-file`

I really have no idea why it defaults to ZIP.  My preferred archive format is `.tar` since the late 1980s.

How can I switch it to `.tar.xz`?  Permanently?

Also I have issues with this command.

- Good: It creates reproducible ZIPs.  So regardless on which machine or when I do this, the ZIP always is the same on the same commit.

- Bad: It uses the timestamp of the commit, not the one of the individual commits of the file object stored.

The latter is bad, because it thwarts the use of `make`.

If files are included which are thought to be redone with `make`, it is crucial to have correct timestamps.

Perhaps some file depends on some external reference.  Hence if the external reference changes,
you want the file to update.  There should not be a difference of a build depending on when you did the last commit.
The dependence should be, when you committed a file.

A generic standard system command must support this, so this must be considererd as a **major bug**
which renders the tool unsafe to use.

> Note that this is something nontrivial, something you do not script within a second.
>
> Hence I did not do it, because doing something like this for others needs the property to have done it right!
>
> This is why I do most things for me, and solely me alone.  So if you use it, you know that it might not be suitable for you.
>
> There are only a few exceptions to this.

## `git-authors`

    git authors
    :wq
    git authors
    :wq
    
Do I need to say more?  Complete garbage this tool!  It simply does not work.

## `git back`

Overly complicated with a lot of dead code and WTF why?

`git back N` is just an alias for `git reset --soft HEAD~N`.
Well, the latter is far better to remember and use than `git back`.

Introducing something like this just cultters the namespace unneccessarily!

## `git bug`

Be prepared to enter the twilight zone.

`git bug` is an overly complicated replacement for some far superior more easy to use `git` concepts.

Read this?  Let's go:

- `git bug bug-NNNN`

WTF?  Really?  I have to choose some `bug-NNNN` myself?  Really?  WTF!

And here I stop thinking about such a "feature".

Apropos "feature", this is just a wrapper against an even more complicated replacement named `git feature`.
It's just an alias doing `git feature -a bug args..`, but done overly complex and bloated as a script.

> Pure bloatware.  Considered a bug, as the name suggest.

## `git feature`

> (Sorry, not in alphabetical sequence due to demand)

Some overly complex and very bad designed "feature".
Especially the argument parsing part seems to be buggy as hell to me.
The code looks a bit as if it was done in a hurry by a speed-monkey.

Example: `git feature finish`

This does not create a feature branch named `finish`,
no, it finishes the feature branch.

But wait, no, it does not do this.
Actually all it does is merging a feature branch
and removing it after the merge.
For this you have to give (and remember!) the name of the feature branch.

Read:  This command is no help at all.

The right thing to express this is to do something like
`git mad BRANCH` (`mad` stands for **m**erge-**a**nd-**d**elete).

And the rest of this command?

Basically some overly complex rewording of `git checkout -b feature/FEATURE`,
wrapped into some neither overly complex command `git create-branch`.

## `git create-branch`

> (Sorry, not in alphabetical sequence due to demand)

Look at it's code!  This looks to me as being hacked together
until something came out which possibly works,
and then thrown out of the window to hopefully mature and evolve in the world.
Or something like that.

`git create-branch BRANCH` basically does `git checkout -b BRANCH`
Well sort of, because `git create-branch BRANCH ORIGIN` does `git checkout -b ORIGIN`.
(Which is sort of nuts, because it surely is not what you intended to do.)

So `git create-branch` is prone to errors.  But there is more!

`git create-branch -r BRANCH` is a hack (actually, just look into the code!)
to express `git checkout --track -b BRANCH origin/BRANCH`.

Well, sort of.  Because first, it tries to kill `BRANCH` on `origin` by overwriting it with HEAD.

> Fun fact:  You cannot create a branch on the remote which differs from your local branch.
>
> No, this is not bad habbit.  This is Gerrit.

And no error processing whatsoever.  It just does some black magic from behind,
and then pretends to not being the culprit if the world goes south.

WTF how bad can such a little bit of code be created?!?

> BTW compare:
>
> - `git create-branch BRANCH`
> - `git checkout -b BRANCH`
>
> Usually `checkout` has the alias `co`, hence:
>
> - `git create-branch BRANCH`
> - `git co -b BRANCH`
>
> With an alias of `cb=checkout -b` (which stands for `checkout branch`, not `create/branch`) this gives
>
> - `git create-branch BRANCH`
> - `git cb BRANCH`
>
> And for creating a branch on the remote, I would recommend `cr` for `create remote`.
>
> Now add some salt with `-r` or `-rREMOTE` (no space!), and you get following workflow:
>
> - `git cb -r BRANCH` or `git cb -rREMOTE BRANCH` or `git cb BRANCH REMOTE` or `git cb BRANCH REMOTE/OTHERBRANCH`
> - `git cr` as this command now can figure out what to do
>
> Much better workflow, less error prone, far more versatile and less to understand or remember.
>
> Ah, and when using `gerrit` you could attach some automagic to the remote.
> Easy and convenient, like `git cb.hook gerrit script.sh` which then augments the branch name on the remote.
>
> This also gets rid of `git feature` and `git bug` at the same time.
>
> And this is what I come up with after thinking just 5 minutes about this issue while sitting on the toilet.
> So I do not claim that this is perfect.  It's just the straight forward no-brainer!
>
> What do you can make up if you just think about it longer than this here needed to read?

# I STOP HERE, OUT OF TIME

> Continued if I get [the big Kotzen](https://en.wikipedia.org/wiki/Vomiting) again.
