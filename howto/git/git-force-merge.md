[Implementation example](https://github.com/hilbix/gitstart/blob/46f3d195f46d00efeeea585679aa7a13e4eb9b39/aliases.sh#L506-L524)

# Why is there no forced merge in `git`?

Why is there an asymmetry?

```
+--WORKS--+    IMPOSSIBLE
v    v    v    v

o    o    o    o
|\   |\   |\   |\
| o  o |  | o  o |
o |  | o  | |  | |
| o  o |  | o  o |
|/   |/   |/   |/
o    o    o    o
|    |    |    |
```

WTF WHY?

I need the latter.  I need it badly in case I have to revert some 100 commits.

Why do I need this?  Think of a debian package.  It goes v1.  Then v2.  Then v3.  Then v4.

Then something drastically happens and the next version after v4 is v1 again.
However you have to increment the version to v5, but the files stay at v1.

In that case you do not want to leave behind the changelog, as this still must keep the history.
So you cannot do a revert - this then does not explain the changelog - **you must do a merge**.

As `master` is on `v2.2` the merge must come from `v1`, not from `v2.2`!
But `git` refuses to merge in this case.  Consider:

```
Before:      master--+
    oldmaster--+     |
               v     v
               
v1 --- v2 --- v3 --- v4

After:              master--+
          oldmaster--+      |
                     v      v
                     
v1 --- v2 --- v3 --- v4 --- v5
  \                         /
    -----------------------         <--- no commit on this!
```

How to archive this?

I call it "fakemerge".  Fakemerge does following:

- It just creates a merge node with some dummy text on the current branch with the given revisions.
- The first revision is the parent.  The other revisions are just more pointers.

    git fake-merge rev

Just stage all files which then shall become the outcome of the merge.  You need at least one revisions.

In the above variant you would do:

    git read-tree v1
    git checkout -- debian/changelog
    git fake-merge v1
    git commit --amend

```
git-fake-merge()
{
# T.B.D. as I have no idea what to do
}
```

[Implemented here](https://github.com/hilbix/gitstart/blob/46f3d195f46d00efeeea585679aa7a13e4eb9b39/aliases.sh#L506-L524)
