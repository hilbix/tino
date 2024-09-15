# Rants

Hier lade ich meinen Frust ab.

## Docker

### 2024-09-15 Heise-Post

**[Funktionieren Build+Push nicht auch mit GitHub-Actions oder Cirrus-CI?](https://www.heise.de/forum/heise-online/Kommentare/Bis-zu-80-Prozent-mehr-Docker-erhoeht-die-Preise/Funktionieren-Build-Push-nicht-auch-mit-GitHub-Actions-oder-Cirrus-CI/posting-44427190/show/)**

Ich war noch nie bei Docker, habe also keine Ahnung, was ich hier schreibe, das sollte aber IMHO gehen.

Docker-Builds und Push gehen doch sicher auch mit GitHub-Actions oder einem brauchbaren anderen CI wie Cirrus-CI?

Hinweis: 

Travis-CI will Vollzugriff, das ist für mich ein No-Go.  GH-Actions hat zwar auch Vollzugriff, aber GitHub hat ja logischerweise immer Vollzugriff auf sich selbst.  Cirrus-CI ist IMHO das einzige CI, das mit reinem Readonly daherkommt und nur Signale pushen will - und dafür setzt man es ja ein.

Zur Not kann man bei Hetzner.cloud o.Ä. eine dedizierte VM hochspindeln.  Kostet keine 5 EUR (also jetzt deutlich weniger als das bei Docker) im Monat wenn man die kleinste permanent durchlaufen lässt.  Und läuft die ohne IPv4, wird es sogar noch günstiger (das geht aber evtl. nur, wenn man eh schon einen Gateway mit IPv4 dort hat, der kann dann auch die Provisionierung steuern und als REST-Proxy dienen).

Angesichts der Kosten für so eine kleine VM kann ich das Preis/Leistungsverhältnis von Diensten wie Docker, NordVPN, IFFT usw. irgendwie so überhaupt nicht verstehen - sollte Synergie, also Services zusammenzulegen, nicht deutlich günstiger werden, als es selbst zu hosten?  Eine solche verschissene 5 EUR-VM kann problemlos 10000 Captchas parallel serven und (mit dem Inklusivvolumen) weit über 5 Millionen davon im Monat.  Gegen das, was Capcha-Services verlangen, ist Druckertinte also geradezu kostenlos!

Baut man die VM mit Cloudinit bei Bedarf selbst On-Demand, kosten ein Build sogar unter 1 Cent - dürfte sich lohnen wenn man weniger als 100 Builds pro Monat hat.  Für große Builds kann man die Build-Zeit mit fetteren VMs deutlich verkürzen.

Leider rechnet Hetzner IMHO stundenweise und nicht minutengenau ab, da lohnt es sich erst, Builds zu beschleunigen, die länger als 45 Minuten dauern (das erreicht man aber nur mit extremen Builds wie LibreOffice oder Android) .. Ich gehe von einer Rüstzeit von bis zu 10 Minuten und minimalen Karenzzeit von bis zu 4 Minuten aus.  (Normal liegt die Rüstzeit unter 2 Minuten.)

Bei mir waren Hetzner-VMs jedenfalls immer Sekunden nach der Provisionierung oben und konnte also quasi sofort eingerichtet werden.  Ist aber ein paar Jahre her, dass ich mal einen eigenen Webdienst brauchte, der für Demonstrationszwecke dedizierte VMs on-Demand starten können musste.  Das ging so:

- Man bekommt einen Link.
- Man öffnet den Link im Browser.
- Es wird ein Wartelogo angezeigt
- Bei Hetzner wird eine VM provisioniert und fährt hoch.
- Der Browser verbindet sich dann mit der VM.
- Das Wartelogo wurde so nur wenige Sekunden lang angezeigt, bei vielen Webseiten dauert ein Login oft länger!
- Man ist dann in der Demo und kann sie sich in aller Ruhe (1-2h) ansehen.
- Danach (bzw. spätestens nach 3h) wird die VM automatisch deprovisioniert (gelöscht).
- Der Link war dann nimmer gültig .

Eine solche Demo hat also max. unter 3 Cent gekostet (weniger als 1 Cent/h) und es konnten bis zu 25 Demos parallel laufen (Hetzner hat da Limits, die man auf den Bedarf erweitern kann.  Ich glaube es waren über die Monate nie mehr als 10 Demos gleichzeitig aktiv.)

Alleine der Zusatzaufwand, eine Demo zu entwickeln, die auf einem shared-Host laufen kann, hätte weit mehr Arbeitszeit gekostet, als die Demo-VMs am Ende zusammen kosteten.  Im Wirkbetrieb hatte jeder Kunde - aufgrund gesetzlicher Regelungen, das war noch vor der DSGVO - eine von anderen Kunden strikt getrennte Instanz.  Das war am einfachsten über eine dedizierte VM (mit eigener Grundverschlüsselung usw.) sicherzustellen, weshalb der Service auch auf nichts anderes ausgelegt war.  Also wurde die Provisionierung vollautomatisiert (vorher war nur das Setup gescriptet), das war einfacher.

Es kam allerdings nicht mehr dazu, die Demos noch um Standby zu erweitern, so dass man den Stand der Demos backuppen und aus dem Backup automatisch wiederherstellen kann (abgeschaltete VMs kosten ja weiter, die mussten also vollständig deprovisioniert werden), denn da hat die T das durch die VMs angesprochene Backend urplötzlich abgekündigt ..

Irgendwie hat sich mir Docker (gemeint ist der Dienst dort) bisher nie so richtig eingeleuchtet.  Chroot, KVM, LXC, Cloud, dazu Git und Ansible und inzwischen ProxMox sowie CloudInit.  Das alles verwende ich und habe Docker eigentlich nicht vermisst.  Denn so etwas wie Dockerhub (dazu zähle ich auch Bower, Maven usw.) ist, für mich jedenfalls, nur eins:

Viel zu Gefährlich

Bitte nicht missverstehen:

Dockerfiles sind bei der Anlieferung von Software durch Dienstleister sehr hilfreich (weil man ein funktionierendes Sample bekommt und keinen Streit wegen "bei mir tuts aber" bekommt), und das Ökosystem drumherum ist insgesamt ebenfalls echt brauchbar (Cirrus-CI setzt z.B. auf Docker-Container).

Aber es geht auch alles ohne so einen Matmoss a la Dockerhub, denn um aufeinander aufbauende Dockerfiles zu verbreiten reicht eigebtlich soetwas wie Git, da braucht es keinen Download von Binärmonsterimages!

Aber Docker gehört ja noch zu den Guten, denn Docker-Images kann man cachen und vollständig offline nutzen.

NPM ist da eine Größenordnung schlimmer und crasht gerne, aber erst nach einigen Minuten, weil es gerade nicht nach Hause telefonieren kann.

Und noch mindestens eine weitere Größenordnung ärger, also sozusagen der brutalstmögliche Abschuss von allen, sind Snaps!  Die sind nicht nur permanent online, die kann man auch nicht einmal cachen! Das kommt echt klasse, wenn man bei 250 PI-Zeros mal parallel den Snap update fährt (so eine kleine Cloud kostet heutzutage weniger als ein Gaming-Laptop, und verbraucht auch weniger Strom), da wünscht man sich dann echt FTTH statt nur 250 MBit VDSL ..

-Tino  
PS:  So, der Frust für heute ist damit ausreichend raus.  Hoffe ich ..

--------
