# NetFlix

Hallo Netflix auch.

Ich habe 3 Streamingdienste:

- Netflix
- Disney Plus
- Amazon Prime

Und wenn ihr weiter so drauf seid, wie derzeit, sind es vermutlich bald nur noch 2.

Ich bin einer der Kunden, die euer Maximalabo haben.  **Und wenn die Gängelung nicht aufhört, dann werde ich Neflix vermutlich irgendwann kündigen!**

> Klar könnt ihr gegen Leute vorgeht, die euren Account "missbrauchen" (wie auch immer das möglich sein soll, oder wie auch immer
> ihr das definiert).  Habe hätte ich nichts.  Wenn ihr mich mit diesem Scheiß verschont.
> Aber wenn es in Gängelung von mir ausartet, dann sorry, habt ihr bei mir, mit Verlaub, verschissen.
>
> Und ich bin nicht alleine.  Mir folgen sicher einige.  Wenn ihr also Abonennten verlieren wollt, dann macht gerne so weiter.  Geht sterben!

## Was los?

Ich habe

- 4 mögliche Standorte in verschiedenen nahe beieinandergelegenen Orten (Umgebung Augsburg)
  - Dazu gehört das Haus, in dem ich bei Google Maps gemeldet bin
  - Das ist nicht ganz zufällig auch meine ladungsfähige Adresse von meiner Homepage.
  - Und das ist der Ort, den andere für mich als Wohnort definieren würden.
  - Und den ihr, Netflix, vielleicht als meinen "Haushalt" begreifen wollt.
  - Ich sehe das hingegen etwas, um nicht zu sagen, deutlich differenzierter.
  - In so einfachen Zeiten leben wir nicht mehr.
  - Ich bin zwar Deutscher und würde nur ungern woanders leben, aber als meine Heimat bezeichne ich: Das Internet.
  - Denn im Internet, da lebe ich.  Übrigens schon mindestens seitdem ich geboren bin.  Und das ist 1967.
  - Um im Internet zu leben ist übrigens kein Internetanschluss eines ISPs notwendig.  Internet ist eine reine Geisteshaltung.  Oder meinetwegen Geisteskrankheit, das ändert aber nichts.
- 5 Festnetz-Internetanschlüsse mit semidynamischer IP (manche Standorte sind aus Sicherheitsgründen mehrfach abgestützt)
- 6 Smart-TV verschiedener Größe (von 60cm bis 250cm, von 3D-Full-HD bis 8K)
- 5 Fire-Sticks (weil die dummen TVs kein Disney+ können)
- 10+ verschiedene wLANs in die ich die TVs und Sticks schalten kann
- 3 weitere Mobilgeräte mit 2 verschiedenen Verträgen (also eigener IP), auf denen über deren Mobil-IP theoretisch Netflix gestreamt werden kann
  - Dazu gehört auch das Auto, denn meine Karre ist modern.  Nein, kein Tesla.  Ich sagte modern.
- Und eine Myriade von Devices wie Standrechner, Laptops, Tablets usw. auf denen Netflix als App oder im Browser laufen kann
- Dazu kommt noch ein zum Haushalt gehöriger Sohn, der natürlich ebenfalls Netflix auf seinem von mir bezahlten Mobiltelefon nutzt.
  - Egal wo er gerade ist, also Uni, McDonalds, Zuhause, whatever
  - Meist nutzte er natürlich wLAN, weil das freie schnelle inklusiv-Datenkontingent ihm natürlich nicht ausreichen kann ..
  - ganz Deutschland einig Rückstandsland eben, und nein, er kriegt keine 60 EUR-Vertrag damit er unlimitiert surfen kann.
  - Und klar, der hat auch eine Laptop sowie Desktop mit Netflix per App und Browser drauf.

> Das klingt nur viel.  Aber bei mir wird nur bezahlt, was absolut minimal notwendig ist.  
> Das alles oben ist bei mir mindestens so notwendig, wie der Wasseranschluss.  
> Genauer: Ich würde lieber auf Frischwasser und Toiletten verzichten als auf das Internet.
>
> **Ohne Wasser stirbt nur mein Körper.  Ohne Internet, da sterbe ich!**
>
> A what?  Ja, Leute.  Ein Server in der Hetzner-Cloud kostet 5 EUR/Monat.  Lüge, es kostet weniger.  Nur so mal als Denkansatz.
> Aber ich kaufe mir lieber alle 5 Monate einen neuen Firestick oder Raspberry-PI anstatt einen 10 EUR/Monat teureren Mobilfunkvertrag zu nutzen.
> Die One-Off-Costs sind nämlich verträglich.  Wichtig ist, die running-Costs zu senken.
>
> Und das kann ich, z.B. durch Reduktion von Dingen mit monatlichen Kosten, deren Nutzen sich überholt hat.
> So etwas wie vielleicht Netflix bald, **wenn die weiterhin denken, mich einfach so gängeln zu können**.
> Nicht mit mir, dafür seid ihr nicht wichtig genug!

Dazu kommen noch mehr:

- 8 (überschlagsweise, das kann variieren) weitere weltweit verteilte ISPs deren multiplen Standorte ich mit Servern von denen die ich mitnutze
  - Insgesamt sind das so etwas über 30 IPv4.
  - Meistens auch mit IPv6.  Aber nicht jeder ISP, den ich nutze, bietet mir nutzbares IPv6 (ich schreibe das im Jahr 2023!  Go figure ..)
- 2 voneinander unabhängige VPN-Dienste mit ca. 500+ verschiedenen IPs, davon alleine 100+ in Deutschland
  - Die können teils sogar schon bruchteilhaft IPv6.  (Ich schreibe das immer noch im Jahr 2023.)
- Und ich bin ziemlich viel unterwegs und hänge durchaus auch mal nachts in einem Hotel oder sonstwo rum
  - Seit Corona zwar selten, aber kann ja immer mal wieder vorkommen

Theoretisch kann ich all das auch per VPN nutzen.  Derzeit ist das zwar noch nicht so, wird aber kommen.
Warum?  Weil bei mir die Standorte alle vLAN (nicht zu verwechseln mit wLAN) haben,
d. h. das Backbon von (so gut wie jedem) Standort logisch in mehere Sicherheitsbereiche getrennt ist.

Ist bisher noch nicht vorgekommen, wird aber in dieser Richtung weiter ausgebaut (das kann bei mir Jahre dauern,
passiert immer dann wenn ich es brauche oder mich etwas dazu treibt), dass ich diese Segmente in ein VPN hieve.

> Das ganze Bramborium oben hat einen Sinn.  Nämlich den, unlimitiert bestimmte variable Tests durchführen zu können.
> Ich selbst brauche keine IP.  Aber wenn man mal Balancer-Tests und so "exotische Dinge" wie Multi- und Anycast testen will,
> ist es praktisch, IP-mäßig schnell binnen ein paar Sekunden mehrfach um den gesamten Globus reisen zu können.
>
> - Dummerweise gehört das zu meiner Jobbeschreibung.  (Wie ich meinen Job beschreibe.  Nicht andere, denn ich bin ja extremer Egozentriker.)
> - Dummerweise bin ich Admin und arbeite also 25/7.  (Als Admin beobachte ich meine Systeme gerne während der Zeitumschaltung, da hat der Tag 1h mehr.)
> - Dummerweise ist das nicht nur mein Beruf sondern auch meine Berufung.  (Und mein Hobby.  Das bin ich und einfach ich und ich einfach.)
>
> Anders gesagt:  Das alles ist mir selbst und sonst niemandem geschuldet.  Weil ich - in diesem unendlich kaputten Universum - nur so leben kann.  Und will.
>
> Und alles, was mir nicht in den Kram passt, z.B. weil es aus unerfindlichen Gründen denkt mir irgendwie ans Bein pissen zu können,
> das werde ich für mich reduzieren.  Oder wie es mein Arzt sagt:  Ich lebe zu ungesund.  Aber so bin ich einfach, warum ändern?
>
> Soll ich jetzt etwas ändern, nur weil ich dann evt. 5 Jahre länger leben?  5 Jahre, 25 Jahre, 250 Jahre, das sind Nullmengen.
>
> Was ist do wenig Jahre verglichen mit den tausenden Mannjahren,
> die ich als notwendig erachte, in die Entwicklung des Internets reinzustecken, um es wirklich voranzubringen?
> Also so wie, ganz der Egozentriker, ich das sehe, selbstverständlich.
> Also, was können 25 Jahre mehr oder weniger da bringen?  Was kann ich in so wenig Zeit alleine schon reißen?
> Absolut nichts!  Das ist zu wenig Zeit um irgendetwas zu verändern.
> Dagegen hat ein Tropfen im Plasmafeuer geradzu eine phänomenal größere Wirkung!
>
> Ja, ok, mein Sohn wird das vielleicht anders sehen.  Und as ist auch das gute:  Kinder erden.
>
> Aber das ist ein ganz anderes Thema und hat nichts mit Netflix zu tun.  Oder alles.

Also, in Bälde wird es sehr wohl dazu kommen, dass ich eines der Segmente (insbesondere wLAN) mal schnell zur Sicherheit in eines der VPNs hieven muss.
Und wenn ich aus so einem Segment gerade Neflix laufen habe, dann roamt das Streaming halt mit.

Klar hängen Smart-TVs in der DMZ.  Und gerade die ist wahrscheinlicher, dass sie mal roamet.


## 4 parallele Streams an 3-4 Standorten?  Ganz normal!

Warum habe ich das maximale Netflix-Abo?

Nun, ich habe auch einen 8K Fernseher.  Eigentlich Monitor.  Das ist halt auch ein Fernseher.  Mit Firestick.
Aber das alleine bringt mich nicht zum Maximalabo.  Das habe ich aus Bequemlichkeit.  Weil es mir das wert ist.

Ich lasse das Streaming nämlich durchaus weiterlaufenm während ich mal nicht da bin.  Die meisten meiner Rechner laufen ja auch permanent durch.
Oder so Dinge wie Remote-Desktop-Sessions, die mehr Daten rumschlenzen als so ein Streaming.

Also ich liege im Bett, die Blase drückt (ich werde halt auch älter, das mit der Admin-Blase ist nimmer so wie früher)
und ich springe (nicht literal gemeint) zum Klo.  Während der Fernseher weiterläuft.

> Ich muss mir unbeding mal ein Terminal ins Klo einbauen.  Diese disruptiven Klo-Sessions werden nämlich immer häufiger und länger.
> Ich werde ja leider älter.  Und das mit der Admin-Blase ist einfach nimmer so wie früher.
> (Von den Auswirkungen der medikamentösen Nebenwirkungen all der Drogen, die mir der Arzt verschreibt, mal zu schweigen,
> das dürfte den erträglichen Ekelfaktor vieler Menschen zu stark übersteigen.  Ihr Leute im Pflegedienst aber kennt das.
> Mein Admin-Job ist da übrigens nicht viel anders.  Ihr putzt die physikalische Scheiße weg, ich die virtuelle.
> Und, glaubt mir bitte, virtuelle Scheiße kann ebenso unweträglich stinken!)

Und dann komme ich aus dem Klo, ein Server ruft, ich gehe ins Arbeitszimmer und bastle rum.

Dort habe ich auch ein TV, eigentlich Monitor, auf dem ich weiterstreamen kann.

> Und ewig streamt das SchlafzimmerTV parallel weiter.

Bis ich dann zu einem meiner anderen Standorte fahre, um dort weiterzumachen.

> Und dabei streamt das ArbeitzimmerTV weiter

Und auch dort starte ich einen Stream.  Ggf. einen andeen.  Wieso nicht, wenn's nicht nervt.

> Bin ich da auf "Reisen"?  Nö.  
> Bin ich da in meinem Haushalt?  Äh, definiere Haushalt!

Was sieht Netflix?

- 3 verschiedene IPs
- die 3 verschiedene Titel streamen
- und evtl. kommt noch mein Sohn hinzu

Ich versuche zwar immer, das automatische Weiterstreamen abzuschalten, aber das fuunktioniert irgendwie nicht immer.
Dazu kommen Titel, die 3h und länger laufen.  In so kurzer Zeit kann ich durch alle meine Standorte tunneln.
Besonders nachts, denn die liegen ja nahe genug beieinander.

> Ich habe zuhause Telekom-DSL und Kabel.  Einfach weil das Monitoring beim Ausfall einer Internetleitung
> \- nicht nur durch Wartung - nicht anfangen soll zu lärmen weil es irgendwas nicht erreicht.
>
> TVs sind ein probates Diagnosemittel.  Hören die auf zu streamen ist was mit der Internetleitung.
> Das ist freundlicher als ein rumlärmendes Monitoring, auch wenn es überr die Hausautomatisierung nur die Lampen rot blinken lässt.
>
> Im letzten Jahrtausend hat ein Kollege mal den Ausfall einer Standleitung dank des Spielens von Doom antizipiert.
> Kann mir nicht passieren, denn ich spiele keine solchen Computerspiele.  Solche Spiele sind mir nämlich viel zu stressig.  
> (Hallo, Randy, übrigens.)


## Und wo ist jetzt das Problem?

Nun.  2 Uhr nachts.  Ich schalte das TV ein um Netflix zu sehen.

**Und Netflix gängelt mit irgendwas hinsichtlich, ob das mein Haushalt sei oder ich auf Reisen bin.**

Bin ich nicht.  Und ich bin mir ziemlich sicher, dass Netflix mit "Haushalt" nicht mein Konstrukt im Sinn hat.

> Oder würdet ihr behaupten, dass eure Serverräume zu eurem Haushalt gehören?  Ich tue das nicht.
>
> Aber da bin ich auch nicht auf Reisen.  Denn in Serverräumen bin ich zuhause!
>
> Zuhause und Haushalt sind bei mir disjunkte Dinge!

Ich will nicht lügen.  Aber ihr gebt mir 2 gleichermaßen falsche Antwortmöglichkeiten.
Also habe ich "Haushalt" genommen.  Weil das das ist, was dem einfach am nächsten kommt.

Aber das ist nicht das eigentliche Problem.

**Das Problem ist, dass ich in geistiger Umnachtung angenommen habe, es mit einem vernünftigen Dienst zu tun zu haben.**

Diese Annahme hat sich damit als grundsätzlich falsch herausgestellt.  Leider ändert das aber nichts am falschen Setup.

Das wirkliche Problem war aber, dass ich das, was Netflix da von mir wollte, nicht selbst lösen konnte!  
Warum?  Weil ich mich ans Deutsche Gesetz halte.  Deshalb!

> Da ich denke, dass Netflix dadurch in eklatanter Weise gegen die DSGVO verstoßen hat,
> habe ich eine entsprechende Beschwerde bei der Datenschutzbehöre gegen Netflix eingereicht.
>
> Siehe unten

In meinem jugendlichen Wahnsinn bin ich in Neflix mit der Mailadresse meines Sohnes registiert.

Warum?  Weil ich wollte, dass er den Passwort-Reset selbst durchführen kann und mir einfach nur das Passwort mitteilt.
Ich meine, er ist die Jugend, und wenn ich etwas aus meiner Jugend weiß ist, dass Warten keine Option darstellt.

> Die Leute, die gegen die Netflix-Statuten verstoßen, haben natürlich kein Problem mit dem Vorgehen von Netflix.
> Die sind ja durch einen gemeinsamen Account schon lange darauf vorbereitet.
> Ich aber, als legitimer Nutzer, tappe da selbstreden voll in die Falle.
>
> Es trifft also halt nur die hart, die sich nichts vorzuwerfen haben.  Applaus, Applaus, Applaus.

Schwerer Fehler.  2 Uhr morgens.  Und Netflix schickt meinem Sohn die Mail.  Also habe ich nun 2 Möglichkeiten:

- Ich wecke meinen Sohn auf
- Oder ich greife ohne sein Wissen auf seine Mails zu

Beides könnte ich.  Ich bin sein Mail-Provider.  Aber ich bin auch Admin.  Als Admin mache ich genau das nicht, nämlich Mails zu lesen.
Technisch bin ich dazu problemlos in der Lage.  Aber irgendetwas hindert mich daran, dass ich das tun kann.
Muss wohl ein psychischer Defekt sein.

Und meinen Sohn deshalb aufzuwecken.  Nö.

Also konnte ich Netflix nicht sehen.  Obwohl ich alles bezahle.  Und daran war einzig und alleine Netflix schuld.
Oder meine Einfältigkeit, zu erwarten, dass sich so jemand wie Neflix an Treu und Glaube hält.  Oder so.

Jedenfalls war ich erst einmal sauer.

Später dann (heute Nachmittag) habe ich das Problem dann mit der Hilfe meines Sohnes gelöst.

Geht deshalb die Welt unter?  Nein.  Aber Netflix hat bei mir jetzt, mit Verlaub, verschissen.


## Lesson learned

Ich werde Netflix wohl auf einen Shared Account umstellen müssen.  Sprich, auf einen Mailverteiler,
der dann an uns beide geht, also mich und meinen Sohn.

Da ich auf diese doofen Spielchen von Netflix wirklich keine Lust habe,
werde ich alle Devices wohl auf VPN umstellen,
sprich, all meine Fernseher gehen dann mit derselben IP an Netflix.

Warum?  Weil ich es kann!

Mir ist dabei scheißegal, was Netflix vielleicht zur Nutzung von VPN sagt.
Ich halte das eh für unzulässig, VPNs einzuschränken.
Siehe meine Datenschutzbeschwerde unten.

Und wenn Netflix mit der Praxis weitermacht, überlege ich mir ernsthaft, den Dienst zu kündigen.
Weil eigentlich brauche ich den nicht.  Ich habe noch Disney+ und Amazon Prime.
Bis auf die Netflix Originale habe ich eigentlich dort auch alles, mehr oder weniger.
Aber auf jeden Fall genug.

Jetzt aber erst einmal "stänkere" ich mit meiner Datenschutzbeschwerde.
Das hat sich Netflix verdient.  Denn ich schreibe ja nichts überzogenes,
sondern nutze nur den Vorfall um genau das zu fordern, was Gesetz ist:

Nämlich dass Netzflix sich an die DSGVO hält.

Aus meiner Sicht jedenfalls ist erwiesen, dass Neflix in eklatanter Weise gegen die DSGVO verstößt, und sich damit nur selbst schadet.

**Ein Hirnschiss sondergleichen!**

> Das hier ist nur desahlb in der Rubrik "Datenschutz", weil es hier etwas besser hinpasst als in "Hirnschiss".
>
> (Ich muss es noch ordentlich verlinken.)


# Datenschutzbeschwerde 2023-07-06

Netflix trackt Nutzer in unzulässiger Weise um die Einhaltung von ihnen aufgestellter Nutzungsbedingungen zu erzwingen.

Leider habe ich versäumt, das ganze bei mir aufzuzeichnen.  Aber ich habe dafür 2 Zeugen.

Was Netflix gemacht hat, kann und darf nicht mit der DSGVO vereinbar sein.  Anderenfalls ist die DSGVO nichts wert.
Dann dürfen nämlich alle Unternehmen aus vollkommen nichtigen Gründen alles beliebige erfassen
und dem Nutzer dabei jegliches Recht auf Widerspruch verweigern.
Sie müssen dafür nur irgendeinen nichtigen wirtschaftlich für sie bedeutsamen Grund vorschieben.

Ich denke auch, dass ich über die Art und Weise der Datenverarbeitung, nicht in verständlicher Weise aufgeklärt wurde.  Also:

- Welche Daten sie in welcher Form erheben
- Wie lange, wie und wo sie diese verarbeiten und speichern
- Aufgrund welcher Rechtsgrundlage sie das tun
- Und mit welchen anderen Daten sie diese zusammenführen

Auch ist mir vollkomen schleierhaft, wie sie die von der DSGVO erforderliche Überprüfung der Legitimität der Daten bewerkstelligen wollen.
Ohne ein solches mögliches Überprüfungsverfahren aber halte ich bereits die Erhebung der Daten für unzulässig!

Ich bin seit über 20 Jahren (nebenberuflich) im Bereich Datenschutz im Internet tätig (also schon lange vor DSGVO).
Internet "mache" ich seit über 30 Jahren professionell, und bilde mir deshalb ein, derartiges sogar recht gut beurteilen zu können.

Mir ist jedenfalls KEIN Verfahren bekannt, wie es Netflix ohne Verstoß gegen alles, wofür die DSGVO steht, herausfinden kann,
welche Geräte evtl. so verwendet werden, wie sie es gemäß ihrer Statuten NICHT wollen.
Jedenfalls dürfte das, was ich erlebt habe, so auf keinen Fall zulässig sein.
Als jemand vom Fach halte ich eine derartige Erkennung nur implementierbar, indem man einen eklatanten Datenmissbrauch treibt.

Das, was Netflix macht, mag in den USA oder außerhalb Europas "gehen".  Aber innerhalb Europa, da bin ich mir sehr sehr sicher,
ist es schlicht grob illegal (lies: Ein vorsätzlicher Verstoß gegen die DSGVO.
 Hinweis: IANAL, d. h. ich verwende Umgangssprache, nicht juristische Begriffe).

NETFLIX MUSS DAS WISSEN (da stellt sich der Vorstand nur so dumm, wie beim Betrug durch Unterlassen beim Dieselskandal)!
ES KANN UND DARF NICHT SEIN, DAS DER PLATZHIRSCH DANK SEINER MARTKMACHT MIT SO ETWAS DURCHKOMMT.

Man wird so durch Netflix gezwungen, entweder eine der beiden Angaben zu machen,
oder eben den (bezahlten!) Dienst in (legitimer!) Weise nicht zu nutzen.

Hier fehlt die ERFORDERLICHE Freiheit (bzw. Möglichkeit des Widerspruchs ohne Folgen), wie es die DSGVO vorschreibt!

Ich sehe hier UNMITTELBAREN, SOFORTIGEN und NOTWENDIGEN Handlungsbedarf durch die Datenschutzbehörden,
denn das betrifft potentiell MILLIONEN VON BÜRGERN in Deutschland!

Bitte schreiten Sie SOFORT ein und UNTERSAGEN Sie Netflix folgende gängige Praxis:

- Auf Geräten eine Datenerhebung zu starten, die ohne Verweigerungsmöglichkeit danach fragt, ob das Gerät zum Haushalt gehört oder man gerade auf Reisen ist!
- Den Nutzern unmöglich zu machen, dem für die Erbringung der Leistung nicht notwendigen Personenbezug zwischen IP, Aufenthaltsort und Nutzer zu widersprechen indem sie ein VPN verwenden.

Beides stellt in meinen Augen absolut unzulässige Einschränkungen der in der DSGVO verankerten Rechte der Nutzer von Netflix dar.

Vielen Dank!

Hinweise:

- Ich veröffentliche diesen Text auch in meinem Blog.  Und wenn Sie es zulassen auch gerne Ihre Antwort.
- Ich melde das an Sie in Bayern, weil ich in Bayern lebe.
- Sie dürfen meine Beschwerde gerne frei weitergeben und/oder veröffentlichen, mit und ohne Namensnennung.
- Sie dürfen das auch gerne an Netflix weitergeben.
- Ich habe auch nichts dagegen, wenn mich Netflix deshalb kontaktiert, ich würde dort sehr gerne jemanden zusammenbrüllen.
- Das angehängte PDF enthält nochmals den gesamten Text, für den Fall dass die Textbox nicht richtig übermittelt wurde.

-------

Was mich besonders auf die Palme bringt ist, dass Netflix offensichtlich darüber diskriminiert, welche Art von Gerät man gerade nutzt.

Das bringt mich jetzt dazu, eine entsprechende Beschwerte bei Ihnen einzureichen.
Diese wendet sich jetzt auch gegen andere Aspekte von Netflix, die ich bisher gewillt war zu dulden, weil ich dachte,
ich habe es mit einem Unternehmen zu tun, das die Rechte der Nutzer in einer duldbaren vernünftigen Art und weise einschränkt,
die noch im Bereich dessen ist, was ich als verständlich erachte.

Diesen Bogen hat Netflix aber jetzt deutlich überspannt, ich würde sagen, die Sehne ist gerissen.
Deshalb wende ich mich nicht nur gegen diese aktuelle neue Praxis, sondern auch gegen das (hörensagen) Verbot von VPN
(ich habe noch nie wissentlich versucht, Netflix über VPN zu streamen, kenne mich damit also nicht aus, aber man hört ja so einiges).
Soweit ich gehört habe versucht Netflix die Nutzung von VPNs zu erkennen und den Dienst entsprechend einzuschränken.
Ähnlich wie bei der Netzneutralität darf es hier keine verschiedenen Serviceklassen bei Netflix geben.
(Hinweis: Dieser Eiwand von mir hinsichtlich VPN gilt selbstverständlich nur für die Server, die sich an die deutschen Verbraucher wenden.
Dies gilt also nicht für die Server von Netflix, die sich an Ausländer richtet, wie das Netflix Angebot aus den USA.
Allerdings nehme ich an, dass gleiches auch für alle Server gilt, die Netflix für Nutzer in der EU betreibt.
Mit "Nutzer in der EU" ist jeder gemeint, der sich innerhalb der Grenzen der EU aufhält, sei es als Bürger eines EU-Landes,
Tourist oder sonstiger Ausländer, unabhängig ob der Aufenthalt legal oder illegal ist.  Die DSGVO unterscheidet da IMHO nicht.)

Was ist passiert?  Auf einem von mir genutzten Smart-TV erschien plötzlich die Frage, ob ich auf Reisen bin!?!
Nur auf diesem einem Gerät.  All die anderen Geräte fragten das nicht.

> Wenn es nur eine Stichprobe war, ist es unzulässig.  Siehe oben, fehlende Freiheit keine Angabe zu machen.  
> Wenn es nur ein Experiment war, ist es (um mit Dr. Seltsam zu sagen) noch unzulässiger,
> denn dazu wäre es notwendig, vorher explizit die Zustimmung zu solchen Experimenten einzuholen.

WAS HAT ES BITTE EINEN STRAMINGDIENST ZU INTERESSIEREN, WELCHE GERÄTE ICH WIE UND MIT WELCHER IP VERWENDE?

Ich bezahle den Dienst.  Und ich nutze den Dienst auf zulässige Weise.  Außerdem verwende ich schon das "Maximalabo", mehr geht einfach nicht.

Es ist nicht ersichtlich, dass dazu irgendeine weitere Datenerhebung als die minimal notwendige erforderlich wäre.

Insbesondere dass sie überwachen, wann, wo, wie und wie oft ich auf welchen Geräten ihren Dienst nutze,
das ist für die Bereitstellung des Dienstes ABSOLUT NICHT NOTWENDIG und NICHT DARSTELLBAR.
(Das mag er Vertrieb von Netflix anders sehen.  Einen technischen Grund dafür gibt es jedenfalls nicht.)

Dass sie im Bedarfsfall bei TECHNISCHER Notwendigkeit erweiterete Daten erfassen, geht in Ordnung.  Das mache ich auf meinen Diensten auch um Problemen nachzuspüren.  
Dass sie derartige Daten evtl. in pseudonymisierter Weise erfassen, um statistische Auswertungen wirtschaftlicher Natur zu machen, ist von der DSGVO gedeckt (denke ich jedenfalls).  
Darum handelt es sich hier aber eben genau nicht.  Es handelt sich um eine (meineserachtens) unzulässige Überwachung der Bürger,
weil Netflix alle seine Nutzer unter Generalverdacht stellt, gegen ihre Nutzungsbedinungen zu handeln
(unerheblich davon, ob diese Nutzungsbedingungen in dieser Form überhaupt deutschem Recht entsprechen oder nicht.
Es geht mir hier nicht um die Verbraucherrechte, sondern ausschließlich um den Datenschutz.
Evtl. aber wäre das auch für die Verbraucherorganisationen und Kartellbehörden interesseant.
Der EuGH hat zu letzterem gerade ein entsprechendes Urteil gefällt).

Genauso wie die Vorratsdatenspeicherung für Deutschland unzulässig ist, muss dasselbe genauso für Dienste wie Netflix gelten.
Während aber die VDS nur die IP (nicht die Inhalte) erfassen soll, erfasst Netflix für seine (ihre?) Zwecke deutlich mehr weitergehende Daten
wie z.B. das Gerät auf dem gerade Netflix läuft.

Netflix verarbeitet dabei eben nicht nur die IP.  Ein anderes Gerät, mit derselben IP und demselben Account, hatte keine Einschränkungen!
Das beweist, dass Netflix eben deutlich mehr als nur die IP zu diesem Zweck erfasst und verarbeitet hat.
Wie geschrieben, pseudonymisiert zu statistischen Zwecken wäre das OK.

Nicht in Ordnung ist es in meinen Augen aber, diese Daten mit dem Account zusammenzuführen.
Jedenfalls nicht ohne Widerspruchsrecht ähnlich einem Cookie-Banner (Tracking).
Daraus dann noch eine Abfrage zu bauen, die einem keine Wahl mehr lässt, macht daraus (für mich) eine offensichtliche Vorsätztlichkeit.

Ich kann es nicht beweisen.  Aber für mich ist erwiesen, dass Netflix hier nur grob illegale Methoden verwenden kann,
um genau das zu erreichen, was sie da gemacht haben.  Für mich ist deutlich mehr als nur ein bloßer "Anfangsverdacht".

Mir war bewusst, dass Netflix meine IP bekommt.  Mir war aber nicht bewusst, dass Netflix sich die Freiheit herausnimmt,
ggf. Einblick in intimsten Daten zu nehmen indem diese Daten mit dem Nutzer zusammengeführt werden.

Die Information, wo ein Device steht, was es für ein Device ist und wann ich es wie verwende, das sind u.U. sehr intime Details.

Notwendigerweise erfährt Netflix natürlich, wann ich ihren Dienst nutze.  Das kann man nicht verhindern.  
Notwendigerweise erfährt Netflix meine IP.  Das ließe sich durch die explizite Erlaubnis von VPN verhindern.
(In allen meinen im Internet bereitgestellten Diensten ist die Nutzung von VPNs deshalb explizit erlaubt,
so setze ich nämlich als Einzelkämpfer das in der DSGVO geforderte Widerspruchsrecht TECHNISCH um.)

Aber schon die Erfassung, um welches Device es sich handelt (ich bin mir ziemlich sicher,
Netflix unterscheidet hier "zur Verbesserung des Nutzerergebnisses" zwischen Laptop, Browser, Smart-TV und Firestick)
und wo (IP-mäßig) sich ein Device befindet,  
um dann zu fragen, ob das Gerät zum Haushalt gehört oder ich auf Reisen bin,  
das verlagert auch die (wenigen) technisch (absolut) notwendigen Daten in den intimsten Bereich der Lebensführung.

Netflix verwandelt somit unabdingbar notwendigen Daten unnötigerweise in plötzlich besonders durch die DSGVO geschützte intime Daten!
Mir fällt jetzt beim besten Willen kein Grund ein, wie jemand ein derart dummes Handeln vor seinen Anteilseignern rechtfertigen will.
Aber vielleicht verstehe ich die Motivation von Netflix einfach auch nur grundlegend falsch.

Denn intime Daten sind durch die DSGVO besonders geschützt und erfordern weitere harte Datenschutzmaßnahmen auf Seite von Netflix
(die IMHO Netflix sicher nicht erbracht hat, dann wäre ihnen aufgegangen, dass diese Datenverarbeitung das zulässige Maß überschreitet).

Bei mir stehen TVs jedenfalls auch in den Schlafzimmern.  Wenn Netflix trackt, was für ein Device jemand gerade nutzt,
ob es zum Haushalt gehört oder gerade jemanden anderes besucht wird, so dringt das mit ziemlicher Sicherheit
IN UNZULÄSSGER WEISE IN DIE INTIMSTE PRIVATSPHÄRE ALLER BÜRGER ein.

Zwar ist es vielelleicht nicht so, dass Netflix jetzt tracken will,
wer gerade mit wem schläft oder wer gerade (während er seinen Netflix-Account nutzt) bei welcher Hure zu Gast ist.
Aber genau das geben die Daten her!  Man muss sie nur statistisch auswerten und mit
\- frei zugänglichen Verzeichnissen wie Google Maps - abgeleichen.

Für die DSGVO ist nicht relevant, ob das gemacht wird.  Es ist nur relevant, ob das gemacht werden kann.

Bei mir trifft das zwar gerade nicht zu.  Aber wenn jemand z.B. seinen Netflix-Account auf das Smart-TV seiner Freundin installiert
und dann immer nur nach (oder während) des Sex Netflix laufen lässt (das ist nur eine theoretische Überlegung),
so könnte Netflix das - mit statistischen Methoden - ermitteln.
Und ich bin mir sicher:  Die Anzahl der Menschen, die sich so verhalten, ist größer als 0.
Das ist also mit ziemlicher Sicherheit schlicht die Wirklichkeit, in der wir leben.
Und, egal was man davon halten mag, genau vor solcher Ausspähungen muss uns die DSGVO schützen!

Und das zu tun ist (Stichwort KI und Big Data) heuzutage überhaupt kein Thema mehr.
Dazu ist sogar (Stichwort Chat GPT) nicht einmal mehr ein besonderes Fachwissen notwendig.
Alles, was man dazu braucht, ist der Datentopf, mit den Daten, die Netflix sich erlaubt,
rein nur zu ihren ureigensten Zwecken zu erfassen, um sie gegen den Nutzer in Stellung zu bringen.
(Aus genau diesem Grund halte ich die Verarbeitung dieser Daten für hoch-illegal.)

Sollte Netflix behaupten, diese Daten zu pseudonymisieren, DANN LÜGT NETFLIX.

Denn gemäß DSGVO existiert dann notwendigerweise ein Verzeichnis, das diese Daten depseudonymisiert und dem Netflix-Account zuordnet.
Anderenfalls könnten sie auf dem Gerät keine entsprechende Anfrage einblenden, ob das Gerät zum Haushalt gehört oder man auf Reisen ist. 

Aufgrund Google existiert ein weiteres Verzeichnis, das den Standort des Geräts oft sogar auf wenige Meter eingrenzen kann.
Es ist UNERHEBLICH, ob Netflix das Verzeichnis nutzt.  ERHEBLICH ist, dass man mit dessen Hilfe und den so erhobenen Daten
EINBLICK IN INTIME PRIVATE DETAILS nehmen kann (Netflix wendet sich ja nicht an Firmen sondern vornehmlich an Bürger).
Wenn die DSGVO irgendetwas wert ist, dann darf das großen Unternehmen wie Netflix nicht erlaubt sein.  Insbesondere den Platzhirschen nicht!
Und erst Recht nicht ohne adäquate Widerspruchsmöglichkeit (Netflix nicht zu nutzen ist nicht adäquat).

Alleine dass man nur die Wahl zwischen 2 Möglichkeiten hat und nicht die Möglichkeit hat,
"keine Angabe" zu machen, halte ich für einen eklatanten Verstoß gegen die DSGVO.
(Gem. DSGVO hat die Erfassung solcher Informationen FREIWILLIG zu erfolgen, hier fehlt nicht nur das,
sondern auch die Möglichkeit des WIDERSPRUCHS)

Alleine schon, dass ein Unternehmen auf die Idee kommen könnte, eine Anfrage in dieser Form zu stellen,
also dem legitimen Nutzer quasi die Pistole auf die Brust zu halten um aus ihm Informationen herauszupressen,
halte ich für eine äußerst unverschämte Frechheit!  Dass sie das dann auch noch in die Tat umsetzen,
muss man IMHO schon als maffiös bezeichnen (Der Pate: "Ich habe einen Vorschlag den Du nicht ablehnen kannst").

-------

Des Weiteren (Streiflicht VPN):

Firmen wie Netflix haben - aufgrund der IP - eine sehr genaue Vorstellung davon - oft auf ein paar Meter genau - wo man sich gerade befindet.
Grund sind Geolocation-Dienste wie Google sie anbietet.  Das lässt sich nicht ändern, da man ja auf die IP nicht verzichten darf.
Netflix verbietet aber die Nutzung von VPNs.  Das alleine halte ich aus diesen Gründen sogar für absolut unzulässig.

In Deutschland gehört (gem. EuGH) die IP zu den personenbezogenen Daten.  Die IP ist zur Erbringung der Leistung notwendig.
Durch die Nutzung von VPNs kann man die IP verschleiern und so dem Personenbezug widerprechen.

Was nicht ganz stimmt.  Auch VPNs können zur Herausgabe der Daten gezwungen werden, und man kann so den Nutzer widersprechen.
Das ist aber IMHO kompliziert genug, dass dies in so gut wie allen Fällen unterhalb organisierter Kriminalität und Terrorismus
nur selten erfolgen dürfte.  Sprich, insgesamt ist der Bürger bei Nutzung von VPNs vor Tracking sicher(er).
Und das dürfte hinsichtlich Netflix ausreichen um dem Widerspruchsrecht der DSGVO in Sachen IP zu genügen.  (Meine Meinung jedenfalls.)

Dass VPNs kostenflichtig sind (kostenfreie VPNs dürften für Streaming von Netflix jedenfalls keine Rolle spielen), das ist hier kein Hinderungsgrund.
Auch der Internetanschluss kostet Geld, ein zusätzliches Abonnement eines VPN kostet dazu vergleichsweise wenig.
Diese "notwendige Mitarbeit" der Nutzer eines Dienstes beim Widerspruch (also die Nutzung eines bezahlten VPN) kann man deshalb erwarten,
genauso wie man erwarten kann, dass die Nutzer über einen (bezahlten) Internetanschluss verfügen.
(Bei Nutzung eines freien wLAN dürfte es eh keinen Personenbezug geben, ein VPN ist dann nur zur Sicherheit anzuraten.)

Die DSGVO erfordert jedenfalls eine (risikofreie und nichtdiskriminierende) Widerspruchsmöglichkeit.
Wenn die Nutzung von VPNs eingeschränkt wird, schränkt dies die (effeltove) Widerspruchsmöglichkeit ein.
Lies:  Sie als Datenschutzbehörde sollten das Diensten wie Netflix gegenüber bitte so deutlich klarstellen,
dass diese nicht einmal auf die Idee kommen, VPN-Nutzer als Nutzer zweiter Klasse zu behandeln.
Denn ich kann mir keine andere Möglichkeit vorstellen, wie ein Nutzer auf sichere Art und Weise der Nutzung der IP widersprechen kann.
Alles andere benötigt das Vertrauen auf den Anbieter.  Dieses Vertrauen hat Netflix bei mir jetzt eindeutig verspielt.

Die DSGVO muss den Nutzern auch eine Schutzmöglichkeit bieten, die Anbieter wie Netflix nicht grundlos einschränken dürfen.
Der Grund muss dabei sehr hoher Natur sein, wie z. B. eine Gefahr für Leib und Leben bei Missbrauch mittels VPN.
Dieses Level dürften einfache kommerzielle Diente im Internet, solche wie Netflix, aber regelmäßig nicht erreichen können.

Wieder nur meine Meinung, aber auch meine Hoffnung.  Denn alles andere führt meineserachtens direkt in den Abgrund.
Und aus mir spricht mehr als 30 Jahre detaillierte und tiefste Erfahrungen mit dem Internet, Netwerken, Internetprotokollen,
Computer und Unix.  Allerdings habe sehe ich das alles nur aus meiner eigenen, ganz speziellen und rein technischen Blickrichtung.

Ich jedenfalls werde jetzt die Nutzbarkeit von VPN für Netflix für mich eruieren.
Alles, was es dazu in Sachen Datenschutz zu sagen gibt, habe ich hier aber bereits gesagt, ist also schon Teil dieser Beschwerde.

