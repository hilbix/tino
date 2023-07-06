# NetFlix

Hallo Netfli auch.

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

T.B.D.
