# HowTo

Quick-URLs:

- [OpenWRT-one-Download-Links für Firmware etc.](https://openwrt.org/toh/openwrt/one#installation)
- [Konformitätserklärungen](https://one.openwrt.org/hardware/certification/) CE, ROHS, FCC

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
  - man kann den Router nicht ausschalten
  - `poweroff` schaltet ihn nicht aus, er fährt nach einer Weile selbst wieder hoch
- Labels wie CE, ROHS und FCC
  - Die [Konformitätserklärungen sind alle auf der Website](https://one.openwrt.org/hardware/certification/)
  - **Ich hoffe, jemand bastelt einen ausdruckbaren Sticker, den man auf den Router kleben kann**

Das Gehäuse ist durchdacht.  Es bietet folgende Anschlüsse:

- Vorne ist eine angeschraubte Platte
  - USB-C Serielle Schnittstelle mit 115200 Baud, siehe `socat /dev/ttyACM0,b115200,rawer -,cfmakeraw`
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

> Bei mir war eines der Antennenkabel übrigens hinten eingeklemmt.
> Ich habe das Board abgeschraubt, das Kabel befreit und wieder festgeschraubt.
> Dabei muss man das Board ganz nach vorne schieben, so dass die Ethernetanschlüsse hinten sich mit der Rückwand decken.


### Installation

Ich kann mir eigentlich nur 3 sinnvolle Szenarien ausdenken, die im Normalfall vorkommen.
Leider wird keine davon mit den Guides direkt abgedeckt.

#### Szenario 0: Kennenlernen

> Dieses Szenario ist kein Normalfall, aber betrifft mich am meisten

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

Also Szenario 0 und der Router liegt aufgeschraubt vor mir.

#### Rumschrauben

Man sollte gleich die 3 Antennen anschrauben.  Zwar wird die WiFi-Hardware nicht automatisch aktiviert,
aber es stört nicht weiter und kann auch nicht schaden.

Ich habe dann die Front vom Router abgeschraubt und die Deckplatte herausgezogen, so dass er offen vor mir liegt.

> Die Schrauben saßen sehr fest und waren mit dem beigelegten Schraubenzieher nicht zu lösen.
>
> Und ja, ich weiß, es heißt eigentlich Schraubendreher oder kürzer Kreuzschlitz.


#### Erstinbetriebnahme

Das weiße USB-C-Kabel in den vorderen USB-C vom Router stecken und mit der Linux-Workstation verbinden.

> Fun Fact: Als ich das Kabel einstecken wollte machte mein Rechner einen unvermittelten Reboot.
> War mein Fehler, ich hatte versucht, den USB-C-Stecker beim Reset-Button vom Gehäuse einzustecken,
> und damit einen Reset ausgelöst.

Im Computer erscheint dann eine neue serielle Schnittstelle, die mit folgendem Kommando angezeigt werden kann:

```
socat /dev/ttyACM0,rawer,b115200 -,cfmakeraw,escape=0x1c
```

- Dadurch kann man per `C-\` (also Quit) aus dem Terminal wieder aussteigen
- Wer möchte kann auch `screen /dev/ttyACM0 115200` verwenden

Nun wird das Netzteil eingesteckt.

> Fun Fact: Beim Einstecken des Netzteils ging bei mir das Licht aus.
> Das Haus hatte zufällig just im gleichen Moment das Licht abgeschaltet ;)

Da man das beiligende Kabel bereits verwendet muss man das Netzteil mit einem anderen Kabel (ich verwende eines, das in etwa den Stromfluss misst) mit dem Router verbinden.  USB-C auf USB-C.

Die LEDs im Router leuchten auf und auf der Konsole (`socat` oben) rattern Statusmeldungen durch.

Irgendwann ist durchgebootet und man kann per `Return` das Terminal aktivieren.

Noch ist der Router mit nichts verbunden.

Wenn man die Konsole (den `socat`) abbrechen will und den Escape vergessen hat,
kann man auch einfach das USB-C-Kabel an der Front abziehen.  Dann verschwindet das
TTY und der `socat` bricht ab.

> Fun Fact:  Wenn ich das bei mir mache, geht meistens dabei mein Monitor aus.
> Ist wiederum kein Fehler vom Router oder dem Kabel, sondern eine Besonderheit des Montiors.
> Er hat eine Schutzschaltung gegen EMV/EMP/Brownouts/Überspannung und misst das gegen Masse.
> Bei Masseveränderungen wie durch Anstecken eines anderen Geräts per USB löst das dann häufig aus.
> Und ja, ich war deshalb auch am Anfang ziemlich verwundert.

Zu den Netzteilen:

- Er zieht bei 15.3V etwa 4.5W (bei der Ampere-Zahl misst das Kabel zu ungenau)
- Man sollte darauf achten, dass das USB-C-Netzteil auch wirklich 15V liefern kann!
- Es funktionieren auch andere Netzteile
- Das mitgelieferte scheint recht wertig zu sein.

Ich habe einige andere Netzteile getestet die alle 15V können:

- Solche mit nur einem Ausgang:
  - Amazon-Basic (65W und 30W)
  - Mit einem angeschlagenem Kabel (45W)
  - Und noch ein anderer mit 45W
- Solche mit mehreren Ausgängen
  - Eines, das gesamt 65W kann
  - Schließt man ein anderes Gerät an das Netzteil, dann wird dabei leider der Stromfluss kurz unterbrochen
  - Interessanterweise aber schafft das Netzteil es, die Ausgänge gleichzeitig mit verschiedenen Spannungen zu versorgen

Außerdem habe ich bei den Tests festgestellt, dass der Router bei Netzteilen mit mehreren Ports manchmal
nicht auf 15V kommt, sondern sich eine niedrigere Spannung einstellt, z.B. 12V.

Auch lief er mit einer reinen 5V-Versorgung, aber die Netzteile bei mir liefern immer mindestens 2A,
bei weniger wird das sicher schnell instabil, denke ich.

> **Warnung!** Es ist vermutlich nicht sinnvoll, den Router derart außerhalb der Spezifikation zu betreiben.
> Dabei könnte der Eingangsstromwandler überlastet werden.  5V ist sicher die untere Grenze,
> und viele Netzteile knicken da gerne ein bzw. die Kabel haben einen zu hohen Innenwiderstand.
>
> Niedrigere Spannungen bedeuten eine höhere Stromstärke und mehr Verlustleistung.
> **Das kann zu Kabelbrand führen!**
>
> Also, **betreibt den Router bitte immer mit einem dedizierten Netzteil**, auch wenn es mit Multiport-
> Netzteilen zu funktionieren scheint.  **Die Alternative ist PoE!**


#### Internet

Nun steckt man ein LAN-Kabel in den WAN-Port (das ist der mit 2.5G direkt neben dem Stromanschluss hinten).
Der Router zieht sich dann automatisch per DHCP eine IP und wird pingbar.

> Die IP sieht man in der Konsole per Kommando `ip a s`

Allerdings kann man sich so nicht in den Router von außen einloggen.

Ob der Router online ist kann man in der Konsole ausprobieren:

```
ping 1.1.1.1
```

> Abbrechen per `C-C` (also Strg+C)

#### Flash updaten

Nun updatet man am besten die Firmware vom Router.  Das geht [laut Dokumentation](https://openwrt.org/docs/guide-user/installation/sysupgrade.cli) wie folgt:

- Man zieht sich über das Internet das `Factory sysupgrade image` auf den Router
  - Den Link findet man auf <https://one.openwrt.org/> unter `Installation`
- Dann flasht man das per Commandline im Router
  - Das sollte man auf keinen Fall unterbrechen

Das ergibt folgende Kommandos (die man auf dem Computer bequem ins Terminal pasten kann):

```
cd /tmp
df -h .
```

Es sollten 400 MB oder mehr frei sein.
 
```
wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/openwrt-mediatek-filogic-openwrt_one-squashfs-sysupgrade.itb
wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/sha256sums
wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/sha256sums.asc
sha256sum -c sha256sums 2>/dev/null | grep -v ': FAILED$'
gpg2 sha256sums.asc 
```

Als Output sollte man etwas folgender Form erhalten:

```
root@OpenWrt:/tmp# sha256sum -c sha256sums 2>/dev/null | grep -v ': FAILED$'
openwrt-mediatek-filogic-openwrt_one-squashfs-sysupgrade.itb: OK
```
```
root@OpenWrt:/tmp# gpg2 sha256sums.asc 
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
gpg: assuming signed data in 'sha256sums'
gpg: Signature made Wed Jan 15 23:04:07 2025 CET
gpg:                using EDDSA key 92C561DE55AE6552F3C736B82B0151090606D1D9
gpg: Good signature from "OpenWrt Build System (Nitrokey3) <contact@openwrt.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 8A8B C12F 46B8 36C0 F9CD  B36F 1D53 D187 7742 E911
     Subkey fingerprint: 92C5 61DE 55AE 6552 F3C7  36B8 2B01 5109 0606 D1D9
```

Natürlich funktioniert das so nicht, denn auf OpenWRT ist weder `gpg2` installiert noch funktionsfähig
(bei mir steigt derzeit `dirmngr` mit einem SIGSEV aus).

Also macht man das auf einem anderen Rechner:

```
wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/sha256sums
wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/sha256sums.asc
gpg --receive-keys 92C561DE55AE6552F3C736B82B0151090606D1D9
gpg2 sha256sums.asc 
```

Nun sollte man noch überprüfen, ob die Datei identisch ist, also auf dem Rechner:

```
sha256sum sha256sums
```

und auf dem Router

```
sha256sum -c -
```

Und dann den Output vom ersten Rechner dort reinpasten (mit Return).  Es erscheint:

```
sha256sums: OK
```

Nun mit `C-D` (Ctrl+D) oder `C-C` abbrechen.

Nun kann man den Systemupgrade durchführen:

```
sysupgrade -v /tmp/openwrt-mediatek-filogic-openwrt_one-squashfs-sysupgrade.itb 
```

Der Router rebootet dann automatisch in die neue Firmware.
