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

Aber ja doch, man kann tatsächlich rein theoretisch ein Cloudbasiertes Intranet herstellen.  Dazu fehlen uns aber heute einige Details:

- Entsprechende Mobilnetze.  Die müssen mindestens weltweit ein VPN bereitstellen.  Ein im Mobilnetz roamendes Handy ist genau das Paradebeispiel wie es nicht implementiert sein darf, weil das dem Intranet-Gedanken zuwiderläuft.
- Entsprechende Mobiltelefone, die als Cloud-Knoten agieren können.  Anderenfalls haben wir eine Intranetbasierte Cloud und kein Cloudbasiertes Intranet.
- Und entsprechende Cloudknoten in den Netzwerkkarten der Rechner.  Das ist etwas, das wir ansich heute schon problemlos haben könnten.

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

-Tino
