# Dashcam

Hier ein paar Requirements einer Dashcam, so wie sie konstruiert sein sollte und wie sie nicht konstruiert sein sollte.

- Absoluter Nachtmodus.  Sieht in der Nacht klarer/heller/besser als das menschliche Auge.
- Absolut administrationsfrei:  Plug und Play, selbst wenn man keine SD einsetzt
- GPS für Uhrzeit, Position, Geschwindigkeit.
- Weitere Sensoren:  Erschütterung, Beschleunigung, Kompass
- Authentisierung aller Daten anhand GPS-Daten
- Änderbares Branding (Default: Hersteller+Gerät, aber beliebig änderbar, 16 Zeichen)
- Keine Störungen in DAB+, UKW oder Keyless-GO
- 2x MicroSD-Card.  Erste SD ist rollierend, zweite SD ist für gespeicherte Videos.
- Automatischer Fallback auf funktionierende SD wenn eine davon kaputt geht.
- 4x Ethernetbuchsen (echtes Ethnernet?)
- Max. 6 Inputs anschließbar (siehe HU)
- 2x Stromversorgung, 8V bis 80V beliebig (AC/DC), Überspannungsfest
- 1x USB-C (Slave)  (Kann ggf. entfallen wg. WiFi, denn USB3 ist noch etwas teuer)
- 1x USB-Slave Serial TTY (Kann ggf. entfallen und per günstigen Diagnoseadapter gemacht werden)
- 4x USB2 Host, davon 1 verwendet für GPS
- Bluetooth und WiFi
- Kein Display (kann man per USB anschließen)
- Lauter Piepser (meldet Betriebsbereitschaft mit superkurzem Piels, Störungen mit langem Pieps oder keinem Pieps)
- Motion-Erkennung per sekundäre Stromversorgung (Primäre Stromversorgung erkennt Zündung an/aus)
- Capacitor (Akku wäre KO-Kriterium) mit ausreichend Energie für folgende Funktionen (akkumuliert, d. h. gesamt, nicht: oder):
  - 12h Standby (Erschütterungssensor weckt Dashcam auf, die Kameraeinheiten sind so lange ohne Strom)
  - 30 Minuten Aufzeichnung (12 x 5 Minuten Erschütterungsserien)
  - 1 Tag Sleep (Speichererhaltung des internen Speichers bei Strom- und/oder SD-Karten-Ausfall)
  - Zwischenspeichern des internen Speichers auf beiden Speicherkarten (bei 1 MB/s Write) vor Ladungsende
- An Ethernetbuchse bis zu 6 Kameraeinheiten anschließbar (Stromversorgung von Zentraleinheit über Kabel):
  - HU: 4x Enternetbuchse, wirkt als Hub um 3 weitere Geräte anzuschließen.  Nicht kaskadierbar, erhöht Gesamtzahl nicht.
  - AU: 1x Ethernetbuchse, 4-Kanal-Audio (4x Klinke Mono-Mic, 2x Klinke Stereo-MIC), 1x Mono-Mic mitgeliefert
  - WW: 1x Ethernetbuchse, Full-HD Weitwinkel (120 Grad)
  - HE: 1x Ethernetbuchse, Full-HD Weitwinkel (120 Grad), 4K HawkEye (40 Grad) für Nummernschilderkennung
  - IR: 1x Ethernetbuchse, Fischlinse 360 Grad, Infrarot, 4-Kanal-Mikrofon (vorne/links/rechts/hinten)
  - EX: 1x LSA, Fischlinse 360 Grad, außen, Dachanbringung durch Fachwerkstatt
- Hinweise:
  - Kompression des Datenfeed geschieht in den Kameraeinheiten, das entlastet den Bus
- Interner flüchtiger Speicher (ca. 256 MB) für mindestens 5x5 Min. a 2x2+1 Inputs (2 x Full-HD, 2 x 4K, Audio)
  - Vor Zündungeende
  - Letzte 3 Erschütterungserien mit 1 Minute davor und 1 Minute danach
  - Lenkradknopf
- Steuerung per WiFi basiertem Webservice (REST per App)

Gründe:

- Standardkabel:  Die Kabel kann man ins Auto einbauen und dann drinnen lassen, sind günstig zu haben.
- Standardstecker:  Krimpen von Cat-5 ist trivial.
- Standardtechnik:  Abschirmung von Cat-5 ist problemlos.
- Alternativ zu Ethernetsteckern (Western):  LSA
- Man kann ein Kabel nach hinten verlegen, und über den HUB links und rechts an den hinteren Seitenscheiben anbringen
- Die Zentraleinheit kann man z. B. unter dem Sitz oder im Handschuhfach anbringen.
- Die Kameraelemente können kleiner sein wenn weniger Technik verbaut ist


## Alternativen

- Raspberry-PI
- Aktive Kameramodule finden die per USB2 angeschlossen werden können
- GPS-USB-Modul ebenfalls
- Fertig

Probleme:

- RasPI bootet zu langsam.  Boot muss unter 10s liegen
- Woher bekommt man 4K-Kameramodule guter Qualität die die Kompression machen und bei Stromversorgung unter 1s Daten liefern?
- RasPI verbraucht zu viel Strom im Sleep-Modus.
  - Ziel ist, dass das Ding vollständig schläft (außer RAM) und dabei so gut wie keinen Strom verbraucht
  - Innerhalb 1ms wacht es auf (per Rüttelsensor), überprüft die Sensoren kurz und weckt ggf. bis zu 4 Kameras
  - Die Kameras zeichnen dann 5 Minuten auf und senden es an die Zentrale
  - Diese geht danach sofort wieder schlafen
