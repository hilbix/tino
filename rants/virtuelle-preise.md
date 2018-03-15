# Preise für virtuelle Güter

Was darf ein virtuelles Gut kosten?

## TL;DR

Alles oberhalb von 1 Cent/Bit ist absoluter Wucher der nicht mehr zu rechtfertigen ist.

Beispiel:

Ein Spiel verkauft eine "Powerup Lotion", die für 1h das Spiel beschleunigt.  Dafür verlangen sie knapp 5 EUR.

Das halte ich für an Kriminalität grenzenden Wucher (es grenzt von der Seite der Kriminalität an die Grenze, nicht von der Seite der Legalität).

Folgende Rechnung:

Ein solcher Item braucht typischerweise 16 Bit um gespeichert zu werden.
Da es aber vorkommen kann, dass ein Spiel tatsächlich mehr als 65536 Items hat, lassen wir es meinetwegen 32 Bit sein.
Die Anzahl der Items die man besitzt, ist unerheblich, die kauft man ja nicht mit.

Das ergibt für solch ein Item einen maximalen "Wert" von 32 Cent.

Evtl. besitzt das Item noch bestimmte Eigenschaften, man kann es also in N Vatianten kaufen.
Diese Varianten könnten ebenfalls nochmals 32 Bit benötigen.

Indem man viele Dimensionen an das Item dranhängt, könnten Firmen auf die Idee kommen, das beliebig aufzublasen.
Aus diesem Grund schlage ich einen Deckel von max. 3 Dimensionen a 32 Bit vor.

Ein solches Item kann also nicht mehr als 128 Bit haben (was nicht zufällig ja der Anzahl der IPv6 entspricht).
Ein Item kann also maximal 1,28 EUR kosten.

5 EUR hingegen liegt mit Faktor 4 zu hoch (ich rechne gerundet mit 512 Cent).  Wenn man von 32 Cent ausgeht, sind das sogar Faktor 16!

Sorry, aber das nenne ich schon krminiell!


## Was sind "virtuelle Güter"

Das sind Dinge im Spiel, die man einzeln kaufen kann.  Also z. B. Kleidung für den Charakter, oder andere Dinge die man im Spiel gebrauchen oder verbrauchen kann.

Ein Bundling ist zwar möglich, das erhöht aber die Bitzahl nur mäßig.
Da man ja nicht den Inhalt des Bundles kauft, sondern das Bundle, trägt jedes Item maximal 1 Bit bei.

Man hat also die N Items, was N Bits entspricht, plus die Referenz auf das Bundle, was wiederum 32 Bit entspricht.
Gedeckelt ist das ebenso auf 128 Bits, alles darüber ist ganz sicher nur künstlich aufgeblasen.


## Wie berechnen sich die Bits?

Die Bits berechnen sich aus dem reinen individuellen Speicherbedarf.  Damit ist nicht der generelle Speicherbedarf gemeint,
sondern derjenige, den man bereitstellen muss, um das Item bereitzustellen.

Handelt es sich bei der Bereitstellung des Items um eine Referenz, dann wird nur der Speicherbedarf der Referenz berechnet.

Beispiel:

- Ein eBook, das man an den Kunden ausliefert, und das nicht mit DRM versehen ist, also so wie ein physisches Buch verwendbar ist,
das hat einen Speicherbedarf von sovielen Bits, wie es Inhalt hat.

Ist das eBook aber eingeschränkt, z. B. mit DRM, kann also nicht wie ein physisches Buch verwendet werden (ein physisches Buch
kann ich z. B. zerteilen und in Teilen an verschiedene Personen weitergeben), dann wird nicht die Größe des eBooks berechnet,
sondern die Größe der Referenz auf das eBook.  Und diese darf dann 128 Bit nicht überschreiten.

eBooks mit DRM sind also max. 1,28 EUR wert, während eBooks soviel Wert sein können wie es Bits braucht um ihren Inhalt aufzuschreiben.

- Genauso Grafiken.  Verkaufe ich eine Grafik, die dann dem Käufer gehört, kann sie so teuer sein wie sie Bits umfasst.
Also sind auch mehrere 1000 EUR überhaupt kein Thema, denn welche Grafik hat nur 10KB?

Wichtig hier aber ist, die Grafik muss sinnvoll sein.  Bastle ich die Grafik, die am Ende 100 MB hat, aus ein paar Elementen,
die wenige Bits haben, dann ist die Grafik eben nicht mehr wert als die Elemente aus denen sie besteht.  (Der Algorithmus, den
ich verwendet habe, ist ebenso ein Element, das aus Elementen besteht.  Diese Elemente sind aber nach Shannon mit minimaler
Entropie zu kodieren, also gilt hier nicht, Source-Code-Bytes zu zählen, sondern eher Source-Code-Statements.)

- Oder Gegenstände im Spiel.  Die Gegenstände können so aufwendig gestaltete Grafiken haben, wie sie nur wollen.
Kauft man solch einen Gegenstand, hat man nur die Referenz auf diese Grafiken erworben, nicht die Grafiken selbst!

Aus diesem Grund kann auch nur die Referenz (in der Regel der index, also max. 32 Bits) dafür berechnet werden.

Technisch steckt hinter jedem Bits also immer ein exakt definierter Aufwand.
Wenn dieser Aufwand 0 ist, weil sich das Bit durch automatisches Aufblähen ergibt, ist das kein Aufwand und das Bit darf
nicht gezählt werden.

Allerdings lassen wir den Usus walten:

Wir rechnen mit Bytes und nicht mit Bits und nehmen die typischen effizienten Datentypen her.

- Ein 64-Bit-Datentyp zu nehmen um ein 32-Bit-Value zu speichern ist nicht effizient.
  Auch wenn ich eine 64 Bit-Maschine verwende!

- Einen 32-Bit-Datentypen zu verwenden wenn genau genommen auch ein 16-Bit-Datentyp ausgereicht hätte
  ist ggf. ebenfalls nicht effizient.  Der Overhead mit 16 Bit rumzurechnen lohnt sich oft nicht.
  
Deshalb ist es durchaus legitim, bei einer Referenz von 32-Bit auszugehen.  Und wenn ein Item mehrere Dimensionen hat,
steigt das bis zu 128 Bit.

Aber bitte daran denken:

In einem Spiel gibt es normalerweise agestufte Preise.  Eine Referenz eines Billigitems benötigt genauso viel Bits
wie ein Premium-Item.  Also stoßen normalerweise nur die absoluten Premium-Items an die Grenze von 1 Cent pro Bit,
alle anderen Items sind weit darunter.


# Wie berechnet sich der Preis?

Viele Items lassen sich nicht direkt mit Geld kaufen, sondern mit irgendwelchen Ingame-Währungen,
und diese Ingame-Währung kann man dann wiederum für Geld kaufen.

Die Firma hat nun die Wahl:

- Berechnet sie den Preis anhand der Ingame-Währung.

- Oder berechnet sie den Preis der Ingame-Währung selbst.

Bei der Ingame-Währung gibt es da ein Thema:

Da ich davon ausgehe, dass diese niemals mehr als 32 Bit braucht (da passt eine IEEE-Float rein,
und die kann alles Geld der Welt erfassen), darf man nicht mehr als 32 Cent im Spiel für Ingame-Währung ausgeben können.

Das ist etwas wenig.  Also tut die Firma gut, nicht den Preis der Ingame-Währung als Deckel zu nehmen,
sondern den Relativpreis der Items, die man per Ingame-Währung kauft.

Nun gibt es natürlich viele Angebote mit Rabatten von Ingame-Währungen.  Damit das nicht missbraucht wird,
muss eine Firma den Preis so ansetzen, wie tatsächlich die Ingame-Währung gekauft wird.
Es gilt also nicht der Relativpreis des teuersten Ingame-Währungs-Pakets,
sondern es wird der Durchschnitt gebildet,
über das häufigste gekaufte Paket zusammen mit dem Paket, welches das geringste Preis/Leistungsverhältnis hat.

Warum?  Weil die Ingame-Geld-Pakete, die wenig Geld kosten, meist extrem ineffizient sind.

Und wichtig hier:  Die Firma muss nachweisen, welches das häufigste gekaufte Paket ist!
Einfach nur "beliebt" draufzuschreiben, das gilt nicht.
Im Zweifel gilt deshalb der Relativpreis des Pakets mit dem schlechtesten Preis/Leistungsverhältnis.

# Abschließende Worte

Ich halte den Preis von virtuellen Gütern für absolut überteuert.  Ganz besonders in Computerspielen.

Nichts gegen Geldverdienen, aber etwas Ethik muss man von den Herstellern einfach erwarten!

Hinweis:  Wenn ich jemals bei einem Spiel etc. etwas zu sagen habe, werde ich darauf hinwirken, dass die hier beschriebenen ethischen Grundlagen eingehalten werden.

Das und der Datenschutz, natürlich.
