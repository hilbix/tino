> Es gibt viel Hirnschiss im Internet.  Besonders übel aber stößt er auf, wenn er in den Internet Standards zu finden ist.
>
> Wir schreiben das Jahr 2019 und gerade hat das Internet eine größere Syn-Amplification-Attack hinter sich.
> [Hat die eigentlich jemand mitbekommen?](https://seclists.org/nanog/2019/Aug/383)
>
> Deshalb habe ich mal BCP38 durchgelesen, und da steht eigentlich nur Schwachsinn drinnen.
>
> Hinweis:  Die Erkenntnisse hier stammen aus der gelebten Praxis im letzten Jahrtausend, sind also **über 20 Jahre alt**!
>
> Um 1998 hatte Amazon einen solchen Ingres-Filter laufen.  Indem sie diesen (verm. auf meinen Wunsch hin) entfernten,
> funktionierte es sofort mit dem DSL-Nutzer auf meiner Seite.  Vorher hat Windows 98 die Verbindung niemals geschafft,
> da die von Amazon durchgeführte MTU-Discovery für den Timeout in Windows 98 zu lange dauerte.


# BCP 38

BCP 38 ist Hirnschiss.  Und zwar der übelsten Sorte.  [Dort steht wörtlich](https://tools.ietf.org/html/bcp38):

>     In other words, the ingress filter on "router 2" above would check:
>
>     IF    packet's source address from within 204.69.207.0/24
>     THEN  forward as appropriate
>
>     IF    packet's source address is anything else
>     THEN  deny packet
>
>     Network administrators should log information on packets which are
>     dropped. This then provides a basis for monitoring any suspicious
>     activity.

Blödsinn:

- Logging ist Hirnschiss, denn wenn ich logge, dann erhöhe ich ja das Paketaufkommen um das Logging.  Profit!
- Deny ist Hirnschiss, das bedeutet, ich schicke einen ICMP-Reply des Verbots.  Gemeint ist wohl "drop".
- Drop ist ebenso Hirnschiss, denn gespoofte Adressen sind sogar bei einigen Vorgängen vorgeschrieben!

Ich kann mir nur, dass derjenige, der die BCP verfasst hat, nicht mit realen Netzen gearbeitet hat,
also aus der Kathedrale und nicht aus dem Basaar stammt.  Denn im realen Routing im Internet kann man
nicht so einfach mal festlegen, welche IP man woher bekommt, da Routen eben nicht symmetrisch arbeiten.

## Beispiel 1:  Einfacher Internetanschluss

In einem einfachen Fall, also jemand hat einen(!) Internetanschluss (also exakt 1), ist alles klar.

Die IPs, die reingehen, die gehen auch raus.  Richtig?

**Falsch!**  Stellen wir uns vor, jemand hat einen NAT-Gateway, in etwa so:

                                             192.168.0.1========.2              172.16.2.1====.2
    Internet -> Router =DMZ=> Gateway =INTRANET=> VPN-GW =EXT=> DSL-GW =PPPoE=> DSL-Router -> Heimarbeitsplatz
              PREFIX.1 .2-.4  .6 10.1================.2    192.168.2.1==========.2

Also aus dem Internet habe ich einen Prefix, sagen wir mal ein /29, also gigantische 5 verwendbare Adressen.

- 4 der Adressen befinden sich in der DMZ, eine davon ist für den Gateway.
- Der Gateway macht NAT, setzt also die 10.x auf den gegebenen Prefix um.
- Die "Standleitung" ist DSL mit PPPOE, hat also eine reduzierte MTU von 1492 stat 1500.

Die Settings sehen wie folgt aus:

- Alle Intranetrechner haben eine Default-Route auf 10.0.0.1/8
- Default-Route vom Heimarbeitsplatz zeigt auf 172.16.X.1/24
- Default-Route vom DSL-Router zeigt auf seine Gegenstelle 192.168.X.1/24
  - Dieser Router macht kein NAT
- Die Default-Route vom DSL-GW 192.168.0.X/24 zeigt auf 192.168.0.1/24
  - Er hat außerdem die IP 172.16.X.1 auf der Seite der Standleitung
  - Dieser Router macht kein NAT
- Default-Route vom VPN-Gateway 192.168.0.1/24 zeigt auf 10.0.0.1/8
  - Der VPN-Gateway zieht per IGP die Routen für 172.16.0/16 an sich.
  - Dieser Router macht kein NAT
- Der gut ausgestattete Intranet-zu-DMZ-Gateway hat die Default-Route zum Router PREFIX.1
  - Er macht NAT für 10.0/8 auf den PREFIX.6
  - Er macht NAT für 172.16.0/12 auf den PREFIX.6
  - Technisch wird das NAT wohl in entsprechenden Boxen in der DMZ vorgenommen werden.
- Technisch wird es wohl mehrere DMZs geben mit eigenen IP-Prefixen und Anycasting.
  Dies brauchen wir hier aber nicht weiter zu betrachten.

Das Setup ist üblich und Skaliert:

- Die Intranet skaliert
  - Es werden 255 Filialen mit 254 Netzen a 253 Rechnern unterstützt.  Das sollte normalerweise ausreichen.
- Das VPN skaliert.
  - Es werden 16 VPN-Gateways mit jeweils 255 angeschlossenen Heimarbeitsplätzen mit bis zu 253 Geräten unterstützt.
  - Die Adresse 192.168.0/16 wird dabei von jedem VPN-Gateway für die Transfernetze wiederverwendet
  - Durch Umpartitionieren auf 13 Geräte je Heimarbeitsplatz kann man die Anzahl der Heimarbeitsplätze ver-16-fachen
- Intranet und VPN können direkt und ohne NAT miteinander sprechen.  
  - Man erkennt an der IP ob es sich um einen Intranet- oder VPN-Rechner handelt.
- Alle Rechner können per NAT im Internet surfen.

Nun baut der Heimarbeitsplatz eine Verbindung zu amazon.de auf.  Die Pakete laufen also wie folgt:

- `172.16.2 -> Amazon` Heimarbeitplatz
- `172.16.2 -> Amazon` DSL-Router
- `172.16.2 -> Amazon` DSL-GW
- `172.16.2 -> Amazon` VPN-GW
- `172.16.2 -> Amazon` Gateway, dieser setzt es auf PREFIX.6 um
- `PREFIX.6 -> Amazon` Router
- `PREFIX.6 -> Amazon` Internet
- `PREFIX.6 -> Amazon` Amazon

Amazon antwortet nun mit einem Paket mit 1500 MSS.  Warum?  Der Heimarbeitsplatz weiß nichts von der reduzierten Paketgröße.

Da Path-MTU-Discovery aktiv ist, ist das DF-Flag gesetzt.  Das Paket läuft also zurück wie folgt:

- `Amazon -> PREFIX.6` Amazon
- `Amazon -> PREFIX.6` Internet
- `Amazon -> PREFIX.6` Router
- `Amazon -> PREFIX.6` Gateway, dieser setzt es auf 172.16.2 um
- `Amazon -> 172.16.2` VPN-GW
- `Amazon -> 172.16.2` DSL-GW

Der DSL-GW hat nun ein Problem.  DF gesetzt mit MSS 1500 aber MTU 1492.

Er schickt also einen ICMP zurück, dass das ganze nicht geht:

- `192.168.2.1 -> Amazon` DSL-GW
- `192.168.2.1 -> Amazon` VPN-GW
- `192.168.2.1 -> Amazon` Gateway, dieser ändert nichts, da er für 192.168 kein NAT machen kann
- `192.168.2.1 -> Amazon` Router
- `192.168.2.1 -> Amazon` Internet, hier schlägt der Ingres-Filter von BCP38 zu

Amazon sieht also niemals den ICMP.  Es kommt der TCP-Retry.  Und Retry.  Und Retry.  Und irgendwann gibt Amazon dann auf.

Wenn wir Glück haben, aber das haben wir nicht immer, dann wird die MTU-Discovery irgendwann ohne DF gemacht.
Das Paket kommt dann (fragmentiert!) durch, und daraus schließt dann Amazon, mit einem sehr obskuren Verfahren,
evtl. auf die reduzierte MTU und schafft es dann irgendwann, die reale MTU zu ermitteln.

Wenn Amazon schlau ist, wird Amazon sich das merken, also wenn wieder mit PREFIX.6 gesprochen wird,
wird automatisch die reduzierte MTU verwendet.

Was wiederum schlecht ist, denn Intranetgeräte vertragen ja die volle MTU, das kann Amazon aber nicht wissen.


## Beispiel 2: Mehrfachabgestützter Internetanschluss

T.B.D.

## Beispiel 3: Transit

T.B.D.
