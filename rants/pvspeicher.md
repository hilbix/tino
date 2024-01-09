> Was ich hier schreibe ist selbstredend CC0 <https://creativecommons.org/publicdomain/zero/1.0/deed.de>

# Gedanken zum PV-Akku

Da ich gerade über Natriumakkus gestolpert bin, die wohl demnächst verfügbar werden können,
habe ich mir ein paar aktuellere Gedanken zu einem PV-Speicher gemacht.

CATL meldet einen Zielpreis von ca. 25$/kWh der in 2025 wohl erreicht werden soll.

> Laut Statistica kostet LFP dann ca. 65$/kWh

Ich bezweifle mal, dass in 2025 diese CATL-Akkus in Stückzahlen zu solch einem geringen Preis in Deutschland für Privatpersonen verfügbar sein werden.
Aber ab 30 EUR/kWh (oder weniger) halte ich es für sinnvoll, mir einen PV-Speicher mit 100kWh zuzulegen, denn dann kann nicht mehr viel kaputtgehen.

Auf keinen Fall will ich LFP.  Denn ich will den Akku in den Keller stellen.  **Bei LFP ist mir das Brandrisiko viel zu hoch.**

> 100 kWh ist da eher das absolute Minimum, darunter lohnt der Aufwand einfach nicht.
>
> Ich will in der Lage sein mein Elektroauto einmal aus dem Hausakku vollzuladen
> und trotzdem möchte ich in der Lage sein, mehrere Tage schlechten Wetters zu überbrücken.
>
> Ich weiß, das bedeutet 80% zusätzliche Ladeverluste aufgrund des Inverters.  Na und?


## Warum

Derzeit lädt mein Elektroauto an einer Schuko-Außensteckdose.  Da mir diese bei voller Ladeleistung zu warm wurde
(nur warm, nicht heiß, aber da ich mich sehr gut mit Strom auskenne bin ich entsprechend vorsichtig)
lade ich es mit reduzierter Ladeleistung (8A).  Das bedeutet von leer auf voll braucht das Auto ca. 60h.

> Das Auto könnte 11 kW, dann wäre es in unter 8h voll.

Der Voranschlag eines Elektrikers, mir eine CEE16-Dose für eine Wallbox zu legen, belief sich auf ca. 20000 EUR!
Davon ca. 10000 EUR alleine um den Zählerkasten an die aktuellen gesetzlichen Erfordernisse anzupassen.

> Ich habe natürlich ein kleinwenig mehr mitmachen lassen wollen, aber das war nur ein Bruchteil der Summe.
>
> Ich bezweifle zwar, dass der Elektriker den Zählerkasten tatsächlich ersetzen muss, aber evtl. hat er ja Recht,
> das übersteigt leider meine Expertise.

Im Dezember 2023 habe ich mir außerdem für ca. 900 EUR über Otto.de (sic!) ein Balkonkraftwerk mit 2 kW Peak (4 Panele a 500W) zugelegt.
Der Preis war inkl. Inverter und Anschlusskabel sowie WiFi-Steuerung, versteht sich.

> Bin aktuell noch nicht dazu gekommen, die Panele aufzustellen und anzuschließen.
>
> Und ja, ich finde das war die richtige Zeit, denn so sehe ich schon, wieviel da im Winter rumkommt.

2kW Peak für ein Balkonkraftwerk hört sich zuviel an, denn man darf ja nur (2024!) maximal 800W einspeisen.
Aber ich möchte dieses Maximum möglichst lang am Tag und möglichst auch bei schlechter Witterung erreichen.

Der Überschuss verpufft leider.

Deshalb wäre es IMHO sinnvoll, diese 2kW Peak zuerst in einen Hausakku einzuspeisen und die PV erst dann als
Balkonkraftwerk zu betreiben, wenn der Akku wirklich randvoll ist.

Außerdem habe ich schon einen variablen Strompreis (noch fehlt mir dazu der passende Smartmeter, aber dessen Einbau kann man ab 2025 ja
erzwingen), weshalb es sich für mich sinnvoll anhört, den Akku bei entsprechend niedrigen Stromkosten zu laden,
um dessen Ladung bei hohen Stromkosten zu nutzen.

> Das ist trotz der 5% Lade und 80% Wandlerverluste sinnvoll, denn der Strompreis schwankt deutlich stärker als 25%.

Und wenn ich den Strom dreiphasig mit 11 kW aus dem Akku ziehen kann, dann kann ich damit sogar das BEV mit 11 kW laden,
ohne sich eine Außensteckdose legen lassen zu müssen (eine Inselanlage kann ich vollständig selbst verdrahten,
da muss ich ja nicht an der eigentlichen Hauselektrik rumfummeln oder an den Zählerschrank ran sondern lege ein
vollständig alternatives Netz.  Und das ist dann nichts anderes, als ein Verlängerungskabel zu verlegen).


## Was stelle ich mir vor?

Ich stelle mir das als 19"-Rack vor in dem sich alles befindet.

- Der 100 kW Akku auf Natriumbasis.
  - Erweiterungsfähig
- Ein Steuerungsmodul mit Touchscreen
  - Das Steuermodul ist unvernetzt und wird über den Touchscreen (z.B. auf Basis vom PI-Zero) manuell eingestellt
  - Es hat so etwas wie eine Dockingstation für einen PI400
  - Der PI400 stellt dann die gesamte aktive Steuerung sowie Konnektivität bereit
  - Der PI400 besitzt eine eine Tastatur und kann den Touchscreen über das Steuermodul ansprechen
- Eine PV Ladeschaltung für den Akku mit minimum 4 Eingängen für PV-Module
  - Es sollten mindestens 10 kW Ladeleistung möglich sein
- Eine Stromanschluss, der aus einer haushaltsüblichen Schuko-Steckdose den Akku mit 2400W (10A) belädt
  - Da wären 16A möglich, das aber halte ich für zuviel für eine normale Steckdose, diese werden bei 10A schon oft deutlich warm
  - Alternativ ein Akku-Lader, der den Akku mit bis zu 11 kW aus einem Drehstromanschluss laden kann
  - Letzteres wäre besser um die niedrigen Strompreise besser auszunutzen
- Ein Balkonkraftwerksmodul, auf das man die PV-Panele umschalten kann
  - IMHO ist es in Deutschland Balkonkraftwerken verboten, den Strom aus einem Akku zurückzuspeisen
  - Das wäre dann ja eine rückspeisefähige Anlage die anmelde- und genehmigungspflichtig ist und außerdem ständiger Wartung unterliegt
  - Letzteres will ich unbedingt zwingend vermeiden
- Und 1 bis 3 Output-Module
  - Jedes mit einem dreiphasigen 11 kW Sinus-Wechselrichter
  - Jedes mit eigenem eigenen FI
  - Jedes mit eigenen Sicherungsautomaten
  - Jedes mit auswechselbarem Varistor-basiertem Blitzschutz
  - Eine Variante mit CEE16 und eine Variante mit 3 Schukos.

> Damit haben wir bis zu 0.21C beim Laden und 0.33C beim Entladen

Ich habe überhaupt nicht vor, die ganze Anlage rückspeisefähig auszulegen, eben weil man dann unerträgliche Auflagen erfüllen muss.
Wenn sie etwas zurückspeist, dann ausschließlich von der PV als Balkonkraftwerk, so wie es allgemein maximal erlaubt ist.

> Wenn die Bundesregierung möchte, dass man mehr macht, dann muss sie das unbürokratisch ermöglichen.
> So wie sie es bei Balkonkraftwerken gezwungen wurde.
> Alles darüber hinausgehende ist unerträglicher Bürokratismus, und bei dem mache ich nicht mit!
>
> Nur so nebenbei:  Ich hätte nichts dagegen, wenn der Netzbetreiber da etwas anbieten würde.
> So dass man mehr netzdienlich arbeiten kann.  Aber das darf dann nicht zusätzlichen Aufwand bedeuten!
> Man ist schließlich netzdienlich, also zeigt ein erwünschtes Verhalten.
> **Erwünschtes Verhalten zu pönalisieren ist doch vollkommen widersinnig!**

Anmerkung:

- Das Balkonkraftwerk sollte möglichst an die Phase gehängt werden, die im Haus maximal belastet wird
  - Zwar zählen die Zähler akkumulierend (oder wie das heißt), aber warum soll man eine Phase zurückspeisen, während eine andere belastet wird?
- Wenn man das Rack neben die Luft-Wärmepumpe stellt, die das Warmwasser bereitet, nutzt man die Abwärme der Inverter sinnvoll mit
  - Wäre es evtl. sogar möglich, mit der Warmwassersäule eine Art Wasserkühlung zu machen?
  - In entsprechend hohen Warmwassersäulen befindet sich unten recht kühles Wasser, das man also zur Kühlung verwenden könnte.
  - Das kennen wir vom Auto im Sommer:  Oben ist die Wasserflasche schwülwarm, unten aber eher kühl


## Wieviel darf das kosten?

- 2500 EUR der 100 kW Akku (a 25$/kWh)
  - Da man Natriumakkus vollständig entladen darf, erwarte ich eine nutzbare Kapazität von 95 kW
  - Ich gehe davon aus, der Akku wird so bei 50V liegen
  - Bisher konnte ich für Natriumakkus kein BMS finden
- 500 EUR für das Rack
- 500 EUR für Steuerungsmodul mit Touchscreen
  - Inklusive Schütze für Notüberbrückung
  - Inklusive Dockingstation für den PI400
  - Inklusive Blitzschutz
- 500 EUR für den Akkulader der den Akku aus dem Netz lädt
  - Bei 50V muss der 220A liefern um 11 kW zu erreichen
- 500 EUR für den Inverter der das Balkonkraftwerk darstellt
  - Der war bei meinem Balkonkraftwerk dabei
  - Aber die Stecker, Kabel und Schütze zur Umschaltung der PV auf den Inverter kosten bald 200 EUR
- 2000 EUR je 11 kW Wechselrichter
- Evtl. 50 EUR je Satellitenmodul
  - Die dienen dazu, mehrere PV-Module zusammenzuschalten, um die Leistung zu erhöhen
  - Keine Ahnung ob es so etwas gibt, aber ich denke schon

Mit obigem habe ich so etwas meine Probleme:

Eigentlich würde ich es gerne aus einzelnen Komponenten zusammenstecken.

Aber anscheinend liefert der Markt das so nicht.
Beispielsweise konnte ich keine 11 kW Offgrid Wechselrichter finden, die aus 50V eben 11 kW Drehstrom herstellen.

Für 3000 EUR fand ich aber Offgrid Wechselrichtersysteme mit 11 kW.
Diese erlauben aber auch den Akku mit 11 kW zu laden!

Auch fand ich einphasige Wechselrichter mit 22 kW.

Das bedeutet, so wie ich das gerne hätte (modular, alles 3-phasig, und CEE kann durch 3*Schuko ausgetauscht werden)
wird das wohl nicht möglich sein.   Vermutlich muss man es anders aufbauen:

- Für 3000 EUR einen dreiphasigen 11 kW Drehstrom-Wechselrichter
  - Dieser erledigt auch das Laden aus dem Netz
  - An diesen steckt man auch die PV
- Für 1200 EUR einen einphasigen 11 kW Wechselrichter
  - Dieser beliefert dann gleichzeitig drei Schukosteckdosen

Insgesamt wird alles dadurch günstiger.  Aber komplizierter zu steuern.

## Anmerkungen

Ich will, dass die Anlage als eine Art Online-USV funktioniert.  Das bedeutet, sie muss auch eine Überbrückung haben.

Überbrückung bedeutet:

Ich kann 3 Phasen überbrücken und dann die gesamte Anlage komplett offline nehme, ohne dass es zu einer Versorgungsunterbrechung kommt.

Wie stelle ich mir das jetzt wieder vor?

Ziemlich einfach:

- Es gibt einen Eingang und einen Ausgang
- Man überbrückt Eingang und Ausgang in der Anlage
- Der Eingang und der Ausgang werden dann zusätzlich mit einem mechanischen Schütz überbrückt
- Der mechanische Schütz wird eingerastet
- Die Anlage wird offline genommen (das geht erst nach dem Einrasten)
- Die Anlage wird von der Versorgung getrennt

Danach hängt die gesamte Anlage in der Luft und die einzelnen Komponenten sind stromlos.

> Technisch dauert es bis sie sich entladen haben.
> Deshalb ist die Überbrückung auch für eine längere Zeit einplanbar.

Wenn man die Anlage wieder in Betrieb nehmen will, geschieht das umgekehrt:

- Man verbindet die Anlage wieder mit der Versorgung
- Man nimmt die Anlage online
  - Dabei übernimmt die Anlage parallel zum mechanischen Schütz die Überbrückung vom Ein- und Ausgang
  - Die Anlage erkennt das daran, dass der mechanische Schütz eingerastet ist
- Dann rastet den mechanischen Schütz aus
  - Das geht nur, während auch die die Anlage überbrückt
- Man schaltet die Überbrückung durch den mechanischen Schütz ab
- Die Anlage beendet die Überbrückung von Ein- und Ausgang
  - Dabei übernimmt sie die Versorgung vom Ausgang

Man hat also einen mechanischen Schütz, der überbrückt, so lange man die Anlage getrennt hat.
Der Schütz ist außerdem eingerastet, so dass man ihn nicht fälschlich abschalten kann.
Und man kann die Rastung nicht zurücknehmen so lange die Anlage nicht wieder Online ist.

> Warum dieser Aufwand?
>
> Damit es nicht zu Lichtbogenbildungen kommen kann und die Verbraucher ohne Unterbrechung weiterbetreiben können,
> die am überbrückbaren Ausgang hängen.  Ganz USV eben.

Dadurch kann ich die Anlage stromlos machen um an ihr herumzubasteln, ohne dass mir irgendein Server runtergefahren werden muss.
Der mechanische Schütz ist dabei parallel zur Anlage geschaltet, so dass es hier zu keinem Kontaktabbrand etc. kommen kann.

Aber wie realisiert man die Überbrückung in der Anlage?

Das ist alles andere als einfach.  Rechtlich muss dafür nämlich eine wichtige Bedingung erfüllt werden:

Es muss unmöglich sein, dass der Eingang mit dem Wechselrichter verbunden wird, z. B. weil der Ausgang gleichzeitig zu beiden durchgeschaltet ist.
Wäre das der Fall hätte man (mal vom möglichen Kurzschluss abgesehen) keine Inselanlage mehr,
da der Wechselrichter ja mit dem Stromnetz verbunden werden könnte.  Das darf die Anlage nicht erlauben.

Damit das nicht passiert gibt es spezielle Umschalter, die "Netzvorrangschaltung" genannt werden.
Diese sorgen dafür, dass der "master" verwendet wird, wenn dieser Strom liefert, und wenn nicht, dann der "slave".

Der Eingang ist somit der Slave, der Master ist der Wechselrichtter.  Dadurch haben wir die USV-Funktion:

Fällt der Wechselrichter aus (Batterie ist leer), wird automatisch auf den Netzstrom umgeschaltet.

Das alleine reicht aber noch nicht.  Es gibt noch zwei Dinge zu bedenken.

Erstens will ich - per Software - auch einen Ausgang ganz abschalten können.
Und zweitens will ich verhindern, dass man den mechanischen Schütz einschaltet, wenn die Anlage nicht überbrückt.

Die Lösung ist tatsächlich recht simpel.

- Die Vorrangschaltung befindet sich beim Ausgang.
- Die Seite "Master" geht in die Anlage zum Wechselrichter.
  - Wird die Anlage getrennt, geht diese Verbindung somit flöten.
- Die Seite "Slave" geht zum mechanischen Schütz
  - Wird der Schütz geschlossen, ist weiterhin die Vorrangschaltung unverändert aktiv, es passiert also nichts
- In der Anlage ist ein Relais, das den Schütz überbrückt
- Ist dieses Relais aktive, dann überbrückt die Anlage
- Ist dieses Relais nicht aktiv (und der Schütz nicht geschaltet, was ja normal so ist), dann fehlt die Spannung am "Slave"

Der Vorgang ist also wie folgt:

- Normalzustand
  - Der Wechselrichter ist aktiv
  - Das Überbrückungs-Relais ist aus
  - Die Vorrangschaltung steht auf Master
- Man aktiviert die Überbrückung
  - Das Überbrückungs-Relais schaltet ein
  - Der Wechselrichter schaltet aus
  - Die Vorrangschaltung schaltet auf Slave um
- Nun schließt man den SChütz
  - Das überbrückt das Überbrückungs-Relais
- Jetzt kann man die Anlage trennen

Noch ein paar Anmerkungen:

- Für den Fall, dass man die Überbrückung nach einem völligen Stromausfall (auch der Akku ist leer) wieder anfahren will,
  sollte das Überbrückungs-Relais ein Nullpunktsrelais sein
  (Stichwort Nullspannungsschalter, Nullpunktschaltend, Momentanwert-Schalter, Nulldurchgangsschaltung etc., ist gar nicht so einfach zu finden),
  damit sich kein Kontaktabbrand entwickeln kann.
- Es ist nicht dumm, zwischen Inverter und Vorrangschaltung ein weiteres Nullpunktsrelais anzubringen,
  denn ich gehe nicht davon aus, dass Inverter ihren Stromfluss bein Anfahren oder Abschalten sauber unterbrechen.

Evtl. wäre es auch gut, einen Shunt zu haben, den man beim Inverter (wiederum über Nullpunktsrelais) zuschalten kann,
so dass der Inverter eine Dummy-Last haben kann um sich ein- bzw. auszuschwingen.

Der Boot-Prozess sieht dann also so aus:

- Shunt einschalten
  - Inverter ist von der Vorrangschaltung getrennt
- Inverter hochfahren
- Inverter wird auf Vorrangschaltung geschaltet
- Shunt abschalten

Und der Inverter wird wie folgt gestoppt:

- Shunt einschalten
- Inverter wird von Vorrangschaltung getrennt
- Inverter abschalten
- Shunt abschalten

Der Shunt muss nicht groß sein, ein Keramik-Widerstand mit 100 Ohm mit 5W sollte reichen.
Da muss auch nicht viel gekühlt werden, denn der wird ja nur für wenige Sekunden benötigt.

> FTR, weil [Nulldurchgangsschalter/Nullspannungsschalter/Scheitelschalter/Transformatorschaltrelais](https://de.wikipedia.org/wiki/Nulldurchgangsschalter)
> anscheinend total schwer zu finden sind:
>
> 77.31.8.230.8050 "Einschaltstromreduzierung durch Zuschalten im Nullpunkt"
>
> Das ist keine Werbung da ich das Teil nicht kenne sondern rein zufällig durch Google drüberstolperte und wahrlich nichts ähnliches fand.
> Wenn der Preis den ich sah normal ist, ist das sowieso unbezahlbar teuer.

