# Plattform

Hier mache ich mir Gedanken, wie ein brauchbares Account-Management einer Plattform aussehen müsste.

## Grundlagen

Stellen wir uns eine Internetplattform vor.  Diese bietet selbstverständlich einen Login an.  Folgende Dinge sind dann zu bedenken:

- DoS (jemand versucht die Plattform zu stören)
- Brute Force (jemand probiert Passworte durch)
- MitM (AKA Transportverschlüsselung)
- Passwortsicherheit (die Passworte bekommen Beine)
- Exploit-Schutz (Anwender hat einen Exploit den er nicht bemerkt)
- Funktion (wenn die Plattform unter starkem Beschuss ist können die Nutzer trotzdem eingeschränkt weiterarbeiten)
- DSGVO (allgmein: Härtestes Einhalten vom Datenschutz)
- Escrow (aka: Passwort-Rücksetzung)
- Integration (leicht nutzbare API)

Das ist eine ganz schöne Menge an Dingen die so eine Plattform braucht.

Habe ich was vergessen?

- 2FA (sprich: Absicherung vom Account)
- OAUTH (Integration von Drittservices)
- uvm. (vermutlich)


## Basis-Setup

Fangen wir mit dem Basis-Setup an.

### IP

> **In Deutschland ist die IP ein personenbezogenes Datum, das erst nach erfolgter Aufklärung verwendet werden darf!**

Heutzutage braucht man IPv4 und IPv6.  Beides ist leicht zu bekommen und kann, über einen zentralen Loadbalancer (**LB**) leicht umgesetzt werden.

Hinter dem Loadbalancer muss die IP des Nutzers nicht mehr verwendet werden, da die Plattform nur mit den Loadbalandern spricht.

> Ein Loadbalancer ist also inzwischen ein Tool zur Einhaltung der DSGVO.

Sofern man den Loadbalancer nicht selbst betreibt, sondern das einem ISP überlässt, und selbst keinerlei Zugriff auf die Deanonymisierung erhält,
wird der Datenschutz hinsichtlich IP auf der eigenen Seite damit eingehalten.

> Ohne IP gibt es im Internet allerdings keine Kommunikation

Im Weiteren gehe ich davon aus, dass man den Loadbalancer selber betreibt, da das Gegenteil (Datenkrake!) meist schlechtere Ergebnisse für den Datenschutz bedeutet.

> CloudFlare ist eine Datenkrake.  Wer CloudFlare in Deutschland vorschaltet, der muss schon einen guten Grund dafür haben.
>
> Ein akuter DDoS ist solch ein guter Grund.  Eine möglicher DDoS-Schutz hingegen nicht.  Man kann das hohe Gut "Datenschutz" nicht der Bequemlichkeit opfern.
>
> Das bedeutet aber nicht, dass man CloudFlare nicht nutzen darf!  Nach Zustimmung des Nutzers ist das in Ordnung.
> Bei der Zustimmung bitte immer die Freiwilligkeit beachten!
> Freiwilligkeit bedeutet auch, dass der Nutzer jederzeit widerrufen kann ohne dadurch Nachteile zu erleiden.

Wer den Dienst so gestaltet, dass er ohne Zustimmung nur eingeschränkt genutzt werden kann, der gängelt den Nutzer und widerspricht damit der Freiwilligkeit!

- "Wenn Sie nicht zustimmen, können Sie den Dienst nicht nutzen" entbehrt jeglicher Freiwilligkeit.
- "Wenn Sie Werbung zustimmen, können Sie den Dienst nur durch Bezahlung nutzen" ist sogar eine direkte (IMHO strafbare) Erpressung!
- "Wenn Sie nicht zustimmen, wird der Dienst für sie eingeschränkt" entbehrt ebenso der Freiwilligkeit.
- "Wenn Sie nicht zustimmen kann es zu Einschränkungen des Dienstes kommen" ist in Ordnung, wenn der Dienst ansonsten nicht eingeschränkt ist.

> Bitte nicht missverstehen!  **Kostenpflichtige Dienste im Internet sind in Ordnung!**
>
> Das darf aber nicht zu Lasten des Datenschutzes gehen!  Nach meiner Lesart der DSGVO ist es (sogar recht eindeutig) verboten, mit Daten zu bezahlen,
> da dies eben genau dem Anspruch auf Kontrolle der Daten widerspricht der in der DSGVO nidergelegt wurde.
>
> Sprich: Ich darf selbstverständlich ein rein kostenpflichtiges Angebot bereitstellen.
>
> Aber ich darf niemandem "zusätzlich" den "freiwilligen" Zugang dadurch gewähren, dass der Nutzer Cookies oder Werbung akzeptieren muss.
> Das stellt recht deutlichen Zwang im Sinne der DSGVO dar und widerspricht jeglicher Freiwilligkeit.
>
> - Wenn die Leute **ablehnen** darf ich ihnen **willkürlich Benefits** versprechen aber nur **unwillkürliche Einschränkungen**.
> - Wenn die Leute **zustimmen** darf ich ihnen nur **unwillkürliche Benefits** versprechen, aber **willkürliche Einschränkungen**.
>
> Nur sorum bleibt die Zustimmung gem. DSGVO freiwillig, alles andere stellt - für mich klipp und klar - Erpressung dar.
>
> Wer dann sagt "aber ohne Werbung kann ich meinen Service nicht mehr anbieten und muss schließen (träneausdrück)", ja, sorry, Pech gehabt!  
> Entweder **geh sterben** oder packe den gesamten Dienst hinter die Paywall ohne "freien" (er ist ja nicht frei!) Zugang per Werbung.  
> **So einfach ist das!**  Wenn das Deinem alten Geschäftsmodell nimmer entspricht, dann ist das halt jetzt ein rein hochillegales Geschäftsmodell.  
> Punkt aus und Ende.  War halt eine blöde und falsche unternehmerische Entscheidung das Business auf diesen Annahmen zu gründen.  
> Was früher als gesellschaftsfördernd angesehen wurde kann heute plötzlich (aus gutem Grund) illegal werden.  
> Im Mittelalter war die Vermietung von Kindern für Sex ja auch gesellschaftlicher Usus.  Jetzt trifft es halt z. B. Zeitschriften.
>
> Dafür gibt es von mir absolut keinerleit Mitleid, ehrlich nicht einmal ein Quentchen!  Um es ganz klar und ungefiltert auszudrücken:  
> **Ihr seid dumm, ihr seid überholt, verschwindet bitte aus meinem Netz ihr Arschlöcher!**  Je schneller, je lieber!  
> Ende der Durchsage.
>
> Es darf einfach nicht sein, dass derartige Raubmörder (sie rauben Daten und morden den Datenschutz) ihren Beruf weiter ausüben.
> (Wer seinen Service uneingeschänkt zur Vefügung stellt, der ist von dem hier selbstverständlich nicht betroffen.)
>
> Fun Fact:
>
> **Heise funktioniert bisher uneingeschränkt**, wenn man weiß, wie.  Ich habe gar nicht bemerkt, dass sie jetzt auch ein "Plusabo" anbieten.
> **So lange das so bleibt, habe ich dagegen überhaupt nichts einzuwenden.**  Es ist zwar nicht nett, Dumme im Internet abzuzocken (und nichts anderes ist
> solch ein Plusabo), aber hey, so lange es mich nicht betrifft darf jeder wie er lustig ist.  
> Aber sollten sie das jemals ändern, gibt es von mir vermutlich umgehend eine **begründete** Beschwerde beim zuständigen Amt für den Datenschutz.
> Aus bestimmten Gründen nehme ich aber an, dass Heise das ganz bewusst macht.  So lange Sales dort den Verlag nicht kaputtmacht, dürfte das bestehen.

Wer die Weitergabe der IP an YouTube ablehnt (das ist nach meiner Lesart zwingend zustimmungspflichtig), der kann selbstverständlich YouTube nicht nutzen.
Mit solch einer Einschränkung muss man dann halt leben, und evtl. auf die stimmungsvollen Cut-Scenes verzichten, sofern das nicht weiter relevant ist.

> Das Spiel kann ja problemlos ein Transkript oder Podcast anbieten.
>
> Das ist auch anderweitig gut, Stichwort Accessibility, so können Blinde im Transkript lesen, was sie im Video nicht sehen können.
>
> Es *ist* so einfach.  Datenschutz, richtig gedacht, hilft benachteiligten Menschen!  
> Und jeder ist irgendwo irgendwie benachteiligt!  Das ist also der Normalzustand!
>
> (Ich möchte deshalb nicht behindert schreiben.  Wenn man Defekte, wie fehlendes Augenlicht, Dummheit etc., als Behinderung einstuft,
> dann ist genau genommen jeder Mensch irgendwo behindert.  Ich sehe z. B. Farben anders als andere, für mich ist oft gelb was für andere grün ist.
> Vermutlich haben die eine Gelb-Grün-Schwäche und erkennen Gelb nicht am Farb- sondern Grauton.  
> Sind nun die behindert oder bin ich es, weil ich durch etwas "unnötiges" abgelenkt werde?  
> Oft ist die Behinderung sogar nur eingebildet, anerzogen oder fehlgesteuert.  Erst seitem der Himmel als blau definiert wurde,
> können die Menschen diese Farbe wahrnehmen.  Physisch haben wir uns aber nicht verändert.  Bevor wir gelernt hatten,
> die vorhandenen Sinneseindrücke zu klassifizieren, war es uns unmöglich, diese zu unterscheiden.  
> Siehe Umami.  Ich kanns nicht schmecken, wenn man sich darauf trainiert kann das aber so gut wie jeder Mensch lernen,
> denn eigentlich jeder Mensch hat dafür Rezeptoren, nur ist man nicht darauf trainiert, das separat herauszuschmecken!)

- Wenn nun ein Spiel aber nur dann spielbar ist, wenn man das YouTube-Video ansieht, der macht etwas grundfalsch.
- In diesem Fall muss der Dienst das Video auch außerhalb von YouTube zum Abruf bereithalten und diese Möglichkeit brauchbar gestalten.
- In Ausnahmefällen (aber wirklich nur solchen) kann es dann zu Einschränkungen kommen (beispielsweise der Server geht hopps bis er wieder zeitnah repariert wird)

Fazit hier:

- Die IP wird am LB terminiert.
- Dahinter verwendet man seine eigene IP.
- Man kann auch Rauchzeichen verwenden, vollkommen wurscht.

Und technisch?

**Technisch darf man die Nutzung von Anonymizern (wie ToR) nicht einschränken**,
weil man sonst dem Nutzer die Möglichkeit nimmt, sich der Preisgabe der personenbezogenen Daten zu entziehen.

> Merke: Personenbezogene Daten wie die IP darf man erst nach Aufklärung verwenden.
>
> Es besteht also ein eindeutig ausgesprochenes Verbot, die IP zur Aufklärung zu verwenden.
> Jetzt pauschal zu sagen "ja aber ohne IP kann man es im Internet ja nicht anders machen" zeigt,
> dass man eben nicht gewillt ist, sich an die DSGVO zu halten, weil man es sich entschieden zu einfach macht!
>
> Einzig richtig wäre die Aussage:  Besser als wie wir es tun, kann man es technisch unmöglich umsetzen!  
> (Und dann muss man jederzeit den Beweis führen können, dass es technisch wirklich nicht besser geht!)
>
> Das, und nur das, ist IMHO die einzige zulässige Art und Weise, dass man es machen darf.
>
> **Ich hoffe allerdings auf eine dauerhafte Duldung von Altservices,
> die in Grauer Vorzeit des Internets auf Basis des BDSG entstanden sind,
> so lange diese in unveränderter Form weiterhin bereitgestellt und genutzt werden.**
>
> Das gilt aber sicher nicht für neue Services, die jetzt entstehen und somit der DSGVO Rechnung tragen müssen!
>
> Und das sollte auch nicht für Services gelten, die (abseits vom Unabwendbaren) Veränderungen erfahren,
> z. B. ein Rebranding durch einen Verkauf.  Altservices sollten so lange NICHT Bestandteil eines Kaufs sein dürfen,
> wie sie noch nicht auf den aktuellen Level des Datenschutzes angehoben wurden.
>
> Auch nicht dulden darf man Services, die schon zu Zeiten des BDSG nicht alle Bedingungen
> dieses in vielen Bereichen laxeren Gesetzes einhielten.  Man sollte sie also am alten BSDG messen.
> Halten sie das ein - bis auf unerwünschte offensichtlich unabsichtliche Fehler - sollte das BDSG
> weiter gelten können, sofern ein Anheben auf die DSGVO den Tod der Altplattform bedeutet.
>
> Ich habe gleich mehrere solche Altservices die zwar das BDSG (akribisch!) einhalten,
> aber aufgrund der Art und Weise, wie sie die IP verwenden, jetzt gegen die DSGVO verstoßen,
> und auch nicht (ohne die Services vollständig zu zerstören) entsprechend angepasst werden können
> (jedenfalls habe ich mir viel Gedanken gemacht und habe bisher keine Lösung dafür gefunden,
> außer halt solche, die einige der Garantien der Altservices zerbrechen, dadurch entweder
> einen vollkommen neuen Service kreieren würden, oder dieser schlichtweg zum Nachteil aller sterben müsste.
> Nein, halt, falsch, das wäre mein Vorteil, weil ich den Scheiß nimmer betreiben müsste.
> Hm, aber warum tue ich es dann?  Ganz einfach:  Weil ich kann!  Denn wenn die, die es können, es nimmer tun, wer macht es dann?  Na?  Eben!).

**Anonymizer wie ToR auf der Plattform zu verbieten wäre nach meiner Lesart ein direkter (und harter) Verstoß gegen die DSGVO!**

> Aufgrund des oben gesagten unterstützen alle meine Altplattformen uneingeschränkt die Nutzung auch mit anonymer IP.

Wer Anonymizier nutzt kann selbstverständlich zusätzliche Einschränkungen erleiden, sofern dies rein technisch nicht anders machbar ist.

> Beispielsweise Region-Lock.  Man darf bestimmte Inhalte z. B. nur an deutsche IPs ausliefern.
>
> In diesem Fall ist es nicht in Ordnung, pauschal Anonymizer auszusperren, sondern man muss dem Nutzer eine Möglichkeit geben,
> die Inhalte abzurufen, wenn er dieser Region angehört.
>
> Denn genau umgekehrt wird ein Schuh draus!  Man hat sich vertraglich dafür verpflichtet, die Inhalte nur den Nutzern einer Region zur Verfügung
> zu stellen.  Aber genau das stellt man nicht dadurch sicher, dass man die IP mit irgendwelchen Geo-IP-Datenbanken abgleicht.
> Denn Leute können Proxy-Services (AKA VPN-Provider) innerhalb der Region nutzen, um außerhalb der Region zuzugreifen.
>
> Sprich, macht man schon solch einen Mist mit Region-Lock, dann muss man das anders gewährleisten und kann es eben gerade nicht an der IP festmachen.
>
> Wenn der Eigentümer der Inhalte sich mit solch einem Schmuh wie Geo-IP-Datenbank zufrieden gibt, sollte man ihn lieber links liegen lassen.
> Das ist nämlich höchst unseriös und widerspricht - nach meiner Lesart - eindeutig der DSGVO (Diskriminierungsverbot).
>
> Apropos Diskriminierung.  Ist "links" liegen lassen nicht irgendwie diskriminierend?  Von Rechts wegen .. ach lassen wir das.


### DNS

Um eine Plattform anzusprechen braucht es (heutzutage, noch) immer eine DNS-Auflösung, damit der Nutzer diese ansprechen kann.

Wie man den DNS absichert ist hier nicht beschrieben.  Die Lösung vom DNS ist in der Regel, dass man diesen nicht selber macht,
sondern einen DNS-Dienstleister verwendet wie z. B. CloudFlare (das dürfte im kostenlosen Tier enthalten sein).

> Cloudflare ist eine Datenkrake.  Kann ich die gem. DSGVO verwenden?
>
> Bedenken sind ja, dass **vor Abgabe der Aufklärung** von mir die personenbezogene Daten nicht verwendet werden dürfen!
>
> DNS erfüllt diese Bedingung perfekt.  Grund:  Der Nutzer fragt die DNS von CloudFlare ja nicht direkt,
> sondern seinen Resolver.  Dieser fragt normalerweise die Resolver vom ISP, usw.  Sprich, CouldFlare
> sieht die IP vom Nutzer gar nicht.  DSGVO ist somit eingehalten.  Wer Pi-Hole nutzt, der dann direkt
> CloudFlare-DNS fragt und somit die IP exponiert, der weiß was er tut, den muss ich nicht entsprechend vorher aufklären.

DNS ist der erste Schritt für das Loadbalanding.
Indem man einem Service mehr als 1 IP zuweist ergibt sich eine natürliche Form der Lastverteilung (Round Robin).

Wichtig an dieser Stelle ist, dass man wenig Einfluss auf die Verteilung nehmen kann, und Clients die Tendenz haben,
zwar an einer IP zu "kleben", aber genau im ungünstigsten Moment werden sie die IP wechseln.  Sprich, mit welcher IP
der Client spricht ist nicht vorherstimmbar.

Bei kleinen Setups (bis 100 Requests/s bzw. bis 500 MBit/s) reicht in der Regel 1 IP aus.
Darüber sollte man dann langsam hochskalieren.

Außerdem ist es ggf. sinnvoll, nicht allen Traffic über ein einziges URL abzuhandeln, sondern über mehrere verschiedene URLs.

> Damit meine ich natürlich nicht CDNs.  CDNs benötigen die Zustimmungslösung, weil man bei CDNs die IP an Dritte weitergibt.

Im Weiteren gehe ich davon aus, dass eine Plattform aus mindestens folgenden URLs besteht:

- example.com und www.example.com das HauptURL, das die User ansurfen
  - Warum immer dieses `www?`  
    Ja, ich weiß, Konvention.  
    Ja, ich weiß, Domains.  
    Ja, ich weiß es doch!  
    Aber genau deshalb die Frage: Warum immer dieses `www.`?  
    Wäre etwas wie homepage.example.com nicht sinnvoller?
  - Dieses URL wird hier im Text nebenher behandelt, da es für die erste Kontaktaufnahme notwendig ist
- api.example.com das eine interne oder externe API anbietet
  - Unter jeder Domain kann es Spezialisierungen geben können wie v1.api.example.com
  - Eine Spezialisierung auf Kunden wie c1.api.example.com ist zwar möglich,
    pseudonyme Daten haben im DNS aber gemeinhin nichts verloren,
    da man diese per Korrelation depseudonymisieren könnte.
  - Dieses URL wird hier im Text nebenher behandelt, da es intern eine Rolle spielen wird
- login.example.com für das Loginmanagement
  - Dieses Ding verwaltet die Logins, also Authentikation
  - Um dieses URL geht es in diesem Text eigentlich hauptsächlich
- accounts.example.com für das Accountmanagement
  - Dieses Ding verwaltet alle Nutzerdaten, also Accounting
  - Accounts und Logins sind technisch, logisch und rechtlich unterschiedliche Dinge
  - Um dieses URL geht es in diesem Text ebenso
- forum.example.com das Nutzer- zu Nutzer-Forum (C2C)
  - **Wenn man sich so etwas tatsächlich antun will**
  - Ich empfehle es wegzulassen wenn irgendwie möglich.
  - Can of worms.  Ein stetiger Quell der Belastung.
  - Erfordert zwingend Moderation
  - Sollte man zwingend hinter einem Login verstecken, also nicht öffentlich zugänglich machen.  
  - Aber wunderbar für Marketing und andere Krakenoperationen wie Communitybildung.
  - Hier predige ich also genau das Gegenteil dessen, was heute allgemeiner Usus ist.
  - Es gibt aber genügend Alternativen, über die man so etwas handhaben kann, z. B. Facebook Communities.  
    (Wie kann es eigentlich sein, dass das Leute nicht nur zufriedenstellt, sondern die sogar darauf abfahren?)
- support.example.com mit dem Supportforum (B2C)
  - Ein dediziertes Supportforum für die Nutzer
  - Um dieses URL geht es in diesem Text eigentlich nicht
  - Dies ist erst einmal primär unabhängig von login.example.com und accounts.example.com, denn diese können ja Störungen aufweisen!
  - Aber es sollte eben auch kein eigenes Account-Management enthalten, weil das ein Henne-Ei-Problem verursacht
  - Gibt es bis heute leider nicht in brauchbarer Weise.  Weil die Leute anscheinend grundsätzlich falsch drangehen.
  - Dazu unten mehr
- wiki.example.com ein Wiki.  Braucht man.
  - Mein Lieblingsspruch dazu: Ein Wiki mit Login ist wie Sex ohne Orgasmus.
  - Aber "frei editierbar" hat nichts mit "jeder kann ein Ei legen das dann jeder sehen kann" zu tun.  
    Wer bitte hat solch ein Gerücht in die Welt gesetzt?
  - Wenn man es falsch macht: Can of worms.  Ein stetiger Quell der Belastung.
  - Wenn man es richtig macht: Absolut hilfreich und sehr praktisch.
  - Bis heute gibt es keine sinnvoll verwendbare Wiki-Software, alles, ohne Ausnahme, ist komplett kaputtprogrammiert.
  - Dazu unten mehr
- status.example.com mit einem Statusmonitor für User
  - Hierüber kann man detailliertere Informationen über Störungen usw. verlauten lassen
  - Dies ist eine reine Standseite mit Zusatzinformationnen
- **TODO** hier fehlt noch was

### AAA

AAA steht für Authentikation, Authorisierung und Accounting

Diese drei Dinge kann man wunderbar getrennt halten, und sollte das auch.  Denn sie spielen zwar zusammen, sind aber vollkommen getrennte Dinge.

Meistens aber werden die Dinge nicht nur in einen Topf geworfen, die meisten Systeme gehen noch weiter und vermengen das bis zur Unkenntlichkeit
mit anderen Sachen.  Und schwupps haben wir den Salat.

Authentikation in ihrem eigentlichen Sinne gibt es nicht.  Nichts ist erst einmal per-se authentisch, Authentizität kann man weder erzwingen noch sinnvoll prüfen.
Deshalb arbeitet man hier mit einem wesentlich schwächeren Mechanismus, einem Authentikationsprovider.

Ein solcher Authentikationsprovider kann folgendes sein (aufsteigende Güte, absteigende Praktikabilität):

- Username+Passwort, die schwächste und schlechteste Form überhaupt
- Mailadresse+Passwort, deutlich besser, aber nur, weil es das Sankt-Florians-Prinzip verwenden kann und die Problematik auf das Mailsystem abwälzt
- 2FA wie FIDO, TOTP, Yubikey
- Token, eine generierte ID (Geräteschlüssel, API-Key), [siehe auch Token Binding](../wtf/rfc8473-token-binding.md)
- Public Key (die vermutlich beste Form)

Das sind alles nur Stellvertreter einer realen Authentikation, selbst wenn man die Registrierung von etwas wie PostIdent abhängig macht!

- Technisch kann eigentlich nur der ePerso eine wirkliche Authentikation bereitstellen.
  - Aber auch nur dann, wenn vor-Ort eine entsprechende Infrastruktur vorhanden ist.
- Oder man schickt das Token per Brief mit einer angehängten PostIdent-Überprüfung
  - Das Token darf man dann aber nicht mehrfach verwenden, sonst kann es schon wieder missbraucht werden

Sprich, wenn wir von Authentifikation ausgehen, sprechen wir meisten von einem Stellvertretrermechanismus (also Proxy) bzw. einem Authentikationsprovider.

Es ist deshalb absolut sinnvoll, diesen getrennt von allem anderen zu halten.  Das ist login.example.com.

Authorisierung baut auf der Authentikation auf, hat selbst aber nichts mit der Authentifikation selbst am Hut.

- Rein technisch macht jedes System selbst diese Autorisierung.  Es prüft also die Authentikation und erlaubt von dieser ausgehend den Zugriff.
- Um die Sache technisch zu vereinfachen würde ich die Autorisierung aber nicht von der Authentikation, sondern von dem Accout abhängig machen.
- Das ergibt dann ein ganz natürliches Accounting und auch eine ganz natürliche zentralisierte Datenhaltung.
- Sprich, um die Datenauskunft zu erteilen muss ich nicht jedes einzelne System selbst befragen, dafür reicht dann das Accounting.
  - Systeme haben auch die Eigenschaft, dass sie sich verändern.  Ich muss mich dann nicht mit Systemveränderungen rumschlagen.

Ich habe also folgende Reihenfolge:

- Authentikation
- Account
- Autorisierung

Aber ganz so einfach ist das nicht.  Der Account kann mehr als eine Authentikation haben.
Und von der Form der Authentikation geht dann evtl. eine andere Autorisierung hervor.

> Beispiel:  Onlinebanking.  Jemand loggt sich mit Username+Passwort ein und sieht das Konto.  Aber um eine Überweisung zu tätigen braucht er zusätzlich eine TAN.
>
> Ja, ich weiß, inzwischen ist da der Wahnsinn ausgebrochen und **die Sicherheit beim Onlinebanking wurde vollkommen erodiert.**  
> Bei meiner Bank ist es noch schlimmer.  Sich am Konto anzumelden braucht Benutzername + Passwort + App, während die anschließende Überweisung nur die App braucht.  
> Wo bitte ist da der für die Sicherheit notwendige Medienbruch?  Wen muss man für diesen vollkommen unbrauchbaren Sicherheitsbrei schlagen?
>
> Merke: **Kein Medienbruch, keine Sicherheit.  Egal wie stark ich mich sonst auch anstrenge.  Punkt!**

Am einfachsten versteht man die Problematik mit dem Blick auf Unix:

- Die UID entspricht der Authentikation
- Die GID entspricht dem Account
- Die Permissions der Autorisation

Es gibt deutlich kompliziertere Verfahren wie die bei Windows, aber das Unix-Schema reicht meistens vollkommen aus.

Technisch würde ich das so implementieren:

- Authentikation: Login bestimmt den Account (N:1)
- Accounting: Account bestimmt die Zugriffsrechte (1:N)
- Authorisierung: Die Zugriffsrechte ermöglichen den Zugriff

Dazu kommt:

- Accounts sind hierarchisch organisierbar
- Rechtegruppen sind feingranular, der Account ist z. B. gleichzeitig eine Rechtegruppe
- Man loggt sich nicht in den Account ein sondern in die jeweilige Account-Hierarchie
- In der Hierarchie kann man die Position (und damit die Gruppe) ggf. (temporär) wechseln, voraus man kann sich entsprechend umautorisieren

Sprich:

- Man loggt sich ein
- Anhand des Logins wird der entsprechende Unteraccout bestimmt
- An dem Unteraccount hängen die Zugriffsrechte
- Die Zugriffsrechte selbst ermöglichen dann den Zugriff

Aus Einfachheitsgründen würde ich noch folgendes hinzufügen:

- Die Zugriffsrechte würde ich in Gruppen packen, denen man dann Accounts zuweisen kann
- Ein hierarchich übergeordneter Account besitzt automatisch alle Gruppen eines hierarchisch untergeordneten Accounts
- Man kann in der Hierarchie jederzeit absteigen
  - Dies kann temporär oder permanent geschehen
- Man kann in der Hierarchie aber nicht ohne weiteres aufsteigen
  - Dies sollte immer nur temporär geschehen
- Wenn erhöhte Rechte benötigt werden, kann jedes System einen temporären Aufstieg in der Hierarchie anfordern

Das Gruppenmanagement geschieht in Kooperation zwischen System und Account.

Am Anfang ist die Sache sehr einfach, und muss nicht unbedingt komplizierter werden:

- Man legt sich einen Login an
- Dieser legt sich einen Account an
- Dieser legt eine Gruppe an
- Und diese Gruppe wird dann zur Autorisation verwendet.

Ein System kann sich dann mit der Gruppe zufriedengeben oder bei der Einrichtung eines neuen Nutzers eine neue Gruppe anlegen und den Account dieser zusweisen.

Zusätzlich hängen an jeder Gruppe außerdem Rollen:

- Die eigentlichen Rechte hängen an der jeweiligen Rolle
- Der Account kann in mehreren Rollen sein

Die Systeme arbeiten dann grundsätzlich nicht mit Accounts, sondern mit den Gruppen.

- Diesen Gruppen können sie dann Rollen für die im System notwndigen Rechte hinzufügen.
- Die Rollen kann man dann im Accountmanagement bearbeiten - sofern man die entsprechende Rolle dafür besitzt.
- Die Systeme müssen sich nicht selbst darum kümmern, sondern delegieren das an das Accountmanagement.

Was haben wir also:

- Logins
  - Diese mappen auf einen Account.
  - Ein Account kann mehr als einen Login besitzen.
  - Ein Account kann mehr als einen Login erfordern (2FA).
- Accounts
  - Diese sind in einer Hierarchie organisiert.
  - Übergeordnete Accounts können untergeordnete Accounts bearbeiten.
  - Übergeordnete Accounts können in untergeordnete Accounts wechseln.
  - Übergeordnete Accounts besitzen also alle Rechte untergeordneter Accounts
  - Untergeordnete Accounts können temporär die Rechte übergeordneter Accounts verwenden, sofern der Nutzer sich entsprechend Autorisieren kann
  - Die Hierarchie nach unten ist immer vollständig sichbar.
  - Die Hierarchie nach oben ist grundsätzlich sichtbar.  Die sichtbaren Informationen hängen aber an Gruppen.
  - Die Hierarchie in Nebensträngen ist normalerweise nicht sichtbar.  Dies hängt zusätzlich an einer Rolle in einer Gruppe.
  - Jeder Account ist auch gleichzeitig eine Gruppe mit allen Rollen in der Gruppe.
- Gruppen
  - Die Gruppen sind die zentrale Verwaltungseinheit für die Rechte auf Systemen
  - Es gibt immer eine Standardgruppe, das ist der Account selbst
  - Neben der Standardgruppe gibt es immer eine Hauptgruppe.  Diese kann von System zu System wechseln.
  - Systeme müssen sich selbst nicht mit Accounts rumschlagen
  - Systeme müssen sich auch nicht mit Gruppenverwaltung rumschlagen
  - Das Accountmanagement übernimmt die vollständige Gruppenwaltung
  - Systeme können neue Gruppen registrieren und löschen.  Die so erzeugte Gruppe hängt an dem jeweiligen System.
  - Systeme können sich für bereits existierende Gruppen registrieren.  Die Gruppe ist dann zwischen mehreren Systemen geteilt.
  - In Gruppen können Accounts mehrere Rollen einnehmen
  - Die Systeme definieren immer eine Gruppe (default die Standardgrppe) als Hauptgruppe
  - Neue Rollen werden immer dieser Hauptgruppe zugewiesen
- Rollen
  - Das Accountmanagement übernimmt die Rollenverwaltung in den Gruppen, Systeme müssen sich also nicht damit selbst rumschlagen
  - Falls eine Privilegierung (temporäre Rolle) notwedig ist, fordert das System die Rolle an, das Accountmanagement macht den Rest (lehnt ggf. ab).
  - Systeme können Rollen registrieren und löschen.  Die so erzeugte Rolle hängt an dem jeweiligen System und wird nicht mit anderen geteilt.
  - Es gibt einige Standardrollen, die vom Accountmanangement erzeugt wurden und die Systeme nutzen können.
  - Rollen sind gruppenunabhängig.  Dieselbe Rolle kann beliebig vielen Gruppen zugeordnet werden.
- Rechte
  - Die Rechte (Autorisierung) erfolgt über die Rollen.
  - Welche Rechte zu einer Rolle gehören entscheiden die Systeme selbst.
  - Das Accountmanagement hilft beim Rollenmanagement nicht.  Es kann nur Rollen einem Account zuweisen oder entziehen, aber nicht die Rechte der Rolle ändern.

Folgende Informationen werden standardmäßig vom Accountmanagement an ein System übertragen:

- Pseudonyme Account-ID
- Pseudonyme Hauptgruppen-ID
- Rollen

Weitere Informationen werden nicht übertragen.  Die Pseudonymisierung ist systemspezifisch, d. h. jedes System sieht eine andere (feste) ID.

> Das ist wichtig für das Recht auf Vergessen.  Das System benötigt dann keinerlei Bereinigung.
> 
> Da die IDs pseudonym sind, kann sie nicht mit anderen Systemen korreliert werden sobald das Accountmanagement diese Verknüpfung löscht.
>
> Wichtig in diesem Zusammenhang:  Das System darf Rollen nicht individualisieren.

Das System kann weitere Informationen vom Accountmanagement anfordern.

- Vom System selbst dort abgelegte Daten.  Z. B. ein Alias oder Nickname.
  - Dies ist ein einfacher Key-Value-Store für das jeweilige System.
  - Der Key ist ein String und kann nur einmal existieren.
  - Das Value ist sinnvollerweise JSON
  - Gespeichert ist also ein Tripplet:  System, Key, Value
- Weitere Informationen.  Dies erfordert aber eine Genehmigung (Zustimmung) durch den Nutzer.
  - Beispielsweise Mailadresse, Telefonnummer, etc.
  - Diese werden genauso verwaltet wie die Informationen vom System, wobei das System halt das Accountmanangement selbst ist.
  - Man kann so auch Keys eines anderen Systems anfragen, sofern der Nutzer das zulässt.

Hier gibt es noch ein (wichtiges!) Spezifikum bei vom System abgelegten Daten:

- Der jeweilige Key kann (für das System) in der jeweiligen Hierarchie nur einmal vorhanden sein.

Das bedeutet, der Key kann in der direkt aufsteigenden und gesamten absteigenden Hierarchie nicht mehrfach existieren.

- Wenn ein Key in einem übergeordneten Account befindet, muss man in diesen Account vorher aufsteigen.
- Wenn sich ein Key in einem untergeordneten Account befindet, muss man in diesen absteigen.
- Ein Key kann sich in mehreren untergeordneten Accounts befinden.  Dann muss der Nutzer wählen, in welchen er absteigt.
- Bitte beachten, dass sich bei Accountwechsel die Account-ID ändert.  In der Regel wird das System diesen Accountwechsel ablehnen.
- Das ist anders als bei Gruppen- und Rollenwechseln.  Diese können temporär erfolgen, ohne die Gruppe zu wechseln.

Beispiel Account-Merge.

- Beide Accounts haben keine Hierarchie
- Beide Accounts enthalten denselben Key.
- Dann kann man sie nur mergen, wenn der Inhalt der Keys identisch ist.
- Anderenfalls muss man halt einen gemeinsamen Überaccount anlegen und diese beiden Accounts zu Unteraccounts machen.

Der Split ist ähnlich einfach:

- Man legt 2 neue Unteraccounts an und verschiebt die jeweiligen Informationen in die jeweligen Accounts.
- Dabei kann man Informationen auch duplizieren
- Wenn der Überaccount leer ist kann man diesen entfernen.

Simpel.  Damit aber genau all das möglich ist, kann die Struktur leider nicht vereinfacht werden.


### Loadbalancer LB

Ich spreche hier von einem verlässlichen Ding wie HaProxy.

Auch wenn der ISP so etwas bereitstellt oder man etwas wie CloudFlare nutzt, sollte dieser Punkt in der eigenen Platform vorhanden sein.

- SSL-Terminui



-------------------------

Zum eigentlichen Thema bin ich gerade leider nicht mehr gekommen.  Wird evtl. weitergeführt sobald ich die Zeit finde.

Es geht hierum nicht um "wie baue ich die Accountstruktur".  Das ist bei AAA eigentlich schon erklärt.

Es geht auch nicht um "wie mache ich das DSGVO-Konform".  Das spreche ich nur an, weil es ohne diese Voraussetzung einfach nicht gemacht werden kann!

Es geht darum, wie gieße ich das in Technik, und zwar so, dass das nicht nur cloudmäßig skaliert,
sondern auch noch in einfache, klare, unabhängige Einheitsblöcke zerlegt werden kann,
so dass das Ganze resilient wird.

- Mit Resilienz meine ich nicht Backups.  Die sind komplett außen vor.
- Das hat auch nichts mit Redundanz zu tun, diese wird bereits vollständig über die Skalierung abgehandelt.

Mit Resilizen meine ich Programmierfehler, Lücken, Ausfälle und anderweitig beliebige externe Störungen.

Also z. B. wie behandle ich Dinge wie Rate-Limiting, schütze ich die Plattform gegen Brute-Force-Attacken, usw.

Und zwar so, dass das überhaupt nicht weh tut und man danach keinerlei Gedanken mehr verschwenden muss,
bis der jeweilige Fall eintritt, und dann hat man einfache Stellschrauben, an denen man drehen kann,
sowie natürliche Eingreifpunkte, an denen man zur Verbessung der Situation sofort ohne weiteren Planungsbedarf ansetzen kann.

Einfach, weil das ganze Setup das gleich von Anfang an hergibt.

Ein paar Stichpunkte als Gedankennotiz für später noch:

- DSGVO Aufklärungspflicht
  - Es wird sichergestellt, dass es ohne Aufklärung gar nicht weitergegangen sein kann.
  - Damit ist technisch bewiesen, dass aufgeklärt wurde.
- DSGVO Zustimmung
  - Wie behandelt man das und warum sollte man darauf besser verzichten
  - Büchse der Pandora ist dagegen Kindergarten
  - Man kann das eigentlich nur mit Nuklearkrieg vergleichen.  Nur wenn man diesen final gewinnen kann, dann kann man die Zustimmungslösung vielleicht verwenden.
  - Besser also Finger weg.
- HaProxy und Request-Routing
  - Wieviele HaProxies hätten Sie denn gern, und darf es auch etwas mehr sein?
  - HaProxy und Round-Robin
- HaProxy und TLS-Terminierung
  - Warum TLS nichts und niemanden wirklich schützt
- Time based Cookie
  - Und sein Missbrauch
  - Skalierung NginX
  - PHP-FPM
- Handling der Dreifaltigkeit:  Aktive User, Gute User vs. Angreifer
  - Was ist überhaupt ein Angriff und kann es das überhaupt geben?
  - Der Standardbrowser als DoS-Attacke oder: Weihnachten kommt etwas früher wenn der Weihnachtsmann sekündlich klingelt
  - Was ist eigentlich normal und ab wieviel zehntausend TABs ist man Messy?
- Wenn die Millisekunde zählt
  - Wieviele Millionen darf es kosten?
  - Und warum es inzwischen auch für fast lau geht.
- Kubernetes
  - Oder warum man soetwas besser erst gar nicht (für sich selbst) verwendet
