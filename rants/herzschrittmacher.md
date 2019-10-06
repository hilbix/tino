# Herzschrittmacher

Wie ich mir vorstelle, dass ein Herzschrittmacher konstruiert sein müsste.

Ich habe mal ein Gedankenexperiment gestartet, wie ich mir, als Techniker, vorstellen würde, wie ein Herzschrittmacher
konstruiert sein müsste.  Folgende Grundlagen habe ich mir dabei vorgestellt:

- Der Schrittmacher muss im Umfeld eines MRT weiter einsetzbar sein
- Der Schrittmacher muss jeden harten EMP aushalten ("aushalten" bedeutet:
  Er kann kaputtgehen, aber nur so, dass der Träger dadurch nicht gefährdet wird)
- Überhaupt muss der Schrittmacher jegliche elektrische oder magnetische Ladung aushalten, die einen Menschen nicht umbringt.
- Er muss servicetechnisch leicht reparierbar und austauschfähig sein
- Er muss flexibel sein, also sich verschiedensten Notwendigkeiten anpassen
- Er sollte redundant konstruiert sein, so dass der Ausfall eines Teils zu keinem kompletten Ausfall führt
- Er sollte über einen Notlaufmodus verfügen, d. h. im kritischen Fall bis zum Eintreffen von Hilfe (mehrere Stunden lang) weiterfunktionieren
- Und er soll Messmethoden unterstützen, d. h. auch in der Lage sein, entsprechende Daten zu erfassen.

Und hier ist, was ich mir so mal auf die Schnelle, als medizinischer Laie, ausgedacht habe.  Ob das Sinn ergibt?  Keine Ahnung!

## Grundlagen

Dies sind die Grundlagen, von denen ich ausgehe.  Ob diese stimmen oder nicht weiß ich nicht.

- Ein Herzschrittmacher besteht im Prinzip aus 2 Elektroden, die dem Herz eingesetzt werden.
- Diese zwei Elektroden werden verwendet, um das Herz zu messen und gleichzeitig, um die jeweiligen Stromstöße zu applizieren.
- Dazu kommt ein Steuergerät, das über eine längere Leitung an diese Elektroden angeschlossen ist

Genau hier sehe ich das Problem:  Die Leitungen sind störanfällig.  In sie können starke Ströme induziert werden.
Aus diesem Grund ist der erste Schritt, diese leitungen zu entfernen.

Das Steuergerät würde ich aus Einfachheitsgründen außerdem in 2 Teile zerlegen, um es redundant zu machen.

Und zusätzlich würde ich passive Komponenten, wie die Antenne/Spule zur Aufladung etc. aus dem Steuergerät entfernen
und separat einsetzen.

## Part 1: Elektroden

Die Plazierung der Elektroden sollte vom Operateur bestimmbar sein.  Das bedeutet, dass man diese an 2 unabhängige
Punkte am Herzen einsetzen kann.

Die Elektroden sollen aber nicht mehr Drahtgebunden sein, aber langlebig.

- Deshalb würde ich diese als kleine EMP-feste Chips kostruiert sehen wollen.
- Damit die Chips EMP-fest sind, sind sie gekapselt, also kleine Metallkügelchen.
- Über diese Metalloberfläche wird auch der Strom ins Herz appliziert bzw. der Strom gemessen.
- Damit die Kügelchen frei platziert werden können und ein Stromkreis entstehen kann, liegt zwischen ihnen eine
  Drahtverbindung.
- Außerdem besitzen sie einen optischen Ein- und Ausgang über den sie mit optischer Energie versorgt werden und mit dem Steuergerät kommunizieren.

## Part 2: Glasfaserleitungen

Zwischen den Kügelchen und dem Steuergerät liegen nichtleitende Glasfaserleitungen.

- Diese sind aus bestimmten Gründen (siehe unten) hohl ausgelegt.
- Ihre Enden bei den Kügelchen sind geschlossen und leitfähig, so das der Faradaysche Käfig nicht unterbrochen ist.
- Über diese Leitungen kommuniziert das Chip auf einer anderen Wellenläge, als es Energie erhält.
- Die Rückkommunikation geschieht mit nur kurzen Lichtblitzen.  Diese können z. B. durch optische Modulation entstehen,
  d. h. es muss kein Fotoemitter verwendet werden (sofern es optische Modulatoren gibt, müsste aber im Quantenbereich
  inzwischen auf Chips ätzbar sein).

## Part 3: Das Steuergerät

Das Steuergerät besteht aus 2 Steuergeräten, die aneinander gekapselt sind, also aus einem Werkstück bestehen.

- Jedes der Steuergeräte bedient eine der Glasfaserleitungen.
- Fällt eines der Steuergeräte aus, kann das verbliebene die Funktion übernehmen, d. h. die Glasfaserleitung ansprechen
- Außerdem gibt es den davon unabhängigen Notlaufmodus, siehe unten
- Das Steuergerät ist wiederum so gekapselt konstruiert, dass es jeden EMP aushalten kann.
- Die Glasfaserleitungen sind an das Gerät gekuppelt, d. h. man kann das Gerät von den Glasfaserleitungen abkuppeln.

## Part 4: Antenne

An dieses duale Steuergerät ist dann eine Antenne (Spule) verbaut,
über die man mit ihm kommunizieren oder es aufladen kann.

Auch hier empfehle ich eine optische Energieübertragung, so dass die Spule elektrisch vom Steuergerät getrennt ist.

Diese Spule muss so konstruiert und verlegt sein, dass sie keinen Schaden anrichtet, wenn ein EMP sie zerstört.

Die Spule ist austauschfähig gehalten, d. h. man kann sie abstecken, austauschen und wieder anstecken.


## Funktionsweise

Das Steuergerät überträgt optische Energie auf die Kügelschen/Elektroden.  Die Elektroden erzeugen die notwendigen Ströme
und liefern die entsprechenden Daten über optische Lichtblitze an die Steuergeräte zurück.

Die Elektroden sind intelligent genug, dass sie grundlegende Fehlsteuerungen vom Steuergerät erkennen können.
Dazu ist ihnen ein Profil mitgegeben, über das sie zulässige Werte etc. ermöglichen.

Das Profil ist änderbar.  Die Änderungen werden in den Kügelchen gespeichert.  Ist der Speicher voll, dann führt die
nächste Programmierung in den Notlaufmodus.  Sprich:  Die Kügelchen stellen den Dienst ein.

Das Steuergerät kann an die Kügelchen Kommandos und Energie übertragen.  Beides geschieht optisch.

Die Kügelchen bauen zwischen sich ein entsprechendes Energiepotential auf und applizieren dann die gegebene Energie.

Dazu brauchen sie ein Current-Loop.  Dieses bedingt, dass zwischen ihnen 2 Drähte liegen.
Diese Drähte sind in dem Sinne abgeschirmt, dass sie keinen Schaden anrichten, wenn sie durchbrennen.

Im Fall eines EMPs brennen die Drähte durch.  Da es eher unwahrscheinlich ist, dass die Drähte gleichzeitig durchbrennen,
gibt es in den Chips eine Schutzschaltung, die die Drähte abkoppeln kann.  Diese Schutzschaltung ist im Prinzip eine
Schmelzsicherung, die auslöst, bevor es zu gravierenden Fehlfuktionen auf dem Chip kommt.
Sinnvoll wäre auch, wenn diese Schmelzsicherung eine Abtrennung des Drahtes zur Folge hätte,
so das dieser in seiner Schutzhülle reißt, damit keine Induktionsströme über die leitende Hülle des
Kügelchens auf das Herz wirken.  Dies lässt sich vermutlich durch den Einsatz von Memorymetall erreichen
- wird dieses zu heiß aufgrund des EMP - hat es ein definiertes Verhalten,
nämlich zerfällt in mehrere unabhängige nicht mehr miteinander verbundene Teile.


## EMP

Nach einem EMP tritt der Notlaufmodus in Kraft.

Bei einem EMP oder sonstigen elektromagnitischen Einwirkung von außen werden die Kügelchen inaktiv,
und zwar auf eine Weise, die das Herz nicht selbst schädigt.  Danach sind sie 2 isolierte Kügelchen,
die an einer nichtleitenden Glasfaser hängen, verbunden mit 2 innerlich fragmentieren Drähten,
die keinerlei schädliche Auswirkungen haben können.

Die beiden Steuergeräte sind ebenfalls EMP-sicher konstruiert, verlieren aber die Verbindung zu den
Kügelchen, da diese ihre Funktion nach dem EMP einstellen.  Außerdem brennt die Antenne/Spule durch,
was durchaus eine Schädigung des Menschen zur Folge haben kann.  Deshalb sind Spule und Steuergerät
(das bei EMP durchaus sehr heiß werden kann) aber an einer Stelle untergebracht, die nicht lebenswichtig
ist, die also bei einen thermischen Schock (mehrere 100 Grad) zwar verbrennt, aber den Menschen überleben lässt.


## MRT

Wenn ein MRT notwendig wird, kann man wie folgt vorgehen:

- Man entfernt operativ vorbereitend die großflächige Spule.  Das geht ohne den Herzschritmacher zu beeinflussen.

- Kurz vor dem MRT entnimmt man das vergleichsweise kleine Steuergerät und schließt die Glasfaser an ein externes
  Gerät an, welches die Funktion des Herzschrittmachers übernimmt.

- Die Kügelchen/Sensoren verbleiben im Herzen.

- Elektrisch wird das Loop von den Kügelchen getrennt, da bei MRT, gegenüber einem EMP,
  nicht anzunehmen ist, dass hohe Spannungen erzeugt werden können.  Da MRTs konstruktiv unterhalb von 5 Tesla
  angesiedelt sind, kann man das Verhalten der Kügelchen bei entsprechenden Feldstärken um die 10 Tesla testen.
  
Durch diese Maßnahme wird der MRT nicht problemfrei.  Also auch wenn das Steuergerät nun nicht mehr problematisch
ist, da es extern übernommen wird, ist jegliches Metall im Körper ein Problem.  Die Erwärmung des Loops ist
dabei einzukalkulieren, und zwar in die Isolation mit der das Loop versehen wird.  Die Kügelchen sollten sich
aufgrund ihrer geringen Größe nicht stärker als 1-2 Grad erwärmen.  Entsprechende Sensorik kann in das Kügelchen
eingebaut werden, das ja aufgrund seiner Natur einen Faradayschen Käfig darstellt, also während des MRT operabel bleibt.

Ziel wäre also, dass MRTs auch bei notwedigem aktiven Herzschrittmacher jederzeit möglich ist.


## Notlaufmodus

Im Fall dass die Kügelchen sich separieren, und der Mensch nicht in der Lage ist, die Herztätigkeit selbständig
aufrechtzuerhalten, tritt ein Notlaufmodus ein.  Das bedeutet, die Steuergeräte fangen an, passiv
(also ohne Kenntnis der aktuellen Zustands) das Herz zu steuern, so wie vorgesehen.

- Die Glasfasern sind nichtleitend ausgelegt, weshalb über diese per-se keine Energie übertragen werden kann
- Deshalb sind sie hohl.  In diesen Hohlraum wird eine leitfähige Flüssigkeit (z. B. Salzwasser) eingespritzt,
  die dann die Leitfähigkeit der Glasfaser bereitstellt.
- Da die Enden bei den Kügelchen leitfähig sind, erreicht die elektrische Ladung auch die Außenhülle der Kügelchen.
- Über die so hergestellte leitende Verbindung wird dann die Notsteuerung des Herzens übernommen

Diese Steuerung ist unabhängig von den Steuergeräten und nicht programmierbar.  Sie hängt von den
eingesetzten Steuergeräten ab.  Wird diese Steuerung also verändert, müssen die Steuergeräte ausgetauscht werden.

Die Notsteuerung ist weitgehend mechanisch auszurichten, d. h. läuft eher wie ein mechanisches Uhrwerk als
elektronisch gesteuert.  Es wird einfach, in periodischen Abständen, wie vorgesehen, die Energie der
Batterie an die beiden nun leitfähigen Glasfaserkabel angelegt.  Genauso wie der Einspritzvorgang einen
mechanischen Vorgang darstellt.

Dieser Notlaufmodus ist so zu konstruieren, dass er mindestens 8h durchhält.
Sinnvollerweise basiert er nicht auf einem Akku, sondern einer chemischen Notbatterie.


# Abschließende Erklärung

Mir ist nicht klar, ob man auf diese Weise einen Herzschrittmacher konstruieren kann.
Es geht hierbei auch nicht um implantierte Defibrillatoren, sondern um "echte", meist aktive, Herzschrittmacher.

Allerdings bin ich der Meinung, dass ein Herzschrittmacher so konstruiert sein sollte,
dass er bei Ausfall der Hauptelektronik weiter grundlegend funktioniert.

Der Notlaufmodus ist dabei nicht programmierbar sondern so konstruiert,
dass er auf den jeweiligen Patienten vor-eingestellt ist.
Dies kann durch einen mechanischen Aufbau mit anschließender Einmal-Versiegelung geschehen.
Der Notlaufmodus ist dabei nicht auf einen endlosen Betrieb ausgerichtet,
sondern auf eine Notfall-Versorgung des Patienten bis Hilfe eintrifft.
Er muss darauf eingestellt sein, wie schnell Hilfe eintreffen kann, und wie lang dies im schlechtesten Fall dauert.

> Schlechtester Fall wäre z. B. Großflächiger Strom- und Telekommunikationsausfall mit gleichzeitiger Überschwemmung
> bei Wind in Orkanstärke, wenn die Notmannschaften sich also gezielt von Patient zu Patient durchschlagen müssen.
> Hier ist also zu berücksichtigen, wie lange es dauert, den letzten Patienten in einen Sicherheitsbereich zu evakuieren,
> eingedenk der Möglichkeit, dass ja der Notfall eine Millisekunde nach der letzten erfolgreichen Ferndiagnose
> eingetreten sein könnte.
>
> Früher, bei fremdgespeister Analogtelefonie, da war es noch einfacher gewesen.  Da hätte man die meisten Patienten
> ja weiter telefonisch erreichen können.  Jetzt aber fällt nach einem Stromausfall die IP-Telefonie sofort aus,
> und nur wenige Sekunden bis wenige Stunden später das Mobilnetz, das als Backup für die Remote-Diagnostik genutzt wird.
> Deshalb muss man im großflächigeren environmentalen Schadensfall entweder mit deutlich erhöten Todeswahrscheinlichkeit
> bei Herzschrittmacherimplantatsträgern rechnen, oder man muss geeignete teure Notfallverfahren etablieren, die dies
> in diesem Fall verhindern können.
>
> Das einfachste Verfahren wäre gewesen, einfach nur die Analogtelefonie wie gehabt beizubehalten.
>
> Das zweite Verfahren wäre, von Mobilfunkanbietern eine Garantie zu fordern, dass die Mobilnetzabdeckung
> bei einem grosflächigen Desaster mindestens 1 Woche zu 100% garantiert ist, also auch dann,
> wenn Wege aufgrund von Überschwemmung, Eis oder unerhörten Windstärken tagelang unpassierbar sind.
>
> Ein drittes Verfahren wären satellitengestützte Kommunkationsstrukturen, die in diesem Fall einspringen.
> Entgegen allgemeiner Filmdarstellung bedeutet das aber eine Außenantenne mit freier Sicht nach Oben für jedes Haus,
> in dem sich ein entsprechender Anschluss von Remotediagonstik befindet.
>
> Ein dezentrales Akkumanagement, welches eine mehrtägige Notspeisefähigkeit für Remote-Diagnostik (also nicht
> die allgemeine Telefonie) ermöglicht, dürfte technisch keinerlei Herausforderung darstellen.

EMP mag sich schräg anhören, aber EMP-Waffen existieren.  Ebenso wie Taser.  Dazu kommen Dinge wie der MRT.
Deshalb ist die Forderung danach nicht sinnfrei, sondern notwendig.

Ein Herzschrittmacher ist ein lebenswichtiges Aggregat, an dem Menschenleben hängen und das man nicht ohne extreme
Sicherheitsmargen konstruieren darf.

Es gibt verschiedene Sorten von Herzschrittmachern:

- Die, die das Herz permanent unterstützen, weil es sonst aus dem Tritt gerät
- Die, die das Herz bei Bedarf unterstützen, wenn es nicht richtig regelt.
- Defibrilatoren, die bei Bedarf einen Kondensator laden und das Herz per Schock "zurücksetzen".

Letztere sind konstruktiv weniger problematisch, da diese genauso gut durch ein externes Notaggregat ersetzt werden können,
wie es sich inzwischen in jedem U-Bahnhof in Deutschland befindet.
Der Träger benötigt die Funktion des Geräts außerdem nur in äußerst seltenen Fällen,
und dessen Funktion ist in der Regel auf wenige Anwendungen beschränkt bis die Batterie leer ist.

> Vermutlich können Defibrillatoren auch nicht mit Lichtenergie gespeist werden, da die Kondensatoren zu energiereich sind.
> Andererseits wäre es evtl. möglich, einen Kondensator in dem Loop einzubringen, also zwei weitere Kügelchen,
> die dann ständig auf der notwendigen Betriebsladung gehalten werden (es sind mindestens 2 nötig, für Redundanz,
> aber außerdem dauert das Aufladen des Kondensators mehrere Minuten, d. h. es müssen so viele Kondensatoren
> vorhanden sein, wie evtl. Schocks in einer kurzen Reihe notwendig sind, plus Redundanz).
>
> Es ist nichts dagegen einzuwenden, wenn die Aufladung der Kondensatoren nicht vom Steuergerät ausgeht,
> sondern die dafür notwendige Energie extern (regelmäßig) über die Spulen zugeführt wird.
> (So wie man das Handy nachts auflädt, lädt man dann seinen Defi auf.)
>
> Defibrillatoren wären also vermutlich ähnlich konstruierbar.  Allerdings weiß ich nicht, wie man diese
> dann EMP-fest bekommt, denn diese sind ja aufgeladen, und ich halte es im EMP-Fall als gegeben,
> ein unkontrollierten Defi-Schock möglichst zu vermeiden.

# Fun Fact:  Die Darstellung des Defi in Filmen ist zu 99% falsch.

Defis werden nämlich nicht eingesetzt um das Herz zu starten, sondern um es zu stoppen.

Nämlich für den Fall, dass das Herz unkontrolliert zuckt (sog. Kammerflimmern).
Dadurch verbraucht das Herz seine Energie und der Blutfluss gerät ins Stocken.  Wird das Herz angehalten,
fängt es normalerweise wieder von selbst an zu schlagen.

Evtl. braucht es dabei allerdings Starthilfe durch einen manuell eingeleiteten Blutfluss, durch eine Herzmassage,
eben um wieder genug Energie in den Zellen aufbauen zu können dass diese den Herzschlag durchführen können.

"Wir haben immer noch keinen Puls, Defi höher einstellen Hände weg und Schock" wie in Filmen ist totaler Unsinn.
Das kommt nur daher, weil das nicht nur dramatischer dargestellt werden kann und besser aussieht als wenn jemand
Herzmassage durchführt, sondern auch die Darstellung einer ordentlichen Herzmassage eher kompliziert und schwierig ist,
dabei ein deutliches Verletzungsrisiko der Darsteller existiert und das dramaturgisch auch doof rüberkommt
und außerdem meistens zu lange dauert - im Film kann die Spannung ja nicht aufrechterhalten werden, wenn man sieht,
wie sich jemand 15 Minuten im Film mit einer Herzmassage abrackert.

Durch ständige Defi-Schocks grillt man das Herz letztendlich nur, verhindert also, dass es jemals wieder schlägt.
Mehrfache Defi-Schocks sind nur dann notwendig, wenn das Herzkammerflimmern nicht aufhört.  Dies kann man aber nicht
anhand von Pulsmessungen erkennen, sondern dazu bedarf es eines EKGs, das in dem Fall eben keine Flat-Line anzeigt
wie immer in Filmen dargestellt, sondern ein total gestörten unkontrollierten Herzrhythmus.

Moderne Defis arbeiten entsprechend auch vollautomatisch, und beschreiben die notwendigen Maßnahmen entsprechend so,
dass der Laie diese korrekt anwenden kann.  Das ist nicht nur eine technische Notwendigkeit, weil ein Laie
Herzkammerflimmern ja gar nicht erkennen kann, sondern auch der falschen Darstellung im Film geschuldet,
die Leute würden das Gerät nämlich sonst vollkommen falsch anwenden.

Eine Herzmassage ist bei Kammerflimmern in der Regel weitgehend ineffektiv.  Um einen ordentlichen Blufluss
wiederherzustellen muss das Herz in dem Fall erst gestoppt werden, so dass es wieder die Energie zum Schlagen aufbauen kann,
die Herzmassage ist dann lediglich unterstützend, um das Organ mit Sauerstoff zu versorgen, bis es wieder genug Energie hat,
seinen Dienst wieder selbst zu verrichten.

Es gibt noch den Fall, dass das Herz tatsächlich nicht von selbst anspringt.  Dafür ist dann wohl ebenfalls ein Impuls
notwendig, der aber vollkommen anders aussieht, als das, was der Defi abgibt.  Das entspricht dem, was der Herzschrittmacher
tut, nämlich einen sehr geringen minimalen impuls abzugeben, der dafür sorgt, dass der Muskel sich kontrolliert(!)
zusammenzieht.  Dieser Impuls ist dann aber oft über weiter Strecken notwendig, weil der Sinusknoten, der das Schlagen des
Herzens kontrolliert, dann offensichtlich geschädigt oder ausgefallen ist.  Hier hilft ein Defi-Impuls nicht,
im Gegenteil, er würde die Schädigung nur verstärken.

Während das mit dem Defi also eher eine kurze Phase darstellt, kann die Herzmassage viele Minuten anhaltend
notwendig sein, also mindestens bis zum Eintreffen der Rettungsmannschaften.
Der moderne Defi unterstützt auch dabei, weil er erkennen kann, sobald das Herz wieder von selbst schlägt.

Aber:

Auch bei Kammerflimmern hilft die Herzmassage wohl trotzdem, muss aber entsprechend verstärkt durchgeführt werden.
Dass dabei Rippen brechen ist eher der Normalfall wie man so hört.  Man muss also eher mit brachialer Gewalt herangehen
als mit Vorsicht.

# Wichtiger Hinweis

Was ich hier schreibe ist Hörensagen und kann Fehler enthalten.

Wie man eine Herzmassage korrekt durchführt erlernt man im Erste-Hilfe-Kurs, den jeder Autofahrer durchführen muss.

Diesen Kurs sollte man eigentlich von Zeit zu Zeit aktiv wiederholen um die Kenntnisse aufzufrischen.

Ich persönlich sollte mir da an die Nase fassen, denn mein letzter Erste-Hilfe-Kurs liegt schon über 30 Jahre zurück.

Jetzt im Zuge der Umstellung des Führerscheins auf Verlängerungsbasis wäre es eigentlich sinnvoll,
wenn man die Verlängerung and die Teilnahme eines Erste-Hilfe-Kurses koppeln würde.
Also keine medizinische Untersuchung (wie von einigen angedacht) sondern eine medizinische Schulung.
