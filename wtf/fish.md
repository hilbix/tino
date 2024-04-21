# WTF

## `fish` - Friendly Interactive SHell

After

```
sudo apt install fish
```

I see this

```
tino@bookworm:~$ fish
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
tino@bookworm ~> help
Error: no such file "file:///usr/share/doc/fish/index.html"
tino@bookworm ~ [2]>
tino@bookworm:~$ ls -al /usr/share/doc/fish/index.html
-rw-r--r-- 1 root root 23731 Dec 21 14:47 /usr/share/doc/fish/index.html
```

Not very friendly!

