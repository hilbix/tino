# HowTo MineCraft

Here I document, how I run a customized vanilla Minecraft Server

> This is probably VERY incomplete

## Vanilla

Vanilla means, this is the original Mojang code.  No changes.  No Forge.  No Bukkit.  Nothing.
Just plain original.

However it still is highly customized for my needs.


## Why?

I tried many things.  Bukkit.  Forge.  Whatever.

However I do not have enough time to spare.  So I want someting which just works.
Which I understand.  And which is mostly hassle-free.

As we now can do many (if not all) things with datapacks, this is enough for me.

Additionally I rely on `RCON`, to give commands to the MineCraft server.

**This has the advantage, that I do not need a customized MineCraft Client, too.
Everything runs with the standard install!**

After I looked into many variants and even tried to create something on my own,
doing it this way had the best success for now.

It has its downsides, though.  Information transfer is not very good at the moment.
Or better say:  Not existing at all.

However I am confident that I will find some better information in the future.

And the best part:  I can upgrade to the newest MineCraft every time and do not have
to wait until Forge etc. comes up.


## Windows

Note that I do not use Windows often.  So everything I do is a bit Linux centric.

If you are on Windows, I therefor cannot help you much.  Best is, [install WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) and a download [a minimal Debian from Micrsoft Store](https://apps.microsoft.com/detail/9msvkqc78pk6).

Then you can probably use the commands as you find them here.  Running a MineCraft Server
on WSL2 should be possible, as WSL2 allows to keep 127.0.0.1 (localhost) in sync for both sides, the WSL and the Windows side, such that the MineCraft Client running under Windows is able to connect to the MineCraft server which listens on `127.0.0.1:25565` on the WSL2 side.


## Server?

Yes.  I run a dedicated server.  This has advantages and disadvantages.
But I am not sure it can be done with a MineCraft client alone.
So yes, the disadvantage is, that you need to run a separate thingie here somehow.

But wait, this is nothing unusual.  **The MineCraft Client actually is a MineCraft server!**  This is why you can open your singleplayer world to a second MineCraft instance!

The difference to what I do here is just that you run the server separately,
instead to have one automatically run on your behalf.

The only difference is, that the Server then runs independently of your Game.
So if you stop the Client, the separate server does not stop as well.
It continues to run until you stop it!

Everything else, however, is similar.  You can copy your existing world over to the server
and run it there.  I never spotted any difference.

So running a dedicated server is like:

- Starting a Client, but leave this Client alone
- Opening the Client to the LAN
- And then connect another Client to it which you use to play Minecraft

However with a dedicated Server you have much more control over the world than with the
Client.  However the downside is, that you probably need the Commandline and do not have
a nifty UI for this.


## How?

> In future I perhaps can provide a `git` repo for this here on GitHub.  But for now it is manually documented, sorry.

### Donload of the Server

Just download the server from Mojang (TODO: Document here where to find it on Mojang)
and unpack it.  It then looks like this:

> Yes, it is a little bit older what I did.  I have no time to update to the latest ..

```
tino@mc112:~/mc119$ ls -la
drwxr-xr-x  2 tino tino     4096 Jul 10 13:52 .
drwxr-xr-x 18 tino tino     4096 Jul 10 13:51 ..
-rw-r--r--  1 tino tino 47162712 Jul 10 13:48 minecraft_server.1.19.3.jar
```

### Setup of the Server

Create a script (here: named `.x`) and make it executable:

```
tino@mc112:~/mc119$ cat <<'MCEOF' >.x && chmod +x ./.x;
#!/bin/bash

mem=4096

unset DISPLAY
ARGS=(nogui)
ARGS=()

retries=0
timeout=5
CODE=
retry()
{
local ret=$?

CODE=" rc=$ret"

let retries++
[ 0 = "$ret" ] && retries=0

timeout=$[5 + 5 * retries]
return $ret
}

mode()
{
  TIMER=(-t "$timeout")
  PROMPT="start in ${timeout}s"
  [ -f .stop ] || return
  TIMER=()
  PROMPT='autostart diabled, start to start, help for help'
}

help()
{
  cat <<EOF
help    this help
start   start server
bye     stop this script (will restart in a minute)
stop    disable autostart
auto    enable autostart (timeout or blank line starts server)
EOF
}

while   mode
        printf '%(%Y%m%d-%H%M%S)T%s (%s): ' -1 "$CODE" "$PROMPT"
        read "${TIMER[@]}" -r cmd || cmd=
do
        case "$cmd" in
        ('')            [ -f .stop ] && echo 'autostart disabled' && continue; echo 'AUTOSTART';;
        ('help')        help; continue;;
        (bye)           break;;
        (stop)          touch .stop; continue;;
        (auto)          rm -f .stop; continue;;
        (start)         ;;
        (*)             echo 'unkown command, try: help'; continue;;
        esac
        ( set -x; exec java -Xmx${mem}M -Xms${mem}M -jar minecraft_server.jar "${ARGS[@]}" )
        retry "$?"
done
MCEOF
```

It now looks like this:

```
tino@mc112:~/mc119$ ls -al
total 46072
drwxr-xr-x  2 tino tino     4096 Jul 10 13:54 .
drwxr-xr-x 18 tino tino     4096 Jul 10 13:51 ..
-rwxr-xr-x  1 tino tino     1222 Jul 10 13:54 .x
-rw-r--r--  1 tino tino 47162712 Jul 10 13:48 minecraft_server.1.19.3.jar
```

Create the softlink to which server to run.  This way you can exchange the binary in future more easily:

```
tino@mc112:~/mc119$ ln -s minecraft_server.1.19.3.jar minecraft_server.jar
```

Run the server the first time:

```
tino@mc112:~/mc119$ ./.x
20240710-135557 (start in 5s): start
+ exec java -Xmx4096M -Xms4096M -jar minecraft_server.jar
```
now a lot of babble follows.  Enter `stop` to stop this loop:

```
[13:56:05] [ServerMain/WARN]: Failed to load eula.txt
[13:56:05] [ServerMain/INFO]: You need to agree to the EULA in order to run the server. Go to eula.txt for more info.
20240710-135649 rc=0 (start in 5s): stop
20240710-135650 rc=0 (autostart diabled, start to start, help for help): help
help    this help
start   start server
bye     stop this script (will restart in a minute)
stop    disable autostart
auto    enable autostart (timeout or blank line starts server)
20240710-135716 rc=0 (autostart diabled, start to start, help for help): bye
```

It now looks like this:

```
tino@mc112:~/mc119$ ls -al
total 46092
drwxr-xr-x  5 tino tino     4096 Jul 10 13:56 .
drwxr-xr-x 18 tino tino     4096 Jul 10 13:51 ..
-rw-r--r--  1 tino tino        0 Jul 10 13:56 .stop
-rwxr-xr-x  1 tino tino     1222 Jul 10 13:54 .x
-rw-r--r--  1 tino tino      159 Jul 10 13:56 eula.txt
drwxr-xr-x  8 tino tino     4096 Jul 10 13:55 libraries
drwxr-xr-x  2 tino tino     4096 Jul 10 13:56 logs
-rw-r--r--  1 tino tino 47162712 Jul 10 13:48 minecraft_server.1.19.3.jar
lrwxrwxrwx  1 tino tino       27 Jul 10 13:55 minecraft_server.jar -> minecraft_server.1.19.3.jar
-rw-r--r--  1 tino tino     1273 Jul 10 13:56 server.properties
drwxr-xr-x  3 tino tino     4096 Jul 10 13:55 versions
```

- `.stop` comes from my script because you entered `stop`
  - The idea is, that with `auto` (or missing `.stop` file) the server is restarted
    in case it crashes.  However give it a bit of grace period to allow me to enter
    something like `bye`
- All the other new files come from the MineCraft server.

Edit the `eula.txt` to confirm to it.

```
tino@mc112:~/mc119$ cat eula.txt 
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
#Wed Jul 10 13:56:05 CEST 2024
eula=false
tino@mc112:~/mc119$ sed -i 's/false/true/' eula.txt
tino@mc112:~/mc119$ cat eula.txt 
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
#Wed Jul 10 13:56:05 CEST 2024
eula=true
```

Start the server again:

```
tino@mc112:~/mc119$ ./.x
20240710-140115 (autostart diabled, start to start, help for help): start
+ exec java -Xmx4096M -Xms4096M -jar minecraft_server.jar
Starting net.minecraft.server.Main
[14:01:22] [ServerMain/INFO]: Building unoptimized datafixer
[14:01:23] [ServerMain/INFO]: Environment: authHost='https://authserver.mojang.com', accountsHost='https://api.mojang.com', sessionHost='https://sessionserver.mojang.com', servicesHost='https://api.minecraftservices.com', name='PROD'
[14:01:25] [ServerMain/INFO]: Loaded 7 recipes
[14:01:25] [ServerMain/INFO]: Loaded 1179 advancements
[14:01:26] [Server thread/INFO]: Starting minecraft server version 1.19.3
[14:01:26] [Server thread/INFO]: Loading properties
[14:01:26] [Server thread/INFO]: Default game type: SURVIVAL
[14:01:26] [Server thread/INFO]: Generating keypair
[14:01:26] [Server thread/INFO]: Starting Minecraft server on *:25565
[14:01:26] [Server thread/INFO]: Using epoll channel type
[14:01:26] [Server thread/WARN]: **** FAILED TO BIND TO PORT!
[14:01:26] [Server thread/WARN]: The exception was: io.netty.channel.unix.Errors$NativeIoException: bind(..) failed: Address already in use
[14:01:26] [Server thread/WARN]: Perhaps a server is already running on that port?
[14:01:26] [Server thread/ERROR]: Encountered an unexpected exception
java.lang.IllegalStateException: Failed to initialize server
	at net.minecraft.server.MinecraftServer.w(SourceFile:689) ~[server-1.19.3.jar:?]
	at net.minecraft.server.MinecraftServer.a(SourceFile:264) ~[server-1.19.3.jar:?]
	at java.lang.Thread.run(Thread.java:840) ~[?:?]
[14:01:26] [Server thread/ERROR]: This crash report has been saved to: /home/tino/mc119/./crash-reports/crash-2024-07-10_14.01.26-server.txt
[14:01:26] [Server thread/INFO]: Stopping server
[14:01:26] [Server thread/INFO]: Saving worlds
[14:01:26] [Server thread/ERROR]: Exception stopping the server
java.lang.NullPointerException: Cannot invoke "ahm.q_()" because "$$5" is null
	at net.minecraft.server.MinecraftServer.a(SourceFile:543) ~[server-1.19.3.jar:?]
	at net.minecraft.server.MinecraftServer.t(SourceFile:604) ~[server-1.19.3.jar:?]
	at agn.t(SourceFile:536) ~[server-1.19.3.jar:?]
	at net.minecraft.server.MinecraftServer.w(SourceFile:708) ~[server-1.19.3.jar:?]
	at net.minecraft.server.MinecraftServer.a(SourceFile:264) ~[server-1.19.3.jar:?]
	at java.lang.Thread.run(Thread.java:840) ~[?:?]
```

What happened?  Well, when doing this for demostration purpose I forgot to stop my "real" MC server ;)

OK, start again, now with the other server stopped:

```
20240710-140126 rc=0 (autostart diabled, start to start, help for help): start
+ exec java -Xmx4096M -Xms4096M -jar minecraft_server.jar
Starting net.minecraft.server.Main
[14:03:49] [ServerMain/INFO]: Building unoptimized datafixer
[14:03:50] [ServerMain/INFO]: Environment: authHost='https://authserver.mojang.com', accountsHost='https://api.mojang.com', sessionHost='https://sessionserver.mojang.com', servicesHost='https://api.minecraftservices.com', name='PROD'
[14:03:53] [ServerMain/INFO]: Loaded 7 recipes
[14:03:53] [ServerMain/INFO]: Loaded 1179 advancements
[14:03:53] [Server thread/INFO]: Starting minecraft server version 1.19.3
[14:03:53] [Server thread/INFO]: Loading properties
[14:03:53] [Server thread/INFO]: Default game type: SURVIVAL
[14:03:53] [Server thread/INFO]: Generating keypair
[14:03:53] [Server thread/INFO]: Starting Minecraft server on *:25565
[14:03:53] [Server thread/INFO]: Using epoll channel type
[14:03:54] [Server thread/INFO]: Preparing level "world"
[14:03:59] [Server thread/INFO]: Preparing start region for dimension minecraft:overworld
[14:04:00] [Worker-Main-3/INFO]: Preparing spawn area: 0%
```

and so on until

```
[14:04:25] [Worker-Main-2/INFO]: Preparing spawn area: 97%
[14:04:25] [Server thread/INFO]: Time elapsed: 25871 ms
[14:04:25] [Server thread/INFO]: Done (31.370s)! For help, type "help"
```

The last prompt is from the MineCraft server, not from my script!
So you can control the server via this interface.

> However this interface is the "normal" MC console.  It is not very suitable
> to automate things.  However it is good for setting up things.

### OP yourself

Now the first thing I do on the MC console to "OP" myself.

> `Individulas` is my MC nickname.  You should replace it with your MC nickname.

```
op Individulas
[14:05:30] [Server thread/INFO]: Made Individulas a server operator
```

The server now is up and running!  Stop the server and look at the directory.

Enter `stop` to stop the MC server,
then enter `bye` to exit my script.

```
stop
[14:10:09] [Server thread/INFO]: Stopping the server
[14:10:09] [Server thread/INFO]: Stopping server
[14:10:09] [Server thread/INFO]: Saving players
[14:10:09] [Server thread/INFO]: Saving worlds
[14:10:11] [Server thread/INFO]: Saving chunks for level 'ServerLevel[world]'/minecraft:overworld
[14:10:11] [Server thread/INFO]: Saving chunks for level 'ServerLevel[world]'/minecraft:the_nether
[14:10:11] [Server thread/INFO]: Saving chunks for level 'ServerLevel[world]'/minecraft:the_end
[14:10:11] [Server thread/INFO]: ThreadedAnvilChunkStorage (world): All chunks are saved
[14:10:11] [Server thread/INFO]: ThreadedAnvilChunkStorage (DIM-1): All chunks are saved
[14:10:11] [Server thread/INFO]: ThreadedAnvilChunkStorage (DIM1): All chunks are saved
[14:10:11] [Server thread/INFO]: ThreadedAnvilChunkStorage: All dimensions are saved
20240710-141012 rc=0 (autostart diabled, start to start, help for help): bye
tino@mc112:~/mc119$ ls -al
total 46120
drwxr-xr-x  7 tino tino     4096 Jul 10 14:03 .
drwxr-xr-x 18 tino tino     4096 Jul 10 13:51 ..
-rw-r--r--  1 tino tino        0 Jul 10 14:11 .stop
-rwxr-xr-x  1 tino tino     1222 Jul 10 13:54 .x
-rw-r--r--  1 tino tino        2 Jul 10 14:03 banned-ips.json
-rw-r--r--  1 tino tino        2 Jul 10 14:03 banned-players.json
drwxr-xr-x  2 tino tino     4096 Jul 10 14:01 crash-reports
-rw-r--r--  1 tino tino      158 Jul 10 14:00 eula.txt
drwxr-xr-x  8 tino tino     4096 Jul 10 13:55 libraries
drwxr-xr-x  2 tino tino     4096 Jul 10 14:03 logs
-rw-r--r--  1 tino tino 47162712 Jul 10 13:48 minecraft_server.1.19.3.jar
lrwxrwxrwx  1 tino tino       27 Jul 10 13:55 minecraft_server.jar -> minecraft_server.1.19.3.jar
-rw-r--r--  1 tino tino      139 Jul 10 14:05 ops.json
-rw-r--r--  1 tino tino     1273 Jul 10 14:03 server.properties
-rw-r--r--  1 tino tino      110 Jul 10 14:05 usercache.json
drwxr-xr-x  3 tino tino     4096 Jul 10 13:55 versions
-rw-r--r--  1 tino tino        2 Jul 10 14:03 whitelist.json
drwxr-xr-x 10 tino tino     4096 Jul 10 14:10 world
```

You can edit the `server.properties` file to change the settings as you like them.  The changes I do are:

> Lines with `<` is what the server wrote by default where lines with `>` are what I changed them to.

```diff
]tino@mc112:~/mc119$ diff server.properties ../mc/server.properties
2c2
< #Wed Jul 10 14:03:50 CEST 2024
---
> #Wed Jul 10 13:11:01 CEST 2024
5c5,6
< level-seed=
---
> level-seed=HERESOMESEED
> enable-command-block=true
7d7
< enable-command-block=false
12c12
< motd=A Minecraft Server
---
> motd=Neubeginn
21d20
< use-native-transport=true
22a22
> use-native-transport=true
25c25
< allow-flight=false
---
> allow-flight=true
27,28c27,28
< broadcast-rcon-to-ops=true
< view-distance=10
---
> broadcast-rcon-to-ops=false
> view-distance=15
33c33
< enable-rcon=false
---
> enable-rcon=true
41c41
< rcon.password=
---
> rcon.password=CHANGETHISPASSWORD
48a49
> previews-chat=false
49a51
> snooper-enabled=false
52c54
< level-type=minecraft\:normal
---
> level-type=default
56c58
< spawn-protection=16
---
> spawn-protection=32
```

The important parts are:

- `server-ip=127.0.0.1` to restrict the server to listen on the loopback interface
  - I do not need this, as I run in an externally secured VM.
  - However you probably want this, especially if running on WSL2!
- `enable-rcon=true` to enable RCON
- `rcon.password=CHANGETHISPASSWORD` to set a password for the console
- `broadcast-rcon-to-ops=true` is good as long as you play alone or with friends on this server
  - If you want a real multiplayer server, perhaps do not enable this, as it spoilers
- `enable-command-block=true` is probably what you want to allow the use of command blocks
- `allow-flight=true` usually is good as long as you test your own server instance
- `level-seed=HERESOMESEED` such that if you remove the world you can recreate it with the given seed
  - Note that different MC version create different data from the same seed
- `level-type=minecraft\:normal` I have no idea.  Probably the current default is `minecraft:normal` now and my setting `default` is from older versions of MC server
- `snooper-enabled=false` reduces the network babble of the server (switches off the phone home)

Note that there is another setting which allows to connect with arbitrary (hacked) MC clients:

- `online-mode=true` if set to `false` the server does not communicate with the Mojang servers
  - This is needed if you want to play while being offline (so without Internet connectivity)
- `enable-status=true` allows others to fetch the status (number of players) on the server
  - I usually leave this on, as this only can be seen if you can connect to the server
  - As it listens on 127.0.0.1 on default nobody else than you can connect to it
 
After your `server.propertes` is edited, start the server again:

```
tino@mc112:~/mc119$ ./.x
20240710-143031 (autostart diabled, start to start, help for help): start
+ exec java -Xmx4096M -Xms4096M -jar minecraft_server.jar
Starting net.minecraft.server.Main
[14:30:38] [ServerMain/INFO]: Building unoptimized datafixer
[14:30:39] [ServerMain/INFO]: Environment: authHost='https://authserver.mojang.com', accountsHost='https://api.mojang.com', sessionHost='https://sessionserver.mojang.com', servicesHost='https://api.minecraftservices.com', name='PROD'
[14:30:41] [ServerMain/INFO]: Loaded 7 recipes
[14:30:42] [ServerMain/INFO]: Loaded 1179 advancements
[14:30:42] [Server thread/INFO]: Starting minecraft server version 1.19.3
[14:30:42] [Server thread/INFO]: Loading properties
[14:30:42] [Server thread/INFO]: Default game type: SURVIVAL
[14:30:42] [Server thread/INFO]: Generating keypair
[14:30:42] [Server thread/INFO]: Starting Minecraft server on 127.0.0.1:25565
[14:30:42] [Server thread/INFO]: Using epoll channel type
[14:30:42] [Server thread/INFO]: Preparing level "world"
[14:30:45] [Server thread/INFO]: Preparing start region for dimension minecraft:overworld
[14:30:48] [Worker-Main-1/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-3/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-3/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-3/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-2/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-2/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-2/INFO]: Preparing spawn area: 0%
[14:30:48] [Worker-Main-2/INFO]: Preparing spawn area: 1%
[14:30:49] [Worker-Main-3/INFO]: Preparing spawn area: 57%
[14:30:49] [Server thread/INFO]: Time elapsed: 4369 ms
[14:30:49] [Server thread/INFO]: Done (6.813s)! For help, type "help"
[14:30:49] [Server thread/INFO]: Starting remote control listener
[14:30:49] [Server thread/INFO]: Thread RCON Listener started
[14:30:49] [Server thread/INFO]: RCON running on 127.0.0.1:25575
```

On a second terminal you can see the network connections:

```
tino@mc112:~/mc119$ netstat -natp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
tcp6       0      0 ::1:25                  :::*                    LISTEN      -                   
tcp6       0      0 127.0.0.1:25565         :::*                    LISTEN      7826/java           
tcp6       0      0 127.0.0.1:25575         :::*                    LISTEN      7826/java           
tcp6       0      0 :::22                   :::*                    LISTEN      -                   
```
Or more modern:
```
tino@mc112:~/mc119$ ss -tap
State       Recv-Q      Send-Q                Local Address:Port              Peer Address:Port       Process                               
LISTEN      0           20                        127.0.0.1:smtp                   0.0.0.0:*                                                
LISTEN      0           128                         0.0.0.0:ssh                    0.0.0.0:*                                                
LISTEN      0           20                            [::1]:smtp                      [::]:*                                                
LISTEN      0           4096             [::ffff:127.0.0.1]:25565                        *:*           users:(("java",pid=7826,fd=66))      
LISTEN      0           50               [::ffff:127.0.0.1]:25575                        *:*           users:(("java",pid=7826,fd=79))      
LISTEN      0           128                            [::]:ssh                       [::]:*                                                
```
