# Google Play

## [Google Play – Vertriebsvereinbarung für Entwickler](https://play.google.com/intl/ALL_de/about/developer-distribution-agreement.html)

> Äh, ja, das schreiben die tatsächlich derart undeutsch.  Deutsch wäre soetwas wie "Google-Play-Vertriebsvereinbarung"

Was lese ich da in 4.5?

> 4.5 Sie dürfen Google Play nicht dafür nutzen, Produkte zu vertreiben oder zur Verfügung zu stellen, deren Zweck darin besteht, den Vertrieb von Softwareanwendungen und Spielen für Android-Geräte außerhalb von Google Play zu ermöglichen.

Also ich glaube zu verstehen, was Google damit eigentlich ausschließen will, nur schreiben sie das nicht.
Und das, was sie da schreiben, geht auch gleich aus 2 Gründen schief:

- Erstens wird die EU nicht besonders erfreut darüber sein, dass Google auf diese Weise die Mitbewerber extrem stark benachteiligt.  
  - Denn wäre es möglich, Alternativen zu Google-Play über Google-Play zu erhalten, wäre den Nutzern damit gedient,
    dass die Software ebenso aus einer vertrauenswürdigen Quelle stammt.  Denn überlegen wir mal:
    Middleboxes sind inzwischen in der Lage, Downloads zu trojanisieren.  Der Playstore verhindert das.
    Aber wie soll ein Nutzer, z.B. Dissident, das bemerken, wenn er sich den alternativen Store installiert,
    und das .apk on-the-fly durch eine Middlebox mit einem Rootkit infiziert wurde,
    und das nur, weil dieser Store nicht aus Google-Play selbst geladen werden kann?
  - Aber auch vom wettbewerbsrechtlichen Standpunkt aus halte ich das für eine extreme Marktverzerrung!
  - Außerdem, was bitte bricht Google ab, wenn sie das erlauben?  Entgangener Gewinn?  Inwiefern?
  - Aus meiner unmaßgeblichen Sicht ist dies ein klipp und klarer Machtmissbrauch, den Google hier treibt.  Aber wer fragt mich schon?
- Zweitens ist die Formulierung interessant schwammig.  Denn sie trifft z.B. voll auf Firefox zu!
  - Firefox ermöglicht auf Android-Geräten, dass man Sofwareanwendungen und Spiele ausßerhalb von Google-Play vertreibt!
  - Nochmals:  Einer der Zwecke von Firefox entspricht genau der Formulierung von Paragraph 4.5!
  - Firefox erlaubt nicht nur sogenannte Web-Apps, sondern auch Extensions.  Diese werden auf Android installiert und funktionieren auch ohne Internet, ganz genau so wie andere Programme auf Android!
  - Google ermöglichst hier **wissentlich** eine total willkürliche Auslegung dieses Paragraphen, indem sie Applikationen wie Firefox im Store belässt, aber andere ausgrenzt.
  - Und die Ironie ist, dass Google-Chrome das ebenso kann.  Sie selbst dürfen also gegen ihre eigenen Bedingungen verstoßen, andere aber nicht?
  - Wow, das soll Rechtens sein?

Man kann jetzt in die Formulierung ein "ausschließlich" reinlesen, also "deren Zweck **ausschließlich** darin besteht".  Dann würde das nimmer auf Firefox zutreffen.  Aber das steht aus gutem Grund so nicht da.  Ist auch logisch, dann baut man einen externen Store, dessen Zweck eben nicht nur ist, "Softwareanwendungen und Spiele für Android-Geräte außerhalb von Google Play zu ermöglichen", sondern dessen Zweck auch noch etwas anderes kann, dann wäre das erlaubt.  Das will Google natürlich nicht.

Also kann man weder "ausschließlich" noch "hauptsächlich" da reinschreiben, weil dann kann man den Punkt viel zu leicht umgehen.

Bleibt also nur diese schwammige Formulierung, die der Willkür Tür und Tor öffnet.  Ich habe einige hundert Applikationen entdeckt, die gegen diesen Punkt verstoßen.  Z. B. die Python-IDE.  Auch mit der kann ich Spiele auf Android am Playstore vorbei installieren.

Und einige Spiele erlauben es, Minnispiele innerhalb des Spiels herunterzuladen.  Auch das installiert diese Zusatzspiele ganz am Playstore vorbei aus irgendeiner obskuren Drittquelle!

Und warum fällt mir das auf?  Weil ich [eine App programmieren will](https://singletool.de/), die mir erlaubt,
die Kontrolle zu behalten.  Also keine Myriarde dubioser Tools, sondern eine App um alles zu regeln.

Das Ding wird intern in JavaScript geschrieben und erweiterbar sein (so wie Firefox mit Extensions, nur einfacher)
und erhält dabei von dort aus Nach und Nach auf so gut wie jede API von Android Zugriff.

Allerdings in geregelter und nachvollziehbarer Form!  Sprich, da ist nichts intransparent, sondern man weiß immer bis aufs letzte Bit genau, was gerade abläuft und was früher abgelaufen ist oder in Zukunft ablaufen wird und wie es funktioniert!

Und warum passiert das genau so?  Nicht nur weil ich das so haben will, sondern weil ich bin nicht in der Lage so Zeug wie eine Datenschutzauskunft zu geben.  Desahlb muss die App das von Haus aus machen.  Auf eine transparente Weise.

In dieser App werden lauter winzig kleine Snippets dann hunterte andere teils teure Apps ersetzen können.  Z.B. so Apps, die Tethering steuern, oder irgendwelche Automatisierungen oder Prozesssteuerungen usw.  Und das schöne ist, diese Snippets kann man dann on-the-fly basteln, wenn man sie braucht, und bequem per `git` z.B. Gist teilen.

> Ich programmiere doch keine zentrale Registry, die ich mir als weiteren Bremsklotz ans Bein flicke, und auf der mir wohlmöglich irgendwer sogar ein Ei legt, oder irgendwelche Datenlecks entstehen können.  Nope.  Ich bin doch nicht vollbehämmert!

Aber:

Diese App wird in gleichem Maße wie FireFox gegen diesen Punkt verstoßen!  Wäre der API-Zugriff nicht zu arg durch Firefox beschränkt, würde ich nämlich alles in diesem als Extension programmieren.  Es kann sogar gut sein, dass ich einen Teil der UI direkt in Firefox und Chrome verlagere, die App selbst also nur als Gateway dient, um die Funktionen nachzurüsten, die Firefox fehlen.

Dann würde die App selbst gar nicht gegen diesen Punkt verstoßen, sondern den Verstoß auf Firefox verlagern.

> Das ist übrigens jetzt auch der Backup-Plan im Fall dass Google irgendwelche Einwände gegen die App provoziert weil sie kann was sie kann.
> Intern ist sie dann ja schon JavaScript, da wird es leicht, den betreffenden Code einfach in eine Extension zu verlagern.

Hinweis, wohin ich die App bringen will:

- Sie soll den Launcher ersetzen können
  - Nein, das ist nicht ihre Aufgabe
  - Aber nebenher soll sie eben auch so funktionieren können wie ein Launcher
  - Nur eben mit viel mehr Möglichkeiten, weil man die Funktion jedes Buttons selbst per JS-Snippet leicht festlegen kann
  - Und eine, aber halt nur eine Funktion wird sein, eine Aktitivät zu starten, also das, was der Launcher tut ..
- Sie soll Nachrichten empfangen können
  - Aktivitäten unter Android zu empfangen bedeutet Nachrichten zu empfangen.  Wo ist da der Unterschied zu Instant-Messaging oder Mail?
- Sie soll Nachrichten verschicken können
  - Aktivitäten unter Android sind nichts anderes, als geschickte Nachrichten.
  - Das Teilen von Texten und Dateien ist auch nichts anderes.
- Sie soll Nachrichten verwalten und editieren können
  - Ich habe z.B. noch nie den Unterschied zwischen einem Zettelkasten und einer Mailapplikation verstanden
- Sie soll einfach funktionieren
  - Ich habe noch nie verstanden, warum man Dinge immer erst abschließen muss damit etwas geschieht.
  - Einfach eine Datei an die App teilen und fertig.  Wenn man sie das nächste Mal öffnet kann man die Daten dann organisieren.
  - Das nenne ich einfach.  Diese Wizard-Scheiße, die die Nutzer durch irgendetwas führt, die ist für mich immer total kompliziert!
- Sie soll Alarme können
  - Muss sie, sie muss mich ja benachrichtigen können
  - Und ein System soll mir einen Termin pushen, so dass die App mir mitteilen kann, dass der Server jetzt rebootet, auch dann, wenn ich zu diesem Zeitpunkt gerade offline bin!
  - Und damit muss sie auch Termine, Kalender usw. integrieren
- Sie soll WebRTC können
  - Nicht nur für E2E-verschlüsseltes Instant Messaging
  - Nicht nur für für Videokonferenzen
  - Sondern allgemein für alles mögliche, selbst Dateitransfer und ähnliches
  - Und das auch im Mailboxbetrieb, d.h. ich teile eine Datei, abgerufen wird die später - von meinem Handy
  - Und damit soll sie auch in der Lage sein zu telefonieren, natürlich.

Das alles ist nichts besonderes.  Das ist alles bereits weitgehend in jeden Browser eingebaut!  Nur wird es eben nicht so genutzt.

Und nein, ich will nicht die eierlegende Wollmilchsau programmieren.  Ich will nur, dass die App auf alle APIs in einfacher Weise zugreifen kann, so dass man mit einem minimalen Snippet (3 Zeilen oder so) diese Funktion auf die Art und Weise verwenden kann, wie man es gerade für nötig ansieht.  Ohne Umwege.  Und unkompliziert.

> Das sieht also so aus:
>
> Man fügt auf dem Screen der App einen Button hinzu.  Dann programmiert man diesen mit wenigen Zeilen JS.
> Klickt man auf den Button, wird das dann ausgeführt.
>
> Einige Buttons kann man "autostarten".  Diese klinken dann Callbacks ein.  Können also irgendwas von einer API empfangen.
> Z. B. wenn man eine Datei an die App sendet wird der entsprechende Button automatisch getriggert und tut, was er soll.
> Z. B. empfängt er die Datei und trägt einen Eintrag in eine ensprechende Liste ein.  (Wenn nicht, ein Button kann ja
> einen Dateibrowser starten).
>
> Buttons können auch zeitlich gesteuert werden.  Und schon sind die Alarme da.  All das ist nichts besonderes, denn unter
> Unix gibt es dafür "cron".  Genau so eine Basisfunktion soll die App bereitstellen.
>
> Notizen ist auch nichts besonderes.  Das sind alles Buttons, die den Text anzeigen wenn man draufklickt.
> Edit ist dann per weiterem Button möglich.  Der öffnet dann einfach ein Webformular mit dem gewünschen Editor.
> All das muss man nicht programmieren, all das gibt es schon in epischer Breite überall im Netz!

Wie der Name schon sagt:  SingleTool.  Einfach nur ein Tool, das das dann ermöglicht.  Nicht selbst anbietet, sondern machbar macht.

Und warum als App?  Weil ich eben festgestellt habe, den Browser selbst um all das zu erweitern wäre viel zu komplex.  Anders herum wird also ein Schuh draus, man integriert einfach den Browser (WebView) in die App und erweitert diesen nach und nach um die fehlenden Funktionen.  Den Rest kann man dann bei Bedarf im WebView dazubasteln.

Technisch gesehen verstößt es also gar nicht gegen diesen Paragraphen.  Denn das Tool selbst hat gar nicht den Zweck, das zu tun.

Aber logisch gesehen verstößt es gegen den Paragraphen, weil das Tool eben genau diese Fähigkeit hat.  Es ist dann nämlich leicht, einen anderen Store als Playstore in dem Tool bereitzustellen.  Das geht dann mit wenigen Zeilen.  Alles, was man verlinken muss, ist eine geeignete API vom anderen Store, der Rest ist dann bereits fast schon komplett in der App eingebaut, also auch das APK Management usw.

Ich gehe deshalb mal davon aus, dass dieser Punkt nicht mehr lange in dieser Form überleben kann.
Denn wenn wir Konzernen so etwas durchgehen lassen, erlauben wir ihnen letztendlich damit, unsere Ersteborenen zu fressen.

Jedenfalls meine Meinung.  YMMV.

