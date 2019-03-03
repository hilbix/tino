> Ah, BTW, the `| cat` is far from being useless in following command: `dpkg -l gcc | cat`


# `cat` is good.  `cat` is your friend

There is no such thing as a useless use of cat!

See: http://porkmail.org/era/unix/award.html

Why?

Here is why!


## Variant 1

Just look at it:

    cat /some/protected/file | tr 'A-Z' 'a-z' | awk '$1=="wanted" { print $2 }';

vs.

    </some/protected/file tr 'A-Z' 'a-z' | awk '$1=="wanted" { print $2 }';

Do you spot the difference?

- BTW: This is valid shell syntax, so please do not look at this.  It was chosen such, that both code looks similar.

- The latter has one fork and one pipe less.

- But it creates less understandable code.

- And most important, the latter code is far less flexible.

Just look at this:

    sudo cat /some/protected/file | tr 'A-Z' 'a-z' | awk '$1=="wanted" { print $2 }';

This now makes a lot of a difference, right?


## Variant 2

    cat /some/protected/file |
    while IFS=", " read -r col1 col2 col3;
    do
      some processing;
    done;

vs.

    while IFS=", " read -r col1 col2 col3;
    do
      some processing;
    done </some/protected/file;

Do you spot the difference?

- This has two forks and one pipe less

- But the second fork perhaps has a purpose.  The latter pollutes the running shell with the 3 variables col1 col2 col3.

- Also, if `some processing` bails out (via `exit`) the latter terminates the current shell, while the first continues.

Also you must be very careful, not to redirect `stdin` of `some processing` to the file.  So let's change that:

    while IFS=", " read -ru6 col1 col2 col3;
    do
      some processing 6<&-;
    done 6</some/protected/file;

This code is much better.

## Variant 2b

Perhaps you want to set some variable within `some processing`.  In that case you can also write:

    while IFS=", " read -ru6 col1 col2 col3;
    do
      some processing 6<&-;
    done 6< <(cat /some/protected/file)

WTF?  Why would anybody want to do that?

Well, let's change that a bit to look why this perhaps is better than the other way round:

    rm -f testfile.tmp;
    while reader <&6
    do
      writer 6<&-;
    done 6<testfile.tmp;
    echo $?;

and

    rm -f testfile.tmp;
    while reader <&6
    do
      writer 6<&-;
    done 6< <(cat testfile.tmp);
    echo $?;

with

    reader() { echo R; read -r a b c; };
    writer() { echo W; };

Now, let us run this code:

Without `cat`:

    ./a.sh: line 11: testfile.tmp: No such file or directory
    1

With `cat`:

    R
    cat: testfile.tmp: No such file or directory
    0

Now it is your turn to decide which variant you do prefer.  For me it is clearly the more flexible way, done by the latter.
The error is descriptive and helps me diagnose.  While the first is less informative.  Let's run them with debugging enabled:

    + rm -f testfile.tmp
    ./a.sh: line 11: testfile.tmp: No such file or directory
    + echo 1
    1

vs.

    + rm -f testfile.tmp
    + reader
    + echo R
    R
    + read -r a b c
    ++ cat testfile.tmp
    cat: testfile.tmp: No such file or directory
    + echo 0
    0

While you can easily deduce the problem in the latter, you cannot in the first.  **Because the culprit isn't printed at all!**

You can see that as a shell-bug or whatever.  But if you use `cat` there is not even a minimal problem.

# Honorable mention

Do you spot a "little" difference of the useless use of `| cat`?  Can you do this?

```
$ dpkg -l apt
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                                                                                                               Version                                                                Architecture                                                           Description
+++-==================================================================================================================================-======================================================================-======================================================================-==========================================================================================================================================================================================================================================================================
ii  apt                                                                                                                                1.6.8                                                                  amd64                                                                  commandline package manager
```

vs.

```
$ dpkg -l apt | cat
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-=================================
ii  apt            1.6.8        amd64        commandline package manager
```

# Conclusion

All I can say is:

**Be friendly to others and use `cat` as often as you can!**


## A final note

    producer | cat | consumer

WTF?  Why would you do that?

Consider:

    cat()
    {
      touch debug.txt;
      (
        flock 6;
        ead debug < debug.txt;
        let debug++;
        echo "$debug" > debug.txt;
        echo "catting *" >debug$debug.out;
        cat "$@" | tee -a debug$debug.out;
      ) 6<debug.txt;
    };

Understood why even using `cat` in this most useless way can be a very good idea?

BTW, why do I add the `;` in these examples?  Because this aids Copy'n'Paste.
If you happen to not copy the line endings correctly, it still works.
Adding `;` does not hurt, but it can help.  So why not add it?

Likewise with `cat`:  It seldom hurts, but often helps.
