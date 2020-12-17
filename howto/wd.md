# WD

## Die "richtigen" WD und die falschen

WD-Platten Boxed Retail (nicht: Bulk!) laufen in der Regel über Jahre einwandfrei, weshalb ich diese Platten sehr gerne einsetze.

Allerdings hat Western Digital irgendwie letztlich einen Schuss abgekriegt und ist wahnsinnig geworden,
denn sie verkaufen für einen exakt bestimmten Workload exakt unbrauchbar konstruierte Platten.

WTF?  Damit ich nicht immer irgendwie kompliziert nachgreppen muss, fasse ich hier meine Erkenntnisse zusammen, weil ich das in meinem Zettelkasten auch wieder finde.

- **`EFRX` hat CMR**, das ist die **einzig richtige** Technologie für ZFS NAS.  Diese Platten heißen anscheinend jetzt "RED PLUS"
  - Obwohl .. [anscheinend gibt es Lieferanten](https://www.heise.de/news/WD-Red-Amazon-verkauft-SMR-als-CMR-Festplatten-4798442.html),
    die statt echter "RED PLUS" auch EFAX verkaufen.
- **`EFAX` ist SMR**, sind also **komplett unbrauchbar**.
  - Als Archivplatte kann man die vielleicht verwenden, aber nicht für NAS-Technologie für die sie verkauft werden.
  - Bei mir speichert das NAS RANDOM 4KB-Workloads (ZFS) quer über alle Platten,  komplett zufällig und willkürlich, und zwar gigabyteweise.
  - EAFX steigen da binnen Minuten(!) aus, weil die Platten derart langsam werden, dass die Platten als Defekt erkannt werden und nach mehreren solchen Fehlern als defekt markiert werden.

## SMR vs. CMR

Übrigens könnte SMR hat auch Vorteile haben, wenn die Hersteller der Platten nur für einen Pfifferling gedacht hätten:

- CMR schreibt einen Sektor einmal, und dann eigentlich nie wieder.
- Wie bei RAMs kommt es da zu einem Degradationseffekt, d. h. die Platte bemerkt nicht, dass die Magnetisierung schlechter wird und irgendwann ist der Sektor nimmer lesbar.

- SMR hingegen muss die Zonen bei jedem Schreibvorgang komplett neu erstellen, weil das bei SMR nich anders geht.
- Das refresht die magnetischen Informationen der Zonen, und diese bleiben so frischer.

ABER das ist auch genau der Nachteil von SMR:

- Geht der Refresh-Vorgang einmal schief, weil etwas nicht lesbar ist, ist die Platte ggf. instant KOMPLETT hinüber

## SMR könnte besser sein als CMR

ABER wenn es RICHTIG gemacht worden wäre, hätte SMR all diese Nachteile nimmer!
WENN es richtig gemacht würde.
Wird es aber offensichtlich nicht.

Damit das klappt müsste die Funktion in der Platte komplett umgedreht werden (und die Platten sollten unabhängige Lese- und Schreibköpfe bekommen):

- Die Platte arbeitet stets linear beim Schreiben, was extrem hohe Dauertransferraten bei Random Write zur Folge hätte
- Beim Linearen Lesen kommt halt Random Access raus.
- Dabei liest die Platte (round robin bitte, also selektiv nacheinander) die "alten" Zonen und kopiert diese in die "neue" Zone in die gerade geschrieben wird.
  - Dabei kann man die Sektoren ggf. etwas "linearer" anordnen, so dass der Zugriff sich optimiert.
  - Dadurch refresht sich die Information vollautomatisch.  Defekte Sektoren können so erkannt und ausgeschlossen werden.
  - Ein Reallocation von defekten Sektoren ist NICHT notwendig, stattdessen werden defekte Teile einfach nur markiert und automatisch übersprungen
- Bei einem COW Filesystem wie ZFS macht das dann keinen großen Unterschied, da sind lineare Leseoperationen eher selten aufgrund der COW-Struktur.
  - Außnahme sind wohl zvols, aber die nutze ich eher selten.

Dieses Vorgehen hätte gar nicht soviele Nachteile, denn die Platte funktioniert bei linearen Schreiboperationen weiterhin weitgehend linear.
Außerdem hätte sie ein absolut vorhersagbares Ansprechverhalten, da die Schreibgeschwindigkeit IMMER quasilinear ist,
somit ist die Datenveränderung in der Platte grundsätzlich immer so schnell wie es überhaupt nur sein kann.

Das LESEN wird dann langsamer, je nachdem wo die Sektoren verteilt sind.  Aber auch DAS kann man verbessern:

- Wenn die Platte feststellt, dass ständig bestimmte Sektoren nacheinander gelesen werden, kann sie diese in der aktuellen Schreibzone zusammenfassen,
  so dass diese dann hintereinander stehen.  Damit optimiert sich die Platte vollautomatisch auf den üblichen Workload!
- Dabei sind ZWEI Dinge zu beachten:
  - Wenn die Platte neu gestartet wird, dann gibt es am Anfang einen bestimmten Workload, den sie abspeichern muss, um ihn beim nächsten Start dann zu vergleichen.
  - Und dann, nach 5 Minuten oder so, schaltet sie in den zweiten Modus, und cachet den Workload einfach nur im RAM, das wird aber nicht aufgezeichnet.
  - Finden sich dann Pattern (ist gut im ARC von ZFS beschrieben wie die das machen, es wird da nicht beim ersten Hit gecachet) kann man das verwenden.
  
Wenn jetzt die Platten jetzt noch ZWEI unabhängige Köfe hätten, einen Lesekopf und einen Schreibkopf,
würde das noch viel besser, dann könnte der Schreibkopf schreiben was der Lesekopf liest.
  
Der Lesekopf ist optimiert auf Random Read, während der Schreibkopf eher nur sehr gemächlich über die Platte bewegt werden muss,
da er ja immer nur ganze Zonen schreibt.  Die Platte muss dabei nur über genug RAM verfügen, um eine gesamte Zone im Speicher zu halten.

Da dann der Lesekopf unabhängig vom Schreibkopf arbeitet, kann die Platte Leseoperationen weiter ausführen während der Schreibkopf gerade schreibt.
Einzig die Bewegung des Kopfes muss evtl. etwas gedämpft werden, damit keinen Resonanzen auftreten die die Schreiboperation stören können.

Sofern keine Barrier eintrifft, kann die Platte auch Schreiboperationen ausführen, da sie die bereits geschriebenen Zonendaten ja für neue Daten bereitstehen.

Es wird NOCH besser.  Durch Reordering kann man die Schreiboperationen so gestalten, dass Barriers schneller abgearbeitet werden können,
indem man neu eintreffende Schreibdaten früher schreibt, als all die anderen Zonendaten, die sich anderweitig noch auf der Platte befinden.

Langsamer wird die Platte dann nur, wenn es keine freie Zone mehr gibt, die neu geschrieben werden könnte.  Aber auch das lässt sich beheben:

Richtig gemacht müssen Lese- und Schreibrate nicht unter die Hälfte fallen.  Und zwar per Overcommitment, indem die Platte einfach genug Reserven hat.

Das bedeutet, eine 6 TB Platte hat z. B. in Wahrheit 6.1 TB.  Diese 100 GB mehr werden verwendet, um immer genug freie Zonen zu haben.

> Achtung!  Die Zonengröße hängt von der Schreibgeschwindigkeit ab.  Nicht die vom BUS sondern die vom Schreibkopf.
> Eine sinnvolle Größe liegt unerhalb von 2s, sprich, bei 100 MB/s wäre die Zone max. 200 MB groß.
>
> 2s bedeutet, dass eine Barrier ("sync") durchschnittlich 2s dauert.

Eine Zone hat dann z. B. 1 GB.  Dann entsprechen diese 100 GB bei voller Platte exakt 100 freier Zonen.
Das bedeutet auch, die Platte braucht etwas mehr als 1 GB RAM, damit sie eine Zone komplett in den RAM einlesen kann.

So lange mehr als 50 Zonen frei sind müssen wir uns keine Gedanken machen.  Die Platte hat dann "full speed", sprich, Lese- und Schreibkopf
arbeiten vollkommen unabhängig voneinander, wie folgt:

- Die Platte startet mit einem Füll-Zyklus:
  - Dafür wird der RAM mit der ersten zu verlagernden Zone vorbelegt, liest also z. B. 1 GB in den RAM.
  - Der Lesekopf wird dafür (mindestens!) 50% der Zeit belegt.
  - Dabei werden nicht mehr benutzte Sektoren (a 4K) übersprungen.
  - Es kann also sein, dass mehr als eine Zone gelesen werden muss um den RAM zu befüllen.
  - Dabei werden nicht mehr als 3 volle Zonen eingelesen, sprich, wenn dann immer noch nicht eine Zone komplett gefüllt werden kann ist die neue Zone halt "short".
    - Haben Zonen variable Größe, sind es so viele Zonen, dass 3 volle Zonen Platz geschaffen würde.
  - Eintreffende Schreiboperationen werden dabei mitgenommen, füllen also den RAM ebenfalls auf.
- Trifft eine Barrier ein, blockiert diese, bis die neu gefüllte Zone vom RAM vollständig und erfolgreich auf die Platte geschrieben wurde.
  - Eintreffende Schreiboperationen können aber weiterhin parallel im RAM abgelegt werden und gleich mitgeschrieben werden

> Sofern die Zonengröße immer gleich groß ist, haben wir bei vielen Barriers ein Problem.
> Deshalb sollten Zonen eine variable Größe haben, die aber weit unterschritten werden kann.
>
> Wen also eine Barrier eintrifft, wird die Zone sofort geschrieben.  Dadurch nimmt sie weniger Platz auf der Platte ein.
> Man kann also die nächste Zone "dichter" danhängen und so den ungenutzten Platz verwenden, was die Kapazität der Platte nur geringfügig verkleinert.
>
> Durch die "Garbage-Collection" (verschieben von Zonen) hat man aber immer genug freien Platz um eine gesamte Zone zu schreiben.

- Ist eine Zone gefüllt wird sie geschrieben
  - Bei variabler Zonengröße startet der Schreibvorgang sofort beim Eintreffen einer Barrier
  - Der Schreibvorgang endet, wenn keine Daten zum Schreiben mehr vorhanden sind (logischerweise)
  - Am Ende des Schreibvorgangs wird die Zone "committet", sprich die interne Datenhaltung wird aktualisiert (wo liegt welcher Sektor)
- Sofern übergroße Zonen möglich sind, kann die Zone auch mit deutlich mehr Daten gefüllt werden.
  - Das geschieht aber nur, wenn Schreiboperationen eintreffen während die Zone gerade geschrieben wird bis zum Ende der Daten einer dadurch freiwerdenen vollen Zone.
  - Übergroße Zonen sollgen aber niemals größer werden als 3 Zonen auf der Platte belegen.
  - In diesem Fall sollte die Platte RAM für mindestens 2 Zonen haben.
  - Hat man mehr RAM optimiert das außerdem die Geschwindigkeit, da man eine weitere Zone aufbauen kann (Lesekopf!) während eine noch geschrieben wird.
  - Außerdem verringert das die Wahrscheinlichkeit übergroßer Zonen, da man instant auf die zweite Zone "swichen" kann sobald diese bereitsteht.
  - Sprich:
  - Übergroße Zonen werden normalerweise vermieden und nur ganze Zonen geschrieben.
  - Aber wenn noch Daten im RAM sind,
  - und dadurch eine komplette Zone (nicht: übergroße Zone.  Auch nicht variabel kleinere Zone) frei wird,
  - diese Daten im RAM nicht aus einer übergroßen Zone stammen oder durch kleinere Zonen die nächste "normale" Zonengrenze erreicht wird,
  - dann werden zusäztlich an die geschriebene Zone die Daten angehängt, die diese komplette Zone frei werden lässt.
  - Das ist komplizierter als es klingt.  Denn wenn es variable Zonengrößen gibt, dann können Daten aus mehrere kleinere Zonen benötigt werden.
  - Und warum?  Das hat etwas damit zu tun, die Strukturen auf der Platte "on the fly" der gewünschten Standardstrukturierung anzupassen.
    Das mag vollkommen überflüssig aussehen, ist es eigentlich auch, aber es ist gut, wenn man von einem Standard und nicht Chaos ausgehen kann,
    für den Fall, dass Dinge wie Datenrettung usw. notwendig sind.  Es ist aber auch gut, vom Standard abzuweichen, um die Geschwindigkeit zu erhöhen.
- Ist genug freier RAM da für eine komplette Zone, startet der nächste Füll-Zyklus
  - Der Lesekopf füllt die Zone wieder zu 50% seiner Zeit
  - etc.
- Ist ein Füll-Zyklus abgeschlossen, es trifft aber keine Schreiboperation ein und liegt auch keine vor:
  - Sofern der letzte Schreibvorgang (vom Computer, nicht von der Platte) länger als 5s zurückliegt, wird gewartet
  - Es kann auch ein entsprechendes SMART-Kommando vorhanden sein, dass dieses Warten unterbindet
  - Sind alle Zonen perfekt sortiert, sprich, sind vollständige (nicht kleine oder übergroße) Zonen, enthalten keinerlei Holes mehr und sind in sich
    korrekt sortiert, stoppt dieser Füllzyklus, bis ein Schreibbefehl eintrifft.
- Eine Optimierung kann sein, dass man Daten, die sich bereits genau so auf der Platte befinden, nicht neu schreibt, wenn ein Schreibbefehl eintrifft.
  - Diese Optimierung sollte aber nur dann gemacht werden, wenn der Lesekopf frei oder mittelbar frei ist (sprich, etwas Luft hat um das zu tun).

ARGL, hört sich irre an?  Ist es eigentlich auch, aber ich wollte mal meine Gedanken dazu zusammenfassen.

Ein wichtiger Punkt wurde unterschlagen:

### Die Datenhaltung.

Die Datenhaltung hier ist etwas komplizierter, denn wir haben da ein kleines Problem:  Was, wenn die Datenhaltung komplett durcheinanderkommt?

Auch das lässt sich mit etwas Schweiß lösen.  Dieser heißt "Redundanz".

Jede Zone enthält dabei am Anfang zusätzliche Informationen:

- Eine Generation, die die Generation der Zone beschreibt.  Höhere Generationen überschreiben dabei niedrigere.
- Ein Flag, ob es sich um eine kurze Zone handelt
  - Ein solches Flag gibt es für übergroße Zonen nicht!  Diese fangen wie Normalzonen an, sind halt nur länger.
  - Sinnvollerweise kodiert dieses Flag die länge des Headers.  Ist dies unter dem Maximalwert ist es eine kurze Zone.
- Eine Liste der Sektoren in der VORANGEGANGENEN Zone und wo sich diese auf der Platte befindet (startet)
  - Vorsicht bei übergroßen Zonen, da kann die Liste länger werden, dieser Platz muss vorhanden sein!
  - Bei kurzen Vorgängerzonen ist das kein Problem, da kann man die Liste mit Leereinträgen aufblasen.
- Ggf. einen Top-Level-Update der inneren Baumstruktur zur Suche von Sektoren (B-Tree?) bezogen auf die VORANGEGANGENE Zone
  - Dieser Update-Bereich sollte eine feste Größe haben, damit man besser rechnen kann.
  - Ob diese Informationen überhaupt notwendig sind ist mir nicht ganz klar, so weit habe ich das noch nicht durchgedacht.
  - Diese Struktur dient der Ausnutzung des vorhandenen freien Platzes in dem Header bei Normalzonen.
  - Sie kann dann bei kurzen Zonen entfallen (je nachdem wie das Layout der Platte ist kann es sowieso freien Platz geben.)
- Dieser Zonenheader sollte immer eine feste Länge haben
  - Bei variabler Zonengröße kann der Header bei kurzen Zonen kürzer ausfallen
  - Bei Standardzonen und übergroßen Zonen hat dieser Header hingegen eine exakt festgelegte Länge!
- Wenn die VORANGEGANGENE Zone eine kurze Zone war, 

Jede Zone enthält am Ende zusätzliche Informationen:

- Die Liste ihrer Sektoren
  - Diese Liste kann variabel lang sein

Sinnvoll ist es außerdem, jedem Sektor zusätzlich, neben seiner Sektornummer, die Generation der Zone mitzugeben,
so dass man den Sektor zuordnen kann wenn man ihn auf der Platte findet.

Damit das funktioniert muss die Platte beim Start:

- Die zuletzt geschriebene Zone zuerst einlesen.
- Dann die Baumstruktur mit den Sektoren der Zone aktualisieren
- Und dann ggf. auf vorherige Zonen zurückgreifen, um die weiteren Ebenen der Baumstruktur einzulesen

Da dieser Baum sehr groß werden kann, braucht die Platte ggf. ein Service-Area, in das sie das aktuelle Mapping eintragen kann,
zum schnelleren Nachschlagen.  Der Vorteil ist, dass dieses Service-Area nur ein Cache ist und - bei Stromausfall - passend regeneriert werden kann.

Bei all dieser Datenhaltung kann einiges schiefgehen.  Deshalb braucht die Platte sehr gute Recoveryfähigkeiten.

Z. B. kann sie die gesamte Oberfläche der Platte nach Zonen abscannen und so "verlorene" Informationen wiederherstellen.

Wie findet die Platte diese letzte Zone?

Über das Service-Area.  Das kann aber nicht ganz aktuell sein, da es ja immer nur NACH der Zone aktualisiert wird.
Es kann sogar sein, dass es mehrere Generationen hintendran ist.

Das ist aber kein Problem.  Da Zonen strikt hintereinander aktualisiert werden, kann man die Zonen suchen.
Man springt zur letzten bekannten Zone und sucht dann hiner ihr nach weiteren Zonen.

Und was passiert bei Lesefehlern und Schreibfehlern?

Wenn ein Schreibfehler auftritt (der Lesekopf sollte die geschriebene Zone prüfen bevor das Service-Area committet wird,
ggf. kann auch der Schreibkopf diese Kontrolle ausüben, sofern er auch lesen kann, was vorteilhaft wäre
da dann der Lesekopf frei bleibt während das Service-Area aktualisiert wird) dann wird das in dem Service-Area vermerkt.

Die Platte schließt dann solche defekten Bereiche von einem weiteren Beschreiben aus.
Dies wird dabei im Service-Area notiert, so dass das bekannt ist.

Da defekte Bereiche VOR dem Commit (der erfolgt ja nur, wenn die Zone korrekt geschrieben wurde) erfolgt,
hat die Platte IMMER die Informationen, wo die nächste Zone hinter der letzten bekannten geschriebenen Zone beginnt.

Außerdem sind die Generationen ja strikt aufsteigend, d. h. die Platte kann überprüfen, ob sie die nächste Zone erreicht hat oder nicht.

Einzig ein Problem gibt es noch:  Was, wenn das Service-Area defekt ist?

Auch hierfür gibt es Lösungen, nämlich dass das Service-Area mehrere mögliche Positionen hat auf die ausgewichen werden kann.
Ist ein Service-Area defekt, wird ein einfach zu erkennender Defekt-Marker geschrieben und entsprechend ausgewichen.
Die Platte muss dann allerdings das Service-Area neu aufbauen was lange dauern kann da im schlimmsten Fall die gesamte Plattenoberfläche
durchsucht werden muss.

Hier kommt die feste Strukturierung der Platte ins Spiel.  Zwar kann von der Struktur abgewichen werden, aber wenn hinreichend
viele Zonen ihre Standardposition haben und "normal" sind, und da die Zonen außerdem linear geschrieben werden, kann die Platte
mit Binary Search arbeiten, und muss nur verfeinern, wenn die Zone nicht an eben der Position ist, die erwartet wurde.

# In Software?

Das Ganze kann man auch in Software gießen.  Hierbei hat man nur eine Herausforderung:

Man kann die Platte nicht ändern, sondern muss auf deren Sektorinformationen zugreifen.
Die Sektorengröße kann man nicht verändern, man muss also mit der festen Größe klarkommen.

Da hier aber viel Heuristik ins Spiel kommt, z. B. will man ja erkennen können, wo eine Zone startet, muss man verhindern, dass die Sektorinformationen
zufällig mit den verwendeten Magics übereinstimmen.  Aber das kann man im Sektor selbst nicht kodieren!

Die Lösung ist, man verwendet ein Magic, und bei allen Sektoren, die dieses Magic ebenfalls zufällig enthalten würden, ändert man deren Inhalt vorhersagbar ab.

Warum vorhersagbar?  Damit man diese Sektoren wiederherstellen kann für den Fall, dass man die Informationen verloren hat, ob der Sektor verändert wurde.

Wie diese Änderung aussieht?  Ich schlage schlicht ein XOR 55 für alle Bytes im Sektor vor.  Die wahrscheinlich geänderten Sektoren erkennt man daran,
dass sie das MAGIC xor 55 enthalten müssen.  Nur solche Sektoren könnten evtl. geändert worden sein, alle anderen wurden unverändert gespeichert.

Mal sehen.  Das ganze könnte man per NBD in Linux einbauen.  Dann wären SMR-Platten auch mit ZFS zu verwenden.

Eine Herausforderung gibt es aber noch:

- Erstens sollte man die Serviceinformationen besser nicht auf die SMR-Platten selbst legen
- Zweitens braucht man Informationen über die echte Zonengröße der Platte, sonst hat man ggf. zweimal dieses Remapping-Spiel was absoluter Mist ist

Das "Erstens" ist eigentlich kein Problem.  Man spendiert dem System einfach eine SSD von der es auch bootet und die diese Informationen dann speichert.
Woher ich das Zweitens bekommen kann ist mir leider komplett schleierhaft, denn die Hersteller schweigen sich ja nicht nur darüber aus,
sondern verschleiern ja oft (anscheinend) auch noch, ob die Platte überhaupt SMR ist!

Dabei ist das doch alles gar nicht notwendig!  Spielt doch einfach mit offenen Karten!
Dann hätte ich auch gar kein Problem damit, sondern könnte die Technik für mich optimal einsetzen!
