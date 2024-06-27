# HowTo U2F

Ich habe

- Diverse Yubikeys, alt und älter (die neuesten finde ich unbezahlbar teuer) mit und ohne NFC
- FIDO-Keys mit ohne ohne NFC
- FIDO2-Keys mit NFC
- Sogar eine reine NFC-FIDO-Karte (keine Ahnung welche Version)

und absolut keine Ahnung, wie ich die verwende.

Lüge.  Wie man diese uralten allerersten Yubikes verwendet, also diese reinen TOTP-Devices, das hatte ich kapiert.

> Inzwischen hat Yubico Kunden wie mich mit dem Dampfhammer vor den Kopf gestoßen weil sie die
> für diese Keys bereitgestellte Infrastruktur komplett gelöscht haben.  WTF why?
>
> Vielleicht geht das ja doch noch irgendwie mit dem ganzen Gesums das sie dort ins Netz gestellt haben,
> aber sorry, ich finde mich durch den Wust der Seiten dort einfach nimmer durch.
>
> Was ich erwarte?  Ooch, nicht viel:
>
> - Ich rufe deren Homepage auf
> - Oben ist ein Eingabefeld
> - Ich aktiviere das Eingabenfeld
> - Ich schicke ein TOTP von meinem Yubikey in dieses Eingabefeld
> - und PLOPP werde auf eine Seite mit **allen relevanten** Entwicklerinformationen über den Yubikey geleitet.
>
> Dort befinden sich nur die Infos die zu dem Key passen.  Nicht mehr.  Aber auch nicht weniger!
> Und Links zu Ready-to-Use-Testseiten müssen auch dabei sein.  Halt so alles was es früher mal gab!
>
> Keine Ahnung, aber genau das erwarte ich.  Ist das so schwer zu verstehen?
>
> Ach ja, und das ganze natürlich bitte ohne JavaScript!  Ich verwende mauslose Commandline-Textbrowser wie `w3m`!


## Komplettes Unverständnis

Das Passwort ist Mist.  Sagen sie.  Deshalb schaffen wir es ab.  Sagen sie.

Und dann muss ich eine PIN eingeben?  Hä?  Wo ist bitte der Unterschied zwischen einer PIN und einem Passwort?

> Für mich heißt das:  Sie schaffen das Passwort ab, indem sie das Passwort durch ein Passwort ersetzen.  Alles klar!

Also irgendwie komme ich mir vor als würden die versuchen, mich mit dem Klammberbeutel zu pudern.

### Wozu FIDO2?

FIDO-Sticks möchte ich für viele Dinge verwenden:

- Um den 2FA-Authentikator auf dem Handy zu ersetzen
  - Der ist mir für einige Sachen zu unsicher, eben weil er nur ein Stück Software ist.
  - Da finde ich Hardware-Token eben viel sinnvoller
- Für Inband Autorisierung
- Für Outband Autorisierung
- Um mich gegenüber komplett unwichtigen Accounts auszuweisen.
  - Davon habe ich tausende!

Und das natürlich immer ohne dafür auch nur den Hauch einer Tastatur oder Maus anfassen zu müssen!

> Weil es die in den Szenarien oft gar nicht gibt!

Der Stick steckt dabei nicht notwendigerweise an dem Gerät, auf dem ich mich autorisiere.
Weil das Gerät z.B. gar kein USB oder NFC oder beides hat!

Sprich das sieht so aus:

- `rsync` von einem Computer auf einen anderen
- Auf dem Handy bei mir ploppt eine Authentikationsanfrage auf
- Ich halte den NFC-Fido-Stick dran
- Dann überträgt der `rsync` die Daten

> Wer meint, dass ich den Rsync selbst ausgelöst habe, der hat das Prinzip nicht so ganz verstanden!
> Der `rsync` kann von einer anderen Person kommen.  Oder von `cron`.
> Also nix Terminal irgendwo wo man etwas wie eine PIN eingeben könnte!

Das also ist das Szenario, das ich lösen will.

### Übergangsszenario

Ja, es ist OK, wenn ich bei diesem Szenario erst ein Shell (das dann ein Terminal hat) starten muss,
um mir die Authentikationsanfrage zu holen (polling) und dann mit dem Stick zu beantworten.
Oder eine Webseite mit dem Browser öffnen muss.  All das ist für mich vorerst in Ordnung.

> Der nächste Schritt ist, dass die Autorisierung über Signal etc. gelöst wird.
> D.h. ich kriege die Autorisierungsanfrage auf Threema, halte meinen Stick hin,
> und führe so die Autorisierung durch.
>
> Das macht eine eigene App dann eigentlich unnötig.

### Und wie geht Desaster-Recovery?

Bei etwas Neuem immer bitte den Fallback nicht vergessen!

Also:

- Alles ist untergegangen (also ich meine das literal, durch ein Hochwasser abgesoffen).
  - So dass gar nichts mehr geht.
  - Keine Infrastruktur, kein Google, nichts.
- Und das Handy ist auch tot
  - Wurde vom Blitz getroffen und gegrillt.
- Man hat nur noch den Stick.
  - Und die Anwendung auf der anderen Seite.
  - Und dann stellt man fest, dass der Stick ebenfalls kaputtgegangen ist.

Ja, genau, wie sieht solch ein Desaster-Recovery aus wenn aber auch wirklich alles im Arsch ist?

> Das frage ich mich!  Immer!  Und zwar zuerst!
>
> Der Erbfall quasi, bei dem alles im Feuer verbrannt ist.
>
> Das führt dann zur Frage:  Wie erzeugt man vorher dafür all die notwendigen Desaster-Recovery-Informationen?

Wie man die Desaster-Recovery-Infos gegen Untergang absichert ist bei der Überlegung vollkommen nebensächlich!
Denn alles, was ich bisher gesehen habe, lässt sträflich vermissen,
wie das Desaster-Recovery überhaupt gemacht werden kann.

**Das ist die entscheidende initiale Bringschuld aller Authentikationssysteme!**

> Also, wie sieht das beim Passwort aus?  Man meißelt die Zugangsdaten in Granit!
>
> Das mag unpraktikabel erscheinen, ist aber durchaus eine sehr naheliegende und sehr offensichtliche Möglichkeit.

Entscheidend ist also, wie sieht der Vorgang der Erstellung des Desaster-Recoveries aus,
wann kann man das einrichten und wie einfach ist das?

> Beim Passwort verwendet man halt einen Passwort-Safe oder schreibt es sich auf einem Blatt Papier auf,
> das man geheim hält.  Und bei FIDO2?  Gibt es da etwas ähnlich einfaches?  Irgendwo?

Ich hoffe es wird klar, warum bei mir mangels der Verwendbarkeit sowie Absicherbarkeit
ein komplettes Unverständnis herrscht, wenn es zu FIDO2 kommt.
Weil ich in dieser Richtung bei FIDO2 nur das Äquivalent eines Achselzuckens finden konnte!


## HowTo

Lassen wir mal all meine oben genannten Wünsche und Erwartungen erst einmal beiseite.
Und fangen stattdessen ganz am Anfang an:

### Ich habe einen FIDO2-Key.  Und jetzt?

Ja, sorry, davon habe ich bisher absolut keine Ahnung!

(Wird forgeführt sobald ich etwas herausgefunden habe.)
