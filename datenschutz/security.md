Some words about security:

- use `git`
- use `git submodule`
- and **stop using `gradle`, `maven` and similar, they are pure insanity**!
- If it comes to Debian, [verify your sources](https://gist.github.com/hilbix/0085d19470d5ac754cf26118c824e057)!
  (This works with Debian, Ubuntu and Devuan.)

It's easy to create and use software in a secure fashion.  As long as you follow this easy path.


# Security

If you want to have a secure setup, you must respect some cornerstones of security:

- Safe Spot:  You need some secure environment.

- Borders:  The environment has different borders.  If one border is compromized, security is not affected in the whole.

- Living:  You need to live Security, to keep it secure.

> Did I forget a cornerstone?  Perhaps.  This text is mainly due to explain the Safe Spot.


## Safe Spot

> The safe spot is often forgotten.  To explain the safe spot is the motivation of this text.

Security must be based on a safe spot.  This means, some point in time which you can declare safe or proof to be safe.

This is a mathematical neccessity.  If you have no root, on which you can base your assumptions,
you do not have anything.  **If you are just pretending to be secure, you are willfully lying.**

This safe spot has to meet some basic requirements to be able to create it:

- repeatable:  So you must be able to virtually go back in time to re-create the safe spot from scratch
- verified:  You must be able to verify correctness of the safe spot.  If you are not able to proof every claim, you fail.
- secured:  The Safe Spot must be secured.  This means, it must offer some protection against some known threats.

Note that this does not need to be perfect.  **There is no such thing as a perfect security.**
(According to Kurt Gödel: The only perfect security is if there is no security at all or there is no system to secure.)

Security is not about perfection.  Security is about proper handling of all threats.

### Repeatable

Repetition guarantee is an essential part of Security.  It simply cannot be left away.

If you spot a flaw in your Security, you must be able to detect, where it came from.

Perhaps your Safe Spot already had this flaw.  So you need to be able to re-create it from scratch to proof this.

- Quite often this is not needed because things are clear.
- Quite often this means, you update your Safe Spot and thus create another one.
- Sometimes you have to change your preferences, so change your claims.

But sometimes you have to add a new threat which must be checked against your Safe Spot again to be able to mitigate the
threat.  And things are not-so-clear.  In that case you must be able to do verification again.

Hence without the ability to re-create the Safe Spot you have to re-evaluate your whole Security.
Which is a major act.  Something which ususally is not worth doing.
(Usually the better approach is to re-design Security from scratch then.  To re-think everything.)

**In software this is quite common.**

For example if you have a major flaw and you have to take everything offline.

Then you want to re-install everything and make sure in parallel, that the flaw does no more affect the new system.

Perhaps you can trust others to do the right thing for you.  This is when you just upgrade to the newest version of
the software.  But this is not always what you can do.  This is Security-by-Trust.

If you need to give a security guarantee, and with the DSGVO AKA GDPR you cannot escape this neccessity if you
are processing personal data, you cannot base this on a shere trust, that the Cloud will do it right.
You need to proof this.  And you cannot proof trust.

> The escape route for DSGVO is, to write this down.  To explain, whom you trust, which Cloud services your
> system is based on, such that the users are able to follow your route.  If you do not do this, you are
> lonely responsible for keeping things secure.  And it is your solely fault if things get hacked.
> Because you had false claims in your data protection regulations or forgot to fully explain things.
> And you are fully responsible for this.
>
> The problem here is that if something is backdoored, this is not a software flaw or breach-in.
> You do not have been hacked and there was no exploited bug.
>
> You have - actively - installed something which gave access to precious data for others.
> You have let others onto your system and gave them full access.
> Perhaps not knowingly.  But this is not even the biggest problem here.
>
> The problem here is that you blindly trusted others.  Others who you do not know.
> Others who have not proven to be trustworthy.  Others who are **known to not be trustworthy** in advance.
> (At least you read it here.  So this is known in advance.  You ignored that.  All I can do is warn you!)
>
> I do not say that you need to proof your innocence.  This is not the thing here.
> Because it is already known, that you are guilty.  Guilty for trusting others who are not trustworthy,
> and blindly belief in quotes which tell you, everything is sound and secure, without checking evidence.
> And it is proven that you lied, when you wrote the data protection regulations.
> Hence your data protection regulations are void.
>
> And even worse, you are not even close to be able to mitigate this problem when it hits you,
> because you cannot even tell the truth, because it can be proven that you are unable to know the truth yourself.
> So everything you claim to the officials is provenly just wishful thinking.
> You did not do your homework.  You lie to the officials.  And even if you tell the truth, you only do this by accident.
>
> To say it in German words:
>
> Der Einsatz externer Repositorien ist **grundsätzlich vorsätzlich grob fahrlässig**.
>
> Das gilt für alle Repsitorien, die keinen absoluten Schutz gewähren, so wie es `git` tut.
>
> Also für alle Repositorien die in heute typischer Software genutzt wird, die
> `gradle`, `bower`, `maven`, oder ähliches (`pip`, `pear`, `composer`, `gem`, golang, Perl package manager etc.) verwendet.
>
> Und das ist inzwischen über 90% der Software heutzutage.  Diese ist deshalb grundsätzlich unbrauchbar und unverwendbar,
> jedenfalls wenn sie in einem Bereich eingesetzt wird, auf die die DSGVO zutrifft. 
>
> Im Gegensatz kann man `git` als sicher ansehen, so lange es per `git submodule` gemacht ist.
>
> Der Grund:  Ich kann hier in einer mathematisch beweisbaren Form (also gerichtsfest) nachweisen,
> was ich installiert habe.  Dies kann von unabhängigen Experten im stillen Kämmerlein nachvollzogen
> und auch nachgewiesen werden.  Das ist hinreichend zweifelsfrei.
>
> Verwende ich aber z. B. `maven`, kann der Gutachter nur feststellen, dass die damals eingesetzte Software
> mit dem heute verfügbaren Maven-Repository - sofern sie sich überhaupt noch übersetzen lässt, weil nicht
> irgendwelche Abhängigkeiten verschwunden sind - einen bestimmten Stand repräsentiert.
>
> Ob die vom Gutachter untersuchte Software überhaupt so im Einsatz war, kann nicht mehr zweifelsfrei nachgewiesen werden.
> Außer man hat einen unheimlichen Aufwand getrieben, den die wenigsten Betreiber treiben dürften.
> (Nämlich aus den Backups in der Lage sind, den exakten Point-In-Time wiederherzustellen,
> und zwar so, dass der Gutachter in die Lage versetzt wird, dies zu begutachten.)
>
> Kann man es aber nicht mathematisch sicher und lückenlos nachweisen, welche Software man genau früher eingesetzt hat,
> (und ohne Speicherabbild des flüchtigen Speichers vom Hostsystem wird man in vielen Situationen nicht nachweisen können)
> bedeutet das, dass man gewisse Annahmen über die Software getroffen hat.  Annahmen, die sich als falsch herausgestellt haben.
> Denn sonst hätte es keine Datenlücke gegeben.
>
> Kann ich also die Herkunft der Datenlücke nicht zweifelsfrei nachvollziehen, und auch das ist mehr als nur sehr häufig
> nicht möglich, bin ich auf reine Spekulationen angewiesen.  Spekulationen, wie der Zustand der Software war.
> Spekulationen, wie es zum Datenleck kam.  Spekulationen wie umfangreich der Bruch war usw.
>
> Der sichere Umgang mit solch einer Sache bedeutet, ich muss immer das wahrscheinliche Maximum annehmen.
> Nicht das wahrscheinliche Minimum von dem, was ich entdeckt habe.  Ich muss also Möglichkeiten ausschließen.
>
> Da ich aber nur Spekulationen habe, muss ich davon ausgehen, dass meine Annahmen alle falsch sind.
> Jedenfalls so lange ich keinerlei sinnvolle Annahme darüber treffen kann, ob die Annahmen zutreffen oder nicht.
>
> Gem. DSGVO bin ich verpflichtet, den Nutzer darüber aufzuklären, wie die Daten verarbeitet werden.
> Art. 13 (3) DSGVO legt fest, dass ich das tun muss, wenn ich beabsichtig, die Daten weiterzugeben.
> Meineserachtens liegt diese Absicht vor, wenn man diese Möglichkeit auf fahrlässige Weise nicht explizit ausschließen kann.
>
> Beispielsweise liegt eine Absicht zur Geschwindigkeitsüberschreitung vor, wenn ich grundsätzlich mit 50 km/h fahre.
> Ich habe dann eigentlich nicht vor, zu schnell zu fahren, ich fahre ja nur 50.  Aber in 30er-Zonen fahre ich dann zu schnell.
> Es gibt also keine explizite Absicht, aber eine implizite, weil ich fahrlässig nicht mit angepasster Geschwindigkeit fahre.
> 
> Genauso implizit ist die Absicht der Datenweitergabe, wenn ich nur Wunsch-Annahmen zur Sicherheit von Fremdsoftware treffe.
> Ich nehme zwar an, die Software ist sicher, die ich einsetze, habe aber keinerlei Maßnahmen für den Fall getroffen
> dass ich mich irre.  Ich habe auch keinerlei Hinweise darauf, dass die Software sicher ist.  Der einzige Grund dafür ist,
> dass ich deren Sicherheit annehmen will, weil mir das gerade so in den Kram passt.  Obwohl wir wissen, dass das Gegenteil
> der Fall ist (es gibt mehr als genug Fälle von kompromittierten Docker-Images oder Paketen im Maven-Repository etc.,
> so dass man eben genau diese Annahme nicht treffen darf).
>
> Selbst wenn ich die eingesetzte Software aus solch einer zweifelhaften Quelle auf Sicherheitslücken abklopfe,
> liegt trotzdem ein fahrlässiges Verhalten vor, da ich im Bedarfsfall diese Prüfung nicht mehr unabhängig
> nachvollziehen lassen kann - eben weil ich nicht dokumentieren konnte, wie genau der Gesamtzustand bei der Prüfung aussah.
> Genau diese Dokumentationspflicht ist in der DSGVO an einigen Stellen ja vorgeschrieben.
> Es wäre unsinnig, wenn ich dann die Grundlagen, auf denen all die von mir getroffenen Angaben zur DSGVO basieren,
> nicht ebenso zu dokumentieren sind.
>
> Ich habe in diesem Fall also der Art 13 (3) der DSGVO nicht entsprochen, da der Nutzer von mir eben nicht alle notwendigen
> Informationen erhalten hat, um sich selbst ein Bild zu machen.
>
> Anders sieht es aus, wenn ich `git` statt irgendwelcher externer Cloud-Paketmanager einsetze:
>
> - Dank Submodulen habe ich den vollständigen Gesamtzustand meiner Software zum Commit-Zeitpunkt dokumentiert.
> - Diese Dokumentation ist zweifelsfrei durch Dritte nachvollziehbar (ein einziger SHA reicht)
> - Ich kann auf dieser Basis auch später leicht Dinge überprüfen
>
> Wenn ich dann erkläre, dass ich keine Absicht zur Datenweitergabe gem. Art 13 (3) DSGVO hatte,
> und sich dann trotzdem herausstellt, dass es zu solch einem Datenabfluss kam,
> ist die Korrektheit meiner Aussage durchaus wahrscheinlich,
> denn ich habe die allerbesten Argumente dass jemand anderes das nachweisen kann.
>
> Aus der Commit-Historie geht ja klar hervor, wer wann was gemacht hat.
> Selbst wenn ich jetzt die Software lax auf Sicherheit geprüft habe,
> ich bin meiner Dokumentation vorbildlich nachgekommen.
> Es ist also eher unwahrscheinlich, dass ich all das ordentlich gemacht habe,
> nur um dann anderweitig zu lügen, wo es doch so einfach wird, mir meinen Fehler nachzuweisen!

Being repeatable means, you can re-create your Safe Spot any time by will without help of the others.

Of course this includes the situation where something breaks.  For example, some mirror accidentally got corrupt.

You need to be able to - at least theoretically - be able to create it from scratch again.
And to repair every obstacle on the fly.  And afterwards you must be sure, that you got the thing right again.

Not being able to repeat a setup means, you void security.  Why?  If you want to see                            
how secure something is, you need to repeat it to verify it's process.  But if there
is no guarantee that it can be repeated, this automatically means, you must assume,
that any new re-creation must be re-examined for insecurities.
And even worse, that everything you see today cannot be granted for the past.

Repetition guarantee is an essential part of Security.  It simply cannot be left away.

OTOH even that it is widely unknown, `git` has repetition built in by design,
so it can be used as a cornerstone to Security.  `git` is mathematically repeatable.
Even after this Universe ends.  Because it has a high hacker resilience built in.

Let's assume that GitHub goes out of business.  Then

        git clone --recursive https://github.com/hilbix/firebase-firewall.git

must fail, right?

**Wrong!**  Only the naive spectator thinks this.  But the Pro will use

        git config --global url.git@localhost:.insteadOf https://github.com/

Provided that the `ssh` user `git@localhost:` has a full clone of the recursive
tree of `git` repositories needed by `firebase-firewall.git` the `git clone` will
work.  (How to get this mirror is out of scope of this here.  This must be
part of your desaster recovery plan.  You have a desaster recovery plan, right?
How do you expect to ever gain Security without a desaster recovery plan?)

> Note that this is true for Debian as well.  Debian uses signatures.  They might
> time out due to date restrictions.  But if you repeat the exact process
> with a mirror of the old Debian archive, you will be able to repeat
> everyting, bit by bit, as you did it before.

Thanks to Debian and `git` you automatically gain the same security which you had in the past.
The old security might not be secure today, but this is something completely different.


### Verified

If you ever recreate your Safe Spot, regardless if it is in 1 day, 1 month, 1 year, 1 decade, 1 century or
1 billion years in the future (YKWIM), your must be able to be sure, that you re-created it correctly.

Correctly in the today's sense.

This includes the situation, where other sources are probably no more available or where you are in a
secured clean room environment, which does not have access to other parts of the Internet.

So you must have a copy of all the other external sources, and be able to reproduce the exact state of those source
at the time when you created the Safe Spot.

If you are using external sources like Maven Repositories, this requires some very high level of planning ahead.

In contrast, if you use `git`, creating a copy of your whole `dev`-tree is as easy as this:

        MIRROR="$(readlink -m -- $HOME/gitmirror")";
        mkdir "$MIRROR";

        # Find all of your submodules
        HOME="$MIRROR" git submodule -q foreach --recursive 'git remote get-url --push origin' |
        sed -n -e 's/:[^/].*$/:/p' -e 's!\([^/]\)/[^/].*$!\1/!p' |
        sort -u |
        while read -r a;
        do
          HOME="$MIRROR" git config --global --add "url.$MIRROR/git/${a%/}/.insteadOf" "$a";
        done

        HOME="$MIRROR" git submodule -q foreach --recursive 'git remote get-url --push origin' |
        while read -r a;
        do
          git init --bare "$MIRROR/git/$a.git";
        done

        git submodule foreach --recursive git push origin --all;
        git submodule foreach --recursive git push origin --tags;

If you have [installed my git-tools](https://github.com/hilbix/gitstart), it is even more easy, just type

        git mirror DIR

Provided that your topmost parent `git` repository is `https://git.example.com/main.git`
and your dev-tree was fully checked in and clean (`git status --porcelain`-wise) everything can re-create with

        HOME=$MIRROR git clone --recursive https://git.example.com/main.git

Any questions why you want to use `git` and `git submodule`s?

> With `git` you do not need to plan ahead.  If you detect, that some mirror is broken,
> all you need to do is to is to recover from this fault.  This can even be done years later.
>
> For example by mirroring (as above) from the developer machine before it gets scrapped.
> Or by other means to find the SHA again (you can copy it from production if you deploy
> all git sources there.  Well, this also greatly simplifies deployment strategies,
> as production mostly follows development setup.  The success to `git`'s way is doing
> things the most general and easy way).
>
> All you need is just writing down a SHA.  This is 40 bytes.  And you are done.


### Secured

Securing your Safe Spot means, that you check, that the Safe Spot is safe against common threats.

- This does not only include safety agains common known holes like SQL-injection.
- This also means, that you have to document foreign sources and check that foreign sources are not contaminated
  with things like backdoors and shellcode.

Usually you have external sources.  


## Borders

There is lot of literature about Security Borders.  This is why there are Firewalls.

Secrity Borders are mostly needed for infrastructure.  Because if one of your systems gets hacked,
you definitively do not want that the intruder then gains free access to everything.

In software context you do not need this that badly.  You need to think about this
when desiging software.  But this text here is mostly about why security based on
foreign Cloud repositories is bad.

If you use foregin Cloud reposiories, there is no border at all.  Everything there directly
affects your development machine and your production in parallel.

However, even more worse, there is no border to the future.  If foregin Cloud reposiory is
hacked in some future, you might get affected as well.

In contrast with `git` you will not be affected by this.  Because even if GitHub ever gets compromized,
nobody can change the history of a `git` repository.

So `git` already provides a Security border which is very hard to overcome.

Just verify the SHA of the commit.  And you can be pretty safe, that all others who see the same SHA
(and a clean Worktree including the submodules) have the exact same copy of your software.

If you are even more paranoied, you can use signed commits (or better: signed named tags).
But this already is very complex to do.

The more easy approach is just to verify the SHA.  A single SHA of the topmost `git` parent
in the `git submodule`-tree.  It's as easy as this.  This is the power of `git`.

> When it comes to Security, it's not only important to properly implement it.
>
> **Perhaps the most important key to impement Security is to keep Security as simple as it can be!**


## Living

Another cornerstone of security is Living Security.  If you live security,
you need a Safe Spot in history to build upon.  From then on, you
must detect, adopt and change all things which endanger security.

This is called an update process.  Repeating (the Safe Spot) does not mean to update it.
It means just to re-create the exact history, from which you worked into the future.                                                                            

The formerly known Safe Spot may have gone away today.  This is quite normal.
However if you want to know, how secure you are today, you must be able
to re-visit the formerly Safe Spot to re-evaluate it's security
with your knowledge today.

If you are not able to proof it, again and again, you lost everything,
because you lost your Safe Spot.

> And as I wrote above:
>
> **Perhaps the most important key to impement Security is to keep Security as simple as it can be!**
>
> This means, you must design Security such, that it is easy to live it.
> Security is followed best, if it is designed such, that it is more easy to act securely than to act insecurely.
>
> This is why I prefer `git`.  There are no obstacles to use it securly.
> The only obstacle is to use it properly.  For this all you need to do is to follow the right path.
> To use `git`'s features as they are meant to be used.  And adjust your workflow accordingly.
>
> This does not make things more complex, it makes them only a bit more secure.


## There is no security in the Cloud

Abstain from following services which use the Cloud:

- `pip`
- `pear` and `composer`
- `bower`
- `maven`
- `docker`
- `gradle`

> If you think, you can create something secure with the help of such Cloud services, **you fail grossly negligent**.

There aint no security in the Cloud.  Period.  No, I repeat, no external requirements
are ever able to create a secure environment.  If you have only one single external
requirement, you fail in security.  Not a bit.  You fail gravely and grossly negligent.

So if you want to have some secure setup, your setup must not be based on the cloud.

`pip`, `pear`, `composer`, `bower`, `maven`, `docker` and so on are all extremely insecure.
Not a bit insecure.  They are similar insecure like publishing your root-password in
10m high contrast letters on a side of a hill, as prominent as mount rushmore
or the Hollywood logo.

This is true even for `gradle`.
**There simply is not a single example of a secure `grade` setup on this planet**
(because Gradle documentation fails on this topic).  But even if there were,
`gradle` still, is not secure, because it fails for the safe spot.

> If you think you found some secure setup, please open an issue, I then will look at this.
> And explain the flaw in a clear, mathematical sense.

## Why the Cloud cannot be repeated

If somebody compromizes the maven repository or docker hub or similar,
you will not notice, until somebody detects this issue.  As follows:

- Some docker image is available, which is secure.
- This same docker image gets trojanized, but the date is not exactly known when this happened.
- This goes undetected for years.
- Then the docker image is updated.
- The Command-and-Control-Server silently removes the trojan from all affected systems,
  such that the docker image looks like the docker image before it was trojanized.
- This goes undetected for years.
- Then this issue is detected somehow and reported.

Are you now able to detect, that your systems were affected?  And how much information do you need to detect this?

Usually, after enough time (it should not make any difference if this is 1 day, 1 year, 1 decade, 1 century or
1 billion years) you are not.  You might have the information of the complete setup back then.
However you are not able to fully re-create everything without a time machine.

This is normal in the Cloud.  Dependencies break quite often.  Hence you might be able to repeat somthing,
as long as your caches are still available.  But if you are not extremely careful, you will have lost
some bit on information, which cannot be brought back, because you have no way to verify,
that even if you bring it back, it is the same piece of information you had back then.

With other words:

If you repeat something today which you did yesterday, it might have a different outcome.

Caches do not change this.  If your development machine breaks, you must be able to repeat what you did before it broke.
Exactly without changes which might have been applied to something in the Cloud.
And you must be sure that you see exactly the same thing.  Else your security up to the point where you
setup your development machine again is voided.  You have to re-evaluate everything from scratch!

Mirrors are not good to change this as well.  If you create a mirror, you must have some way to make sure
in future, that the mirror still is in a sane state.  Perhaps somebody who had access to the mirror could
fool you.  The bigger the mirror is, the bigger the problem becomes.  Eventually your copy of the mirror is lost.

Are you able to replace this copy with a copy of the mirror provided by somebody else?  Can you make sure,
that this copy contains the same data as your mirror had?  How do you archive this?  How do you proof this?

## The Cloud cannot be used for desaster recovery

Think of a desaster recovery.  Some major disaster strikes.  GitHub goes away.  debian.org ceases to exist.
Your ISP is dead.  All your servers are gone.  And, sadly, all of your devs and other people have died as well.

But, for some reason, your service has to be re-created.  You have all the pieces:

- A Cloud
- Some basic Internet
- All servers you need
- And a copy of the operating system

Now you must re-apply your setup to the systems.  How can you archive this?

Perhaps you cannot just restore the backups, perhaps because the new systems are not binary compatible.
So you need to re-compile and apply everything from the sources.
Perhaps before the disaster, everything ran on Intel, while after the disaster, it must run on Arm based
Raspbery PIs (because you found some depot of thousands fully operable PIs, and a solar power plant which
is able to provide power to those).

With a setup which needs the Cloud, this is impossible.  You perhaps can re-create some copy of the Cloud you used.
But it will be very difficult to make sure, that the result is exactly the same as you had back then,
before the disaster stroke.

From this perspective, Setups which need information from the Cloud are an absolute No-Go.

Not because they are not doable.  Just because they add such a burdon on complexity,
that nobody can make sure, to identically repeat such an setup, ever.


### Does this mean I cannot use the Cloud in a secure fashion?

No, this is not what I said.  You can create a secure setup which uses the Cloud.
Essentially, the Cloud might even be some essential cornerstone to create such a secure setup
(due to it's DoS resilience).

What I say is, that you cannot create such a secure setup if it is based on something in the Cloud
which is not part of your own setup.

You can use the Cloud in a secure setup.  But your setup must not be Cloud based.

This is, you can implement a large amount of your setup with the help of Cloud based techniques.
But you must be aware of the Cloud nature of those building blocks.
There is nothing wrong to serve files from the Cloud, if you can make sure,
that nobody who gains control over those Cloud Services can harm your data.

This process is not straight forward.  But it can be done.

> If you are not aware of this, and you still use the Cloud,
> and you still pretend this is a secure setup, then you are simply lying.
>
> Doing this is not only grossly negligent.  It is simply intentinal fraud.
>
> The only way to escape this is to openly admit these flaws in your design.
> Then you enable your users to decide if they still trust in your Security.
>
> That's the only way to handle this in a fair way.
