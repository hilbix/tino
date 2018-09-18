# Hirnschiss Cloud basiertes Intranet

Zitat https://pages.coyoapp.com/intranet (sorry, dass es die gerade trifft, aber so bin ich darauf gestoßen):

> Als Cloud Intranet Lösung passt COYO perfekt auf dein Smartphone.

Intranet in der Cloud, überall verfügbar auf dem Smartphone?  **Sounds legit!!!!1!einsElf**

Naja, nur für Leute, die von der Materie weniger als absolut 0 Ahnung haben (sprich: Wohl alle Geschäftsführer größerer Unternehmen).

Nur mal zum Verständnis:

- Eine Intranetlösung in einer internetbasierten Cloud kann nicht und wird niemals existieren.  Das sind zwei Begriffe, die sich gegenseitig vollkommen ausschließen!
- Eine Intranet-App für das Handy, mit der man bequem von überall aus zugreifen kann, kann und wird niemals existieren.  Wer etwas derartig bezeichnet, beweist nur, dass er von der Materie weniger als absolut 0 Ahnung hat.  (AKA: Er ist destruktiv unterwegs, vergleichbar wie ein Raubmörder.)

Im Vergleich zu "Intranet in der Cloud" ist es geradezu eine wissenschaftlich erwiesene Tatsache, dass Jesus tatsächlich eine Jungfrauengeburt darstellte, an der also kein Mann beteiligt war!
(Wir erinnern uns:  Biologisch hat das Baby bei Jungernzeugung nur die DNS der Mutter, muss also logischerweise weiblich sein.  Und wenn das Baby männlich ist, ist ein Mann an der Geburt beteiligt!)

Ein "Intranet in der Cloud" ist - vielleicht - ein Extranet.  Aber als Extranet sehr schwer zu realisieren.
Vor allem nicht über einen Buttonklick, denn dazu gehört eine ausführliche Anwendungsstrategie für das Extranet, sonst geht das in die Hose.
Extranets sind übrigens nicht direkt das Gegenteil eines Intranets, aber halt doch etwas vollkommen anderes.

Aber das schützt natürlich nicht vor Hirnschiss [wie folgendem Mist](https://www.google.com/search?q=%22intranet%22+%22cloud%22):

- https://www.cloudcomputing-insider.de/vier-vorteile-des-cloudbasierten-intranets-a-676811/

Zum Verständnis:

- Cloudbasierte Intranets kann es (in der derzeitigen Netzinfrastruktur) nicht geben.  Dagegen ist Fucking for Virginity eine geradezu empfehlenswerte Strategie!
- Intranetbasierte Clouds (private Clouds) gibt es natürlich.  In der Regel sind diese (zumindest für typische mittelständische Unternehmen) vollkommener Blödsinn.
- Man kann natürlich eine private Cloud für einen Intranetdienst aufbauen, getreu dem Motto "warum einfach, wenn es auch überbordend kompliziert geht".  Eine solche private Cloud bietet sich Diensten wie Google und Facebook an, aber schon bei Twitter dürfte sich eine private Cloud wenig rentieren.  Jedenfalls heute.  Im Internet sind Dinge nicht in Stein gemeißelt, in einigen Jahren (eher Jahrzehnten) wird es vielleicht sinnvoll, diesen Ansatz zu reevaluieren.  Aber eben nicht heute!

Natürlich kann man, rein theoretisch, ein Cloudbasiertes Intranet herstellen.  Heute schon.  Aber dazu fehlen uns einige wichtige Bausteine:

- Entsprechende Mobilnetze.  Die müssen mindestens weltweit ein VPN bereitstellen.  Ein im Mobilnetz roamendes Handy ist genau das Paradebeispiel wie es nicht implementiert sein darf, weil das dem Intranet-Gedanken zuwiderläuft.  Das Handy muss also permanent mit dem VPN, und nur eben diesem VPN, verbunden sein, und das VPN niemals verlassen.
- Entsprechende Mobiltelefone, die als Cloud-Knoten agieren können.  Anderenfalls haben wir eine Intranetbasierte Cloud und kein Cloudbasiertes Intranet.  Der Daten-Roaming-Tarif steht da direkt entgegen!
- Und entsprechende Cloudknoten in den Netzwerkkarten der Rechner die direkt (also nicht via VPN) am Intranet teilnehmen.  Das ist etwas, das wir ansich heute schon problemlos haben könnten, die meisten Netzwerkkarten haben die dafür notwendige Eigenintelligenz und die meisten Rechner (Stichwort: Intel Management Engine) die dafür notwendige Autonomie.  (Ich bewerte nicht, ob das gut oder schlecht ist.  Ich schildere nur die Faktenlage.)

Merke:

- Das Wesen eines Intranets ist die strikte physikalische Trennung der Teilnehmer zum Internet.
  - Jeder Übergang vom Intranet via DMZ ins Internet muss dediziert, kontrolliert und strategisch konstruiert sein.
  - Genau das ist nicht gegeben, wenn das Device vom Nutzer auch ganz normal ins Internet kann.
- Was im Intranet passiert bleibt im Intranet.
  - Ein normales Intranet soll nicht davor schützen, dass Information (auch Viren) vom Internet ins Intranet gelangen.
  - Ein Intranet muss aber davor schützen, dass Informationen (wie Informationsabfluss) ungefiltert vom Intranet ins Intranet gelangen!
  - In hochsicheren Intranets wird zusätzlich dafür gesorgt, dass Informationen auch nicht ungefiltert aus dem Internet ins Intranet gelangen.
    Das bedeutet aber normalerweise, dass es eben gar keinen regulären Übergang ins Internet gibt, das Intranet also in sich abgeschottet existiert!
  - Viele (wenn nicht sogar die meisten) Intranets sind entsprechend fehlkonstruiert, z. B. wenn via DNS Information ungefiltert aus dem Intranet ins Internet tunneln können.
- Die Teilname am Intranet von Geräten außerhalb des Intranets via VPN sorgt in der Regel dafür, dass das Intranet danach kein Intranet mehr ist.
  Man kann es zwar weiterhin als Intranet bezeichnen, macht aber dann so gut wie alles falsch, was man nur in Sachen Intranet falsch machen kann.
  - Über ein VPN kann sich jeder bei Bedarf mit einem Intranet verbinden.  Richtig.
    - Aber nur, wenn man in einer entsprechend kontrollierten VPN-Umgebung landet, die das Intranet vor den VPN-Teilnehmern schützt.
    - Sprich, man ist in einer Art DMZ, die dem Intranet vorgelagert ist, mit entsprechend dedizierten kontrollierten Übergängen ins Intranet.
  - Man kann sich auch über ein VPN transparent mit dem Intranet verbinden, und dann als normaler vollwertiger Intranet-Teilnehmer teil nehmen.  Richig!
    - Aber dann muss das Gerät, das diese VPN-Verbindung aufbaut, bestimmte Voraussetzungen mitbringen, die eben einer Nutzung außerhalb des Intranets verbietet.
    - Ein Duales Gerät, das beides erlaubt, dem kam mal ein Blackberry sehr nahe.  Aber eben auch nur nahe.  Erreicht wurde das Ziel bisher nie.

# Fazit

Wenn Ihnen jemand im Internet von den Vorteilen eines Cloudbasierten Intranets etwas vorfaseln will,
**ballen Sie bitte ihre Faust und schlagen Sie ihm sofort und mit aller Ihnen zur Verfügung stehenden Kraft die Nase ein, und zwar so tief und nachhaltig, wie sie können** damit er schnellstmöglich aus dem Cyberspace ausscheidet.

Derjenige, der Ihnen von solch einem Quatsch erzählt, ist nämlich nicht nur nachweisbar ein absoluter Vollidiot, sondern schlimmer noch, auch noch äußerst gefährlich!

**Wehren Sie sich deshalb mit allem, das Sie haben!  Schützen Sie das wichtigste, Ihre Integrität im Internet!**

-Tino

PS:

Das, was ich hier schreibe wendet sich an die Normalos im Internet.  Hätte man diese Horden hier nicht reingelassen, hätten Nepper mit solchem Quatsch wie "Cloudbasiertem Intranet" sowieso keine Chance weil sie jeder auslachen würde bevor sie den Satz beendet haben.  Aber so ist es im Internet leider nimmer, und ich muss mich dieser traurigen Realität stellen.  Deshalb folgender **Disclaimer zum Verständnis**:

- Das hier stellt selbstverständlich keinen Aufruf zur realen Körperverletzung dar.  Hier geht es ums Internet, also um eine rein virtuelle Umgebung.  Mit Faust und Nase sind entsprechend deren virtuellen Vertreter gemeint, es ist damit nicht die physikalisch materielle Nase einer konkreten Person gemeint, die Sie einschlagen sollen!  (Wer so etwas nicht differenzieren kann hält sich besser aus dem Internet raus, weil er keine Ahnung hat, wie man damit umgeht.)

- Das hier stellt allerdings sehr deutlich einen Aufruf zum "Virtuellen Massenmord" dar ("cloud based intranet" ergibt über 10000 Hits).  "Virtueller Mord" bedeutet, dass hier jemand effektiv und endgültig aus dem Cyberspace elliminiert werden soll.  In diesem Fall dient das dazu, dass derjenige keinen realen Schaden mehr anrichten kann, indem er sich eine derart blutige Nase holt, dass er nicht umhin kann, eine sehr deutliche Lernerfahrung zu machen.  Anders lernen sie nicht.  Leider.  (Beispiel: Loki in der Marvel-Reihe.)

(Warum kann mein "Aufruf zum virtuellen Mord" nicht strafbar sein, sondern ist ganz klar von der freien Meinungsäußerung gedeckt?  Wäre es das, müsste so gut wie jeder Gamer, der PvP macht, im Knast sitzen.  Es wäre sogar gemeinschaftlich verabredeter Mord.  Und warum ist es kein "Aufruf zum virtuellen Totschlag"?  Weil mich hier eindeutig niedere Beweggründe treiben.  Ich will solches Gesocks nicht hier im Internet.  0 Toleranz.  Aber das ist weder nett noch moralisch einwandfrei.  Scheiß drauf, damit kann ich wunderbar leben, so wie milliarden Gamer ebenfalls!  Punkt!)
