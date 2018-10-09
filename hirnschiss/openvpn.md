# OpenVPN Hirnschiss

Hier ein kleines Szenario:

- Wir wollen die Verschlüsselung von einem bestehenden OpenVPN verbessern.
- Wir haben eine beliebige Anzahl extrem hohe Anzahl von Clients
- Wir haben ein sicheres Setup

Frage: Wie bewerkstelligt man das?

Antwort: Nicht.  **OpenVPN kann die Verschlüsselungsstärke nicht ändern**

Grund:  Keine Ahnung, warum das nicht geht.
Ich kann mir einfach keinen einzigen Grund dafür ausdenken, außer eben,
dass irgendwer den Entwicklern von OpenVPN **ganz ganz kräftig ins Hirn geschissen** haben muss.

Und wieso soll das nicht gehen?

Ganz einfach.

- Wir haben ein sicheres Setup.
  Das bedeutet, die Clients sind hinter Firewalls.
  Diese Firewalls lassen selbstverständlich die Clients nur zum VPN-Server verbinden
  und sonst nirgendwohin.
  Ich meine mal, das ist so ungefähr das allermindeste, das ein sicheres Setup leisten muss.
- Wir haben außerdem ein sicheres Setup.
  Das bedeutet, wir haben einen Server, der wiederum von Firewalls geschützt ist.
  Clients (mit variabler IP!) haben die Erlaubnis, zu kommunizieren.
  Andere Rechner selbstverständlich nicht.
- Und wir haben ein sicheres Setup.
  Das bedeutet, wir wollen die Settings des Setups so wenig verbreiten wie möglich.
  Je weniger bescheid wissen, desto besser.
  Alles auch vollkommen logisch.
- Die Clients sind diejenigen, die die Verbindung aufbauen.
  Das tun sie, selbstverständlich, dann, wenn sie das wollen.
  Genau das kann ich nicht kontrollieren.  Dafür sind VPNs ja da.

So, wie sieht nun der Prozess nicht aus, um die Schlüsselstärke anzuheben?

- Wir können die Verschlüsselung auf dem Server nicht einfach so anheben.
  Denn das sperrt all jene Clients aus, die noch nicht umgestellt sind.
- Wir können die Clients auch nicht anheben.  Denn das bedeutet, sie sind ausgesperrt,
  bis der Server angehoben ist.
- Wir können die Clients auch nicht on-demand updaten.
  Weil die Clients ja sicher sind können wir nicht auf sie zugreifen.
  Und wir können nicht kontrollieren, wann sie online gehen um sich den Update zu ziehen.

Schachmatt!

## OpenVPN erlaubt es nicht, die Schlüsselstärke zu verändern

Eben weil ich sie gleichzeitig auf dem Server und allen Clients ändern müsste,
was einfach in der Realität nicht möglich ist.

## Wie ändert man dann im OpenVPN etwas?

**Gar nicht.  Man kann nichts ändern!**

## Wie ändert man ohne zu ändern?

Man baut einfach ein komplett unabhängiges zweites OpenVPN auf.

Verbindet sich ein Client dann mit dem alten OpenVPN, bekommt er ein neues Config
und kann sich dann an das neue OpenVPN anmelden.

Nur .. ganz so einfach ist die Sache nicht.  Wir haben ja ein sicheres Setup (siehe oben).

Das bedeutet also:

- Erst einmal müssen wir den Server duplizieren.  Das bedeutet,
  das Sicherheitsrisiko verdoppelt sich.  Weil jetzt betreibt man 2 Server statt einem.
- Dann muss man die Firewallregeln anpassen.  Auf der Client-Seite.
  Wie wir wissen, so etwas stellt ein wesentliches Betriebsrisiko dar.
  Schlägt die Änderung fehl, aus irgendeinem Grund, kann der Client in einen beliebigen
  Zustand kommen.  Von ungeschützt bis hin zu unkommunikativ.
  Nicht alle Clients sind in der Lage, ggf. dann zur Reparation wieder heimzukommen.
  Sprich, eine entsprechende Zahl von Clients vorausgesetzt,
  verlieren wir einige Clients auf diesem Weg.
- Geänderte Firewallregeln verdoppeln (mindestens) das Risiko auf dem Client.
  Sprich, alle Clients werden einer mindestens doppelt so großen Gefahr ausgesetzt.
- Außerdem müssen wir den alten Server weiterbetreiben bis alle Clients umgestellt sind.
  Das verdoppelt (mindestens) Kosten und Aufwand.

Wow.  Und das alles nur und ausschließlich, weil da irgendwer nicht mitgedacht hat?

Und nein, folgendes geht eben nicht:

- Automatische Umstellung der Clients.  Die Clients sind vermutlich manuell gesetuppt.
  Es geht um VPN, also Road-Warriors und nicht irgendwelche VPN-LAN-Segmente.
- Das einfach auf demselben Server aufschalten.  Entweder Port oder IP ändern sich.
  Man kann keine 2 OpenVPN-Services auf ein und derselben IP auf ein und demselben Port betreiben.
- Das vorab kommunizieren.  Es geht um Ad-Hoc-Änderungen.  Grundsätzlich geht es immer darum.
  Weil wir eben nicht wissen, wann eine Verschlüsselung plötzlich gebrochen wird.

## Es geht doch, per Münchhausen-Methode

Natürlich gibt es eine Lösung.  Die sieht wie folgt aus:

- Man hat einen Host
- Auf dem Host laufen VMs die den OpenVPN-Service bereitstellen
- Der Host hat ein intelligentes Routing, das Clients Round-Robin auf die VMs verteilt
- Die Intelligenz ist, dass weitergeschaltet wird, wenn die Verbindung zu kurz besteht

Nun kann man jede VM mit einem anderen OpenVPN-Setting betreiben.

- Der Client connectet.  Es klappt nicht.
- Beim nächsten Versuch bekommt der client die nächste VM.
- Nach soundso vielen Versuchen klappt es dann.

Das Routing mehrkt sich was geklappt hat und leitet den Client entsprechend weiter.

Es klappt vor allem dann gut, wenn der Client bekannt ist, d. h. dieser sich
per Portcullis vorher angemeldet hat.

Aber ..

.. nichts davon ist in OpenVPN eingebaut.

Portcullis?  Fehlanzeige!

Und die Münchhausenmethode ist sowieso komplett gaga.

Aber so muss man das aufbauen.
Weil die OpenVPN-Leute anscheinend in keister Weise auch nur ansatzweise etwas sinnvolles gebaut haben.

> Wenn es nicht so ist, warum gibt es dann keine Dokumentation darüber?
> Also wie ich den Client so einstelle, dass er die Server-Verschlüsselung akzeptiert?
> Natürlich will ich unsichere Verschlüsselungen auf dem Client ausknipsen können.
> Sprich, ich will das Gegenteil tun, nicht sagen "nimm die" sondern "nimm die nicht".
> Alles andere muss automatisch ausgehandelt werden.
>
> Was ist ein Portcullis?  Ein Portcullis ist ein einfaches Script,
> welches beim Verbindungsaufbau gestartet wird.
> Kommt es mit Erfolg zurück wird die Verbindung aufgebaut,
> ansonsten abgewiesen.
>
> Hat OpenVPN das auf der Client-Seite?  Ich habe es nicht gefunden!
> Ich habe über 30 Minuten nach einem Dokument gesucht,
> welches die Client-Config beschreibt.  Absolute Fehlanzeige.
> Es gibt Beispiele en masse, aber keines hat mich irgendwie erhellt.
>
> Leute, so geht das nicht.
>
> Entweder, etwas ist selbsterklärend, oder es ist dokumentiert.
> Das, **was OpenVPN da aber macht, ist einfach nur Hirnschiss!**
