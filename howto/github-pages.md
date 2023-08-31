# GitHub Pages

Sagt mal, wie kompliziert kann man die einfachste Anleitung eigentlich machen?
Und warum werden die Schritte nicht einfach an einem Beispiel erklärt?
Und warum werden die klarsten Sachen der Welt in epischter Breite erklärt,
die unklaren Sachen aber nur mit einem halben Satz?

Ich muss jedes Mal lange nachsuchen und rumprobieren, bis das mit den GitHub-Pages funktioniert.

- `$ORG` steht für die Organisation oder den GitHub-Namen
  - Ich gehe außerdem davon aus, man hat die Domain `$ORG.org`
- `www` steht für das Repo
  - Die Website ist dann <https://www.$ORG.org/>

Folgendes ist hoffentlich so erklärt, dass man alles auch sofort findet.

> Ansonsten gehe ich davon aus:
> - Man kennt GitHub, aber kennt eben nicht jedes Detail
> - Man weiß, wie DNS funktioniert, und zwar in und auswendig

GitHub läuft bei mir übriegsn auf Englisch,
weil nur so sind Anleitungen international verständlich.


## Schritt 0: Neue Orga bei GitHub erzeugen

> Optional.  Braucht man nicht, wenn `$ORG` der eigene GitHub-Account ist

- <https://github.com/account/organizations/new?plan=free>
- **Organization account name**: `$ORG`
- **Contact email**: Funktionierende(!) Mailadresse fürs Billing
- **This organization belongs to:** `My personal account` (Keine Ahnung was das andere macht!)
- `Haken setzen` bei "Acceptance of Terms of Service" etc.
- **Next**

> Evtl. kommt danach noch etwas.  
> Zur Zeit habe ich aber keine Orga anzuvimlegen, kann da also nicht weitergucken.
> Sorry.  (Wenn man da was anlegt und wieder löscht blockiert das den Namen!)

In der Orga nicht vergessen, 2FA einzuschalten:

- <https://github.com/organizations/$ORG/settings/security>
- `Haken setzen` bei "Require two-factor authentication" etc.
- **Save**

Dann das Orga-Profil vervollständigen:

- <https://github.com/organizations/$ORG/settings/profile>
- **Organization display name**: Sollte man befüllen
- **Email (will be public)**: kann man befüllen
- **Description**: kann man befüllen
- **URL**: `https://$ORG.org/`
- **Social accounts**: Ärks!
- **Location**: Sollte man unbedingt korrekt einstellen!
- **Gravatar email (private)**: Ärks!
- **Sponsors update email (Private)**: Ich habe keine Ahnung was das ist
- **Update profile**

Unten gibt es dann noch Schritt 
## Schritt 1: Domain aufsetzen

```
www	IN	CNAME	$ORG.github.io.
@	IN	A	185.199.108.153
@	IN	A	185.199.109.153
@	IN	A	185.199.110.153
@	IN	A	185.199.111.153
@	IN	AAAA	2606:50c0:8000::153
@	IN	AAAA	2606:50c0:8001::153
@	IN	AAAA	2606:50c0:8002::153
@	IN	AAAA	2606:50c0:8003::153
```

Bei `@` kann man ja leider keinen CNAME eintragen.
Die IPs findet man auch mit:

```
dig +short A    $ORG.github.io.
dig +short AAAA $ORG.github.io.
```

Dieser `dig` geht schon, bevor man die Orga bei GitHub aufgesetzt hat.

> In meinem eigenen proprietären Zonengenerierungstool sieht der Eintrag so aus:
>
> ```
> :
> :MAIL
> :DIRECT
> :DIRECT4        {!GITHUBNAKED4}
> :DIRECT6        {!GITHUBNAKED6}
> :www
> :CNAME  www     $ORG.github.io.
>
> $ORG.org
> ```
>
> FYI: Das Tool ist über 25 Jahre alt, nonpublic und sehr speziell.
> Leere Einträge wie `:MAIL` schalten die automatische
> Generierung entsprechender Einträge ab, die ich nicht brauche,
> da ja alles bei GitHub und nicht bei mir liegt.
>
> In Zukunft habe ich vor, den kostenlosen DNS von
> <https://desec.io/> statt meiner eigenen Infrastruktur zu nutzen.
> (Das für meinen Primary dann monatlich gesparte Geld spende ich bereits dorthin!)


## Schritt 2: Leeres Repo erzeugen

Neues Repo anlegen:

- <https://github.com/new>
- **Owner** auswählen
- **Repository name**: `www`
- **Description**: `Homepage`
- `Public` anklicken
- **Create repository**

Und dort  ein leeres Repo hinpushen.  Das sieht bei mir so aus:

```
git init $ORG/www &&
cd $ORG/www &&
git empty &&
git reset empty &&
git remote add origin "https://github.com/$ORG/www.git" &&
git config --global "url.git-github.com+$ORG-www:$ORG/www.git.insteadOf' "https://github.com/$ORG/www.git" &&
~/.ssh/.add '' "$ORG"
```

Unter <http://github.com/$ORG/www/settings/keys> den **schreibbaren Deployment-Key** eintragen
(dieser wird von meinem `~/.ssh/.add` entsprechend generiert und angezeigt.  YMMV):

> Das braucht <https://github.com/hilbix/gitstart> für die Kommandos wie
> `git empty` und `~/.ssh/.add`.
>
> Aus Sicherheitsgründen verwende ich nämlich nur Deployment-Keys,
> denn bei Nichtverwendung werden die automatisch entfernt.
>
> YMMV, dieser Part hier ist halt primär für mich selbst gedacht.

Anschließend:

```
git push -u origin master
git push --tags
```


## Schritt 2: Domain für Pages im Repo aktivieren

<https://github.com/$ORG/www/settings/pages>

- **Source**: `Deploy from a branch` (keine Ahnung was das andere macht)
- **Branch**: `master` `/docs` **Save**
  - So lange der "master" bei Unis nicht auch abgeschafft ist ..
  - (Irre ich mich oder gabs da nicht mal was namens "Diplom"?)
  - Und: "master*" sind weitere Master-Branches
  - Aber: "main*" kollidiert mit "maint*", den Maintainance-Branches!
- **Custom domain**
  - `$ORG.org`
  - **Save**
- Ich empfehle: `Haken setzen` bei **Enforce HTTPS**
  - kann man aber auch weglassen

> Warum `/docs`?
>
> Weil es blöd ist, wenn alles aus dem Hauptverzeichnis kommt.
> Kommen die Seiten aus einem Unterverzeichnis,
> kann man im Repo noch weitere Dinge problemlos erfassen.
> Z.B. Scripte, die statische Inhalte generieren uvm.


## Schritt 3: Pages sinnvoll befüllen

T.B.D.


## Schritt 4: Domain bei GitHub für Orga registrieren

> Optional, gilt außerdem nur für Orgas

> Wenn man das macht, erlaubt GitHub niemandem sonst
> die Domain ebenfalls zu verwenden.  Sonst könnte jeder
> einen entsprechenden `CNAME` anlegen (siehe Schritt 3).

- <https://github.com/organizations/$ORG/settings/pages>
- **Add a domain**
  - `$ORG.org`
- `$CODE` aus dem unteren Feld rauskopieren
- Warten, bis der DNS-Update (siehe im Weiteren) durch ist
  - Dann **Verify** anklicken

In der Zone `$ORG.org` entsprechenden Eintrag reinpacken:

```
_github-pages-challenge-$ORG A TXT $CODE
```

- `$CODE` entsprechend mit dem kopierten ersetzen
- Dann den DNS-Update auslösen
- Und wenn der durch ist, das **Verify** (siehe oben) anklicken

> In meinem Zonengenerierungstool kommt dafür folgende Zeile dazu:  
> `:txt _github-challenge-$ORG $CODE`

