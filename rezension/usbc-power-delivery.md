# Rezensionen

Ich suche derzeit eine Lösung, um ein Tablet mit Strom zu versorgen, das für ADB-Debugging per USB am Computer hängt.

Der Computer liefert leider nur 2.5W, was für den Erhalt der Ladung des Tablets nicht ausreicht.
Also bräuchte es

- einen PD-Adapter, den man dazwischen hängen kann,
- der die Kommunikation vom Tablet zum Computer nicht unterbricht
- und der gefahrlos betrieben werden kann auch wenn man eine Sache oder mehrere absteckt

Fündig wurde ich bisher leider nicht.  Hier aber die Rezensionen, die ich dazu auf Amazon geschrieben habe.
Damit ich sie wiederfinde und sie nicht verlorengehen.

## 5 in 1 USB C Hub, PD 60W, HDMI 4K, Aluminiumgehäuse, 1x USB3, 2x USB2

> Bezieht sich auf https://www.amazon.de/dp/B0BNNJ3N7N
>
> 3 Sterne

**Für den Preis brauchbar, aber PD will aber nicht mit allen Geräten**

Diese Rezension befasst sich hautpsächlich mit PD.  Hier ist der Hub brauchbar, wenn das Zusammenspiel mit dem Gerät funktioniert.

Für unterwegs an einem (in meinem Fall Samsung-) Handy scheint er deshalb sinnvoll verwendbar zu sein.  Und für den Preis einer Lahmacun ist die Leistung vom Hub vermutlich ebenfalls in Ordnung.  Allerdings habe ich den Hub auch nur hauptsächlich auf seine PD-Fähigkeit getestet.  Und die Angaben zum Hub erscheinen mir dann doch etwas zu marketingtechnisch weichgespült, lückenhaft und sogar übertrieben, deshalb 1 Stern Abzug.

Das Teil hat an meinen beiden Tablets nämlich versagt, denn diese werden nur mit max. 2,5W (also USB-Standard) geladen, was für die Tablets nicht einmal im Standby ausreicht (nur im Schlafmodus).  Die möglichen 3A bei 5V (sowohl mit Raspberry-PI-Netzteil mit 15W sowie PD-Netzteilen z.B. wie dem Amazon-Basic 65W getestet) werden nicht ans Tablet weitergegeben.  Ansich sollten meine beiden Tablets wohl bis zu 19W bei PD unterstützen, aber hier kommt es anscheinend zu Inkompatibilitäten.  Ob das dem Hub selbst zuzuschreiben ist kann ich nicht beurteilen.  Es können auch Tablet, Kabel, Netzteile oder Akkustand eine Rolle spielen.  Wildwest leider.  Trotzdem dafür 1 Stern Abzug, denn niemanden interessiert, warum es mit diesem Hub nicht geht, sondern nur, dass es mit diesem Hub nicht geht.

Ob der Hub wirklich 60W PD unterstützt kann ich nicht feststellen.  Mein messendes USB-C-zu-USB-C-Kabel meldet jedenfalls, dass zum Hub PD aktiviert wurde wenn das Handy am Kabel vom Hub hängt.  Da mein Handy aber selten mehr Leistungen als 6W abruft, sagt das nicht viel aus.  Jedenfalls wird das Handy normal (also schnell und mit deutlich mehr als 2,5W) geladen.

Fällt der Strom aus, geht der Hub in den OTG-Modus, zieht also den Strom vom Handy.  Allerdings verlässt er diesen auch wieder, sobald der Strom zurückkommt, und lädt das Handy dann mit PD weiter.  Das geht sogar mit dem Netzteil vom Raspberry-PI (das IMHO gar kein "echtes" PD unterstützt).  Und das Handy wird ebenfalls über den Hub geladen, wenn es abgeschaltet ist.

Bei meinen Tablets verbleibt der Hub aber dauerhaft im OTG-Modus und zieht weiterhin den Akku vom Tablet leer, bis man den Hub vom Tablet absteckt und wieder ansteckt.

PD funktioniert, aber wohl nur mit ausgewählten Geräten, dann aber so, wie man es sich wünscht.

Den HDMI-Ausgang konnte ich nicht testen, mangels Geräten, die das bei mir unterstützen.  Jedenfalls hat noch kein USB-C-zu-HDMI-Adapter am Handy oder Tablet irgendeine Anzeige über HDMI ermöglicht.  Schade dass der HDMI-Port nutzlos ist, aber man kann dem Hub ja nicht anlasten, was die an ihn angeschlossenen Geräte nicht eingebaut haben.

Der günstigste Hub aus der Reihe hat 2 USB2-Ports und "nur" einen USB3-Port.  Das reicht aber für Tastatur und Maus (an USB2) sowie einen USB-Stick (an USB3).  Der Stick darf dann aber nicht zuviel Strom ziehen.  Anspruchsvollere USB-Geräte (wie SSD, Festplatte, CD-Brenner, etc.) dürften vom Hub also deutlich zu wenig Strom bekommen, unabhängig davon, ob er mit Netzteil betrieben wird oder nicht.

An allen 3 Ports konnte ich maximal 2,5W entnehmen.  Das entspricht den nach USB zulässigen 0,5A (vielleicht können einige Geräte den USB3 auch auf 4,5W hochstufen, aber dafür habe ich keine Testmöglichkeit).  Interessant dabei ist, dass der Hub die 2,5W auch liefert, wenn nichts sonst angeschlossen ist.  Also nur Netzteil und ein Gerät an einem der USB-Anschlüsse und das Gerät bekommt 0,5A!  Auch wenn das Netzteil wesentlich mehr liefert.  Sprich:  Der Hub selbst hat wohl ein eingebautes USB-Power-Management auch dann, wenn der eigentliche USB-Host fehlt.  Das ist gut und habe ich auch schon katastrophal anders gesehen.

Der PD-Eingang ist auch wirklich nur ein PD-Eingang.  Er aktiviert sich auch, wenn man an dem PD-Eingang einen OTG-Ausgang anschließt - dann aber halt ohne Datenfunktion.  Auch das habe ich schon anders gesehen.

Dass der Hub keinen USB-C-Ausgang hat und auch "nur" USB 3 mit 5 MBit/s bietet war bei mir kein Kaufkriterium, mir ging es mehr um einen günstigen Preis und PD.  Mit einem sehr günstigen passiven Adapter kann man an den USB-3-Port ja auch ein USB-C-Kabel anstecken.  Diese Dinger gibt es 10-Stück-weise für knapp 1 EUR/Stück und ihre Anschaffung lohnt sich, weil man so heute schon alles mit USB-C-Stecker kaufen kann, auch wenn man es an einen USB-A-Ports anschließen will.  Inzwischen kosten Geräte mit USB-C-Stecker ähnlich viel und manchmal sogar etwas wenig wie dasselbe Gerät mit USB-A-Stecker.

Gut ist ebenfalls, dass man diesen Hub als einfache Docking-Station verwenden kann, denn ich konnte den Hub durch "wildes herumstöpseln" in keinen "seltsamen" Zustand bringen (vermutlich ist das dem eingebauten Powermanagement zu verdanken).  Das habe ich bei anderen Geräten, die sich hochmütig "Dockingstation" schimpfen, leider schon deutlich anders gesehen.

Auch das Gehäuse finde ich gelungen.  Über Stabilität, Datenübertragungsqualität, Dauereinsatz, Haltbarkeit (insbesondere des angeschlagenen Kabels) usw. kann ich nicht urteilen, diese Rezension entspringt nur schnell und vorläufig von mir vorgenommenen Tests.

Fazit:

Für den Preis OK, aber nicht jeder wird damit glücklich.  Sollte der Hub doch nicht mit den gerade verwendeten Geräten richtig zusammenspielen, wird sich das in Zukunft mit ziemlicher Wahrscheinlichkeit ändern.  Deshalb, wenn man so etwas sucht und die Möglichkeit besteht, dass alles klappt, sollte man hier erst einmal zugreifen, bevor man sich teureren Adaptern zuwendet.


## CSL - USB 3.2 Gen2 Hub aktiv inkl. Netzteil - 4 Port Hub/Verteiler

> Bezieht sich auf <https://www.amazon.de/dp/B0BXMKFXS1>
>
> 3 Sterne

**Hub bedingt brauchbar, Tablet wird mit fast 8W geladen, Netzteil verbesserungswürdig**

Ich möchte ein Tablet dauerhaft per USB an den Computer anschließen.  Bei eingeschaltetem Display zieht das Tablet etwa 6W.  Der Verbrauch des Tablets steigt im Betrieb bis 9W und kann kurzzeitig durchaus 11W erreichen.  Das Szenario ist also:

- Das Tablet wird mit seinem Kabel an einen der 4 USB-Ports vom Hub angeschlossen.
- Der Computer wird über das mitgelieferte Kabel an den Hub angeschlossen.
- Das Netzteil versorgt dann das Tablet mit ausreichend Strom, damit es sich nicht entlädt.
- Der Computer kann als USB-Host mit dem Tablet eine Verbindung aufnehmen.

(Hintergrund ist Android Development, z.B. "adb devices".)

Dies alles kann - mit Einschränkungen - mit diesem Hub tatsächlich erreicht werden und ist schoneinmal eine Empfehlung für diesen Hub.  Andere Hubs (inbesondere solchen mit OTG und PD) haben bei mir in dieser Hinsicht kläglich versagt, teils weil sie sich zu akribisch an den USB-Standard halten, aber auch mit evtl. gefährlich aussehenden Nebenwirkungen.  All diese typischen "Problemchen" konnte ich bei diesem Hub bisher nicht entdecken.

Mein altes Tablet kann an diesem Hub nur geladen werden (keine Datenübertragung).  Mein neuestes Tablet hingegen kann, während es geladen wird, auch über Daten angesprochen werden.

Der Hub liefert bei mir bis zu 7,9W an das Tablet, was bedeutet, dass sich das Tablet gerade so noch leicht aufladen kann.  Der Akku wird also nur zur Pufferung bei höherer Belastung genutzt.  Leider reicht der Hub eben nicht aus, um das Tablet in allen Phasen vollständig mit Energie zu versorgen, dazu müsste er deutlich mehr als 2,5A abgeben können.

Dass er das nicht kann war aber beim Kauf bekannt (siehe Technische Daten), deshalb kein Abzug von Sternen.  CSL täte aber gut daran, ein deutlich stärkeres Netzteil beizulegen, so dass man auch einen aktuellen Raspberry-PI 4 damit betreiben könnte.  Dieser braucht bis zu 3A, d.h. das Netzteil sollte 3,2A und stabile 5V (oder besser 5,1V) liefern, und zwar nicht nur am Netzteilausgang sondern am Stromeingang vom Hub.  Bei dem aufgerufenen Preis für das Netzteil muss das einfach drinnen sein!

Ohne Netzteil wird das Tablet übrigens gar nicht mit Strom versorgt (0W und 0A), es werden lediglich die Daten transferiert.  In sofern wäre der Hub ohne Netzteil für mich vollkommen nutzlos!

Für mich ist eine Notwendigkeit, dass der Hub nach Stromausfall die Stromversorgung zum Tablet wiederherstellt.  Dies ist hier gegeben.  Der Hub versorgt das Tablet auch mit Strom, wenn der Computer abgeschaltet oder gar nicht angesteckt ist.  Auch das ist genau das, was ich benötige.

Real bedeutet das übrigen, dass der Hub hier höchstwahrscheinlich die USB-Spezifikation nicht vollständig einhält und statt den Strom am Port mit dem Gerät auszuhandeln, einfach den vollen "Saft" auf den Port gibt.  Was aber genau das ist, was man in meinem Fall braucht!  Deshalb auch kein Abzug von Sternen dafür!

Anders gesagt, die Konstrukteure dieses Hubs haben etwas zusammengebaut, was man als Verbraucher tatsächlich benötigt, statt sich akribisch an die Standards zu halten (dies führt aber u.U. zu Problemen, siehe weiter unten).  Das Marketing hat dann das Netzteil hinterrücks wieder "kaputtgespart".  Jenfalls ist es das meine Meinung und entspräche voll dem total normalen Wahnsinn unserer Jetztzeit.

Gemäß USB-Standard würde das Tablet nämlich nur mit max. 2,5W versorgt, bis Computer und Tablet mehr aushandeln.  Da der Computer das nicht tun würde (weil er davon nichts weiß oder noch gar nicht angeschlossen wurde) gibt es eigentlich keine andere sinnvolle Möglichkeit, als es so zu machen, wie dieser Hub.

Indiz für die Standardabweichung ist für mich, dass die bei mir eingesetzten messenden Ladekabel beim einseitigen Einstecken in den Hub sofort eine vorhandene Stromversorgung mit 5,3V anzeigen.  Die Kabel sind für PD bis 120W zertifiziert, steckt man sie in den Computer an USB-3 oder standardkonforme Hubs oder PD-Ports, dann zeigen sie keinerlei Stromversorgung an, bis diese mit dem jeweiligen Gerät ausgehandelt wurde.  In diesem Fall hängt aber noch gar kein Gerät (das Tablet) dran und trotzdem sehe ich die Stromversorgung.  IMHO lässt die USB-Spezifikation solche "Grundstromversorgungen" zu, allerdings nur bei 5V bis max. 0,5A (also mickrige 2,5W, um billige USB-Kabel nicht zu überlasten, was ja zu Hausbränden führen könnte).

Deshalb:  Wenn man den Hub mit angeschlossenem Netzteil benutzt, unbedingt immer nur hochwertige Kabel verwenden, die bei einem Kurzschluss auch einen Strom von knapp 2A dauerhaft aushalten ohne dabei Feuer zu fangen.

Da das von mir eingesetzte Ladekabel erlaubt übrigens nur USB-2-Geschwindigkeit (also 480 MBit/s), deshalb habe ich die versprochenen USB 3.2 Gen 2 (also 10 GBit/s) vom Hub nicht getestet.

-----

Wie komme ich zu meiner Wertung?

Ich setze messende USB-C-auf-USB-C-Kabel zum Tablet ein.  Diese stecke ich über einen passiven USB-A-Adapter an den Hub.  Das Kabel meldet dann 7,9W bei 4,7V und 1,7A.  Das ist weniger als ich mir erhofft hatte, denn der Hub wird ja mit 5V 2A beworben.

Die Leerlaufspannung beträgt 5.3V.  Das bedeutet einen Spannungsabfall von 0,6V bei 1,7A, was entweder auf zu hohe interne Verluste oder ein schlecht stabilisiertes Netzteil hindeutet.  Wenn 2A draufsteht sollten auch 2A abgegeben werden können, und das ohne einen so hohen Spannungsabfall und ohne dass das Netzteil dabei nennenswert warm wird.  Beides ist nicht der Fall.  Das Netzteil wird allerdings nur etwas mehr als handwarm, also nichts bedenkliches.  Ich hoffe, es hält bei voller Belastung durch.  Der Hub selbst bleibt übrigens kalt. 

Für den vollkommen unverständlich hohen Zusatzpreis eines derart schwachen Netzteils ziehe ich deshalb einen Stern ab:

Der Aufpreis für das Netzteil beträgt 8 EUR.  Das ist mehr als ein gutes Raspberry-PI-Originalnetzteil ohne Porto und Verpackung kosten würde, welches ohne Murren dauerhaft stabile 3A liefern würde.  (Leider kann man das PI-Netzteil hier nicht verwenden.)

Wie gut der Hub selbst funktioniert habe ich nicht gemessen.  Erste schnelle Tests ergeben:

Nur das neueste Tablet erscheint in "adb devices".  Mein altes Tablet lädt an diesem Hub, aktiviert aber kein USB, und zwar unabhängig ob der Hub mit dem Netzteil mit Strom versorgt wird oder nicht.  Das kann dem Tablet geschuldet sein, aber an anderen Hubs wird es erkannt.

Dafür ziehe ich einen weiteren Stern ab, denn es scheint Geräte zu geben, die mit diesem USB-Hub nicht zusammenarbeiten wollen.  Ich vermute, mein altes Tablet erkennt den Hub fälschlich als Netzteil und deaktiviert damit seine USB-Hardware um Strom zu sparen.

Übrigens teilen sich die 4 Ports die Stromversorgung.  Stecke ich beide Tablets an meldet das eine Kabel z.B. 4,2W, das andere 6,1W.  Bei 4,7V.  Somit würden die versprochenen 10W tatsächlich erreicht werden.  Weil die Spannung aber zu stark einbricht erreiche ich an einem einzelnen Port vermutlich nicht die volle Leistung.

-----

Fazit:  Dies ist nur eine vorläufige Bewertung ohne die Übertragungsleistung und Stabilität des Hubs selbst zu bewerten.  Sollte ich gravierende Mängel feststellen, werde ich diese Rezension vielleicht überarbeiten.

Wer, wie ich, ein Teil braucht, das ein Zwischending von einem USB-2A-Netzteil alter Bauart (also nicht-PD) und USB-Hub benötigt, der kann hier zugreifen.  Allerdings finde ich den Preis von über 20 EUR dafür nicht besonders attraktiv, insbesondere da es sich bei dem Hub um "das alte USB" handelt, auch wenn er bereits USB 3.2 unterstützt.

Nachteilig ist auch, dass der Hub nur maximal schlappe 2A liefert, also nicht einmal genug für einen Rasberry-PI 4 (oder PI400), welcher ja 3A bei stabilen 5V benötigt.  Und moderne Tablets sollten ebenfalls dauerhaft mit 15W versorgt werden, was eben 3A entspricht.

Verglichen mit USB-C-OTG-PD-Adaptern, mit denen ich bisher nicht in der Lage war, das Tablet vernünftig an den Computer anzuschließen, erleidet man mit diesem Hub wenigstens keinen direkten Schiffbruch.

Zu bedenken ist auch, dass sich die 4 Ports die Energieversorgung teilen.  Die 5V 2A entsprechen also genau den 5V 0,5A je Port, die ein USB-Hub leisten muss.

Im Text zum Artikel steht außerdem etwas irreführend "alle Geräte mit hoher Stromleistung versorgen".   Das stimmt, wenn man unter "hoher Stromleistung" den alten USB-Standard versteht, der nur 5V mit 0,5A erlaubt hat.  Das haben wir mit PD und USB 3.2 eigentlich schon lange überwunden!

Tatsächlich kann man mit angestecktem Netzteil wohl 2 Geräte mit 900mA versorgen bzw. ein einziges Gerät mit deutlich mehr (1700mA).  Das ist immerhin etwas.

Übrigens:

Es gibt sehr praktische und günstige passive Adapter, die aus den USB-A-Ports USB-C-Ports machen, meine Kritik am "veralteten USB" betrifft deshalb nicht die 4 Ports am Hub sondern die Anschlussbuchse des Kabels zum Hub.  Dazu kommt die inzwischen veraltete Stromversorgungsbuchse mit Rundstecker.  Denn beides sollte inzwischen in USB-C ausgeführt werden.

Die EU schreibt nämlich ab Ende 2024 vor, dass alle neu in den Markt gebrachten Kleingeräte - dazu dürfte auch dieser Hub zählen - für die Stromversorgung eine USB-C-Buchse verwenden müssen.  Für die Datenverbindung gibt es zwar noch keine solche Vorschrift, aber Kabel von USB-C auf Micro-USB3 sind teuer und unüblich, und die Adapter, die es erlauben das Kabel vom Hub in einen USB-C-Port zu stecken, belasten die USB-C-Ports meist mit zu hohen Torsionskräften, weil der alte USB-A-Stecker einfach zu klobig ist verglichen mit USB-C.

Wir haben es bei diesem Hub also mit einem kommenden Ladenhüter zu tun.  Dafür finde ich, ist der Preis zu hoch.  Allerdings führt das (bei mir noch) zu keinem weiteren Sternabzug.  Es ist ja deutlich zu sehen, was man da kauft, und es wird in dieser Richtung auch nichts falsches versprochen.

Ob und wie stabil der Hub die 10 GBit/s erreicht habe ich nicht einmal im Ansatz geprüft!  Das ist nicht Teil dieser Rezension.  Ich komme über USB mit "adb shell" auf das eine Tablet während es geladen wird, das ist vorerst alles, was ich wollte.



## ANYOYO HB-PM31: 6-IN-12 USB-C Hub (mit 100W PD)

> Bezieht sich auf <https://www.amazon.de/dp/B0BLVWM5MY>
>
> Das Produkt war nur im Amazon-Shop vom Hersteller auffindbar und war nicht auf deren Homepage beschrieben.
>
> (K)ein Stern.

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

