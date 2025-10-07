# Warum Jira Scheiße ist

Ich habe mit Jira so meine Probleme:

- Der Workflow ist .. Murx.
  - Weil ich den nicht anpassen kann.
  - Ich bin kein Admin auf Jira und will auch keiner sein!
  - Hint: Ich bin zwar der Jira-Admin.  Aber wenn ich Tickets bearbeite, dann will ich den Hut nicht anziehen müssen!
- Der Guten Dinge sind 3
  - Tickets benötigen 3 Personen, die mit dem Ticket verbunden sind!
  - Autor: Der das Ticket eintütet (der User)
  - Zuständiger: Der für die Umsetzung des Tickets verantwortlich ist (ich)
  - **Bearbeiter: Derjenige, bei dem das Ticket momentan liegt**
  - Das sind 3 verschiedene Leute (siehe unten warum das IMMER notwendig ist)
 - Ticket-Hierarchie ist zu kurz gedacht
   - "Instanz - Epic - Ticket - Unterticket" ist einfach .. falsch!
   - Instanz ist klar, das ist das jeweilige Jira
   - Epic wird vom Jira-Admin verwaltet.  An denen darf ich als Entwickler nicht rumfummeln!
   - Tickets darf ich erstellen, aber wenn ein Ticket reinkommt ist es schon zu spät!
   - Also fehlt zwischen Epic und Ticket ganz klar eine Ebene.  **Ich würde diese "Unter-Epics" nennen.**
- Kein On-Premise?!?
  - Wie jetzt, es gibt nur noch Cloud?  Sorry, Leute.  Das ist bei mir der No-Go.
  - **"Sie haben gerade keine Internetverbindung, deshalb kann die Defibrillation derzeit nicht durchgeführt werden"**
  - Wenn es wenigstens ein vollständiges Backup gäbe, das man abrufen kann, aber nein!  Frohes Sterben aber auch.
  - BTW (nur so nebenbei erwähnt): Die EU setzt solch ein Komplettbackp das voraus wenn man Dienste in Europa anbietet ..

## TL;DR

Eigentlich ist die Kombination aus Jira und Confluence unschlagbar gut.  Jedenfalls kenne ich nichts besseres.

- Jira ist das Ticketsystem
- Und Confluence ist das Dokumentationssystem

Und die Verzahnung von beiden ist der entscheidende Punkt.  Denn normalerweise sind solche Tools irrsinnig hinderlich:

- Das Ticket-System, damit mag man sich ja gerade noch abfinden.
  - Eigentlich sind Tickets eher lästig, denn sie helfen nur wenig beim Arbeiten selbst.
  - Und sie taugen nicht zur Dokumentation der Arbeit, lediglich der Historie der Tickets.
  - Das bedeutet, mit einem reinen Ticketsystem (Jira ohne Confluence) hat man mehr zusätzliche unnütze Arbeit zu leisten.
- Und ein Wiki?  Ist halt ein Wiki!
  - Dokumentation, sorry, Leute, ein absolutes Horrorthema.  (Und das von einem, der zuerst dokumentiert und dann implementiert!)
  - Es gibt nichts Schlimmeres als halbgare Dokumentation.  Und genau das passiert mit Wikis über die Zeit.  Sie desorganisieren sich.
  - Eigentlich sind Wikis eine gute Idee.  Aber eben nur eigentlich.
  - Je nachdem, wie jemand drauf ist, ist das entweder das rote Tuch (die, die nicht dokumentieren) oder eben ein Bremsklotz (die, die wie ich alles dokumentieren wollen)

Genau das ist der Mist.  Zusätzliche Arbeit.  Gibt es denn nichts, das irgendwie beides verknüpft, und zwar so, dass es mehr hilft als hindert?

**Genau das sind Jira und Confluence** .. fast schon.

Confluence erleichtert mir die Arbeit ungemein, meine Dokumentation zu erfassen wenn ich die Dokumentation erfasse.
Was ich meistens tue, außer bei Überlast.  Und Überlast .. tja, das haben wir eigentlich immer.
Trotzdem nehme ich mir die Zeit, zu dokumentieren wenn ich nur kann.  **Weil ich meine Aufgabe darin verstehe, mich überflüssig zu machen.**
Sprich, ich möchte denen, die mich mal ersetzen, alles so hinterlassen, wie ich es gerne vorfinden würde.

> Was das Problem ist.  Was ich hinterlasse verstehe ich.  Und noch vielleicht so 1 Promill der Anderen.  
> Dazu sage ich immer:  Ich habe keinen Problem mit Code Anderer.  Andere haben den nur mit meinem Code ..  
> Tatsächlich aber kenne ich mehrere, die mit meinem Code auch keine Probleme haben.  Die sind dieses Promill.

Es gibt einige Dinge, die Jira und Confluence zusammen vermögen, was sonst einfach nur hinderlich wäre.
Die Verschränkung zwischen Tickets (Überlast) und Wiki (Dokumentation) ist einfach hier die Arbeitserleichterung.

- Alles, was gerade durch den Kopf schießt aber nicht gemacht werden kann, schnell in ein Ticket verfrachten und weglegen.
- Und wenn etwas in trockenen Tüchern ist, dann kann man das schnell ins Wiki als Dokumentation übernehmen
- Weil im jeweiligen Ticket haben die konkreten Arbeiten nichts verloren.
  - Das Ticket ist Historie zum Nachlesen, die Details gehören in Confluence.
- Aber die Verzahnung ist der Bringer:
  - Das Ticket verweist auf Doku, die evtl. noch nicht vorhanden ist
  - Die Doku verweist auf Tickets, die damit zu tun haben
  - Und dann verlinkt man alles immer miteinander, wenn man darüber stolpert, dass etwas vielleicht miteinander zu tun hat

Das ist beides mit Jira und Confluence möglich.  Wenn auch leider oft umständlich und selten so, wie man es braucht.

Beispiel: "Is blocked by" als Default beim Link zwischen Tickets?  WTF?!?

- Der Default müsste auf "relates to" stehen, und später anpassbar sein.
- Außerdem möchte ich die Relation nicht angeben müssen während ich diese Erfasse, weil meine Meinung ändert sich schneller als die von "Donald Trump" und "Markus Söder" multipliziert!
- **"Blocked by" ist dabei die maximal hinderlichste Eintragung**, die mich ständig tödlich erwischt, wenn ich vergesse, das auszubügeln.

Beispiel: Datenbanken bei Confluence

- Eigentlich eine der allerbesten Dinge die Confluence derzeit zu bieten hat
- Aber es fehlen synthetische (berechnete) Spalten (wie bei einer Tabellenkalkulation.  Hey, wir haben JavaScript!)
  - Z.B. wenn zwei Tabellen einen Join haben (was in einfachen Fällen möglich ist), wie kann ich die Konsistenz erzwingen
  - Gemeint ist etwas wie bei SQL, allerdings permissiv, d.h. wenn die Konsistenz nicht gegeben ist, dann wird das geflaggt
- Außerdem ist es schwierig, Views korrekt anzuordnen (es gibt nur eine fixe Spaltengröße)
- Und wie sieht das mit der Historie aus?
  - Ein falscher Klick und das Feld ist unwiederbringlich zerstört!
  - Ich kann nicht nachsehen, was da vor 2 Jahren drinnenstand.
  - Einzig geht, wenn es mir sofort auffällt und ich noch den Undo machen kann.
  - Sorry, das ist konträr zu jedem Wiki!
- Und dann die Darstellung von Datenbankauszügen in Confluence?
  - WTF, was soll das bitte sein?

All das sind "Annoyances".  Was mir aber jeden Tag beim Arbeiten mit Jira auffällt ist diese willkürliche Limitierung bei den Tickets!

Es mag toll sein, wenn man max. 10 Tickets sieht.  Da behält man die Übersicht.

Wenn man aber, wie ich,

- für jedes Detail ein eigenes Ticket erfasst um das Detail nicht aus den Augen zu bekommen,
- jedes Ticket in zig Untertickets aufspaltet, um jeden einzelnen Wegpunkt besser in der Sicht zu haben
- und parallel an hunderten Dingen arbeitet, die sich Jahre und unzählige Tickets lang ziehen

dann ist Jira schlicht ein Stolperstein.  Hier ein paar Beispiele:

- Der Nutzer stellt das Ticket ein
- Ich bin dafür verantwortlich, dass der Nutzer bekommt, was er benötigt
- Ich arbeite an dem Ticket und muss es an jemanden für ein Detail abgeben
- Was nun?

Ich bin nicht der Autor vom Ticket, das ist der Nutzer.  Ich bin aber auch nicht der Detailbearbeiter (Rückfrage etc.).
Wenn ich jetzt das Ticket an eine andere Person weitergebe, dann verliere ich es aus der Sicht!
Wenn ich es aber behalte, dann sieht der Andere das Ticket nicht!

Die mir bekannten Lösungen sind keine.

- Ich könnte das Ticket als Autor übernehmen und dann am Ende wieder an den Nutzer zurückgeben.
  - Dann könnte ich bei der Detailfrage/Workflow/etc. das an die andere Person abgeben
  - Nur leider sieht dann der Nutzer das Ticket nimmer und denkt sich seinen Teil.  No Go!
- Ich könnte die andere Person eintragen und mache mir dann einen eigenen Tag/Keyword, so dass ich es im Auge behalten kann
  - UUUUUUMMMMMMSTÄNDLICH und sehr Fehleranfällig!
- Ich kann die andere Person erwähnen wodurch eine Mail abgeht
  - Sorry, funktionierte noch nie sowas.
 
Nope.  Was fehlt ist ein Dritter, bei dem das Ticket momentan auf dem Schreibtisch liegt!

Das bin beim Bearbeiten ich, und bei Rückfragen halt jemand anderes.  Also haben wir:

- Autor, der das Ticket zurpückgemeldet bekommt
- Verantwortlicher (ich) der das Ticket im Auge behält und dafür sorgt, dass es bearbeitet wird
- Bearbeiter, bei dem es liegt

Ich weiß, dafür gibt es Scrum-Manager usw.  Danke.  Echt super so ein Arguement, weil mir das absolut NULL weiterhilft.

> Und warum muss der Mensch machen, was die Maschine locker leisten kann?
> Sind wir jetzt Sklaven, die von den Maschinen diktiert bekommen, was wir zu tun haben?

Die Lösung ist einfach dieser Dritte.

- Der Scrum-Manager weist mir die Verantwortung zu!
- Und dann sorge ich dafür, dass es seinen Weg nimmt bis es abgenommen und als Erledigt zurückgemeldet werden kann!

Dazu muss ich aber das Ticket auf den Tisch von jemand anderem legen können, ohne dass es dadurch aus meinem Ding verschwindet.

> Und wenn dieser Dritte bei jemand Viertem rückfragen muss, **dann läuft das über mich**, denn ich muss das sowieso wissen!
> Sprich, der andere kann das Ticket vollständig abgeben, aber zurück kommt es dann nicht mehr an ihn sondern an mich!
> Wenn er das nicht will, muss es über mich gehen.  Ich schicke es dann an den Vierten, erhalte es zurück und gebe es wieder an den Dritten!

Das funktioniert auch mit mehreren Koordinatoren, Urlaubsvertretung usw.

Ich trage mich aus allen Tickets aus und trage meine Vertretung ein.  Und auch bei Tickets, die ich gerade schon woanders liegen habe!

Damit ergibt sich ein sehr einfacher Workflow und man kann fast alles abbilden was man mag.  Insbesondere mit einem Computer.

> Natürlich könnte man Jira mit der API erweitern.  Aber sorry, das gehört einfach zu den Kernbereichen eines Ticketsystems finde ich!

Genau in dieselbe Kerbe hauen Epics.

- Der Nutzer stellt ein Ticket ein.
  - Da fehlt dann das Epic
- Ich weise ein Epic zu wenn ich das Ticket erhalte

Aber was, wenn es das Epic nicht gibt?

Da Epics zur Prokektplanung gehören, sind sie IMHO für den Bearbeiter eines Tickets Tabu!

- Ich kann Epics zuweisen wenn es keines gibt
- Und ich kann Epics, für die ich zuständig bin, ändern
- Aber mehr halt nicht
  - Wenn jemand ein Epic verwendet, auf das ich keinen Zugriff habe, dann kann ich das auch nicht ändern!

Jetzt ist aber das Problem, dass es oft kein sinnvolles Epic gibt.  Oder dass es bisher zu wenig Sinn hatte, dafür ein Epic anzulegen!

Deshalb sollte es Unterepics geben.  Das sind Epics, die jeder anlegen kann.  **Jeder.**

- So ein Unterepic hängt immer an einem übergeordneten Epic.  Einem.
- So ein Unterepic kann anderen Epics (oder Tickets) zugeordnet werden (Relates)
- Und wenn ich nach dem ober-Epic filtere, bekomme ich die Tickets in den Unterepics ebenso zu sehen

Wenn mir also das Epic nicht gefällt kann ich ein Unterepic anlegen und das Ticket daran umhängen.
Und wenn sich dann in dem Epic viel angesammelt hat, kann man sich überlegen, wie man das Epic verändert.

- Evtl. splittet man es
- Oder man promotet es zum Haupt-Epic
- usw.

All das sind einfache Umordnungen im Baum.  Die mit entsprechenden Permissions einhergehen.  Und die man machen kann wenn man Zeit hat.

Wichtig ist, dass die initiale Umordnung (Erzeugen eines neuen Unter-Epics) in keiner Zeit vonstatten geht, so dass man es macht, wenn es sinnvoll ist.

> Alles muss immer schnell schnell in der Microsekunde erledigbar sein, in der einem der Gedanke durch den Kopf schießt.
> Wenn das 1 Minute dauert ist das schlicht Murx, bis dahin hat man den Faden verloren.

Wenn ich länger als 1s nachdenken muss ob es vielleicht ein passenderes Epic gibt als das, was ich schnell anlege, dann sorry, schon verloren!
Sprich, wenn möglich sollte das Epic angelegt werden, ohne dass man es benennen muss.  Das kann man nämlich später noch tun!

Genau so muss ALLES aufgebaut sein.  Alles vorläufig jetzt machen, mit einem automatischen Backlog, um es dann, rekursiv, wieder abzuarbeiten.
Und diese Rekursion, darin unterstützt mich der Computer, indem er mich darauf hinweist, was alles so noch auf dem Stack auf mich wartet.
Ohne zu erwähnen, wie tief im Rekursions-Stack ich gerade vergraben bin!
