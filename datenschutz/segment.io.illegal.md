> Achtung, IANAL.  Ich bin nur ein Nerd und das hier geschriebene stellt lediglich wahrheitsgemäß meine Meinung dar.

# segment.io

Nach meiner (unmaßgeglichen) Analyse handelt jeder, der segment.io in Deutschland einsetzt,
hoch illegal und verstößt in eklatanter, vorsätzlicher und wissentlicher Weise gegen die DSGVO.


## Gründe

Es gibt nur einen einzigen Zweck für segment.io, und dieser ist Personenbezogene Daten ausschließlich für Marketingzwecke an viertplattformen zu übertragen.

Also nochmals zum mitdenken:

- 1: Wir haben eine Webseite, die personenbezogene Daten erfasst
- 2: Wir haben den Betroffenen, dem die personenbezogenen Daten gehören
- 3: Wir haben segment.io, die diese personenbezogenen Daten erheben, weiterverarbeiten und weitergeben
- 4: Wir haben die Viertservices, die dann mit diesen Daten beglückt werden

Auf den Punkt 4 gehe ich in diesem Zusammenhang gar nicht erst ein.
Sprich ich sage nicht, dass diese Daten von 1 an 4 weitergegeben werden dürfen.

Was ich sage ist, dass die Weitergabe von 3. nach 4. höchst illegal ist,
da es keine Begründung dafür geben kann, dass diese notwendig oder erlaubt wäre.

Bei den Daten, die segment.io erfasst, handelt es sich um folgende Daten:

- Wann (Uhrzeit)
- Wer (IP)
- Wo (IP lokation)
- Aktion (Kauf, Login etc.)
- Ergebnis (Schuh gekauft etc.)

Wenn jemand was von wo aus macht und warum, das sind sehr intime Daten, die segment.io so erfasst.
Und es wird nicht ausgeschlossen, dass sich darunter Daten von Kindern befinden.

Aus beiden Gründen unterliegen diese Daten dem erhöhten Aufwand bei der Abwägung gem. DSGVO.
Das bedeutet, man muss diese grundsätzlich als besonders sensible Daten einschätzen,
die einem besonders hohen Schutzlevel unterliegen.

Ein besonders hoher Schutzlevel bedeutet, dass man die Datenverarbeitung nicht unnötig umfangreich gestalten darf.
Im Gegenteil, sie muss besonders Datensparsam erfolgen.

Das könnte hier gegeben sein.

Wenn segment.io in Form mit der (erlaubnispflichtigen)
Verarbeitung von (für den Businessprozess notwendigen) Daten betraut wurde,
kann dies im Rahmen einer Auftragsverarbeitung geschehen.

## Keine Auftragsverarbeitung

Im Rahmen einer Auftragsverarbeitung kann es auch in Form einer Auftragsverarbeitung zu einer Datenweitergabe kommen,
wenn diese im Rahmen der Auftragsverarbeitung notwendig ist.

> Beispiel:  Ich bin ein Schuverkäufer, der Amazon für den Verkauf verwendet.
>
> Dann haben wir zwischen mir und Amazon eine Auftragsverarbeitung, nämlich Amazon wickelt den gesamten Kauf und die Logistik ab.
> Um diese Logistik abzuwickeln, muss Amazon im Rahmen einer Auftragsverarbeitung wiederum die Versandadresse an DHL weitergeben.
>
> All dies ist unabdingbar notwendig um das Geschäft abzuwickeln, aus diesem Grund sind diese Auftragsverarbeitungen auch legal.
>
> Nicht legal wäre, wenn Amazon weitere Daten an DHL weitergibt, die zur Erfüllung des Auftrages nicht unmittelbar notwendig sind,
> wie z. B. Angaben, wie die Anzahl der Pakete die der Kunde pro Woche bestellt, oder wie gut das Vertragsverhältnis ist.

Die Auftragsverarbeitung kann außerdem die Weitergabe von Daten im Auftrag beinhalten,
sprich, ich kann einen Dienstleister (ISP) dazu beauftragen, die von mir ausgesendeten Daten (Mail) zu übermitteln.
Der Auftragsverarbeiter darf die Daten im Rahmen der Auftragsverarbeitung auch verändern,
soweit es für den Auftrag notwendig ist.

Sieht doch dann eigentlich ziemlich gut aus:

- Ich beauftrage segment.io, die die Markeitingdaten zu erheben (ob legal oder nicht lassen wir mal außen vor)
- Zusätzlich beauftrage ich segment.io, die Marketingdaten für mich zu verarbeiten.
- Und anschließend beauftrage ich segment.io, die Marketingdaten an die 4. Dienste weiterzugeben.

Alles gut?  Nein!  Genau das ist es eben nicht!

Der Grund ist, das sind keine 3 separaten Vorgänge, sondern ein einziger Vorgang!

Würde ich also eine Firma beauftragen, für mich die Marketingdaten zu erfassen,
eine weitere Firma beauftragen, für mich die Daten zu verarbeiten,
und eine dritte Firma beauftragen, diese Daten für mich zu übermitteln, dann wäre alles in Ordnung.

Denn bei jedem Schritt habe ich die volle Kontrolle, sprich, die Firmen handeln ganz klar in meinem Auftrag.
Es liegt in diesem Fall jeweils eine exakt umrissene Auftragsverarbeitung vor,
da jede Firma nur exakt genau das tut, was ich vertraglich festgelegt habe.

Wie die Firmen das dann tun ist wiederum egal, siehe das Beispiel Amazon und DHL.
Sofern eine klar umrissene Notwendigkeit existiert, die Daten in einer bestimmten Form weiterzugeben ist alles in Ordnung.

- Also ich übermittle die Kunden an die Marketingfirma und bekomme die Marketingdaten zurück.
- Ich übermittle diese Marketingdaten dann an die Verarbeitungsfirma und bekomme das Ergebnis zurück.
- Dann übermittle ich dieses Ergebnis an die Viertfirmen, und erhalte so meine Marketingübersicht.

Aber genau das geschieht hier nicht.  Ich bekomme keine Daten zurück.

- Ich übermittle die Kunden an segment.io
- segment.io macht dann irgendetwas, das ich nicht kontrollieren kann, da dies zu deren Geschäftsgeheimnis zählt
- Und am Ende landet bei den Viertfirmen die Marketingübersicht, die ich dann sehe

Damit existiert zwischen mir und den Viertfirmen keine Auftragsverarbeitung mehr!
Denn die Firmen verarbeiten ja nicht die Daten, die ich ihnen bereitstelle, sondern die segment.io bereitstellt,
über die ich - aus gutem Grund - keinerlei Kontrolle mehr habe.

Schuld daran ist, dass ich die Kontrolle darüber, wie die Daten verarbeitet werden, an segment.io abgegeben habe.

Im alten BDSG mit der Auftragsdatenverarbeitung war das noch in Ordnung.
Da konnte ich so etwas (rein theoretisch) machen und verargumentieren.

In der neuen DSGVO und der Auftragsverarbeitung funktioniert das aber nicht!
Hier gibt es klare Regeln, wie etwas zu verarbeiten ist.
Ich kann unmöglich in der Haftung stehen für etwas, das ich weder kontrollieren noch beeinflussen kann.
Aber genau das tue ich im Rahmen einer Auftragsverarbeitung.
Damit ist die Kontrolle der Daten (jedenfalls in diesem Fall) eine unabdingbare Voraussetzung dafür,
dass die Datenweitergabe an die Viertfirmen erfolgen kann.

(Zwischen segment.io und z. B. Facebook kann sehr wohl eine unabhängige Auftragsverarbeitung existieren,
diese kann aber nicht zugunsten eines Dritten existieren, also der Firma,
der die Marketingdaten dann am Ende zur Verfügung gestellt werden.)

Die DSGVO halte ich eben in diesem Fall also hinten und vorne nicht ein,
weil sie in diesem Konstrukt unmöglich eingehalten werden kann.
Das kann natürlich unwissentlich (sprich: Aus Faulheit, Dummheit oder Inkompetenz) geschehen.

## segment.io ist nicht notwendig

Nur leider ist diese Ausrede in diesem Fall nicht anwendbar.  Der Grund dafür steht wiederum in der DSGVO.

Im Fall von besonders sensiblen Daten muss ich vor deren Datenverarbeitung abwägen,
ob diese Datenverarbeitung zwingend erforderlich ist, und diese dann ggf. unterlassen.
Selbstverständlich kann ich diese Entscheidung auch an einen Auftragsverarbeiter weitergeben,
der mir dann das Ergebnis der Prüfung mitteilt.  Genau das tut segment.io aber nicht.
Also gibt es diese Prüfung entweder nicht, oder sie wurde auf illegale Weise durchgeführt.

So oder so, die entsprechenden Prüfpflichten, die die DSGVO vorschreibt, wurden auf eklatante Weise unterlassen.
Dies kann nicht unwissentlich sondern nur vorsätzlich geschehen sein.
Denn hier wurden eingehende, klar formulierte und absolut unmissverständliche Regeln der DSGVO missachtet.

Wenn man davon ausgeht, dass es solch eine Prüfung gab oder diese nur fälschlich beurteilt wurde,
dann wird es sogar noch schlimmer.

Dann habe ich nicht nur den Erfordernissen der DSGVO nicht entsprochen, weil ich fälschlich und viel zu naiv abgewägt habe,
sondern ich verstoße dann wiederum in eklatanter, wissentlicher und vorsätzlicher Weise gegen die DSGVO.

Warum?

Das beschreibt segment.io sogar auf ihrer Homepage!

Im Fall von sensiblen Daten muss ich besonders achtsam mit diesen Daten umgehen.
Das bedeutet, ich muss die Sicherheit der Datenverarbeitung auf dem Stand der Technik halten
und diese so sparsam wie möglich durchführen.

Niemand kann mir gegenüber behaupten, dass segment.io eine besonders sparsame Datenverarbeitungstechnik hätte.
Im Gegenteil, diese machen Big Data und werben auch noch damit, das ist das genaue Gegenteil von sparsamer Datenverarbeitung!

Der Schuh, der daraus wird ist, dass segment.io auf ihrer Homepage klipp und klar und total unmissverständlich berschreiben,
dass sie gar nicht notwendig sind, und die Datenverarbeitung ohne segment.io ebenfalls problemlos möglich ist.
Lediglich ist der Aufwand wesentlich höher.

segment.io ist also lediglich die bequemere Variante, Marketingdaten zu verarbeiten.

Nochmals zum Mitedenken:

Statt, wie in der DSGVO ohne jeden Zweifel und unmissverständlich gefordert,
eine sparsame Datenverarbeitungsvariante zu wählen,
haben die Firmen, die segment.io einsetzen aus reiner Bequemlichkeit eine unkontrollierbare Datenkrake gewählt.

Das tun sie ohne Not, ohne Zwang, ohne jeden datentechnisch nachvollziehbaren Grund,
aus freien Stücken, lediglich aus dem niederen Beweggrund der eklatanten Gesetzesmissachtung zur reinen Profitmaximierung.

Dafür gibt es keinerlei Entschuldigung.

> Das, was Unternehmen hier tun, ist nicht einmal mit dem vergleichbar, was Raubmörder oder Bankräuber tun.
> Letztere befinden sich oft selbst in einer Zangs- oder Notlage,
> haben also quasi gar keine andere Wahl oder glauben dies zumindest.
>
> Genau das trifft hier eben nicht zu.  Nicht nur haben alle Unternehmen die freie Wahl ob sie segment.io verwenden,
> auf segment.io zu verzichten ist sogar leicht, weil die Alternative dem typischen und normalen Vorgehen entspricht!
>
> Anders gesagt:  Der Raubmörder handelt deutlich verantwortungsvoller als Unternehmen, die segment.io einsetzen.
> Dem Raubmörder könnte ich vergegeben (aka. Bewährung oder zumindest mildernde Umstände),
> Unternehmen, die segment.io einsetzten, verdienen hingegen niemals jedwede Vergebnung (ergo: Mindesten Höchststrafe)!

Wenn das also nicht der Standardfall für die Höchststrafe der DSGVO darstellt, dann weiß ich nicht,
wie es jemals zu der Höchsstrafe kommen soll.

Hier werden Daten aus rein monetären Gründen in sinnloser Weise and Datenkraken verschachert,
und die Leute wissen das sogar noch vorher (so dumm, etwas anderes anzunehmen, kann nun wirklich niemand sein).

## Fazit

Jedes deutsche Unternehmen, das segment.io einsetzt, oder Firmen im Ausland einsetzt,
die wiederum segment.io einsetzen (sofern segment.io mit den Kundendaten oder Mitarbeiterdaten in Berührung gerät),
begeht den schwersten aller möglichen Verstöße gegen die DSGVO.

# Hinweis

Zur Zeit ist mir kein deutsches Unternehmen bekannt, das segment.io verwendet.
Sollte ich auf eines stoßen werde ich unter Verweis auf meine Analyse hier,
umgehend eine entsprechende Beschwerde beim jeweilig zuständigen Datenschutzbeauftragten einreichen.

Und ich empfehle es jedem anderen, dies ebenfalls zu tun.

> Ergebnisse bitte hier als "Issue" bei GitHub eintüten.

Danke.

## Beispiele für Unternehmen im Ausland die segment.io einsetzen

Beispiel für solch ein Unternehmen:

- PubNub.  Die Registrierung bei PubNub ist nur freigeschaltetem segment.io möglich
  - Alles weitere scheint auch mit blockiertem segment.io zu funktionieren
