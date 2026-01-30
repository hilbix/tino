> Dies ist eine Reaktion auf [39C3 - The Last of Us - Fighting the EU Surveillance Law Apocalypse](https://www.youtube.com/watch?v=pfVng5csqyk)

# Technische Vorratsdatenspeicherung (VDS)

Ich bin Admin (AKA SysOp).  Admin zu sein bedeutet, **dass man das Allerletzte ist**.
In dem Sinne, dass es niemanden sonst auf der Welt gibt (außer vielleicht andere Admins) die einem helfen können.

> Warum sind wir "das Allerletzte"?  Weil Admins die Basis dessen darstellen, auf dem alles gegründet wird.
> - Unter uns gibt es nichts mehr.  Entweder wir halten ein Problem fest da bis zu uns durchdringt, oder es gibt niemanden sonst mehr, der es festhält.
> - Denn alles, was bei den Admins durchschlägt, ist nicht mehr aufzuhalten und verschwindet für immer im Void.
> - Wenn die Admins wackeln, dann wackelt also das ganze Gebäude.
> - Und wenn die Admins versagen, können nicht einmal die Putzfrauen die Toiletten putzen, weil niemand mehr ins Gebäude kommt.

Wir Admins sind dafür verantwortlich, dass

- wir die eingesetzte Technik im Griff haben.
- alle User ihre Arbeit machen können.
- alle Arbeitsprozesse laufen und auch funktionieren.
- die Prozesse, wenn möglich, optimal umgesetzt werden.
- wir mit den uns zur Verfügung gestellten Materialien auskommen so gut es geht.
- wir alle so gut unterstützen, wie es uns möglich ist.
- der rechtliche Rahmen eingehalten wird, so weit wir das selbst erkennen können.

Wir Admins sind NICHT dafür verantwortlich, dass

- uns die Materialen zur Verfügung gestellt werden, die wir brauchen.
  - Wir erklären nur, was wir brauchen.  Wenn wir es dann nicht bekommen, obliegt das nicht unserer Verantwortung.
  - Gemäß "wenn möglich, optimal" weiter oben bedeutet, dass wir auch tatsächlich nur das fordern, was auch wirklich notwendig ist!
- uns falsche Materialien zur Verfügung gestellt werden.
  - Beispiel wenn irgendein Marketing-Fuzzy das Management falsch berät und ihnen so einen Scheiß wie "Intranet in der Cloud" verkauft.
- das Management proaktiv zu informieren dass sie gerade dabei sind, groben Mist zu machen.
  - Es ist die Aufgabe des Managements, sich die notwendigen Informationen bei uns abzuholen, bevor sie von uns Unsinn erwarten.
  - Es ist NICHT unsere Aufgabe, zu erahnen, welchen Quatsch das Management gerade wieder ausgeheckt hat.
  - Es ist NICHT unsere Aufgabe, den verschlüsselten Management-Speak in verständliche Worte zu übersezten.
  - Denn nur im ständigen Dialog mit der IT und den Admins kann das Management können vernünftige Strategien entstehen!
  - Dialog, und nicht Kampf!
- die User geschult werden.
  - Dafür ist das Management notwendig, wir können das nur anregen.
- der rechtliche Rahmen tatsächlich vollständig eingehalten wird.
  - Das zu tun ist die Aufgabe von Fachjuristen und ggf. Gerichten.

> "Echte" Admins haben eine ganz besonders nachhaltige Sicht auf alle Dinge, denn nichts hält länger als ein gut gemachtes Provisorium.
> Wir erfüllen nicht nur unsere aktuelle Aufgabe, sondern versuchen auch, das für die Zukunft sicherzustellen.
> Denn alles andere führt in die sog. "administrative Hölle".  Wenn wir nicht stabil planen können, kann auch nichts stabiles auf uns gegründet werden!

Und genau das mit dem rechtlichen Rahmen ist die Motivation, dies hier zu schreiben.


## Motivation

Die Diskussion um die VDS findet hauptsächlich auf rechtlichem und politischem Gebiet statt.
Wobei ich all die Argumente der Strafverfolger auf dem politischen Gebiet einordne.
Denn die technische Umsetzung der VDS muss von uns Admins vorgenommen werden.

Das bedeutet aber nicht nur, dass wir sie technisch im Griff haben, sondern auch in der Lage sind, den rechtlichen Rahmen zu überprüfen.
Denn wenn wir es nicht tun, dann tut das auch niemand anderes.  Nicht nur weil wir das Allerletzte sind, sondern weil es technisch nicht anders möglich ist.

Die VDS muss auf dem Boden der Gesetze erfolgen.  Die Verfassungsrichter (keine Ahnung welche, kommt hier nicht drauf an)
sagen aber immer wieder, dass bestimmte Rahmenbedinugen eingehalten werden müssen.  Und die Politik ignoriert sie.

Genau das ist ein sehr technisches Problem.  Wenn sich Legislative, Jurisdiktion und Exekutive bei der Umsetzung von etwas nicht einig sind, wie soll ich, der Admin das bitte handhaben?

Und genau DAS ist hier doch der Knackpunkt.  Wenn wir die VDS haben, dann muss diese auch ordentlich umgesetzt werden.
Und genau das wird am Ende in den Händen des Admins liegen.  Weil sonst ja niemand da ist.


## Tempus fugit

Ich gehe davon aus, dass es keine direkte Massenüberwachung geben wird, sindern die VDS mit etwas wie einer "Preservation Order" daherkommen wird.

Wenn diese Order eintrifft, dann ist immer Eile geboten, weil die Daten selbst nach kurzer Zeit wieder aus den Logs verschwinden (DSGVO).

Deshalb muss solch eine Oder immer unmittelbar und sofort umgesetzt werden.
Dadurch ist keine Zeit, sich rückzuversichern.  Also das Management zu fragen, oder den hauseigenen Juristen, oder oder oder.

Genauer:  Es gibt dafür eine API, über die solche Orders hereinkommen.  Ein rein TECHNISCHER Vorgang, in den niemand, auch wir Admins, nicht involviert sind.

> - API steht für "Applcation Programming Interface", sprich eine Art Middleware, die vollautomatisch etwas ohne menschlichen Eingriff auslöst.
> - Es ist nicht nur rein TECHNISCH sinnvoll, das vollzuautomatisieren, da es hier nicht nur um Datenschutz sondern Strafverfolgung und schlimmeres handelt.
> - Es muss SOFORT abgearbeitet werden, weil sonst der menschliche Faktor den Prozess verhindern kann (Krankheit, Schlamperei, menschliches Versagen, Vorsatz).

Als Technischer Vorgang muss es außerdem resilient implementiert sein, damit es bei dem Feature nicht zum Missbrauch kommt.

> Beispiel: Tesla-Mitarbeiter konnten (können?) unautorisiert Zugriff auf die Kameras von Teslas nehmen, und hätten (haben?) die Möglichkeit gehabt, Pärchen beim Sex zu filmen und dies auf Social-Media zu verbreiten.

Das Problem dabei ist aber weniger der Missbrauch, mehr die Erosion der Vorgänge.  Wenn ein Vorgang Jahre und Jahrzehnte besteht, dann wird die Kontrolle laxer.
Damit das NICHT passiert, ist es notwendig, die Schnittstelle zu überwachen.  Aber aufgrund der sich stetig sich verändernden Notwendigkeiten und damit
notwendigen Anpassungen von Prozessen ist es eine PITA (Pain In The Ass), wenn irgendwo eine Schnittstelle existiert, um die man sich permanent kümmern muss.
Vor allem dann, wenn man gar nicht die richtige Stelle ist, um dies zu tun!

Die rein technische Überwachung der Schnittstelle obliegt uns Admins.  Die rein rechtliche Überwachung der Schnittstelle können wir Admins aber nicht leisten.
Aufgrund der kritisch kurzen Zeit aber, die zur Verfügung steht, ist eine proaktive rechtliche Überwachung der Schnittstelle nicht umsetzbar,
und wenn wir Admins eines wissen ist, dass eine nachgelagerte Überwachung der Schnittstelle niemals auf längere Zeit Bestand haben wird.

> Es gibt dafür keinen einzigen Fall in der Geschichte der gesamten Menschheit, dass soetwas jemals qualifiziert und dauerhaft funktioniert hätte,
> außer diese Überwachung geschieht extern und unabhängig von den beteiligten Protagonisten.  (Stichwort "Bock zum Gärtner machen".)
> Das sind hier Exekutive, Management, Justitiare und Admins.  Es fehlt also die unabhängige Stelle wie z.B. der Betroffene oder die Presse.


## Dilemma

Das Dilemma ist also, dass etwas SOFORT gemacht werden kann und man dann vor vollendeten Tatsachen steht.

Aus Admin-Sicht wird es sogar noch schlimmer.  Denn wir brauchen nicht nur die Information, was gemacht werden soll, sondern was nicht mehr gemacht werden soll.

Wenn wir Admins etwas wissen, dann ist es, dass letzteres in der Regel nicht funktioniert.  Die Leute fordern etwas an.  Aber die Meldung, dass etwas nicht mehr gebraucht wird, die ist viel seltener.
Deshalb laufen Dinge teils noch nach Jahrzehnten, oder liegen rum, obwohl sie schon lange nicht mehr gebraucht werden.
Das ist bei rein technischen Vorgängen soweit nicht besonders schlimm.  Aber hier geht es auch um das juristische!

Wer ist verantwortlich, wenn irgendwelche privaten Informationen, die über eine Order erfasst wurden, endlos lange herumliegen und dann in falsche Hände geraten?

> Bei falsch konstruierten Verfahren ist das unausweichlich, also nicht die Frage ob, sondern nur, wann!

Wir sprechen hier ja nicht von irgendetwas, sondern dem sehr tiefen und evtl. sogar dauerhaften Eingriff in die Persönlichkeitsrechte einer Person oder Gruppe!

Das bedeutet, dass die Sache TECHNISCH so konstruiert werden muss, dass sie auch wirklich in der Regel funktionieren kann,
und das typische Versagen eines ordentlichen Ablaufs nicht zu einem Fehler führt, sondern diese Fehler möglichst selbstkorrigierend ausgelegt sind.

> Das ist der Grund, warum sich TCP/IP und das Internet derart durchgesetzt haben.  Nicht, weil sie so gut funktionieren, sondern weil alles auch dann
> weitgehen gut funktioniert, wenn mal etwas schief geht.  Und Schiefgehen ist eigentlich der Normalfall, es funktioniert halt dann trotzdem!


## Mögliche Lösung

Ich skizziere hier deshalb EINE MÖGLICHE Lösung aus der Sicht eines Admin.  Ich sage nicht, dass es die einzige Lösung ist.
Ich sage nicht einmal, dass die Lösung vollständig korrekt ist.
Aber es ist für mich ein Denkansatz, wie soetwas überhaupt funktionieren könnte.

> Wichtig!  Ich gehe nicht näher auf alle Umstände ein, was es bedeutet, wenn man von dem hier geschriebenen abweicht.
> In der Regel gibt es aber für alles sehr gute Gründe, was bedeutet, dass es wahrscheinlich KATASTROPHAL schief geht, wenn man es anders macht als hier beschrieben!

### Voraussetzungen

- Die Lösung ist rein technischer Natur, kann deshalb vollständig von den Admins selbst umgesetzt werden.
- Sie funktioniert unmittelbar und ohne juristische Voraussetzungen, kann also von der Exekutive ohne Verzögerung ausgelöst werden.
- Die juristische Seite wird eingehalten, indem alle Entscheidung in die Jurisdiktion verlagert werden.

Damit ist die Verantwortung klar verteilt.  Insbesondere ist niemand sonst (also auch nicht der Justitiar der Firma sowie das Management) involviert,
außer bei Rückfragen, die aber bei einem reibungslosen Ablauf nicht notwendig sind.


### Preservation Order

Von der Exekutive kommt eine Order.  Diese Order wird nicht auf Legitimität geprüft sondern ohne weitere Prüfung technisch sofort umgesetzt.

Dabei kann die technische Umsetzung fehlschlagen, wenn die technischen Voraussetzungen nicht erfüllt sind.
Die technischen Voraussetzungen zu schaffen sind alleine schon kompliziert genug, weshalb abseits von diesen keine weiteren Voraussetzungen existieren können.

> Technisch bedeutet das, es gibt eine API, über die Order empfangen und durchgeführt wird.

Die Order gibt es in 2 verschiedenen Ausprägungen:

- Mitprotokollieren aller Informationen der nächsten 7 Tage.
- Festhalten der vorhandenen Informationen der letzten 7 Tage.

Das bedeutet:

- Wenn man beide Varianten braucht:
  - Löst man zuerst die Order zum Mitprotokollieren aus
  - und dann die Oder zum Festhalten
- Wenn man eine Order länger als 7 Tage benötigt:
  - Dann muss man sie wiederkehrend auslösen.

Die Order des "Festhaltens" kann dabei natürlich nur die Daten sichern, die es bisher schon gibt.
Welche stark eingeschränkt sind:

- Z.B. Einwahlprotokolle mit zugewiesener IP, Bestandsdaten und sonstige Logs zu dem Kunden.

Die Order "Mitprotokollieren" ist spezieller und erlaubt es z.B. auch bis hinunter zur Paketebene mitzuschneiden.
Diese Entspricht also erst einmal einer Überwachungsanordnung in Ton und Bild.

Wichtig hier:

- Beides speichert erst einmal nur die Daten.
- Auf diese Daten wird dadurch nicht zugegriffen!
- Das vermeidet juristische Probleme wie z.B. ein Fremdzugriff nicht autorisierter Personen.

Auch wichtig:

Welche Daten wie mitgespeichert werden, das obliegt dem Admin!  Das ist deshalb notwendig, weil es im Vorfeld so gut wie unmöglich ist,
alles schon vorher festgelegt zu haben.  Denn die technische Entwicklung bleibt ja nicht stehen, also wäre jeder Katalog von möglichen Maßnahmen
grundätzlich immer veraltet und kann auf den jeweiligen Fall nicht kurzerhand angepasst werden.

Genau das ist zu vermeiden, sprich:  Wenn etwas gemacht werden muss, damit man es abgreifen kann, dann muss dies dem Admin auch möglich sein umzusetzen.
Aus diesem Grund gibt es dafür kein Korsett, sondern nur einen groben Rahmen innerhalb dessen ALLES (also auch wirklich alles) gemacht werden kann.

> Hinweis: Wenn nötig putzt ein Admin auch Toiletten.  Er macht alles, was notwendig ist, wenn es sonst niemand gibt, der es tun kann!
> Das bedeutet aber genau NICHT, dass man dem Admin einfach alles machen lässt, nur um sich diejenigen zu sparen, die es eigentlich tun sollten!
>
> Gemeint ist hier eben genau das alles, was unmöglich ein anderer machen kann.  Denn all das fällt dann genau in den Aufgabenbereich eines Admin!
> Wenn sich der Admin in einer einsamen Raumkapsel z.B. keinen funktionierenden Putzroboter (Stichwort "Halluzinelle") bauen kann, dann muss er halt selbst ran.


### Legitimation zum Datenabruf

Der Datenabruf der so gespeicherten oder anfallenden Daten geschieht nur nach Legitimation.

- Diese Legitimation wird von den Admins geprüft.
  - Niemand sonst ist mit dieser Prüfung involviert!
  - Das dient unter anderem der Geheimhaltung.
- Diese Legitimation muss von den Admins prüfbar sein.
  - Es gibt also einen klaren Vorgang, dem ein Admin folgen kann
  - Diese Vorgang ist autoritativ, sprich frei von Fehlern
- Diese Legitimation erfolgt nicht automatisch.
  - Es ist also immer mindestens eine reale Person involviert!
  - KI oder ähnliche unzuverlässige Verfahren kommen NICHT zum Einsatz
- Dem Admin ist überlassen, wie er die Prüfung durchführt
  - Es gibt also keine von außen an ihn gerichteten Voraussetzungen
- Für die Durchführung der Prüfung ist der Admin direkt verantwortlich
  - Der Admin ist dabei nicht an andere Weisungen gebunden!

Damit die Legitimation auch wirklich geprüft werden kann, muss es einen Vorgang geben, dem man zweifelsfrei folgen kann.
Wie dieser Vorgang aussieht, und wie genau der Admin prüft, das obliegt dem Admin allein, und nur dem Admin allein.
Sofern die Prüfung nicht sicher möglich ist, kann und wird der Admin die Legitimation nicht anerkennen.
Dadurch bleiben die Daten gespeichert, aber es gibt halt keinen Zugriff.

> Das ist notwendig, weil sonst kann die Verantwortung nicht auf die Admin-Seite verlegt werden.
> Angesichts von Deep-Fakes und Social-Engineering aber gibt es keine andere Möglichkeit es zu implementieren,
> denn nur, wenn die Verantwortung in den Händen desjenigen liegt, der den Zugang bereitstellt,
> ist sichergestellt, dass man den Vorgang nicht aufgrund der Komplexität aushebeln oder umgehen kann.

IMHO muss der Vorgang also so aussehen:

- Jemand oder etwas will sich legitimieren indem eine Richterliche Anordnung vorgelegt wird.
- Der Admin prüft diese Richterliche Anordnung
- Und erlaubt dann den Zugang

Wie aber prüft man als juristischer Laie eine Richterliche Anordnung, und das noch zweifelsfrei?

Beispielsweise indem der Admin im lokalen Amtsgericht eine ihm bekannte vereidigte Person fragt, die ihm diese Anordnung bestätigt.
Indem der Admin dieses Nachfragen geeignet protokolliert ist der Verantwortung genüge getan.
Es ist dann die Aufgabe des Amtsgericht, über diese Person zu wachen und sicherzustellen, dass keine falschen Informationen vergeben werden.

> Es mag andere Möglichkeiten geben, aber mir fällt für mich beim besten Willen keine ein!
> Deshalb obliegt das richtige Vorgehen eben beim Admin selbst!  Dieser muss entscheiden, wie weit er geht, denn er verwaltet ja den Zugriff auf die Daten!

Ein anderes Beispiel wäre wenn Deutschland angegriffen wird und z.B. ein Geheimdienst einen Anschluss überwachen lassen will.
Wenn der Admin sich sicher ist, dadurch nicht feindlichen Kräften in die Hände zu spielen, kann er dann nach gutdünken die Mitschnitte an den Geheimdienst streamen.
Dafür zeichnet sich dann aber eben dieser Admin auch selbst verantwortlich!  Deshalb kann man ihm aber auch nicht reinreden, wie ein vorher unbekannter Vorgang auszusehen hat!

> Es ist klipp und klar dargelegt, dass der Admin im Fall eines Irrtums vollständig verantwortlich ist!
> Im Fall eines Versagens wäre das ggf. also Hochverrat, und dafür hätte der Admin dann, ggf. mit seinem Leben, einzustehen.
> Und weil das so ist würde ich, als Admin, mir nichts von irgendjemandem sonst sagen lassen, weil am Ende bin ich dann das Bauernopfer,
> denn ich (als Allerletzter) kann ja keinen anderen mehr benennen, auf den ich die Schuld abwälzen kann.


### Vor-Ort Datenauswahl

Das Problem nennt sich Datensparsamkeit.  Wenn jemand einfach so jeder vorbeikommen könnte, um alle Daten abzugreifen (sprich Online-Zugriff),
dann würden die Order schnell immer so aussehen, dass man mangels besserer Infos schlicht "alles" braucht und dann einfach auch "alles" mitnimmt.

Sorry, das kann ein Admin im Normalfall eben genau nicht verantworten!
Denn der Admin hat ja die alleinige Verantwortung, wer Zugang bekommt!
Also muss dieser Zugang passend eingeschränkt werden können.

Da man aber wiederum nicht den Bock zum Gärtner machen kann (wiederum Argument: Verantwortung), muss es hierfür eine sinnvolle Lösung dafür geben.

Die Lösung ist ein gerichtlich bestellter unabhängiger Datenanalyst.

- Der Admin überprüft seine Legitimation,
- dann bekommt der Datenanlyst Zugang zu der ersten Schicht der Daten
- und kann dann herausfinden, welche Daten relevant sind und welche nicht.

Der Zugang zu den nichtrelevanten Daten wird dann gesperrt und der Analyst bekommt Zugang zur nächsten Schicht der relevanten Daten.

- Das wiederholt sich so lange, bis der Analyst die gewünschten Daten gefunden hat
- Diese können dann abgerufen werden
- Die Schichten bestimmt dabei der Admin!
- Die Daten und den Umfang bestimmt dabei der Analyst!
- Außer, dem Admin kommen Zweifel, dann wird er diese dem Gericht mitteilen.

So werden die Daten schon vor-Ort auf das Mindestmaß eingeschränkt, damit keine unnötigen Daten abfließen.


### Gerichtlicher Abruf

Das Gericht entscheidet am Ende über den endgültigen Zugriff auf die Daten.

Der Admin prüft die Legitimation und richtet dann den Datenzugang von außen ein (oder übermittelt die Daten) und zwar immer auf sichere Weise.

Sobald das geschehen ist, ist der Admin aus dem weiteren Geschehen heraus.


## Datenlöschung

Die Daten dürfen sich nicht endlos anhäufen.  Damit genau das nicht geschieht muss es entsprechende Fristen geben.

- Die erste Frist ist 1 Woche
  - In der werden proaktiv Loginformation usw. gesammelt und dann nach 1 Woche verworfen
  - Über die Order kann man diese Daten festhalten
- Die zweite Frist ist auch 1 Woche
  - In der werden alle gewünschten Informationen gespeichert, und zwar so, wie sie anfallen.
  - Das hört aber nach 1 Woche automatisch wieder auf, wenn die Order nicht aktiv verlängert wird.

Nachdem die Daten anfallen, bleiben sie (bis zu) 1 Jahr lang (ich würde lieber nur 1 Quartal sehen, aber ich denke, es wird auf 1 Jahr hinauslaufen)
nach Ende der jeweiligen Order (also der einen Woche) gespeichert.

Diese Speicherdauer verlängert sich jeweils, sobald etwas mit den Daten geschieht.
Also vor-Ort eine Datenauswahl getroffen wird, oder diese gerichtlich abgerufen werden.

> Es ist wichtig, dass die Daten nicht "einfach so auf Zuruf" dauerhaft gespeichert werden können, weil sonst einfach stetig wachsene Order-Liste entstehen.
> Die Speicherdauer ist also unabhängig davon, ob neue oder verlängerte Order hereinkommen.  Nur dann, wenn wirklich etwas mit den Daten geschieht,
> nur dann verlängert sich die Speicherdauer, denn nur das involviert einen Richter, während die Order ja von irendwoher stammen kann.

Ein wichtiger Aspekt ist, dass die vorzeitige Löschung der Daten nicht angeordnet werden kann!
Das ist das Korrektiv, damit sich Betroffene rechtzeitig wehren können und mit der Löschung kein Missbrauch getrieben werden kann.
Viel zu oft waren schon reingewaschene Aservaten Mächtiger, wie Handschuhe oder gelöschte Smartphones, in der Presse.
Sorry, als Admin kann ich nicht risikieren, Teil solcher Machenschaften zu sein.

# Fazit

Wenn ich die Verantwortung übernehmen muss, und da ich ja der Allerletzte bin gibt es eben keinen anderen der das für mich tun kann,
dann muss diese Verantwortung derart in meine Hände gelegt werden, dass ich diese Verantwortung auch vertreten und somit übernehmen kann!
Das kann aber nur meine ureigene Entscheidung sein, denn IMHO darf niemand gezwungen werden, die Verantwortung für etwas zu übernehmen,
das er gar nicht selbst beeinflussen kann!

Natürlich kann man mir diese Verantwortung aus den Händen nehmen.  Aber genau das führt dann zu dem Problem der Entscheidbarkeit:

Wie lange dauert es, bis ich SICHER entscheiden kann, dass die Verantwortung NICHT in meinen Händen liegt?

Ich bin kein Jurist, habe aber immer wieder von Fällen gehört, in denen ein Richter soetwas meinte wie "das hätten Sie bemerken müssen".
Es besteht also die Gefahr, dass ich einen Fehler begehe, und dann irrtümlich annehme, ich hätte nicht die Verantwortung.

Genau das Risiko kann ich bei etwas derart wichtigem wie dem Datenschutz nicht eingehen!
Aus diesem Grund muss ich IMMER davon ausgehen, dass ICH und NUR ICH die GESAMTE Verantwortung trage.
Und nur so kann ich, der Admin, bei einem Vorgang wie der VDS mitmachen.

So, und nicht anders.

Mir ist nicht klar, ob und wie man das alles anders als hier skizziert lösen kann.
Wichtig ist, das alles muss mich überzeugen.  Denn ich muss es ja umsetzen.
Und niemand sonst auf dem Planeten kann mich dazu zwingen!
Zwar bin ich (als Angestellter) Weisungsgebunden durch den Arbeitgeber,
aber kein Arbeitgeber kann von mir das Risiko zu tragen erwarten,
dass ich aufgrund einer Schlamperei gegen meinen Willen zu einem Landesverräter werde!
Egal ob diese Schlamperei auf meiner Seite ist oder woanders, letztendlich bleibt es bei mir und sonst niemandem hängen.

Ich mache meinen Job gerne.  Und, wenn man den Gerüchten glauben schenken darf, auch noch besonders gut.
Und ich kann mir wirklich nicht vorstellen, dass man die VDS umsetzen kann, indem man alle Admins außen vorlässt.

Wir, die Admins, wir sind das Fundament der IT!
Es mag zwar soetwas wie einen Siemens-Lufthaken geben, um beim Hausbau auf ein Fundament verzichten zu können,
aber ich denke es wäre sinnvoll, alles auf bekannte und gut verstandene Weise zu implementieren,
anstatt auf irgendetwas ohne Bodenhaftung zu setzen.

In diesem Sinne, fragt nicht nur Politik, Juristen und Polizei, sondern vergesst bitte uns nicht,
**die Admins, die den ganzen Scheiß am Ende für euch und uns alle ausbaden müssen!**

> Diesen Text habe ich in der Hoffnung verfasst, etwas Konstruktives zu der Diskussion um die VDS beizutragen.
> Aber wie immer erwarte ich exakt gar nichts, denn uns Admins fragt man ja meistens erst dann, wenn sowieso alles bereits zu spät ist.
