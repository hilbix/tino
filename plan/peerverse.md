# Peerverse

Schon vor sehr sehr langer Zeit, als der Urschleim des Internets noch gerochen werden konnte, habe ich eine Domain registriert:

peerverse.net

Damals hatte ich noch keine konkreten Ideen, wie Peerverse aussehen sollte.
Aber, wie der Name schon nahelegt, sollte es ein "Universum" sein, das durch "Peer"s erschaffen wird.

Gedacht hatte ich damals an ein dezentrales Speichernetzwerk auf Basis des Small-World-Phenomenon.
Heute nennt sich so etwas Overlaynetzwerk mit Speicherlösung.


## Overlay-Netzwerk

Ein Overlaynetzwerk ist ein Netzwerk, das einem anderen Netzwerk bedient, um sich mit dessen Hilfe aufzuspannen.

Mit Overlaynetzwerk bezeichnet man komplexere Netzwerke als SAN oder CIFS,
die einen eigenen Teilnehmerkreis bilden, und das darunterliegende Netz abstrahiert verwenden,
um ihre eigenen vom verwendeten Netzwerk unabhängigen Funktionen bereitzustellen.

> Die Abgrenzung ist für Laien schwierig, weil die Grenzen fließend scheinen, aber für Experten ist das kein Problem.

Es gibt dabei zwei typische Sorten von Overlaynetzwerken:

- OpenNet, an denen jeder teilnehmen kann, der will.  Beispiele dafür sind TOR oder I2P.
- DarkNet, an denen nur teilnehmen kann, der einen anderen Teilnehmer (vorher) kennt.  Beispiel dafür ist Freenetproject.

> Freenetproject hat sich aus einem OpenNet entwickelt und enthält heute einen großen Darknet-Anteil.
> Es gibt im Freenetproject zwar ein OpenNet, dieses ist aber beschränkt.
>
> Das Freenetproject stellt für mich die Referenz für die Begriffe "Darknet" und "Opennet" dar.

Der Unterschied zwischen OpenNet und DarkNet ist sehr einfach zu verstehen:

In einem OpenNet gibt es Verzeichnisse von Teilnehmern,
im DarkNet gibt es keinerlei Verzeichnisse und sie können auch nicht erstellt werden.

Die Verzeichnisse im OpenNet sind in der Regel unvollständig.
TOR verzeichnet z. B. nur Nodes, die das Overlaynetzwerk selbst aufspannen.
Ist ein TOR-Node im Verzeichnis nicht aufgeführt, nimmt er nur als Client am Netzwerk teil,
hilft also nicht mit, das Netzwerk selbst aufzuspannen.

> In dem OpenNet TOR ist es z. B. mit moderatem Aufwand möglich, regelmäßige Teilnehmer herauszufinden,
> wenn man nur ausreichend TOR-Nodes betreibt (was vergleichsweise günstig ist, das geht ab 3 EUR/Monat/Node).
> Es ist deshalb eine geradezu unumgängliches Erfordernis für Geheimdienste, größere TOR-Node-Farmen zu betreiben,
> um das Land vor illegalen Online-Marktplätzen zu schützen, die versuchen, sich hinter TOR zu verstecken.
> Das wiederum garantiert, dass das von DARPA initial gesponserte TOR-Projekt derart gut funktioniert
> und dadurch der freien demokratischen Internetkultur hilft während es hauptsächlich restriktiven Regimes schadet.

Das Verzeichnis erst erlaubt die vollständig anonyme Teilnahme an TOR.  TOR wurde also ganz bewusst nicht als DarkNet
konstruiert und wird auch niemals eines sein (egal was die Presse behauptet).

Darknets hingegen funktionieren anders als TOR.  "Dark" steht für "Dunkel", also "unbeleuchtet", aber nicht für "illegal".
Darknets sind so konstruiert, dass es nicht einmal Teilverzeichnisse gibt, das ist ein grundsätzliches Erfordernis.
Damit dies auch unmöglich ist, ist ein Darknet ähnlich organisiert wie ein terroristisches Kleinzellennetzwerk.

Jeder Node kennt nur seine Nachbarnodes und ist paranoid darauf bedacht, seine Identität keinem anderen außer seinen
nur ihm bekannten Nachbarnodes bekanntzugeben.  Das bedeutet auch, dass er seine Existenz möglichst gut verschleiert,
man also von außen nicht herausfinden kann, ob es sich um solch einen Node handelt oder nicht.

Ein vollständig korrektes Darknet aufzubauen ist dabei eine nichttriviale Herausforderung,
die bis heute glücklicherweise nicht vollständig gemeistert wurde.

Jede vollständig korrekte Implementierung eines Darknets ist in einem rechtsstaatlichen System,
welches die Menschenrechte respektiert, nicht mehr beizukommen:

- Initial kennt man keinen der Teilnehmer, da diese sich nur gegenseitig kennen.
- Hat man einen Teilnehmer erkannt (durch Fehler des Teilnehmers, Infiltration oder Verrat),
  kennt man nur diesen und keine weiteren Teilnehmer.
- Ohne Mithilfe des Teilnehmers kann man keine weiteren Teilnehmer ermitteln.
  (Dies ist ein Erfordernis der korrekten Implementierung eines Darknets.)
- Diese Mithilfe kann z. B. der heimliche Infiltration der Computer des bekannten Teilnehmers sein, oder Überredung.
- Man kann sich trotzdem nie sicher sein, ob man so alle weiteren ihm bekannten Teilnehmer erhält.
- Jeder einzelne Schritt trägt außerdem eine sehr hohe Gefahr des Scheiterns,
  denn sobald man entdeckt wird, landet man in der Quarantäne.
  Das bedeutet, der oder die erkannten Teilnehmer werden nicht nur von der weiteren Teilnahme am Netz ausgeschlossen,
  sondern deren Kontakte verschwinden ebenfalls.
- Dadurch kommt man an die, die man eigentlich erreichen kann, nicht mehr heran.
- Dazu kommt, ein korrekt implementiertes Darknet basiert auf Plausible Deniability.
  Man weiß also nicht, wann jemand lügt oder nicht.
- Die KÜr eines Darknets ist, wenn dieses die Beweislastumkehr unmöglich macht,
  d. h. niemand (nicht einmal der Richter selbst) beweisen kann, dass er niemals Teilnehmer vom Darknet war.

Ein solch perfektes Darknet wurde bisher nicht konstruiert und ich hoffe,
es entsteht niemals die Notwendigkeit, dass sich solch ein Darknet entwickelt.

Peerverse muss deshalb hauptsächlich auf einer Opennet-Basis gründen, damit jeder diskriminierungsfrei teilnehmen kann.
Allerdings müssen einige Bestandteile von Anfang an wie ein Darknet organisiert werden,
weil das Netzwerk sonst auf Dauer nicht überleben kann.


## Modernisierte Konstruktionsbedingungen

Auf folgenden Eigenschaften sollte Peerverse fußen:

- Overlay-Netzwerk (siehe oben)
- Infrastrukturfrei, d. h. es gibt keine zentralen Komponenten und wird alleine durch seine Teilnehmer aufgespannt
- Offen für jeden Teilnehmer, d. h. jeder kann teilnehmen ohne dass er andere kennt
- Small-World-Phenomenon, d. h. die Teilnehmer können untereinander Benutzergruppen bilden,
  in denen aber nur teilnehmen kann, wer einen anderen kennt.
- Pseudonym, d. h. Teilnehmer können in einer Benutzergruppe anonym teilnehmen.  Das geschieht über Proxys,
  die als Proxy bekannt sind, aber selbst die Identität des anderen schützen.
- Anonym, d. h. man kann Gruppen bilden, in denen eine vollständig anonyme Teilnahe möglich ist.
  Diese anonyme Teilnahme kann für Gruppen aber explizit ausgeschlossen werden.
- Gier, d. h. je gieriger ein Teilnehmer ist, desto besser ist er für das Netzwerk.
- Web-of-Trust, d. h. es gibt eine ganz klare kryptographisch basierende Vertrauensbasis, auf der man aufbauen kann.
- Ubiquitär, d. h. es funktioniert aus dem Browser heraus genauso gut wie auf dem Handy.
- Spamresistent, d. h. es ist kein Push-Netzwerk (wie Mail) sondern ein Pull-Netzwerk (wie Web).
  Je mehr SPAM jemand verbreitet, desto stärker verstopft er sich selbst.
- Zensurresistent, d. h. eine Zensur kann nur über einen freiwilligen Konsens der Teilnehmer ausgeübt werden.

Außerdem soll der Betrieb von Peerverse sehr einfach sein:

- Als Teilnehmer installiert man einfach nur eine App und ist "drin".
- Ist man gierig, installiert man einen Node (Docker-Container?), und das Ding administriert sich dann von selbst.

Und es soll folgende weiteren Eigenschaften haben:

- Moderierbar.  Es kann zentrale Kontrollinstanzen geben, die bestimmte Aspekte einer Gruppe etc. kontrollieren können.
  Das basiert, wie bereits beschrieben, aber auf einem freiwilligen Konsens der Teilnehmer,
  indem sie diesen Moderator als Moderator akzeptieren.
- Fuzzydemokratie.  Man kann seine Stimme mehrfach und gewichtet an andere Personen abtreten.
