# WTF ist NetworkSolutions für ein Saftladen

Also ich habe bei NSI einige Domains.  Warum?  Weil man die da 20 Jahre und mehr vorab bezahlen kann.
Und bei einigen ist die Zeit halt noch lange nicht rum.

Mit ein paar anderen Domains habe ich das Problem, dass ich die da wegtransferieren will,
aber das mit dem Transfer-Code klappt irgendwie immer nicht, also bezahle ich halt zähneknirschend weiter.

Und das Webinterface ist noch schlimmer als das von GoDaddy.  Also im letzten Jahrtausend konnte man ja noch
meinen, die sind einfach nur blöd.  Aber Pustekuchen, denn über die Jahre nur noch schlimmer.

Wir schreiben das Jahr 2022.  Unendliche Weiten.  Inzwischen müsste man meinen, jeder hat inzwischen das Web gemeistert.
Aber falsch gedacht, NSI stemmt sich vehement gegen den Mainstream.

> Catchphrase: NSI, das Symantec der Registrare ..   (Ach ja, stimmt ja, Symantec hatte die auch schon mal gekauft glaube ich.)


## 2022-12-27 frohe Weihnachten auch!

Aber um all den eingangs geschriebenen Frust geht es mir hier gar nicht.  Es geht um eine aktuelle Erfahrung.

Also, ich habe 2FA aktiviert.  Die nennen es da "two step login".  Sprich, ich logge mich ein, muss das Passwort angegeben,
bekomme eine SMS und muss den Code dann eingeben.

> SMS?  Hä?  In welchem Jahrtausend leben die?  Wir haben Google-Authenticator, Microsoft-Authenticator, OpenID, FIDO-Keys,
> alles mögliche inzwischen.  Aber SMS?  Das ist die schlechteste aller 2FA-Lösungen.
> 
> Teuer, technisch kompliziert und unsicherer geht es nicht.  Logisch dass NSI das und nur das anbietet.

Also ich logge mich ein und .. nix.  Keine SMS.  Code nochmals geschickt.  Keine SMS.

Seufz.

Also Recovery-Code verwendet.

Dann alles gemacht was ich machen will.

> Wie immer:  Eine Domain kostet $50 oder so.  Wahnsinnig teuer.  Also geht man auf "Send Transfer-Code".
> Und schwupps bekommt man ein günstigeres Angebot damit man die Domain dort lässt.
>
> Immer noch sauteuer (etwa doppelt so teuer wie sonst überall), aber immerhin nicht der Ultra-Wahnsinn.

So, schön.  Also alles erledigt.  Und ausgeloggt.

Äh .. in den Mails steht, dass 2FA abgeschaltet wurde.  Schit!

Also nochmals einloggen, und das Trusted Phone neu hinzufügen.

Gesagt getan, dazu bekommt man eine SMS, gibt den Code ein und das Phone ist registriert.

Super, geht doch, denke ich und aktiviere 2FA wieder.

Dann Logout und schnell wieder einloggen.

Äh .. wo bleibt die SMS?

Gerade bekam ich doch eine.  Aber beim Login?  Da klappt das offensichtlich nicht!

Also den Chat-Support bemüht.  Und jetzt wird es komisch (im Sinne von Lächerlich).  Jedenfalls für mich.

### Der Chat

> Nein, die armen Agenten hinter dem Chat-Bot sind nicht das Problem.  Im Gegenteil.  Sie sind nett, hilfsbereit und
> "willig".  Nur dagegen steht offensichtlich die Konzernphilosophie von NSI!  Man kann es dem bestmotivierstestem Personal
> aller Zeiten natürlich komplett unmöglich machen, Kunden zu helfen.  Und NSI hebt diese Kunstform auf einen neuen Level!

Also zuerst muss man mal an der "KI" vorbei.  Naja.  KI ist das nicht.  Das Ding ist dümmer als Eliza und reagiert nicht
einmal auf Schlagworte.  Einfach nicht beirren lassen.  So lange Quatsch eingeben bis das Ding aufgibt und an einen
Assistenten weitergibt.  Bei mir triggerte die Zeile "**your service is defect**" den Agenten.

Der Agent nimmt also - geduldig - mein Problem auf und als er es versteht meldet er mir, dass er mir nicht weiterhelfen kann,
denn er hat keinen Zugriff auf die technischen Systeme.  Laut Servicestatus sei aber alles in Ordung.  Ich solle mich doch
bitte per Telefon an den technischen Support wenden.

Nun, ich sitze in Deutschland und habe Flatrate in alle deutsche Netze.  Aber nach Amerika kostet mir $2 pro Minute oder so.
Für ein Problem, das NSI hat, mich aber nicht wirklich behindert, aben einfach nur Scheiße ist, weil man keinen 2FA hat.
Also sage ich dem Agenten das, und tatsächlich, er eröffnet für mich ein Ticket im Supportsystem.

Ich danke und der Agent verweist auf die obligatorische Bewertung seiner Leistung die dann folgt.
Mache ich doch gerne, der Agent hat seinen Job zur vollsten Zufriedenheit von mir erledigt.
NSI nicht, der Typ oder die Typin schon.

Also schließe ich den Chat .. äh .. geht nicht, da ist kein Close-Button.  Aber ich kann ja die Seite schließen.
Keine Bewertung.  Nun ja, Pech denke ich.

### Die Bewertung

Kurz darauf macht es pling und von NSI kommt eine Mail herein.  Ah, die Bewertung!

Ich öffne also die Bewertung, fülle sie aus, und schreibe noch dazu, dass die doch bitte eine Toll-Free-Number für
Deutschland dazupacken sollen, denn es ist nicht hinnehmbar, dass man hohe Gebühren dazu zahlen muss,
nur um NSI auf seine ureigenen Probleme aufmerksam zu machen.  Weise noch auf VoIP und WebRTC hin,
die es allesamt leicht machen, eine kostenlose Erreichbarkeit aus allen Teilen der Welt zu bewerkstelligen.

Und .. Technischer Fehler.

> Haben wir etwas anderes von NSI erwartet?

OK, also den Survey nochmals aufgerufen.  Und .. wieder ein Fehler, der Survey wäre nicht mehr aktiv.

> Also **selten wurde ich von einer Firma derart professionell zu Weihnachten verarscht!**

Nun ja, dann eben nicht.


### Facepalm^2

Der Brüller kommt aber noch.

In den Mails habe ich dann noch etwas gefunden.

NSI erblödet sich allen Ernstes, den Recovery-Code für 2FA per Mail zu schicken.

Nochmals:

Die schicken per Mail alle Angaben, die es möglich machen, den Account auszuhebeln!

Nochmals:

Wer einen Mailaccount knackt hat dann alle notwendigen Angaben, um in den Account bei NSI einzubrechen und diesen zu übernehmen:

- Er kann 2FA abschalten (dank Recovery-Code)
- Und er kann das Passwort zurücksetzen (dank Zugriff auf die Mail)

Das nennen die also 2FA?  Sind die meschugge?

Offensichtlich.

Denn das geht auch einher mit der Accountabsicherung, also den geheimen Fragen.

Erstens gibt es keine Frage die man selbst formulieren kann.
Zweitens haben die etwas Probleme mit längeren Antworten.  Packt man da nämlich mehr als 10 KB in die Antwort rein,
was ich mit freude in solchen Fällen mache in denen eine komplett untaugliche Lösung vorhanden ist,
dann fliegt einem deren System mit einem internen Fehler um die Ohren.

Nix da mit dem Hinweis "hey, TMI" oder so.  Nope.  "Ein Fehler ist aufgetreten".  Wow.  Echt modern.

> Das war jedenfalls bis 2020 oder so so.  Da habe ich mich dann erbarmt und eifach nur Passworte mit ausreichend
> Entropie reingepastet.

Also, egal wo man auch nur hinsieht, deren System ist offensichtlich komplett untauglich implementiert.

Ein Fehlerchen kann ja mal vorkommen.  Aber bei denen ziehen sich die krassen Fehler wie ein roter Faden durch alle Systeme.
Außerdem wird von allen Lösungen grundsätzlich die unbrauchbarste gewählt, umgesetzt und dann jahrzehntelang beibehalten.
Ich habe in über 25 Jahren in denen ich dort Kunde bin bisher kein einziges Mal erlebt, dass die Fehler beseitigt haben,
oder irgendetwas so implementiert haben, dass es auf Anhieb funktioniert oder so, wie man es erwarten würde.

- Der 2FA wird auf 1FA reduziert.  Und funktioniert sowieso nicht mit einer Telefonnummer die nicht mit +1 beginnt.
- Das Passwort-Recovery-System arbeitet mit Sicherheitsfragen.  Dingen, die man aus Sicherheitsgründen
  bereits Kollektiv im letzten Jahrtausend zu Grabe getragen hat
- Webservices brechen zusammen statt sinnvolle Fehlermeldungen zu bringen
- Der Support hat keinen Zugriff auf den 3rd-Level
- Und dann noch das was jetzt folgt

Der Supportmitarbeiter hat für mich ein Ticket eröffent.  Und er hat mir die Supportticketnummer mitgeteilt.

So weit so gut.  Aber .. das Ticketsystem hat mir keine Nachricht dazu geschickt!  Alles andere wäre ja auch abwegig.

Sonst könnte der Kunde sich ja erdreisten, weitere sinnvolle Informationen an das Ticket dranzuhängen.

Deshalb kann ich leider nur raten, was und wie das Ticket gelöst wird.  Ich gebe mal hier die möglichen Ergebnisse
mit der kolportieren Wahrscheinlichkeit für mich an (ich habe keine Fakten um zu schätzen):

- 2% Ich bekomme eine Nachricht zu dem Ticket von NSI.
- 90% Ich bekomme nie wieder irgendeine Nachricht zu dem Ticket von NSI.
- 8% Das Ticket hängt für ewig im Status von Schrödingers Katze vor dem Öffnen der Schachtel.
- 0% Das Ticket wird schnell gelöst.
- 1% Das Ticket wird gelöst.
- 80% Das Ticket wird als gelöst im System geführt, das Problem begleitet uns die nächsten Jahrzehnte aber weiter.
- 9% Das Ticket geht den Weg des unbekannten.
- 0% Zu dem Ticket kommt bei mir eine Nachfrage an.
- 20% die verwenden Remedy.
- 30% die verwenden ServiceNow.
- 50% mein Ticket geht bei der Migration zu ServiceNow verloren.

Bin gespannt was rauskommt.  Ich gehe von 90+80+50 aus.  Also 220% ;)
