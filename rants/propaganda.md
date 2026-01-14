# Propaganda

Wir brauchen einen gemeinfreien Propagandakanal zum Mitmachen.

## WTF?

Mein Problem ist, dass ich schlicht nicht die Zeit habe, mich der rechten, linken, oder sonstigen Propaganda entgegenzustemmen.
Diese Zeit hat einfach niemand.  Dadurch haben die Trollarmeen vom Kommerz, von Putin, oder auch irgendwelchen Parteien leichtes Spiel!
Denn was kann ich schon dagagen tun?

Passende Gegenpropaganda zu verbreiten!  Und zwar OHNE mein Zutun und Vollautomatisch.

Auf meiner Homepage.  Auf meiner T-Net-Box.  Auf meinem Handy oder Firestick.
Auf dem Displpay meiner Hausautomatisierung.  Und auf allen möglichen Kanälen, die andere von mir wahrnehmen.

Passend ausgewählt (gefiltert nach MEINEN Bedürfnissen) und mit gemeinfreien Inhalten.
Ein "shoot and forgete", einmal kurz richtig eingesstellt, und dann läuft das, von selbst, ewig und immer aktuell!

Den Content kann ich nicht aussuchen oder filtern.  Keine Zeit!  Der muss also passend vorgefiltert sein!  
Ich kann dem ganzen Scheiß nicht nacharbeiten.  Also einmal eingestellt muss das mindestens 1 Dekade lang laufen!  Von selbst!  
Und die Teilnahme muss absolut FREIWILLIG und KOSTENLOS sein!

## Formate

Der Content muss in VIELFÄLTIGEN Formaten verfügbar sein.

Nicht jeder Content muss in allen Formaten verfügbar sein.  Wichtig ist aber, dass ich das Format finde, das ich benötige.

- Reine Textform
- Reines Audio
- Reines Video (ohne Audio mit Untertiteln/Überschriften etc.)
- Animiertes GIF
- Video in den bekannten Formaten (Youtube, Shorts, TikTok etc.)
- Statisches Bild (Groß, Mittel, Klein, Thumbnail/ICO/Avatar)
- JPG, PNG, GIF
- Bildfolge/Slideshow
- diverse übliche Bannerformen (klein, breit, hoch, fullpage 16:9, fullpage 4:3, quadratisch, etc.)

Einiges kann automatisch umgerechnet werden, aber es wäre gut, den Content in optimierten Formaten bereitzustellen.

### Spezielle Formate

Es kann auch noch weitere Spezialformate geben:

- Playlist
- KI
  - Die KI-Trainingsdaten müssen dabei gemeinfrei verfügbar sein
  - Das KI-Training muss ebenfalls vollautomatisch nachvollziehbar beschrieben sein
  - Und die trainierte KI muss natürlich auch frei verfügbar sein
  - Es gibt in Zukunft KI-Chips in Handys, dieses Format ist hauptsächlich gemeint und nicht die gigantischen von Hugginface
- Was sich sonst noch so ergibt


## Einbindung

Wichtigster Punkt hier:  Aller Content muss vollständig gemeinfrei sein und kostenlos zur Verfügung stehen.

Zweitwichtigster Punkt hier ist, dass ich mir einen eigenen Kanal anlegen kann, über den der vorgefilterte Content abrufbar ist.

- Dieser Kanal wird über die App (siehe unten) verwaltet.
- Und ich kann diesen Kanal abonnieren, OHNE dass man das nachvollziehen kann.
- Sprich, die Plattform rückt die Kriterien, die ich dem Kanal gegeben habe, nicht heraus.
- Da aber die Daten der Kanäle öffentlich sind, bedeutet das, dass man den exakten Kanal, auf dem ich bin, nicht herausfinden kann.
  - Das funktioniert mit einem Mix.  Ich abonniere also mehrere Kanäle mit einer Gewichtung.
  - Und das wird an die Plattform verschlüsselt übertragen.

Die Einbindung geschieht dabei strikt webbasiert.  Sprich, die Inhalte werden über HTTP bereitgestellt (bzw. HTTPS, oder HTTP/2 oder HTTP/3 oder was auch immer).

Es gibt außerdem weitere Möglichkeiten wie `git` (welches ja auch webbasiert funktioniert).

Technisch reicht also ein IFRAME auf einer Homepage und der Inhalt kommt von der Plattform.

ABER ..

.. es ist halt wichtig, dass ich den IFRAME auch selbst ausliefern kann.

Das ist inbesondere für Overlay-Netzwerke wie ToR oder I2P notwendig.  Während ich davon ausgehe, dass die Plattform in beiden Netzen verfügbar gestellt wird (hauptsächlich für den anonymen Upload), gibt es aber viele weitere Overlay-Netzwerke.  Und es soll hier keine Vorentscheidung getroffen werden.

Sprich: Jeder kann einen Proxy oder Cache oder Mirror der Plattform für sich selbst aufbauen.  Wobei "Mirror" wohl niemals vollständig sein kann, da die Plattform viel zu groß werden wird.

Das ist sogar auf Dauer essentiell.  Denn die Plattform erscheint zwar zentralisiert, aber sollte nach und nach komplett dezentralisiert werden.

> Mir schwebt sogar eine Infrastruktur vor, die vollständig Community-Driven ist,
> so wie bei BitCoin.  Dann braucht es idealerweise nur einen Koodinator,
> und alles ab da, inkl. Redundanz, kommt von der Community.

Die Plattform wird nicht ganz so enorme Datenmengen wie Youtube oder PornHub speichern müssen,
da die Beiträge ja kurz und prägnant sein sollen, aber der Speicheraufwand wird durchaus
beachtlich sein.  Ein großer Vorteil ist, dass man sehr gut archivieren kann,
da die Kanäle ja festlegen, was ausgeliefert wird.  So kann man ältere Dinge "wegarchivieren",
und nur dann, wenn jemand doch darauf zugreifen will (Download), dann stellt man sie wieder bereit.

Außerdem kann die Plattform auf externe Ressourcen zugreifen.  Niemand sagt, dass die Dateien lokal
liegen müssen.  Sie können auch auf Plattformen wie GitHub oder sonstigen Hostern gespeichert sein,
man kann also das freie Potential nutzen.  Alles was es dazu braucht ist halt ein Backup, falls
man ein externer Hoster wegbricht.

All das reduziert die Kosten.  Auch die für die Teilnahme.  Denn Verfügbarkeit ist alles.

Wie ich es einbinde, darin bin ich also dann frei.  Ich kann wählen, woher die Daten stammen,
und wie sie an meine Nutzer ausgeliefert werden.  Und wenn ich nicht mit dem, was die Plattform
bietet oder wie sie es macht einverstanden bin, dann kann ich das alles halt selbst machen.

Denn alles ist klipp und klar gemeinfrei (so lange ich die Dispute korrekt beachtet werden).


## Teilnahme

Nutzt die Community!  Erlaubt es, eigenen Content bereitzustellen.  Anonym und gleichzeitig getrackt!

Hä?

Also:

- Man kann Beiträge über das Web hochladen/posten.
- Die Beiträge werden unter ihrem Hashwert erfasst, so dass der Uploader über den Hash an die Metadaten kommt.
- Diese Beiträge sind anonym, sprich, werden NIEMANDEM zugeordnet.
- Diese Beiträge werden NICHT automatisch veröffentlicht, sondern erst entsprechend von einem Gremium passend geTAGgt.
- Unpassende Beiträge (Volksverhetzung, Fake-News usw.) werden ignoriert!
- Die Begründung (nicht der Beitrag selbst!) werden unter dem Hash abgelegt (öffentlich, GIT-Repo!)
- So kann die Community diskutieren und man kann sich KONKRET ein EIGENES Bild machen (wenn man den Hash oder Beitrag hat)

> Hint: Eine KI kann die Beiträge vorqualifizieren und ähnliche Re-Uploads mit anderem Hash identifizieren!

Und es gibt eine App, mit der man anonym beitragen kann:

- Audio (Podcasst) hochladen
- Video-Only (ohne Ton) hochladen
- Videos (mit Ton) hochladen
- Kurztexte hochladen
- Pamphlete hochladen
- Und Quellen verwalten, zu dem, was man hochgeladen hat
- Zusätzlich kann man hier Kontakt zu dem Rating aufnehmen, um z.B. zu protestieren

> Die App erzeugt die notwendigen kryptographischen Einträge um sie in die Blockchain aufzunehmen.

Die App liefert dabei die pseudonymen Konten.
In ihr sollte ToR bzw. I2P einbindbar sein, sprich, die Plattform ist als .onion oder EEPSITE erreichbar!

- Jeder kann sich so viele Konten erstellen, wie er will.
- Das ist für die Kanäle auch notwendig.
- Die App verwaltet die Konten über einen Kryptoschlüssel.
- Hierfür bietet sich ein Wallet-System (Konten) und Blockchain (Hashes der Beiträge) an!
- Die Konten sind dadurch alle ÖFFENTLICH, aber eben pseudonym.

Die Blockchain enthält selbst keine Daten, sondern authentiziert diese lediglich.
Also ordnet z.B. Wallet zu den Beiträgen zu und deren Bewertung.
Enthält weder Wallet-Infos noch Beiträge noch Bewertungen oder TAGs, aber listet JEDE Änderung!

Alle Aktivitäten sind somit nachvollziehbar.

- Es ist nachvollziehbar, wann der erste Upload geschah.
- Es ist nachvollziehbar, welches Konto sich den Content zueignet (z.B. Re-Upload)
- Es ist nachvollziehbar, wie der Content getaggt wurde
- Es ist nachvollziehbar, warum ein Content abgelehnt wurde
- Es ist nachvollziehbar, wie sich ein Konto verändert hat
- Es ist alles bis ins Detail nachvollziehbar und öffentlich!

Aber das Konto selbst ist niemandem zugeordnet, außer derjenige BEWEIST das über seinen Schlüssel.

Werfe ich den Schlüssel weg, sind alle Verbindungen zu mir abgebrochen.
Es ist essentiell wichtig, dass die Hoheit über den Schlüssel nur und ausschließlich die Person oder der Bot selbst haben!

### Warum?

Nun, es wird anonyme Teilnehmer geben, die sich von anderen abheben wollen, indem sie besonders viele Beiträge in die Plattform bekommen.

Es gibt Beiträge, die abgelehnt werden, sich später aber als richtig herausstellen und dann neu bewertet werden.

Es gibt andere Beiträge, die falsch gewertet wurden und aus dem Programm genommen werden.

Und ich muss in der Lage sein, den Content zu abonnieren, den ich will.

Außerdem muss die Plattform extern kontrollierbar sein, also müssen alle Dinge in Öffentlichkeit gemacht werden.
Aber halt auch sicher für alle Teilnehmer.  Ob DAU, Radikal oder Terrorist.  Niemand wird ausgeschlossen.

Nur .. wer nicht richtig kooperiert bekommt halt seinen Inhalt nicht veröffentlicht!
Weil da das Rating davor steht.  Und genau DAS ist der Knackpunkt.

Ich kann also teilnehmen.  Als Creator.  Oder als Nutzer des Content.  Und ich bin geschützt!

- Der Content ist gemeinfrei, also DARF NIEMAND deswegen abgezockt oder demonetarisiert werden.
- Dafür hat das Gremium zu sorgen.  Sprich, aller Content wird VON DER PLATTFORM gemeinfrei gestellt.
  - Alle Ansprüche usw. gehen also an die Plattform selbst, NICHT an den Creator oder Nutzer!

Wichtig ist aber auch, dass ich den Content BELIEBIG nutzen darf.  Das ist ebenfalls essentiell!

- Die DSGVO macht es oft notwendig, dass ich den Content NICHT verlinke sondern SELBST ausliefere!
  - Das kann als Proxy geschehen.  Sprich, mein Server zieht sich den Content jedes Mal und forwardet ihn
  - Das kann als Cache geschehen.  Sprich, mein Server zieht sich den Content einmal und forwardet ihn dann mehrfach
  - Das kann als Kopie geschehen.  Sprich ich downloade den Content einmal und hoste ihn dann beliebig
- Deshalb braucht es eine Clensing-API, die mir mitteilt, dass der Content nicht mehr opportun ist
  - Sprich, irgendein Disput läuft.  Wichtig ist hier die TRANSPARENZ!
  - Ich kann dann passende SELBST auf den Disput reagieren
- Beim Proxy ist sowieso alles klar, der Content ist ggf. nicht mehr auf der Plattform erreichbar.
- Beim Cache ist es fast genauso klar.  Ich kann bei der Plattform nach dem Status fragen und handeln.
- Bei der Kopie kann ich es mit der API entsprechend abgleichen.
  - Da die API die Blockchain ist, ist das technisch relativ gut zu implementieren!

Ich kann also den Content - wenn ich mich traue - weiterhin verbreiten, auch wenn die Plattform diesen blockt.
Dann weiß ich aber, dass ich dafür dann selbst verantwortlich bin.

Vorsichtige können den Content schon früher als die Plattform deaktivieren, weil der Disput eben viele Stadien habnen muss.
All das steht in der Blockchain:

- Irgendwer hat einen falschen Claim gemacht.
- Es gibt einen unbewiesenen Disput
- Es gibt viele Einsprüche (z.B. von Konten, denen man folgt, weil sie sich als verlässlich herausgestellt hat)
- Es gibt einen Disput, der von vielen geteilt wird
- Es gibt einen offensichtlich nicht unberechtigten Disput, auch wenn er nicht endgültig bewiesen ist
- Es gibt einen berechtigten Disput
- Es gibt einen bestätigten Disput
- u.v.m.  Da muss man sich halt eine sinnvolle Matrix für ausdenken auf die ich reagieren kann

Da alles in der Blockchain steht, ist es kein Problem, eigene Kriterien zu entwickeln.
Wichtig ist hier die Granularität der Einträge, sowie darauf zu achten, dass man alte Zöpfe nicht abschneidet wenn man etwas erneuert.

Damit alte Software (API-Aufrufe) eben NICHT und NIEMALS aktualisiert werden müssen.

> Wiederum: Beim Proxy und guten Caches ist das ein No-Brainer, da bekommt man es nicht mehr von der Plattform.


### Verified Creators

Es gibt außerdem "verifizierte" Creators.  Diese sind z.B. die öffentlich rechtlichen Rundfunkanstalten.

Über diese werden die Informationen öffentlich auffindbar gehalten.  Z.B. in einem Git-Repo.

Man kann also zu dem Konto diese zusätzlichen Infos abrufen.  Von der Plattform selbst.
Das sind dann die "offiziell verizierten Creators".

Es gibt auch die "inoffiziell verifizierten Creators" indem man ein Zertifikat auf die Homepage klatscht.
Das Zertifikat unterschreibt damit den Hash vom Konto mit dem privaten Schlüssel, so dass man das Ownership verifizieren kann.

Mit dem Zertifikat werden auch die weiteren Infos zertifiziert die darinnenstehen.
Somit steht das Zertifikat für sich selbst.  Es it also sinnvoll, die Domain darin aufzunehmen, für die das Zertifikat gilt, sonst kann es sich ja jeder aneignen.


# Und wer bezahlt das?

Der Betrieb der Plattform sowie das Gremium, das die Sachen einschätzt,
muss unabhängig und öffentlich finanziert werden.  Z.B. durch den Rundfunkbeitrag.

Es ist wichtig, dass es hier eine unabdingbare und unabhängige Finanzierung gibt,
unbeeinflusst von politischen oder sonstigen Zwängen.

Der Korrektiv hier ist die Community, genauer, die Blockchain, in der alles öffentlich bereitsteht.
Sollte das Gremium also Mist bauen, ist das offensichtlich und nachvollziehbar dokumentiert!
Damit ist gemeint: Gerichtsfest und man kann bis zum EuGH daggen klagen.

Genau so stelle ich mir das jedenfalls vor.

Hinweis zu den Kosten:

Die Kosten sind SEHR ÜBERSCHAUBAR!  Wenn man jetzt nicht teure Systeme a la AWS für die Plattform verwendet,
sondern andere Anbieter wie IONOS oder Hetzner,
dann beläuft sich der Betrieb der Infrastruktur auf einen 4-stelligen EUR-Betrag pro Monat!
Und wenn die Server gut aufgesetzt sind, dann reicht dafür ein Admin, der das nebenbei betreibt.
Sprich, die zusätzlichen Kosten für die Nutzung des Admin ist in den Kosten schon mit dabei,
wenn man den Admin bereits hat.  Ansonsten muss man halt noch einen (guten) Admin einrechnen.

> Hinweis:
>
> - Ich bin so ein Admin, der so etwas nebenbei betreiben kann.
> - Ich bin auch bereit, das für einen solchen mittleren 4-stelligen Festpreis bereitzustellen!
> - Der Aufbau der Plattform ist dabei NICHT inbegriffen, aber der vollstädige Betrieb!
>
> Ich mache das übrigens bereits seit über 30 Jahre, weiß also sehr genau, wovon ich rede!
> Jeder, der etwas anderes behauptet, beweist, dass er absolut keine Ahnung hat, denn ich habe den Gegenbeweis!
>
> Und ja, ich kann das nicht nur GERICHTSFEST beweisen, viel schlimmer, ich KANN DAS WIRKLICH BEREITSTELLEN!

Der eigentliche Aufwand ist also nicht der Datenverkehr, nicht die Plattform und auch nicht ihr Betrieb.

Der Aufwand liegt vollständig im Bereich von:

- Creators
- Gremium

Am Anfang braucht es eigene Creators.  Diese müssen gemeinfrei publizieren!
Genau das ist das Problem, solche zu finden wird anfangs schwer sein bis sich die Plattform etabliert.

> Hier erwarte ich den ÖR!

Und das Gremium ist noch komplizierter.  Hier ist zwingend eine demokratische (politische) Kontrolle notwendig.
Denn Plattformen wie Wikipedia, Stackoverflow, Reddit usw. driften immer weiter ins Nazitum ab.

> Hier sind die Nazis nicht politisch rechts oder links, sondern diejenigen, die den Content beurteilen,
> welcher leben darf und welcher nicht.  Wer also lebt und wer stirbt.  Das ist untragbar.
>
> Es ist also zu verhindern, dass sich derart eingeschworene Gemeinschaften bilden,
> es dürfen hier sich keine Platzhirsche etablieren oder sonstige Seilschaften oder Cancel-Culture bilden!

Die Lösung ist die öffentliche Kontrolle.  Welche auch durch die Plattform selbst gelöst werden kann.
Indem man die Dinge mit transparenten Strukturen einklagbar gestaltet.

> Ein abgelehnter Beitrag kann also eingeklagt werden.  Dafür muss es klare Regeln geben.

Womit ich zum Gremium komme.

Das Gremium ist hier der rechtliche Ansprechpartner.  Das verklagt werden kann, wenn es falsch handelt.
Das eine Garantie einzuhalten hat, und unabhängig, unparteilich und vorurteilsfrei handelt.

> Sprich: Alles, was es tut, muss absolut stichfest und nachvollziehbar sein.

Dabei hilft die Blockchain, die ja alles zweifelsfrei beweisen kann.  Trotzdem steht das Gremium im Feuer!

Das zu leisten bedeutet also nicht nur Chutzpe (sprich: Die Mitglieder sollten nicht öffentlich benannt sein,
außer des Mitglied will das selbst), sondern auch fundierten rechltichen Beistand!

> Nein, das Mitglied selbst soll eben genau KEIN Jurist sein, sich aber jederzeit juristisch absichern können!

Anfangs hat das Gremium wenig zu tun (jedenfalls wenn der ÖR die Beiträge gestaltet):

- Da müssen nur die Richtlinien festgelegt werden
- Und die Beiträge passend getaggt werden
- Und man muss auf die Notwendigkeiten von den Usern eingehen, die ja passende Filter brauchen

Aber später, wenn die Community aufschlägt geht der Workload durch die Decke:

- Man muss sich jeden Beitrag ansehen
- Und diesen einschätzen
- Und diesen passend Taggen
- Und sich bei Ablehnung juristisch absichern
- Und sich bei nicht-Ablehnung ebenso oft juristisch absichern
- Und bei Beiträgen in der Schwebe entsprechende transparente Verfahren etablieren
- Außerdem werden sich Urheber melden, weil der Creator falsche Angaben gemacht hat 
- Und dann kommen noch die ganzen Schwurbler und Fakes hinzu, die man abweheren muss!

Das ist alles nicht zu unterschätzen.  KI kann hier in gewissem Maß helfen.

> Hinweis: Diese KI kann ich bereitstellen, ABER nicht zu dem oben genannten Preis!
> Dafür sind mehrer Vollzeitarbeitskräft notwendig, außerdem ein paar KI-Experten.
> Einiges davon kann die Community bereitstellen.  Aber vieles muss man zukaufen und teuer bezahlen.

Ich schätze, dass diese KI einen hohen 6-stelligen Betrag bis niedrigen 7-stelligen Betrag pro Jahr kosten wird.

ABER

Da die KI, genauso wie alles andere, EBENFALLS frei verfügbar sein wird,
ist diese KI ein WESENTLICHER BEITRAG für den SOZIALEN FRIEDEN wie auch
den SCHUTZ VON URHEBERN!  Genauso wie sie dann auch gegen FAKES trainiert ist,
und man sie somit SELBST ZUHAUSE betreiben kann, um sich und die Kinder zu schützen!

Diese Ausgaben sind also nicht übertrieben.  Sondern, verglichen mit ihrem Nutzen, stinkebillig!

Genauso wie diese Plattform.

Aber ich denke, etwas, das im Jahr soviel kostet wie 10 km Autobahnerneuerung,
das hat in Deutschland sicher weder eine Lobby noch eine Finanzierungsmöglichkeit.
Denn diese 10 km Autobahn sind ja wichtiger als sozialer Friede!

> Laut KI kosten 10km Autobahnerneuerung ca. 6 Millionen EUR.
>
> Was für mich noch wichtiger ist:
>
> Das wäre nur der Anfang.  Daraus kann sich ein Demokratisches
> Hilfmittel entwickeln, das die gesamte Kommunikation in der Gesellschaft auf neue Füße stellt.
>
> Aber hey, wer bin ich schon, dass man mir so etwas glaubt?

# Hinweis

Wenn mir jemand 10 Millionen EUR pro Jahr (zzgl. Inflation) für die nächsten 20 Jahre garantiert,
DEM BAUE ICH DAS ALLES WIE BESCHRIEBEN AUF!  Und vieles mehr!  (Allerdings ohne die Creators!)

Warum 20 Jahre?  Weil hier der Ablauf:

- Im ersten Jahr passiert NICHTS.  Ich eruiere und baue eine Testplattform auf.
  - Nicht alleine, sondern ich suche mir Mitstreiter!
  - Es werden die VIRTUELLEN Strukturen geschaffen
  - Dafür verwende ich 5 Mio EUR, die restlichen 5 Mio werden für später zurückgelegt
- Im zweiten Jahr wird die RECHTLICHE GRUNDLAGE geschaffen.
  - Der Aufbau des Gremiums wird geschaffen
  - Es wird ein Standort aufgebaut (dafür stehen 5 Mio zur Verfügung, laut KI mehr als ausreichend)
  - Mitarbeiter bekommen je nach Wunsch feste Arbeitsplätze oder Gelegenheitsarbeitsplätze
  - Der Standort bietet außerdem Gruppenräume mit Videoausrüstung für virtuelle Meetings
  - Mehrere Gruppenräume können virtuell zu einem großen Meeting-Raum zusammengefasst werden
- Im dritten Jahr wird die Infrastruktur bereitgestellt
  - Außerdem wird die Rechtsabteilung aufgebaut
  - Dafür sind wiederum 5 Mio eingeplant
  - Ab hier werden jedes Jahr 1 Mio für Rechtsstreitigkeiten zurückgelegt
  - Außerdem wird 1 Mio wird für "sonstiges" das später auftritt zurückgelegt
- Im vierten Jahr geht das alles in den Testbetrieb
  - 1 Mio wird jedes Jahr für später zurückgelegt
  - Parallel wird eine kleine KI-Abteilung aufgebaut
  - Dafür setze ich wiederum 5 Mio EUR an
- Im fünften Jahr geht es in die Beta
  - Die KI-Abteilung wird den Erfordernissen nach und nach angepasst
- Im sechsten Jahr geht es in die verlängerte Beta (Pre-Production)
- Im siebten oder achten Jahr geht es dann in Produktion
- Ab dem zehnten Jahr geht die Plattform dann in den vollen Wirkbetrieb
- Und in dem bleibt sie dann die nächsten 10 Jahre
- In diesen 10 Jahren wird nach und nach die KI-Plattform ergänzt
  - 3 Mio Personalkosten (Gremium, Juristen, IT, Entwicklung und Support; Ohne Creators und Nutzer!)
  - 2 Mio IT-Betrieb
  - 1 Mio sonstige Infrastruktur (Fuhrpark, Gebäude, Beschaffung, Bepflanzung, Wasser, Heizung)
  - 2 Mio sind freies Budget, das geht weitgehend in die KI-Entwicklung und Nutzung
  - 2 Mio zurückgestellt (Recht + Sonstiges)
- Nach den ersten 20 Jahren
  - Ich bin da schon 10 Jahre in Rente
  - Mir muss aber gestattet sein, dass ich die Ressourcen der Plattform für mich weiter nutze!
  - Und dadurch wird sich nebenher so langesam GENAU DAS ergeben, was ich wirklich will!
  - Das zu erklären führt aber hier zu weit.
  - Nur soviel:  Derzeit profitiert ganz Europa davon, was ich seit 30 Jahren unentgeltlich betreibe!
  - Und dafür braucht es einfach eine Zukunft, die unabhängig von mir funktioniert!
  - Und genau dafür bruache ich ca. 10% der Ressourcen einer derartigen Plattform!
  - Und der Wert für ganz Europa kommt mit einem ca. mindestens 100-Fachen Faktor wieder zurück.
  - Ja, 10 Mio/Jahr mal 100 ist 1 Milliarde EUR.  Also kein Pappenstil.
  - Das Problem ist nur, dass man diesen Wert zwar beziffern aber nicht einpreisen kann.

> Und ja, ICH BIN BEREIT DAS ALLES GERICHTSFEST ZU BEWEISEN wenn mir dafür ALLE AUFWÄNDE bezahlt werden!
> Ich muss dazu nämlich auf ein paar Experten zurückgreifen, die ich dafür bezahlen müsste,
> aber halt nicht selbst bezahlen kann.  Die Kosten für meine Expertise trage ich dabei selbst
> und möchste nur Reisekosten und sonstige zusätzlichen Aufwände wie Verdienstausfall ausgeglichen bekommen.
>
> Hinweis: Die 10 Mio müssen sich der allgemeinen Kostenentwicklung anpassen,
> also Inflation, Lohnentwicklung und nicht normal-sinkende Preise auf dem IT-Sektor.
>
> Bei dieser Darstellung gehe ich von den ÜBLICHEN SINKENDEN PREISEN im IT-Bereich in den
> letzten Dekaden aus.  In dieser Dekade ist der Trend wegen KI aber recht gegenläufig.
> Das bedeutet, die Kosten sinken nicht entsprechend, sondern laufen im guten Fall horizontal.
> Im Speicherumfeld steigen sie sogar!  (Der Preis von KI-Chips ist indes eingerechnet.)
