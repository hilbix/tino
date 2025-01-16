# HowTo

Quick-URLs:

- [OpenWRT-one-Download-Links für Firmware etc.](https://openwrt.org/toh/openwrt/one#installation)
- [CE Konformitätserklärung]()

## OpenWRT one

Ich habe den OpenWRT one gekrauft.  Und dann versuchte ich, den gemäß der Anleitung in Betrieb zu nehmen.

WTF?  Ist das deren Ernst?  Das sind Anleitungen, die alle aus der Steinzeit zu stammen scheinen!

Da ich keinerlei brauchbare Seite finden konnte, die mir wie von mir gewünscht den OpenWRT one in Betrieb zu nehmen,
und ich mir alle Infos mühsam aus vielen Seiten herausfischen musste,
trage ich hier alles an einem Ort (für mich) zusammen.
Denn ich bin faul und möchte das alles nicht irgendwann wieder machen oder jemandem erklären müssen.


### Unboxing der Innereien

> Als erstes habe ich mich gefragt:  Was bekomme ich eigentlich für mein Geld und was brauche ich sonst noch?
> Dafür gibt es Youtube-Videos.  Aber die sind entweder uralt, zu langathmig oder enthalten wenig Fleisch.

Der Router kommt zusammengeschraubt mit einem sehr sinnvollen Lieferumfang an.  Bei mir war in der Verpackung:

- 1 blaues Gehäuse mit dem Router
- 4 schwarze Gummifüße, die man unten ankleben kann
- 3 schwarze Antennen, die man ans Gehäuse schraubt
- 1 weißes USB-C-nach-USB-C-Kabel 
- 4+2 Ersatzschrauben (sehr gut!)
- 1 Jumper (um das NOR bei Bedarf schreibbar zu machen)
- 1 (europäisches) USB-C-Netzteil mit 30W und 5V/3A, 9V/3A, 12V/2.5A, 15V/2A, 20V/1.5A
  - Verwendet werden übrigens die 15V
- 1 kleiner roter leicht magnetisierter (sehr gut!) Schraubenzieher
  - Bei mir hatten die verschiedene Farben

Nicht mitgeliefert werden:

- **Für die RTC eine CR1220-Batterie**
  - CR1220 ist eine für mich eher unübliche Größe.  Oder genauer Winzigkeit, denn Platz für eine normale Größe wäre da.
- Ethernetkabel
- Ein Ein-Aus-Schalter (wäre eh sinnfrei)
- Das CE-Label
  - Die [CE-Konformitätserklärung ist aber auf der Website]()

Das Gehäuse ist durchdacht.  Es bietet folgende Anschlüsse:

- Vorne ist eine angeschraubte Platte
  - USB-C Serielle Schnittstelle mit 115200 Baud, siehe `socat /dev/ttyACM0,b115200 -,cfmakeraw`
  - 1 User-Button
  - 1 USB2.0-Anschluss
  - 3 LEDs mit verschiedenen Farben
- Seitlich sind nur Lüftungsschlitze
- Unten werden die Füße angeklebt und befinden sich zwei Aussparungen um den Router aufzuhängen
  - Achtung, durch die Löcher ist die Platine theoretisch zugänglich
- Hinten ist eine angeschraubte Platte
  - Reset-Button
  - 1G Ethernet (LAN)
  - Umschalter für NOR/NAND
  - 2.5G Ethernet (WAN)
  - USB-C Stromeingang (PD 15V)
  - 3 Schraubanschlüsse für die Antennen
- Oben ist eine geriffelte Platte
  - Die kann man herausziehen, wenn man die Vorderseite oder Rückseite abschraubt

Man kann das Gehäuse öffnen, ohne die hinteren Anschlüsse oder Platte abzunehmen.

- Man schraubt nur die Frontplatte ab
- und zieht dann die Oberseite nach vorne raus.

Danach sind [die Innereien vom Router](https://docs.banana-pi.org/en/OpenWRT-One/BananaPi_OpenWRT-One) alle gut zugänglich:

- Der Kühlkörper, darunter:
  - CPU (MT7981B, 1300 MHz, 2 Cores)
  - 1 GB DDR4 RAM
  - wLAN-Chip (MT7976C)
  - SPI NOR (16 MB)
  - SPI NAND (256 MB)
  - Ethernet (EN8811H 2.5G)
- Der M.2 Steckplatz
  - KEY-M PICe2.0 mit 1 Lane
  - Es passen nur die kurzen Karten (2230/2242) und NICHT die langen (2280).
  - Leider konnte ich keinen NVME-nach-Micro-SD-Adapter finden, das wäre cool!
  - Mit einem Adapter (den man kaufen muss) kann man [PCIe-Karten betreiben](https://youtu.be/I0n53oVkQns)
  - Dafür muss man die Platine aber aus dem Gehäuse nehmen, denn die Seitenwand lässt sich nicht entfernen.
- Der Mikro-BUS connector
  - für eigene Erweiterungen
  - Wird anscheinend momentan noch nicht von der Software unterstützt
- Die RTC-Batterie
- JTAG und NOR-Jumper
- POE-Modul um den Router via PoE zu versorgen
- Die Kabel zu den Antennen
- Und eine grüne Power-LED

> Bei mir war eines der Kabel übrigens hinten eingeklemmt.
> Ich habe das Board abgeschraubt, das Kabel befreit und wieder festgeschraubt.
> Dabei muss man das Board ganz nach vorne schieben, so dass die Ethernetanschlüsse hinten sich mit der Rückwand decken.


### Installation

Ich kann mir eigentlich nur 3 sinnvolle Szenarien ausdenken, die vorkommen.
Leider wird keine davon mit den Guides direkt abgedeckt.

#### Szenario 0: Kennenlernen

- Ich habe den Router, so, wie er aus der Verpackung kommt
- Ich möchte ihn kennenlernen und das erste Mal sinnvoll in Betrieb nehmen
- Bei mir selbst läuft alles und ich habe genug Bastelkram rumliegen

#### Szenario 1: Von Scratch

- Ich habe den Router, so, wie er aus der Verpackung kommt
- Ich habe ein Handy mit Internet
- Ich habe einen Laptop, aber der ist ohne Ethernet

#### Szenario 2: Per Ethernet

- Ich habe den Router, so, wie er aus der Verpackung kommt
- Dieser wird per Ethernet an ein vorhandenes LAN angeschlossen
- Und soll dann remote in Betrieb genommen werden

#### Szenario 3: Per wLAN

- Ich habe den Router, so, wie er aus der Verpackung kommt
- Ich habe einen Laptop oder ein Handy das an den seriellen USB-Port vom Router angeschlossen wird
- Und es gibt ein vorhandenes wLAN, über das man arbeiten kann

### Installationsschritte

Ich gehe mal davon aus, dass man den Router das erste Mal in die Finger bekommen hat.

Also Szenario 0 und der Router liegt dann aufgeschraubt vor einem.

Als erstes 



Ich erwarte, dass eine brauchbare Anleitung alle 3 Szenarien abdeckt.

> Und deshalb schreibe ich diesen Mist hier!  Alles muss man selber machen .. grummel!



WTF!?!  Why are they so
