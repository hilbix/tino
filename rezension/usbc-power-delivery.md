# Rezensionen

Ich suche derzeit eine Lösung, um ein Tablet mit Strom zu versorgen, das für ADB-Debugging per USB am Computer hängt.

Der Computer liefert leider nur 2.5W, was für den Erhalt der Ladung des Tablets nicht ausreicht.
Also bräuchte es

- einen PD-Adapter, den man dazwischen hängen kann,
- der die Kommunikation vom Tablet zum Computer nicht unterbricht
- und der gefahrlos betrieben werden kann auch wenn man eine Sache oder mehrere absteckt

Fündig wurde ich bisher leider nicht.  Hier aber die Rezensionen, die ich dazu auf Amazon geschrieben habe.
Damit ich sie wiederfinde und sie nicht verlorengehen.


## ANYOYO HB-PM31: 6-IN-12 USB-C Hub (mit 100W PD)

> Bezieht sich auf <https://www.amazon.de/dp/B0BLVWM5MY>
>
> Das Produkt war nur im Amazon-Shop vom Hersteller auffindbar und war nicht auf deren Homepage beschrieben.

**Als Dockingstation unbrauchbar, an OTG-fähigen Geräten ist es ein OTG-Adapter ohne Power-Delivery**

Ich konnte nur ein Szenario herstellen, in dem das Gerät tatsächlich so etwas wie PD erlaubt.  Nur tritt dieses Szenario im Regelbetrieb bei mir nicht auf, denn dafür habe ich günstigere Adapter.  Es kann durchaus ein Szenario geben, in dem der Adapter Power-Delivery zuverlässig bietet, dieses ist leider nur nicht spezifiziert.

Das Versagen der Power-Delivery-Funktion im den getesteten Szenarien ist immer und ausschließlich dem Adapter geschuldet.  Der Adapter ist nämlich nutzlos, wenn das jeweilige PD-Szenario nicht unterstützt wird.  Das kann man vor dem Kauf aber nicht erkennen, weil die Angaben das nicht erwarten lassen.  Somit muss man die Angaben als irreführend ansehen.

DESHALB KANN ICH VON DEM KAUF DIESES ADAPTERS UND ÄHNLICH KONSTRUIERTEN GERÄTEN (ich vermute, diese alle haben denselben Fehler) WARNEN!  VERMUTLICH WIRD MAN SCHIFFBRUCH ERLEIDEN, so wie im Weiteren von mir beschrieben.  Aus diesem Grund vermutlich auch die vielen diversen Rezensionen.  Bei den einen Leuten geht es, weil sie zufällig die Kombination haben, die tut, die anderen erwarten, dass es bei ihnen geht, aber.es.geht.net.

Außerdem habe ich ein bedenkliches Verhalten entdeckt, wenn man den Adapter als Dockingstation (wie beworgen) verwenden will.

Meine Erwartungen werden auch mit dem Argument "billig" nicht konterkariert. Der Verbraucher darf auch von den billigsten 230V-Mehrfachsteckdosen (die es früher im Baumarkt auch mal für unter 1 EUR im Angebot gab) erwarten, dass sie problemlos und ohne jede Einschränkung funktionieren.  Gleiches gilt genauso für USB-Equipment.  Und wenn da PD draufsteht muss da auch vollumfänglich PD drinnen sein, egal was der Konstrukteur sich darunter jetzt vorstellt, sondern was der Verbraucher sich darunter vorstellt.  Wenn die Nutzbarkeit stark eingeschränkt ist, wie hier, muss dies auch exakt, nachvollziehbar und für jeden(!) Laien verständlich dargestellt werden (damit meine ich einfach verständliche Warnhinweis wie "nicht hintereinanderstecken").

Hier müsste deutlich beschrieben werden, dass der Adapter

- an all seinen Ports nur max. 2.5W unterstützt
- Power-Delivery nur zum Gerät am angeschlagenen Kabel funktioniert
- und das auch nur, sofern dieses OTG nicht(!) unterstützt

Damit hätte ich zumindest gewusst, dass man dieses Teil nicht kaufen muss, weil es bei mir nicht funktionieren wird.

Darauf hinzuweisen, dass Power-Delivery auch an OTG-Geräten funktioniert, so lange der Adapter nicht über das angeschlagene Kabel mit Strom versorgt wird, wäre für Normalverbraucher bereits komplett unverständlich und damit eine irreführende Angabe, weil ausschließlich Computerfuzzis wie ich etwas damit anfangen können.

Der Adapter unterstützt jedenfalls keines der von mir getesteten Standard-Szenarien in denen ich PD erwarten würde.

Für die Tests verwendete Geräte:

Tablet das bei 9V bis 19W ziehen kann.  Die Grundlast bei eingeschaltetem Display ist ca. 3W.  Je nach Nutzung und Helligkeit steigt der Eigenverbrauch bis ca. 11W.
Handy das bis 9W zieht und dafür gerne 9V verwendet.
(Für PD über 9V habe ich derzeit noch kein Gerät.)
Diverse PD-Netzteile (z.B. Amazon-Basic), die PD im Bereich 20W bis 65W können.
Diverse USB-C zu USB-C-Kabel, darunter auch welche, die den Strom usw. messen.
Diverse USB-A zu USB-C Kabel.
USB-C zu USB-A Adapter, die vermutlich rein passiv sind, also streng genommen nicht der USB-C-Spec entsprechen, aber über die man USB-C-Kabel an USB-A-Adapter anschließen kann.
Und natürlich dieser Adapter.


Fehlschlag 1:  Nach Stromausfall kein PD

Man steckt das Netzteil an den PD-Eingang.  Blaue LED geht an.
Man steckt das kurze Kabel ins Tablet.  Das Tablet wird mit 9W bei 5V geladen.
Nun Stromausfallsimulation:  Man schaltet das Netzteil ab.
Die LED geht kurz aus, der Adapter ist nun im OTG-Modus.
Man schaltet das Netzteil an.

Erwartung:  Die LED blinkt kurz, das Tablet wird wieder geladen.

Aber Ergebnis: Die LED bleibt an, das Gerät wird nicht geladen.

Der Wechsel von PD auf OTG funktioniert, der Wechsel von OTG auf PD nicht.  Damit ist das Gerät für seinen Hauptzweck vollkommen unbrauchbar.  Z. B. im Auto:  Wenn man die Zündung anschaltet kommt PD hoch, dann erwarte ich, dass das verkabelte Tablet versorgt wird.  Wird es aber nicht.

Dass der Wechsel von OTG in PD nicht funktioniert kann nicht auf eine fehlerhafte Implementierung im angeschlossenen Gerät oder einem fehlenden Standard in der USB-Spec geschoben werden, denn die Lösung muss ZWINGEND vom Adapter kommen, sonst ist er komplett nutzlos.


Fehlschlag 2: Adapter an Tablet um es mit Strom zu versorgen

Man hat einen Computer mit USB3 (oder USB-C ohne PD).  An diesen Anschluss ist ein Tablet angeschlossen, das 3W oder mehr braucht.  Schließt man das Tablet an den Computer an wird es entladen, da der Computer nur 2.5W liefert (USB3 ohne PD erlaubt nur 0.5A bei 5V).

Also schaltet man diesen Adapter dazwischen:

Das Kabel, das vom Computer zum Tablet führte, kommt in den USB-C-DATA-Anschluss vom Adapter.
Das Netzteil kommt an den PD-Anschluss vom Adapter.
Das kurze Kabel vom Adapter steckt man in das Tablet.

Das Tablet wird jetzt vom Strom versorgt (so lange es nicht auf OTG schaltet jedenfalls).  Aber der Computer sieht das Tablet nicht.

Das ist vermutlich dem USB-Standard geschuldet.  Das eingesetzte USB-Kabel kann vermutlich kein Host-zu-Host-Modus.  Das sind aber Details, die den Käufer dieses Adapters grundsätzlich nicht interessieren.  Der Käufer muss erwarten können, dass der Adapter dieses Standard-Szenario meistert, weil er ja "einfach nur dazwischengesteckt wird" (wie eine Mehrfachsteckdose beim Strom).  Genau das funktioniert aber nicht einmal ansatzweise.

Dass der Adapter die vom Verbraucher erwartete Funktion bietet, die der USB-C-Standard eigentlich nicht (direkt) unterstützt, ist keine unzulässige Forderung.  Wir haben 2023.  USB-C-Hubs müssen jetzt beim Verbraucher genauso einfach funktionieren wie 230V-Mehrfachsteckdosen (auch beim Strom kann man den Stecker ja andersherum einstecken, usw.).  Damit das so ist und wie das erreicht wird, dafür sind die Konstrukteure verantwortlich.  Es ist ihre Aufgabe, Unzulänglichkeiten vom USB-Standard entsprechend zu umschiffen.


Fehlschlag 3: Adapter an Computer

Also dreht man die Sache um:  Alles abstecken, kurz warten (damit sich der Adapter rücksetzt), nun umverkabeln:

Netzteil an den PD-Anschluss.  LED leuchtet.
Tablet an den USB-C-Anschluss.  Das Tablet wird nun mit 5W versorgt (1.1A bei 4.9V).  Es bleibt hier allerdings bei der geringen Ladeleistung mit 5V, was IMHO bereits einen Fehlschlag darstellt (allerdings steht ja da "laden wird nicht empfohlen", was wohl darauf hinweisen soll, dass dieses Szenario hier nicht unterstützt wird, was ich als "extrem irreführend" bezeichne).

Nun steckt man den Adapter in den Computer.  Und dann sinkt(!) die Versorgung des Tablets auf 0.5A, also etwa 2.4W.

Was ist passiert?  USB ist passiert.  Der Computer erkennt das Gerät und stellt die maximal zulässige Energiemenge am USB-Port ein.  Das sind gemäß Standard 0.5A, weil der Computer ja nichts vom PD weiß.  Wie sollte er das auch?

Stimmt natürlich, das ist ein Fehler, der nur deshalb auftritt, weil der Adapter sich an die USB-Spec hält!

Trotzdem ist es ein Fehler vom Adapter, den wiederum interessiert sich der Käufer, mit Verlaub auf gut Bayerisch gesagt, einen absoluten Scheißdreck für den USB-Standard.  Der Käufer muss erwarten können, dass es einfach nur funktioniert, und die Konstrukteure eines solchen Adapters haben dies entsprechend umzusetzen.  Das zu tun ist ihr Job!

Wie sie das lösen ist nicht mein Problem, oder das des Verbrauchers, sondern der der Konstrukteure.  Ob dies durch Schalter oder spezielle weitere Ports geschieht, ist auch nicht mein Problem, sondern deren.


Fehlschlag 4: Adapter als Zwischenstecker

Netzteil am PD-Eingang.
Tablet am USB3-A.  Das Tablet bekommt 5W (1A)
Das Anschlusskabel vom Adapter bleibt unverschaltet.
USB-C vom Computer am USB-Data-Eingang vom Adapter.  Das Tablet bekommt nur noch 3.5W (0.7A)

Auch dieses Szenario funktioniert nicht.  Der Host sieht das Tablet nicht.
Steckt man das Netzteil ab, wird  trotzdem weiter geladen, dabei zieht der Adapter den Strom über den USB-C-Data-Port.  Das bleibt auch so, wenn man das Netzteil wieder verbindet, d. h. es wird nicht wieder aufs Netzteil zurückgeschaltet.

Streiflicht:  Stecke ich den USB-C-Port am Computer in dieser Situation ein oder aus, geht bei mir einer der angeschlossenen Monitore aus, und zwar der, der an USB-C hängt.  DVI und HDMI sind nicht betroffen.  Ich bin dem nicht weiter nachgegangen.

Hinweis:  Das Szenario ist nur der Vollständigkeit halber enthalten, denn gemäß USB-Standard kann es so (eigentlich) gar nicht funktionieren.  Insbesondere dass der Adapter plötzlich den Strom vom Data-Port zieht (und dabei bleibt) kam für mich unerwartet.

Wenn ich es richtig verstanden habe (ich bin kein USB-Guru!) kann USB-C Multi-Host, bei Host-to-Host sind aber (vermutlich) für eine Datenkommunikation spezielle Kabel notwendig, die diesen Modus ebenfalls unterstützen.  Außerdem muss das auch im Adapter vorgesehen sein, damit er am jeweiligen Port den passenden Modus erlaubt (ob es so ist kann ich mangels Möglichkeiten nicht ermitteln).

Vor einem Problem mit dem alten USB2 aber schützt USB-C dann doch:  Wenn man etwas falsch zusammensteckt passiert nichts schlimmes.  Im "alten" USB-2-Standard, wenn man ein (passives) USB-A-zu-USB-A-Kabel verwendet hat, konnten schlimme Dinge (bis hin zum Hausbrand) passieren.  Dies ist (dank aktiver Kabel) bei korrekter Umsetzung von USB-C ausgeschlossen.

Dies trifft auch auf diesen Adapter zu.  Aus meiner (unmaßgeblichen) Sicht hält er wohl alle USB-C-Standards ein.  Aber erlaubt nichts darüberhinausgehendes.

Anders gesagt:  Es handelt sich eigentlich nur um einen OTG-Adapter, dem eine PD-Option hinzugefügt wurde, die aber nur dann funktioniert, sobald das am Kabel angeschlossene Gerät (wie ein Computer) nicht über OTG verfügt.

Siehe dazu ganz unten.


Fehlschlag 5: Umgekehrter Fehlschlag 4

Ich habe der Vollständigkeit halber noch die umgekehrte Variante probiert.

Netzteil am PD-Eingang.
Tablet am USB3-C-Data.  Das Tablet bekommt 5W (1A)
Das Anschlusskabel vom Adapter bleibt unverschaltet.
USB-C vom Computer am USB3-A vom Adapter.  Das Tablet bekommt weiterhin 5W.

Stecke ich das Netzteil ab wird weiter geladen.  Hier fließt der Strom vom Computer zum USB-A am Adapter und dann über USB-C-Data zum Tablet.  Das ist für mich vollkommen unerwartet!

Stecke ich das Netzteil wieder an, wird es wieder nicht mehr verwendet.

Komplett abstrus wird die Sache, wenn ich Computer und Netzteil ausstecke.  Dann blinkt die LED.  Hängt der Adapter also am Tablet das OTG kann, dann passieren "seltsame Dinge" die eigentlich nicht passieren dürften.

Siehe dazu ganz unten.



Funktioniert: Aktiver Hub bis 0.5A

Das ist dann auch das entsprechende einzige Szenario, das irgendwie ansatzweise funktioniert hat.

Man schließt es an ein Gerät an, das kein OTG erlaubt und dessen USB-Port zu wenig Ausgangsleistung.  Dank des PD-Eingangs funktioniert der Adapter nun als stinknormaler als aktiver USB-Hub und erlauben alle USB-Ports entsprechend 0.5A.

In diesem Fall dürfte das Gerät vom Adapter über das kurze Anschlusskabel auch zuverlässig mit PD versorgt werden.  Dies konnte ich - mangels Gerät das an USB-C kein OTG unterstützt - leider nicht testen.  Die Angabe "und andere USB-C-Geräte" im Titel ist somit irreführend.


Fazit:

Dieser Adapter ist für so gut wie alle PD-Szenarien komplett unbrauchbar.  Für alle anderen Szenarien ist er zu teuer, dafür gibt es deutlich günstigere Adapter.

Dass er sich aber über USB3-A mit Strom versorgen lässt und sich im Zusammenhang mit OTG-Geräte am USB-C-Data-Ausgang seltsam verhält, bewerte ich als eindeutigen Fehler von dem Adapter.  In wieweit das sogar eine Gefahr darstellt, also Komponenten in einen unzulässigen Betriebsmodus gelangen können, kann ich nicht beurteilen, halte das aber für äußerst Wahrscheinlich.

Wer jetzt einwirft "ja aber so betreibt man den Adapter nicht", liegt leider komplett falsch!

Laut Beschreibung ist das Gerät auch eine Docking-Station.  Also muss es als Docking-Station verwendbar sein.

Wie sieht der Betrieb da aus?

Nun, man hat einen (nicht OTG-fähigen) Computer am Anschlusskabel vom Adapter.
Der Adapter wird über das PD-Netzteil mit Strom versorgt.
Am HDMI-Port hat man den Monitor angeschlossen.
Am USB-C-Data-Port ein Tablet.

Alles super soweit, das Tablet lädt war nicht ordentlich, aber das macht nichts, es geht ja um die Datenübertragung zwischen Tablet und Computer oder wie auch immer.

Nun steckt man den Laptop von der Dockingstation (dem Adapter) ab und schaltet vom Desktop den Strom ab (ich kenne Arbeitgeber, die verlangen, dass der Arbeitnehmer am Tagesende die Computer über einen Schalter vom Netz nimmt).

Das PD-Netzteil wird also stromlos.  Der Computer steckt nicht am Kabel.  Einzig das Tablet hängt noch (über USB-C-Data) am Adapter.

Erwarten würde ich nun, dass der Adapter abschaltet, und damit auch das Tablet in den Schlafmodus geht.  Gute Tablets überleben in diesem Modus mehrere Wochen bzw. fahren selbständig rechtzeitig runter.

Was ich auf keinen Fall erwarte ist, dass jetzt die LED am Adapter an wie wild anfängt zu blinken, vermutlich weil das Tablet erfolglos versucht, OTG zu aktivieren, und so nicht zur Ruhe kommen kann.

Und was passiert, wenn dann noch Tastatur und Maus am Adapter stecken - ist ja eine Dockingstation - will ich gar nicht wissen.  Da der Adapter als Dockingstation beschrieben wird muss man das sogar als gravierenden Fehler des Adapters begreifen.  Von einer Docking-Station erwarte ich jedenfalls kein solches Verhalten.   Punkt aus und Ende.

Auf weiterführende Tests (wie den HDMI-Ausgang) habe ich verzichtet.

