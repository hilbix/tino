See also [`git` sparse and shallow checkout](sparse-shallow.md)

# git

## TL;DR

I do not want to use methods, which do not work at scale.
Hence, as long as this is not solved, I stay with meta repos instead of Monorepos.
([Example](https://github.com/hilbix/src))

Here are some commands needed with Monorepos (or bigger `git` repos):

- clone only the topmost commit object (a single commit object, very fast, but lacks all data):  
  `git clone --no-checkout --filter=tree:0    --depth 1`
- clone the topmost commit with full tree data (feasible):  
  `git clone --no-checkout --filter=blob:none --depth 1`
- clone all commit objects (full history but no data, slow):  
  `git clone --no-checkout --filter=tree:0`
- clone all tree data (very slow, big):  
  `git clone --no-checkout --filter=blob:none`
- clone everything (deadly slow to unbearable):  
  `git clone --no-checkout`


## Monorepo unsolved

So how to feasibly do a Monorepo in `git`?

- How to checkout a single tree path of a single commit of a Monorepo
  - Currently I only manage to download all trees of a single commit
  - This can be millions (if not more) of completely unnecessary objects
- How to satisfy `.git` with all files needed to work quickly without reaching out to the network
  - I.E. `git blame` within the `sparse-checkout`ed files.
- How to limit `git` to a managable amount of `commit` objects
  - Think about a Monorepo with 1+ commits per second

Read:

- I do not think, Monorepos are feasible in `git` this way.
  - Better use a top repo which then links to submodules, so you can easily checkout each path
  - I call these type of repos "meta repos"
- YMMV if you have more knowledge than me in this area.
  - **In that case, please share your knowledge!**

### Number challenge

- Top level tree objects with 100k entries each
  - Around 5 MB compressed
- Incoming
  - 1 commits/s
  - 6 MB/s in trees (compressed)
  - 1 MB/s in blobs (compressed)
  - Hence per second there are 10 to 20 objects added in total
  - Even your smartpone is able to handle such an incoming load!
- After a year:
  - 30 000 000 top level commit objects
  - 500 000 000 objects
  - 200 TiB repo size

> Again to stress it:  **There is nothing wrong with these numbers!**
>
> Even a $75 Raspberry PI400 can manage an incoming load of this size easily!
> All you need is to attach enough storage to it (USB3 or iSCSI or NFS).

This leaves us with following questions:

- How to serve such a repo on the **outgoing** side?
- How can clients clone this efficiently?
- How can clients keep their subtrees up-to-date?

Compare with:

- One meta repo binding 100k git repos as submodules
- The repos can independently move from the meta repo
  - Hence you do can relax the commits to the meta repo to 1 per minute
- In that case you can even serve this with a PI400 easily
  - As the load is distributed across the 100k repos of different size
