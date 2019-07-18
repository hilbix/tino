> Achtung!  Ich bin Techniker und kein Jurist!

Das Fazit vorweg:

Ob die IP ein pseudonymes Datum oder ein personenbezogenes Datum ist,
das ist gem. DSGVO prinzipiell dieselbe Frage,
wie in der Physik die Frage, ob ein Quant nun Welle oder Teilchen ist.

Es hängt nämlich immer davon ab, was ich mit der IP tue:

- Verwende ich die IP personenbezogen, dann ist sie personenbezogen.
- Verwende ich sie aber ohne Personenbezug, dann ist sie ein pseudonymes Datum, wenn überhaupt.
- Erstes dürfte eine eher seltene Ausnahme darstellen, denn letzeres ist im Internet die Regel.

So jedenfalls der Schluss, zu dem ich gekommen bin.

Wer also sagt, die IP hätte in der DSGVO einen personenbezug, und zwar nicht nur in besonderen Fällen,
der macht sich die Sache nicht nur viel zu einfach, sondern erzählt schlicht Stuss.


# Ist die IP ein personenbezogenes Datum?

Im Internet vertreten einige Juristen oft die Auffassung, eine IP wäre ganz klar ein personenbezogenes Datum.

Aber ich habe von der IP als Techniker ein vollkommen anderes Verständnis wie alles funktioniert,
und bin der festen Überzeugung, dass es nicht so sein kann, weil es sonst das Internet nicht gibt.

> Und als Mathematiker fällt mir auf, dass es weniger IPv4 als Menschen gibt.  Wie kann die IP da Surjektiv sein?

Natürlich kann die IP ein personenbezogenes Datum darstellen (insbesondere im Zusammenhang mit einem Timestamp).
Aber das kann nicht die Regel darstellen!

Denn wenn die IP immer ein personenbezogenes Datum wäre, dann haben wir nicht nur ein kleines Problem, sondern ein extremes.
Und nicht nur im Internet, sondern Europaweit auf jeder Ebene der Existenz.
Denn dann wäre alles in einer derartigen Schieflage, dass gar nichts mehr funktioniert.
(Aber diese Richtung führt uns auf Abwege, deshalb gehe ich hier nicht näher darauf ein.
Ein Anklang wird hoffentlich aus den Beispielen erkennbar.)

> Alles was hier steht geht aus meinem Verständnis der DSGVO hervor.
> Aber Vorsicht, juristischem Gebiet [bin ich ein Idiot](https://de.wikipedia.org/wiki/Idiotes).

Um nun herauszufinden, was die IP denn nun ist, personenbezogen oder nicht, muss ich leider etwas weiter ausholen.
Aber dann wird es hoffentlich zu 101% klar, wie es zu verstehen ist.


# Zuerst einmal, wie es im alten Gesetz war

Im alten Datenschutzrecht waren (so hatte ich es jedenfalls verstanden) personenbezogene Daten all diejenigen Daten,
die dazu geeignet waren, dass man sie auf Personen bezieht.  Das Denkmodell war also:

- Ich habe einen beliebigen Aspekt einer Person.
- Kann ich nun Gruppe Menschen geeignet so aufstellen, dass ich die Person mit diesem Aspekt herauspicken kann?
- Dann ist dieser Aspekt personenbezogen.

Beispiel:

- Augenfarbe eines Menschen.
- Ich kann eine Gruppe von Menschen aufstellen, die alle eine andere Augenfarbe als die gesuchte Person haben.
- Stellt sich nun die gesuchte Person in die Gruppe, dann kann ich sie anhand ihrer Augenfarbe erkennen.
- Damit ist die Augenfarbe ein personenbezogenes Datum.

(Das ist jetzt nicht die juristisch korrekte Defition, sondern das Denkmodell, das ich daraus abgleitet habe,
welches mir immer sehr gute Dienste bei der Einschätzung gegeben hat, ob etwas personenbezogen ist oder nicht.)

Wichtig beim alten Gesetz war, dass die Regelung davon unerheblich war, ob ich den Aspekt auf die Person beziehen konnte.
Es reichte aus, dass irgendwer das kann, selbst wenn es nur die Person selbst ist!

Das war ein wesentlicher Eckpfeiler des alten Datenschutzgesetzes, nämlich dass man hier nicht argumentieren konnte.
(Anders gesagt galt als Eselsbrücke:  Wer dachte zu argumentieren, der hatte das Datenschutzgesetz gebrochen.)

Ich konnte nicht sagen "also 'blau' kann nicht personenbezogen sein, das ist nur eine Farbe".  Wenn das im Feld
Augenfarbe stand, dann war das ein klare personenbezogenes Datum, egal wie ich mich drehte oder wendete.

Denn die alte Welt des Datenschutzgesetzes war rein binär.
Entweder etwas war personenbezogen oder nicht.  Da gab es nix fallweises, über das man hätte diskutieren können.
Wenn ich also anfing, darüber zu schwadronieren, warum etwas keinen Personenbezug hatte, dann war es klar personenbezogen.

So einfach war die Welt damals.  (Und das Datenschutzgesetz war entsprechend ein zahnloser Papiertiger.
Denn Strafen beim Verstoß gab es nicht, der Datenschutzbeauftragte konnte nur den Finger heben und mahnen.
Strafen gab es nur im Fall der Fälle, wenn jemand konkret dadurch geschädigt wurde.
Und das war in den meisten Fällen mehr als nur unmöglich nachzuweisen.)

Beispiel:

- Autokennzeichen der gesuchten Person.
- Ich kann beliebige Gruppen von Autos hinstellen.
- Ich kann das Auto mit dem Kennzeichen finden.
- Aber der Fahrer des Autos muss nicht notgedrungen die gesuchte Person sein!
- Damit ist das Autokennzeichen kein personenbezogenes Datum.

Das hat sich in der DSGVO radikal geändert.  Und das ist sowohl gut als auch schlecht.


# Personenbezogene Daten gem. DSGVO

In der DSGVO geht es nicht mehr darum, ob irgendwer auf diesem Planeten in der Lage sein könnte,
von dem Aspekt auf die Person zu schließen.

In der DSGVO geht es darum, ob ich, konkret, evtl. mit der Hilfe eines Dritten,
anhand des Aspekts auf die Person schließen kann.

> Wenn ich also die Daten an eine Auskunftei geben kann und diese ermittelt mir dann die Person,
> dann sind die Daten personenbezogen.  (Das ist aber nur ein Kriterium unter vielen.)

Das ändert vieles.  Die Augenfarbe eines Menschen ist zwar in der Regel personenbezogen, kann ich diese Angabe aber
- ganz konkret - nicht auf eine bestimmte Person beziehen, ist die Angabe für mich nicht mehr personenbezogen,
und ich unterliege nimmer den strengen Bedingungen in der DSGVO.

Die DSGVO hat für solche Daten eine neue Kategorie, die es früher nicht gab:  Pseudonyme Daten.

Das sind alle Daten, die sich auf eine Person beziehen, aber die so angelegt sind, dass ich aus diesen Daten
nicht (mehr) auf die Person schließen kann.

Autokennzeichen, Augenfarbe, Personalausweisnummer usw. für sich genommen sind also jetzt pseudonyme Daten!
Erst, wenn man zwischen den Daten einen Zusammenhang errichtet, der auf die Person schließen lässt,
also z. B. in der Form einer Tabelle in der auch Name und Anschrift stehen, werden das personenbezogene Daten.

Der Vorteil ist, trenne ich die Informationen voneinander auf eine Weise, dass ich sie nicht mehr zusammenführen kann,
dann wird alleine die Zusammenführung zum Personenbezug, und alles andere kann ich laxer handhaben.

Logisch erscheint so eine Trennung schwierig.  Technisch ist das sogar recht einfach zu lösen!
Deshalb ist das auch mehr als nur sehr relevant für die Praxis!

Die DSGVO stellt hier also eine Verbesserung gegenüber früher bereit, denn früher konnte ich nicht auskommen
und musste den Prozess den Daten anpassen.  Heute kann ich die Daten dem Prozess anpassen.
(Ich setze voraus, dass der Prozess die jeweiligen Gesetze erfüllt.)

> Nein, diese Anpassung funktioniert überhaupt nicht so, wie ihr gerade denkt.
>
> Es reicht also nicht, eine Datenbank zu partitionieren, oder einfach die Daten umzudeklarieren.
>
> Den ganzen vorhandenen Schrott, besonders wenn er aus den USA kommt, muss man komplett wegwerfen
> um ihn komplett gem. DSGVO neu zu schreiben.  Aber hat man erst einmal begriffen, wie das aussehen muss,
> dann ist das eben keine Raketenwissenschaft mehr, sondern ergibt sich aus dem Geradeausweg quasi von selbst.
> Einfach aus der Notwendigkeit heraus, sich an die DSGVO zu halten.
>
> Übrigens hat sich da aus den Zeiten des Datenschutzgesetzes eher nichts verändert.
> Hätte man es schon damals vollständig richtig gemacht, dann hat man es heute mit der DSGVO eindeutig leichter!
> Wenn man also jetzt mit dem Altsystem ein Problem mit der DSGVO bekommt, dann nur deshalb,
> weil man schon zu Zeiten des Datenschutzgesetztes dachte, wie ein Raubritter unterwegs sein zu dürfen.
> Tja, Pech auch und dumm gelaufen, das ist kein Fehler der DSGVO sondern von einem selbst!
>
> Allerdings ist dieser Fehler verständlich.  Erst aus der DSGVO ergeben sich klare Implementierungsweisen,
> vorher hat man sozusagen im Vakuum gerudert ohne klaren Weg vor Augen.

Aber eine Sache ist hier wichtig:  Früher war alles binär.  Entweder es war ein personenbezogenes Datum, oder nicht.

In der DSGVO kommt es jetzt entscheidend auf den Kontext an.  Und zwar nicht nur den Kontext, in dem die Daten
gespeichert sind, sondern auch den Kontext davor (also der Erhebung) und danach (also Verarbeitung).

Ist ein Datum im Kontext personenbezogen, dann muss ich die strengeren Regeln der DSGVO ansetzen.
Wenn nicht, dann reichen die laxeren.

> Und wenn ich es falsch mache, dann kann ich das nicht irgendwie hinterher reparieren oder von der Person
> nachträglich abgesegnen lassen.  Nö, dann habe ich mich nicht an die DSGVO gehalten und handelte klar illegal.
>
> Das ist ein anzeigepflichtiger Datenschutzverstoß!
>
> So einfach ist das jetzt.  Also entweder mache ich es gleich richtig, oder lasse es besser ganz bleiben!
> (Das ist so wie mit der Weltherrschaft.  Entweder ich mache es gleich von Anfang an richtig und kann die an mich reißen,
> dann kann mir auch keiner mehr etwas, oder ich bin soetwas von tot, egal ob ich das nun wahrhaben will oder nicht.)

Besonders "streng" in Sinne der DSGVO sind meine Pflichten.  Also meine Bringschuld, z. B. vor Erhebung der
personenbezogenen Daten über deren Verwendung aufzuklären.  Und die damit verbundenen Dokumentationspflichten,
z. B. wenn die Person einwilligt, dann muss ich diese Einwilligung zweifelsfrei wieder reproduzieren können.
Ein reines "er hat zugestimmt" reicht da nicht aus, ich muss schon mitspeichern, welche Version meiner
Datenschutzerklärung da zugestimmt wurde, wann, in welchem Umfang und wie das geschah, usw.

Stimmt später ein kleines Bit dieser Angaben nicht mehr (z. B. geht meine alte Datenschutzerklärung verloren,
oder ich habe mir die Zeit falsch notiert, oder kann die Zustimmung nicht reproduzieren der da zugestimmt wurde)
dann habe ich schuldhaft gehandelt, da ich meinen Pflichten nicht nachgekommen bin.

Deshalb ist die Basis der DSGVO auch so entscheidend bei der Datenorganisation.  Richtig gemacht kann ich immer
noch unendliche Datentöpfe anhäufen, und das ganz ohne Gefahr.  Ich muss nur sauber pseudonymisieren.
Dann muss ich mich auch nimmer darum kümmern, was passiert, wenn diese Daten Beine bekommen.

Den die pseudonymisierten Daten kann ja keiner mehr zusammenfügen, so dass ein Personenbezug entsteht.


# Konkretes Beispiel

Der Landkreis Augsburg chippt die Mülltonnen.

Auf meiner Mülltonne prangt seitdem im Klartext ein Aufkleber mit:

- Meinem Namen
- Und meiner vollständigen Adresse

Bevor der Landkreis diese Daten aufgeklebt hat, hat mich der Landkeis nicht gem. DSGVO über diese Datenverarbeitung aufgeklärt.
Und auch auf mein Nachfragen hin hat er sich geweigert, eine entsprechende DSGVO-konforme Erklärung abgzugeben.

Verstößt der Landkreis also gegen die DSGVO?

Mitnichten!  Denn diese Daten sind nur gemäß des alten Datenschutzrechts personenbezogen,
gemäß der neuen DSGVO sind sie es nimmer.

Nochmals zum Mitdenken:

Mein Name samt meiner Adresse prangt offen für jeden lesbar auf der Mülltonne.
Und es ist tatsächlich meine Mülltonne, auf der dieser Aufkleber klebt.

Und *trotzdem* gibt es dort keinerlei personenbezug zu mir gem. DSGVO!

**Behaupte nicht ich.  Behauptet der Landkreis Augsburg.**

Aber nach reiflicher Überlegung denke ich, er hat damit Recht!
Dieses Vorkommnis hat bei mir jedenfalls zu einem wesentlichen Verständnis der DSGVO beigetragen.
Ich habe sie nämlich deswegen genauer studiert.  Und bin dabei zu diesem Schluss gekommen:

Der Datenschutzbeauftragte des Landkreis Augsburg hat mit seiner Aussage absolut Recht!
Aus der DSGVO lässt sich nirgendwo herauslesen, dass diese Kombination meiner Daten
einen Personenbezug darstellen würden!

Tatsächlich ist es nämlich so (die Einrückung ist das, was mir der Datenschutzbeauftragte erklärte):

> Die Adresse auf der Mülltonne ist die Adresse des Hauses, in dem ich wohne.

Das Haus ist nicht mit mir identisch.  In meinem Haus lebe nicht nur ich.
Aber selbst wenn nur ich dort wohne, ist dies ein reiner Zufall.
Jedenfalls nach dem Gesetz.  Denn niemand zwingt mich in das Haus.

> Die Adressangabe auf der Tonne ist deshalb ohne Personenbezug.

Sie bezieht sich nicht auf mich, sondern ganz klar nur auf den Standort der Mülltonne.
Es ist also eine rein technische Angabe.

Und mein Name?  Wieso steht dort mein Name drauf?

> Das ist eben nicht mein Name.  Es ist der Name desjenigen, der für die Müllentsorgung bezahlt.

Derjenige bin nicht ich, sondern ist der Hausbesitzer.  Das kann in Personalunion sein, muss aber nicht zutreffen.

Dieser Hausbesitzer trägt in meinem Fall - sozusagen zufällig - denselben Namen wie ich.
Aber diese Angabe ist nicht mit meiner Person identisch, sondern eben nur mit demjenigen,
der die Müllrechnung begleicht.  Und es ist nun enmal so, dass nicht überall dieser Jemand
dort wohnt, wo die Mülltonne beheimatet ist!  Und aus einem Namen ohne weitere Angaben
kann niemand einen Personenbezug herstellen.  Naja, in meinem Fall zwar schon,
denn mein Name ist weltweit ziemlich selten, aber bei Müller ist das halt anders.

Sprich, auch wenn da mein vollständiger Name samt vollständiger Anschrift auf der Mülltonne
steht, so hat das dann nichts mit mir zu tun.  Die Zusammenführung der Daten geschieht nicht,
um einen Personenbezug herzustellen, sondern es sind zwei voneinander unabhängige
PSEUDONYME Datensätze, die zusammen auf der Tonne kleben um zu ihr einen Bezug herstellen.

Und dieser eindeutige Bezug auf die Tonne funktioniert logischerweise nicht, wenn nur eine Adresse oder nur ein Name angegeben wäre.

Dass bei mir dadurch rein prozesstechnisch ein Personenbezug entsteht, das ist so nicht intendiert.
Es dürfte zwar häufig sein, aber bleibt trotzdem nicht beabsichtigt, da der Prozess,
der diesen Personenbezug generiert, offensichtlich nicht dazu geeignet ist, einen Personenbezug herzustellen.

Oder anders gesagt:

Wenn man lange genug 2 pseudonyme Daten zusammenwürfelt, kommt immer irgendwann ein vermeintlicher
Personenbezug heraus, der so aber nicht beabsichtigt ist.  Durch einen deterministischen
Vorgang kann man nicht zufällig gegen das Gesetz verstoßen.  Das geht nur fahrlässig,
wenn man den deterministischen Prozess falsch umgesetzt hat.  Das dürfte hier aber nicht
passiert sein, denn niemand kann aus der Angabe auf der Mülltonne ohne weitere Inormationen
einen Personenbezug herstellen.  Niemand!  Und wenn doch, dann irrt er, hat also einen
scheinbaren Personenbezug gefunden, der da aber dann nur durch Zufall halt gerade richtig
sein kann - oder aber in vielen Fällen auch nicht ist.


# Mit der DSGVO ist die Quantentheorie in der Rechtsprechung angekommen

Verstanden was das alles bedeutet?

Das bedeutet, dass es in der DSGVO eben keine einfache Ausage mehr geben kann
"dabei handelt es sich um personenbezogene Daten" oder "dabei handelt es sich
nicht um personenbezogene Daten".  Das konnte man früher machen.  Heute nimmer!

Heute kommt es immer auf den Kontext an, in dem die Daten stehen.

Was für den einen personenbezogene Daten sind, kann für jemand anderen nur eine
Ansammlung zusammengewürfelter Daten darstellen.  Und Umgekehrt!

Durch die Weitergabe können aus pseudonymisierten Daten plötzlich personenbezogene Daten werden,
genauso wie umgekehrt:  Ich kann meine personenbezogenen Daten so weitergeben, dass diese pseudonymisiert sind
(nur letzteres ist unkritisch - vorausgesetz ich habe mich nicht selbst belogen und den Prozess falsch implementiert).

Sprich:  Nicht die Daten entscheiden was sie sind, und auch nicht die Vergangenheit.
Sondern mit jedem Schritt, den ich tue, mit jeder Verarbeitung, muss ich mich jedes Mal neu entscheiden,
worum es sich bei den Daten handelt.

Das ist aber wesentlich besser als früher.  Früher waren mir die Hände gebunden.  Ich konnte keinen Einfluss nehmen.
Heute habe ich alle Freiheiten, aber halt auch alle Risiken.


# Und was bedeutet das für die IP?

Die IP ist erst einmal ein rein technisches Datum.  Eine Adresse einer Gegenstelle.

Das Internet ist P2P.  Damit ist die Erhebung, Speicherung und Verarbeitung von IPs unabdingbar.
Es ist ein grundlegender Eckpfeiler, wie das Internet funktioniert.  Und niemand erwartet, dass wir das ändern.

**Die IP ist unmöglich personenbezogen.**

Wäre die IP personenbezogen, darf ich sie nur mit Einwilligung bzw. Aufklärung der Person verwenden.
Ohne dies kann ich sie also weder erheben, speichern noch verarbeiten.
Da ich aber nicht weiß, welche Person gerade mit mir über die IP in Kontakt treten will,
kann ich nicht herausfinden, ob ich eine solche Einwilligung hätte!
Das kann ich niemals herausfinden, ohne die IP zu verarbeiten!

Wie soll ich nun einen Web-Request verarbeiten, wenn ich nicht antworten darf?  TCP benötigt nunmal Antwortpakete.

Damit ich also die Daten überhaupt empfangen darf, muss es mir erlaubt sein, beliebige IPs zu verarbeiten!
Somit kann die IP gar nicht personenbezogen sein, denn sonst greift die DSGVO.

Und selbstverständlich darf ich die IP auch ohne Einschränkung an Dritte weitergeben.
Das geht auch gar nicht anders.  Wenn ich das nicht dürfte, funktioniert das Routing im Internet nicht mehr,
genauso wie das mit den Kontrollpaketen (ICMP) oder Route-Servern nimmer funktionieren würde.

Und ich darf die IP auch anderweitig verarbeiten, sonst funktionieren weder NAT noch Tunneling,
alles Standardverfahren die in hohem Umfang im Internet eingesetzt werden (z. B. 6to4).

Wäre die IP ein personenbezogenes Datum, müssten wir das gesamte Internet EU-weit abschalten.
Und zwar sofort.  Und eine Alternative haben wir nicht (auch X25 hat einen Subscriber).

Wie der Aufdruck auf der Mülltonne ist die IP also genausowenig ein personenbezogenes Datum.

**Aber**

Selbstverständlich kann ich aus der IP ein personenbezogenes Datum machen, indem ich es mit weiteren Daten verknüpfe.

Es kommt also alleine auf die Nutzung der IP bei mir an, ob sie einen Personenbezug darstellt oder nicht.

Und aus der IP ein personenbezogenes Datum zu machen ist jedoch ziemlich schwer.
Selbst wenn ich den ISP kontaktiere, dem die IP zugeordnet wurde, und über diesen den Anschlussinhaber ermitteln könnte,
ist (vergleiche Mülltonne) noch nicht gesagt, dass ich die Person habe.

Und selbst wenn ich die IP ganz konkret den Daten eines meiner User zuordnen kann, also jemand, der mir bestens bekannt ist,
bedeutet das noch lange nicht (vergleiche Autokennzeichen), dass der Verursacher auch dieser User ist.

Wichtig in diesem Zusammenhang ist aber, dass ich eben nicht einfach so ausschließen kann, dass die IP ein personenbezogenes Datum ist.
Ich muss also bei jedem Schritt eines Prozesses darauf achten, ob die IP nicht plötzlich in dem Zusammenhang,
in dem ich sie verwende, einen Personenbezug erhält oder nicht.

> Das war früher übrigens anders.  Da war die IP ein personenbezogenes Datum!

Dieser Dualismus der IP ist aber technisch kein Problem.  Technisch kenne ich den Prozess.  Ich weiß, was dieser tut.
Ich habe den definiert und außerdem im Griff.  Statt jetzt die IP zu bewerten, kann ich den Prozess bewerten.
Und dann weiß ich, ob es eine Gefahr geben kann, dass eine IP einen Personenbezug erhält.

Natürlich kann meine Einschätzung sich als falsch erweisen.  Aber das ist dann ein normaler Bug, also ein
Implementierungsfehler, den man reparieren kann.

Nur schlecht wenn das Verfahren so alt oder unklar definiert ist, dass man eben genau diesen Punkt nicht verifizieren kann.


# Fazit

In der Regel kann die IP kein personenbezogenes Datum sein.

Allerdings muss ich höllisch aufpassen, dass ich diese nicht aus Versehen um einen Personenbezug ergänze.

> Es soll dazu ein höchstrichterliches Urteil geben.  Das würde ich gerne mal lesen.
> Leider wird es immer nur zitiert, aber die Quelle scheint geheim zu sein.
>
> Aber auch wenn es tatsächlich so ein Urteil gibt, die Technik können wir nicht ändern.
>
> Um per IP der DSGVO zu entsprechen, muss ich die IP verwenden, bevor ich der DSGVO entsprechen kann!
> Das kann ich aber nur, wenn die IP schon vorher der DSGVO entspricht.
> Somit kann ich die an personenbezogene Daten geknüpften Bedingungen in der DSGVO niemals entsprechen.
>
> Das ist nämlich schlicht unmöglich.
>
> Deshalb gehe ich schlicht davon aus, dass die Leute das Urteil alle nicht verstanden haben, die es immer so geheimnisvoll zitieren.
> (Dazu gehört übrigens auch die Wikipedia, die das ebenso behauptet, und zwar seltsamerweise ganz ohne Quellenangabe!)

Und folgendes [habe ich dazu bei der Wikipedia hinterlassen](https://de.wikipedia.org/wiki/Diskussion:6to4#Datenschutzaspekt:_Quellangabe_fehlt_und_vermutlich_veraltet)
(Kopie hier, weil meine Beiträge in der Wikipedia meistens eine Haltbarkeit von nur wenigen Millisekunden haben):

```
== Datenschutzaspekt: Quellangabe fehlt und vermutlich veraltet ==
Wo ist die Quellangabe zu diesem zitierten Datenschutzaspekt?  Wenn so etwas behauptet wird erwarte ich den Link auf das Urteil!
Auch nach ausführlicher Recherche konnte ich nur einen immer ubiquitär recycelten Fall finden, der wohl noch aus Datenschutzzeiten stammt.
War der hier gemeint?

Ich stimme dem zu, dass im alten BDSG die IPs personenbezogene Daten waren, weil das da auch genau so und nur so funktioniert hat.

In der DSGVO hingegen muss man bei personenbezogenen Daten *vor* Erhebung/Speicherung/Verarbeitung den Nutzer aufgeklärt haben.
Bringschuld!  Was logischerweise nicht geht ohne die IP zu verwenden, was man nur kann, wenn man die Dokumentation fälscht,
womit bewiesen wird, dass man gegen die DSGVO gehandelt hat.  Henne + Ei.

IMHO sind IPs in der DSGVO deshalb pseudonym.  Wenn nicht, müssten wir das Internet europaweit abschalten!
Nein, nicht HTTP, da kann ich die Datenschutzregeln theoretisch einblenden.

Es geht um Protokolle ohne Nutzerinteraktion, wie SMTP und DNS.  Ich kann aktuell schlecht verhindern, wer meinen Authoritaive-Primary verwendet oder mir mit seiner personenbezogenen IP da Mail auf meinen MTA legt.  Das interessiert die DSGVO aber nicht, die habe ich auch dann einzuhalten, wenn Nutzer mit ihrer personenbezogenen IP direkt an meine Server zugreifen!  Punkt!  Niemand in Europa kann unter diesen Bedingungen ohne DSGVO-Verstoß eigene Server betreiben, außer der lokale ISP, aber nur für seine eigenen Kunden, da er diese ja schon vorher kennt und ihnen die IP ausgegeben hat - wofür der Kunde die Datenschutzbestimmungen des ISP kennt.

Oder wir müssen halt ein neues DSGVO-Protokoll entwickeln, über das Nutzer die Bekanntgabe der Datenschutzbestimmungen abnicken können, ohne dabei die eigene IP preiszugeben.  Erst durch das Abnicken wird die IP des Nutzers zur Kommunikation am Server freigeschaltet, so dass wir die IP erheben/speichern/verarbeiten dürfen.  Damit wäre die Bringschuld der DSGVO sowie die erforderliche beweissichere Dokumentation erbracht.

Nein, ToR funktioniert nicht.  Ein Guard darf ebensowenig mit personenbezogenen IPs sprechen ohne vorher die DSGVO-Brinschuld erbracht zu haben!

Dazu fällt mir deshalb nur noch DNS mit TXT-Records ein, weil das über die DNS-Caches bei den ISPs abgewickelt werden könnte.
Ein spezieller Resolver beim Nutzer ruft den TXT-Record ab, lässt sich die Zur-Kenntnisnahme bestätigen und produziert - wieder via DNS - eine Rückmeldung, welche erst dann die IP am Server freischaltet.

Bleibt nur noch eine Frage:  Woher erhalte ich die Liste der nicht-personenbezogenen IPs, um den DNS abzusichern?  Oder braucht das sogar für jeden ISP in Euopa einen separaten Vertrag?  Fragen über Fragen!

Ich hoffe mal, die EUGH-Aussage ist schlicht nicht auf die DSGVO übertragbar.  Egal wie oft sie im Web gebetsmühlenartig - sogar von Juristen - weiter rezitiert wird.
--~~~~
```


# Ein paar Denkansätze zur DSGVO

- Ein Altsystems, das sich schon nicht akribisch an jeden Teil des Datenschutzgesetzes gehalten hat, auf die DSGVO umzustellen gleicht dem **Versuch, einen Mann zu schwängern**.  
  In solch einem Fall ist die einzige Chance die, das gesamte System komplett durch etwas Neues zu ersetzen, das von Anfang an der DSGVO entspricht.  
  Korollar mit Buzzwords:  
  Durch Anflanschen einer Blockchain an ein Altverfahren erhält dieses keinerlei Vorteile, sondern erbt lediglich alle Nachteile der Blockchain.  Um etwas auf Blockchain umzurüsten, muss man es schon komplett neu schreiben, damit es von Anfang an auf der Blockchain basiert.  Jeder andere Ansatz wird scheitern.

- Wer auf die Zustimmungslösung gem. Art 6(1)a setzt, heimst sich mehr Probleme ein, als in diesem Universum jemals gelöst werden können.
  Beispiel:  
  Cookie-Einwilligungen über ein Popup sind Null und Nichtig, und zwar aufgrund Art 7(2) Satz 2 wegen Art 7(3) Satz 4.  
  Denn wie kann ich genauso einfach widersprechen nachdem das Popup verschwunden ist?  
  Dass sie meistens auch noch gegen Art 7(4) sowie Art 30 Satz 3 verstoßen, ist hier gar nicht mehr relevant.
