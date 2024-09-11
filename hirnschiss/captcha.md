# Hirnschiss Captcha

Nachdem mein Chrome hier 2000% CPU verbraucht hat mit ReCaptcha Hintergrundprozessoren, habe ich mich mal nach brauchbaren Captcha-Services umgesehen.

Brauchbar meinte ich.  Das bedeutet auch durchaus bezahlbar.


## Das Szenario

Also hier mal das Szenario:

Man hat eine simple VM, die unter 5 EUR/Monat kostet, also 2 vCPU, 4 GB RAM, 40 GB Storage, 20 TB Datentransfer (outgoing).
Was kann diese VM leisten?

- 7 MB/s outgoing Datentransfer oder rund 5000 Pakete a 1500 Byte pro Sekunde
  - Von der Platte-IO her ist das vollkommen problemlos zu bewältigen
- Es können problemlos 10000 parallele Verbindungen verarbeitet werden
  - Eine Daumenregel besagt, dass man ca. 20 KB pro aktivem Socket braucht
  - Eine aktive Verbindung braucht ca. 3 Sockets (HaProxy rein, raus und Webservice)
  - Eine offene, gehaltene und gerade nicht aktive Verbindung braucht nur 1 Socket (HaProxy rein)
  - Bei 4 GB RAM kann man ca. 1 GB RAM für die Verbindungen zur Verfügung stellen an irgendwelche Limits zu stoßen
  - Damit können also problemlos über 10000 aktive Verbindungen verarbeitet werden
- Die Netzwerkseite ist somit überhaupt kein Thema

Wieviele CaptChas kann solch eine billige VM also verarbeiten?

Das hängt nicht an der CPU, nicht an der Platte, nicht am RAM, sondern ganz alleine am Datentransfer!

Wenn ich das CaptCha so auslege, dass es 7 MB groß ist, kann ich logischerweise nur 1 CaptCha pro Sekunde bedienen,
dann ist Schluss.  Die VM ist zwar mit 1 GBit angebunden, könnte also 100 MB/s ausliefern, aber dann müsste ich für den Transfer
zusätzlich bezahlen, was in der Regel ungünstiger ist, als im Inklusive-Volumen zu bleiben.

> In diesem Fall ist also Skalierung die deutlich günstigere und sinnvollere Variante,
> d.h. ich miete einfach eine weitere solche VM an und verteile auf die VMs.
>
> Der interne Datenverkehr zwischen VMs ist kostenlos, also kann ich die Requests auf die internen VMs verteilen
> und, wenn das Inklusivvolumen fast aufgebraucht ist, einfach per DNS auf eine andere VM umschalten.
>
> Was ich hier schreibe ist nicht ganz richtig, denn ein klitzekleinwenig mehr gehört schon noch dazu.
> Denn würde ich alles hier hinschreiben das ich weiß, würde ich im Leben nicht mehr fertig.

Sinnvollerweise sorge ich dafür, dass der Datentransfer so gering wie möglich ausfällt.
Das bedeutet, das CaptCha verwendet nur ein kleines minifiziertes JavaScript, das möglichst in einem Datenpaket beim Empfänger landet.

Das JavaScript muss also um 1 KB groß sein, damit es, zusammen mit den Headern, ausgeliefert werden kann.

Danach kommt noch eine Antwort vom Browser die verifziert wird.  Das wären 2 KB pro CaptCha.

Wenn man noch etwas weitere Daten dazupackt, sagen wir mal 7 KB pro Captcha (das lässt sich leichter rechnen).

Somit könnten 1000 Captchas pro Sekunde geservet werden.  Bei 70 KB wären es noch 100.

> Wir vergleichen mit kommerziellen Diensten, die wenig optimiert sein dürften, also gehe ich mal von 70 KB pro Captcha aus.

### 250 Millionen Captchas pro Monat kosten also 5 EUR/Monat

250 Millionen CaptChas ist also die Marke, mit der ich kommerzielle Dienste vergleiche.  Schauen wir mal:

- Bei den meisten gibt es einen "Free Plan" um die 1000 Captchas pro Monat.
  - 1000?  Ernsthaft?  Die aktivste Rubrik in meinem seit über 25 Jahren kostenlosen  Service hat etwa aktive 400 Posts pro Monat.
  - Würde ich da ein CaptCha einsetzen, würde das bereits am Free Tier kratzen.
- Pro Captcha fallen - bei den günstigeren Preisen - ca. 0,1 Cent an
- Also kosten 250 Millionen Captchas pro Monat ca. 250kEUR.  WTF?
  - Das ist das 50000-fache von den Kosten einer VM!?!

**Also verarschen kann ich mich selbst deutlich besser!**

Natürlich kann ich den Preis der blanken VM nicht unterbieten.  Deshalb würde ich sagen,
beim 10-fachen Preis würde ich mir selbst keine Gedanken machen und das von fremd einkaufen.

Ich glaube, ich sollte ins Captcha-Geschäft einsteigen mit folgenden Randparametern:

- Unlimitierte Anzahl von Domains, unlimitierte Anzahl von Webseiten
- Der Dienst kostet für Firmen 1 EUR pro Monat (damit sind 100 Domains möglich)
  - Darin enthalten sind 1 Million ausgelieferter Captchas
  - Jede Domain erhält davon 10000 Captchas exklusiv (zzgl. max. 2500 durch Übertragung vom Vormonat)
  - Die restlichen Captchas werden bei Bedarf auf die Domains verteilt, das passiert 10000 Stückweise
  - Man muss mindestens 25 EUR aufladen, kann es aber auf max. 1 EUR/Monat limitieren
  - Bei Firmen versteht es sich zzgl. MwSt, da es sich an Firmen und professionelle Blogger etc. richtet
- Der Dienst kostet für Privatpersonen 10 Cent pro Monat
  - Darin enthalten sind 100000 ausgelieferter Captchas
  - Jede Domain erhält 2500 Captchas exlusiv (zzgl. max. 2500 durch Übertragung vom Vormonat)
  - Im Preis ist bei Privatpersonen die MwSt. enthalten
  - Man muss mindestens 10 EUR aufladen.
  - Es wird pro Domain Centgenau verrechnet, also jeweils mit 10000 Captchas nachdem die zugeteilten Captchas weg sind
- Der Tarif ist Prepaid, d.h. man lädt das Konto auf und es wird dann soviel wie verbraucht wurde abgezogen
  - Wenn man keine Deckung hat hört der Dienst einfach auf und blockiert
  - Es kann dann für den Dienst fremdgespendet werden
  - Das Konto ist auch für andere Dienste nutzbar (wenn diese mitmachen)
- Hat man sein Kontingent verbraucht wird automatisch aufgebucht
  - Man kann das limitieren, also höchstens einmal pro Stunde aufbuchen etc.
- Nach 730+ Stunden nach der Aufbuchung verfallen alle Captchas
  - Dabei verfallene bezahlte überschüssige Captchas gehen an die Community
  - Der Abrechnungszeitraum schwankt etwas damit möglichst ständig etwas an die Community geht
  - Der Abschluss-Service muss so auch nicht Zeitgenau laufen, sondern kann dem hinterherhecheln
  - Die Idee ist, dass so möglichst jede Stunde ein Kontingent an die Community geht
  - Pro Domain werden max. 2500 Captchas vom Vormonat übertragen, der Rest verfällt
  - Pro User werden max. 1 Mio Captchas vom Vormonat übertragen
  - Es werden erst die bezahlten Captchas, dann die freien Captchas übertragen
  - Beim Übertrag werden die bezahlten Captchas zu freien Captchas, die bezahlten Captchas weden dem Community-Kontingent zugerechnet
  - Der Überschuss verfällt, bezahlte Captchas gehen an die Community
- 2500 Captchas pro Domain, insgesamt maximal 10000 pro User sind pro Monat frei
  - Dazu kommen die vom Vormonat übertragenen Captchas
- Die bezahlten nicht verwendeten verfallenden Captchas gehen an die Community wie folgt:
  - Von ihnen werden die verbrauchten freien Captchas abgezogen und nur der Überschuss verteilt
  - (Damit werden die übertragenen bezahlten Captchas, die zu freien Captchas wurden, im nächsten Monat wieder abgezogen)
  - Die so übertragenen Captchas gelten als bezahlte Captchas!
  - 10% gehen (automatisch) paritätisch an alle
  - 10% gehen (automatisch) an alle im Free Tier
  - 10% gehen (automatisch) an registrierte Privatpersonen
  - 10% gehen (automatisch) an registrierte Dienste, die etwas im Free-Tier anbieten (aber nur da!)
  - 10% gehen (automatisch) an OpenSource-Projekte und Open-Source-Community-Sites
  - 10% gehen (automatisch) an registrierte Opensource-Entwickler
  - 10% werden (automatisch) für plötzlich auftretendes Trending bereitgestellt
  - 30% werden nach meinem Gusto verteilt (verfallen in der Regel)
  - Es werden immer zuerst die freien Captchas verwendet, danach kommen die bezahlten dran
- Bezahlte Captchas kann man an Dritte übertragen
  - Freie Capchas kann man nicht übertragen!
  - Übertragene Capchas erhalten keine höhere Gültigkeitsdauer und fallen weiterhin unter das Übertragungslimit
  - Kontingente werden immer strikt in der Reihenfolge der Zuordnung verbraucht (FiFo-Prinzip)
  - Man kann beim Verbrauch freier Captchas entsprechend bezahltes Captcha automatisch übertragen
  - Das ist insbesondere bei Domains interessant, so dass man auf mehr als 2500 Capchas kommt
  - Ansonsten ist das, außer bei Sponsoring, eher uninteressant.
- Captchas werden intern immer in Paketen verwaltet
  - Das kleinste Paket ist 1000 Captchas, bei Privatpersonen 250
  - Wenn man Captchas überträgt, passiert das in den entsprechenden Paketen
  - Die Pakete haben eine Lebensdauer bis sie verfallen
  - Wenn sie verfallen, werden sie dem Account zugeordnet, von dem sie kamen, da dort alle Pakete gleichzeitig verfallen

So müsste ein Captcha-Service aussehen, den ich für mich verwenden würde.  Weil der transparent arbeitet.

Technisch gesehen kostet dort ein Captcha also nur 1 Cent für 10000 Captchas.

> Nochmals: 1 Mio Captchas kosten 1 EUR, damit muss eine 5 EUR VM also 5 Mio Captchas serven.
> Bei 5 TB Transfer ergibt sich so 1 MB Datenvolumen pro Captcha.
> Eine typische 5 EUR VM bietet aber 20 TB Transfer.

Das alles lässt sich also wunderbar rechnen mit einem Anteil von 80% Gewinn pro umgesetztem EUR.
Gut, davon muss noch das Personal (also ich) bezahlt werden.

Da ja eine ganze Cloud von 5 EUR-VMs an verschiednen Standorten eingesetzt werdne kann,
ist auch die Verfügbarkeit von >99% kein Problem.

Ich verstehe also die Preise der Captcha-Dienste nicht.  Sorry!
