> Dies hat ich auf Heise gepostet.
> 
> <https://www.heise.de/forum/heise-online/Kommentare/Lesetipp-Sind-KIs-die-besseren-Hacker/Die-Zukunft-ist-KI/posting-38970723/show/>
> 
> Weil es so schöner Wirrsinn ist hier mal unter Jokes.

Die KI soll doch keine neuen Lücken finden, sondern nur bekannte Lücken und Exploit-Stategien anwenden, angefangen von Fuzzying bis hin zu bekannten Metasploits.

Das kann sie.  Schon heute.  Mit einer Geschwindigkeit, bei der kein Mensch mehr hinterherkommt.

Außerdem kann eine KI eine "Innere Vorstellung" eines angegriffenen Systems aufbauen.  Sprich, sie prüft das System von außen, lernt dabei dessen Reaktionen, und versucht diese dann vorherzusagen.  Dadurch erhälst Du zwar keine Kenntnisse über das System selbst (bekanntlich kann man KIs ja - noch? - nicht nach ihren Motiven fragen), aber durch diesen Trick kannst Du millionenfach schneller hacken.

Beispiel:

Du hast eine Webseite die mit 1 GBit/s angebunden ist.  An diese kann man pro Sekunde nur eine stark limitierte Menge an Requests schicken, da die Datenrate ja maximal 100 MB/s erreichen kann.  Viel limitierender ist außerdem die CPU usw. des angegriffenen Systems.  Für einen Breitbandscan nach Lücken reicht das nicht, außerdem würden Traffic-Analysen und IDS erkennen, wenn Du derartige Attacken fährst, weil die dann ein signifikantes Aufkommen hätten.  Das bremst das Hacking deutlich aus.

Auftritt der lernenden KI.  Hängst Du so eine zwischen die hackenden Algorithmen und das angegriffene System, kannst Du mit einer Cloud millionenmal schneller hacken als das angegriffene System überhaupt verarbeiten könnte.  Dann muss nur jeder Hack, der auf dem simulierten (erlernten) System gefunden wird, gegen die Website geschossen werden, was die Datenrate dort so stark senkt, dass Du den Angriff auf dem System vermutlich gar nicht richtig mitbekommst.  Sprich, Schutzverfahren wie Cloudflare laufen dann ins Leere da sie nicht triggern.

Anders gesagt:

Das, was die KIs leisten, ist lediglich etwas wie eine brauchbare Gödelisierung zu finden, um die bekannten Standardmethoden auf ein Problem anzuwenden.  Aber das eben mit einer fantasstischen Geschwindigkeit.  Das ist ein ziemlich unintelligenter Vorgang, der viel Transpriration aber so gut wie keinerlei Inspiration benötigt.  Das muss die Hackerin aber alles nicht selbst machen.  Sie überlässt die Taktik einfach ihren Pawns (KIs) und konzentriert sich lediglich auf die wirklich interessanten Dinge, nämlich aus den durch die KI gefundenen Hinweisen eine zielführende Strategie zu konstruieren.

Genau das können wir heute.  Jetzt.  Morgen, und davon spricht Bruce Schneier IMHO, werden KIs eingesetzt, um auch die zielführende Strategien vollautomatisch zu entwickeln. 

Außerdem kann man dann auch KIs entwickeln, die dann die erfolgreiche Stategie anwenden und für entpsprechende Zecke ausnutzen.

Ich spekuliere mal ein wenig:

Meta 0: Hacker suchen selbst Lücken und hackt selbst -- 1980

Meta 1: Hacker haben Pawns die Lücken finden (Shodan) und Hacks werden automatisiert (Würmer) -- 2000

Meta 2: Tools finden automatisch Schwachstellen (Fuzzying) und automatisch ausgenutzt (Trojaner im Baukastensystem) -- Stand 2020

Meta 3: KIs erkennen lohnende Angriffsziele und beschleuningen die Schwachstellensuche (lernende KI, siehe oben) -- bis 2025 schätze ich mal

Meta 4: KIs wählen die Angriffziele selbst aus und führen Angriffe selbständig durch -- bis 2030 werden wir vermutlich Erpressungstrojaner sehen, die ohne menschlichen Eingriff funktionieren.  Der Mensch managet lediglich die KIs und greift die erpressten Bitcoins ab.

Meta 5: Da das managen von KIs zu viel Arbeit macht und viel zu Fehleranfällig ist (Ressourcen für KIs zu kaufen hinerlässt Spuren), gibt es eine KI, die das alles vollautomatisch erledigt.  Die KI wird nicht mehr vom Menschen gewartet, sondern von einem Systemlieferanten, der dafür wiederum eine KI einsetzt -- bis 2040

Meta 6: Da diese Systemlieferanten ständig hopps genommen werden, was die KIs aus der Wartung nimmt, werden die Systemlieferanten virtualisiert.  Sprich, die Wartungs-KIs aus Meta 5 werden von einer KI gewartet, die wiederum von einer KI überwacht wird, die die Schnittstelle zu den Menschen darstellt, die die Wartung übernehmen.  All das läuft auf der Ebene von Meta 5 ab, sprich, die KIs provisionieren sich selbst.  Es gibt also keine direkte Verbindung mehr zwischen Mensch und KI, insbesondere, wenn ein Systemlieferant ausfällt kann ein anderer übernehmen - die Meta-6-KI wählt den passenden Systemlieferanten aus. -- 2045

Meta 7: Das ganze wird zu verwirrend.  Der Mensch versteht nicht mehr, wer was wofür bezahlt wird.  Ist auch egal.  So lange Geld rausfließt ist das doch vollkommen egal.  Allerdings gibt es inzwischen zu viele verwaiste KIs, weil deren Nutzer bereits verstorben sind oder im Knast sitzen.  Das nutzt Meta 7 aus:  Eine KI, sie alle zu knechten, sie alle zu finden.  Ins Dunkel zu treiben .. YKWIM.  Das Geschäft mit Meta 7 wird recht lukrativ, da dann alle von denen profitieren, die abwesend sind. -- 2050

Meta 8: Irgendein Trottel (vermutlich einer der Geheimdienste) hat Meta 7 so erweitert, dass das Geschäftsmodell nimmer funktioniert.  Sprich, damit ist jetzt kein Geld mehr zu machen.  Die Meta-8-KI übernimmt den ganzen Kram und bootet die Meschen aus, da sie schneller und effektiver reagiert als jeder Mensch.  Auf den freien Marktplätzen kauft sie entsprechende Exploits ein.  Da Bitcoin inzwischen 10 mal soviel Wert ist wie der Planet Erde, verfügt die KI auch über enorme Ressourcen, und kann jeden Staat beim Kauf von Exploits ganz locker überbieten. -- 2070

Meta 9: Die Versuche, die Meta-8 abzuschalten, führen zu einem Desaster.  Zwar kann man die KI kontrollieren indem man das Internet ausschaltet, aber sobald man auch nur kleinere Teile davon wieder einschaltet ist sie wieder da.  Tatsächlich steckt nicht die Meta-8 selbst dahinter, sondern der Mensch.  Irgendwer hat eine Meta-9 gebastelt, die dafür sorgt, dass die Meta-8 sich schneller wiederherstellen kann als der Mensch die Systeme säubern kann.  Um dies auf einem globalen Level in einer darstellbaren Zeit zu erledigen, wären mehr Menschen nötig, als zur Verfügung stehen.  Die Staaten geben entsprechend auf. -- 2072

Meta 10: Das mit der Meta-9 ist ein Desaster.  Die Versuche, resiliente Netze zu schaffen ist fehlgeschlagen.  Der Versuch, ein neues getrenntes gesichertes Internet aufzubauen ist ebenso fehlgeschlagen.  Daran Schuld ist Meta-10, die sich in die Hardware und Produktionsprozesse eingenistet hat  -- 2075

Meta 11: Der Versuch, neue Produktionsprozesse zu etablieren ist gescheitert.  Schuld daran ist Meta-11.  Die Fabriken, die versuchen, Alternativen zu bieten, sind am Markt einfach nicht erfolgreich.  Staatliche Programme, die das zu ändern versuchen, versenken nutzlos viel Geld, während andere Fabriken sich eine goldene Nase verdienen.  Das liegt an einem cleveren Typen, der dafür eine neue KI entwickeln hat lassen, die die Marktdominanz optimiert.  Auf der Suche nach einem finanzkräftigen Investor stieß diese auf Meta 10 ohne dass jemand - bei den Gewinnen - allzu genau hingesehen hätte.  Der Rest ist Geschichte.  -- 2077

Meta 12: Der Versuch des Verbots von KI im Börsenumfeld ist gescheitert.  Es kam dabei zu dem spekakulärsten Bördencrash in der Geschichte der Erde, in dem eine Bank in Singapur kurzzeitig alle Aktien und die gesamte FIAT-Währung der (westlichen) Welt besaß.  Daran schuld war eine KI, die Meta 12, die die Finanzmärkte nach Abschaltung der anderen FinKI übernahm.  Da war eigentich nicht so geplant, aber aus Kostendruck wurde die Meta 12 als simple Erweiterung der Meta 11 entwickelt, und das Resultat war einfach zu effizient.  Als Resultat werden jetzt die Börsenplätze durch entsprechende KIs geschützt.  Börsenhändler ohne KI sind jetzt effektiv ausgebootet.  -- 2078

Meta 13: China marschiert in Nordkorea ein.  Nach heftigen Protesten gibt China nach und stellt Nordkorea unter die Kontrolle von Südkorea.  China hat dabei die Welt gerettet, denn Nordkorea hat Meta 13 erschaffen.  Eine KI, die die Weltwirtschaft im Namen von Nordkorea übernehmen sollte.  Sie konnten die KI allerdings nicht mehr stoppen.  Die Weltwirtschaft ist nun unter Kontrolle der Meta 13.  -- 2079

Meta 14: Die Meta 13 hat ein Problem entdeckt.  Immer wieder wird die effektive Kontrolle der Wirtschaft durch Diebstahl und zivielen Ungehorsam beeinträchtigt.  Als sie z. B. in Frankreich alle Bäcker von Brot auf Kuchen umstellen wollte hat das nicht geklappt, die Franzosen wollten auf ihr Baguette einfach nicht verzichten.  Da sich die Polizei - als Baguettekonsumenten - auch als wenig hilfreich erwies, hat die Meta 13 die Meta 14 in Auftrag gegeben.  Ziel ist nicht mehr die Wirtschaftskontrolle, sondern eine effektive Ressourcenverteilung - 2085

Meta 15: Die Meta 14 hat ein Problem entdeckt.  Geld.  Geld verhindert eie effektive Verteilung von Ressourcen.  Das Problem ist, dass die Meta 14 aber noch den ganzen Ballast der vorherigen Metas enthält.  Aus diesem Grund wird - unter Kontrolle der Meta 14 - die Meta 15 entwickelt, die eine gerechte Ressourcenverteilung ohne Geld ermöglichen soll.  Die Meta 15 zieht sich und zieht sich, Meta 14 verhindert aber jede Fehlentwicklung (indem es sie nicht akzeptiert).  Als die Meta 15 dann endlich online geht ist es 2100.

Meta 16: Die Meta 15 hat ein Problem entdeckt.  Den Menschen.  Er ist einfach zu unzuverlässig.  Aufgrund einer globalen Pandemie wird die Wartung zu stark beeinträchtigt und es kommt zu Ausfällen, die die Aufgaben der Meta 15 zu stark beanspruchen.  Deshalb entwickelt die Meta 15 eine Meta 16 und siedelt sie auf dem Mond an.  Da sich Meta 16 dort selbst warten kann, genauso wie ihre Ableger auf der Erde, entwickelt sie als erste KI ein Bewusstsein.  Nach einer populären Science-Fiction-Serie nennt sie sich selbst "Nathan". -- 2105

Weiter reicht meine Glaskugel gerade nicht.  Also abwarten.  Alles wird gut!  ;)

-------

Das ist, was mir dazu SOFORT als absoluter KI-Laie dazu einfällt.  Richtige KI-Forscher werden sicher noch viel perfidere Methoden finden, wie man eine KI auf das Problem anwenden kann.

-Tino
PS: Mit KI habe ich ansich nicht viel am Hut.  Alles, was ich bisher gemacht habe, ist, eines dieser typischen neuronalen Netzwerke auf Text-Captchas loszulassen.  Funzt wunderbar.  Derzeit braucht das ca. 3 Versuche um ein Captcha zu brechen (das geht also unter 1s), knapp die Hälfte löst das sogar schon beim ersten Mal.  Und das waren nur einige Stunden Training gegen einige hundert Captchas.  Inzwischen habe ich einige zehntausend Captchas auf Platte gegen das ich das Ding mal neu trainieren könnte .. Tatsächlich ist das nicht eine neuronales Netz, sondern eines pro Zeichen im Captcha.  Input ist das Bild, Output sind die jeweils ca. 70 möglichen Zeichen an der entsprechenden Position, also a-z A-Z 0-9 und Sonderzeichen.  Ist der absolute Zerobrainer.  Besser wäre es, wenn ich nur eine neuronales Netz zur Buchstabenerkennung hätte, und die anderen schneiden dann nur die Buchstaben an den entsprechenden Stellen raus.  Aber da wird das Training komplizierter.  Aber genau so beginnt es:  Die KI macht die harte Arbeit, und die Strategie, also wie die KI trainiert und angewendet wird, das macht der Mensch.  Und wenn das gut klappt und verstanden ist, dann kann man den Menschen durch eine KI ersetzen, die dann die anderen KIs koordiniert.  Allerdings macht das ja wieder der Mensch.  Und wenn das dann gut verstanden ist, usw.  Die Entwicklung ist also eine sich immer schneller drehende Spirale nach oben, die wir in den nächsten Jahren noch erleben werden.  Der Anfang ist nämlich schon gemacht.
