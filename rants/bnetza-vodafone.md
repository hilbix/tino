> Das habe ich NICHT verschickt, da ich keine Zeit hatte, es fertigzuschreiben.  Es gab dann wichtigeres nachdem der Frust verpufft war

# Folgendes verlinke ich in die Meldung an die BNetzA

Dies ist es eine Beschwerde darüber, dass die Kunden hierzulande von Telekommunikationsunternehmen nicht mit transparenten Informationen versorgt werden, seit wann eine Störung besteht, wie lange die Störung anhält, und bis wann man mit der Beseitigung der Störung rechnen kann.

Meine Bitte an die BNetzA ist, dass diese von den Telekommunikationsunternehmen verlangen, transparenz für ihre Kunden zu üben, und zwar möglichst in folgender Form:

- ISPs, die Telekommunikation anbieten, müssen eine leicht erreichbare Webseite betreiben.  Leicht erreichbar bedeutet, dass die Informationen nicht hinter einem Login, Cookies oder JavaScript verborgen sind.  Die Informationen müssen also per Lynx, W3M, Curl, WGET abrufbar sein.
- Die Webseite muss dem semantischen Web ensprechen, d. h. maschinenlesbar ausgelegt sein.  Das Format muss maschinenlesbar sein.  Es gibt dabei aber keine direkte Formatforschrift, außer, dass man sich an gängige Standards (z. B. Datumsangaben in Computerlesbarer Form) hält.
- Auf dieser Webseite müssen, in tabellarischer Form, alle Störungen der letzten 3 Jahre aufgelistet werden, die unmittelbar oder mittelbar mehr als 1 Teilnehmeranschluss betreffen.  Fällt ein DSLAM aus, an dem mehr als 1 Teilnehmer hängt, ist dies eine solche Störung.
- Auch Störungen von Dritter Seite (z. B. regionaler Stromausfall, Überschwemmungen etc., alles, was zu einem Ausfall von Telefonmasten oder DSLAMs führen) sind zu erfassen.
- Störungen, die von Teilnehmerseite herrühren (abgeschaltetes Endgeät, mutwillige oder unerwünschte Zerstörung beim Teilnehmer z. B. durch Überspannung wie Blitzschlag) müssen nicht erfasst werden.
- Es ist die Region (Postleitzahlenbereich, Straßenzug, GeoDaten etc.) aufzulisten, in der die Störung stattfand
- Es ist jeweils der Tag des ersten möglichen Störungsanfangs aufzulisten.
- Es ist der Tag aufzulisten, an dem die endgültigen vollständigen Beseitigung der Störung vorgenommen wurde
- Wenn Zeitangaben gemacht werden, müssen diese konservativ sein, d. h. die Uhrzeiten dürfen nicht Zeiten betreffen, in denen möglicherweise eine Störung bestand.

Während eine Störung besteht, darf diese Information zur aktuellen Störung eingeschränkt werden:

- Das ist ein Sicherheitsfeature, da Alarmanlagen, Smart-Homes etc. z. B. oft über ein IP-Feature verfügen, also in der gestörten Region den Alarmfall nicht melden könnten.
- Es ist dem gestörten Teilnehmer (z. B. per SMS oder Mail, mündlich mitgeteiltem URL) eine Möglichkeit zu geben, dass dieser trotzdem auf diese Information zugreifen kann.
- Der Zugang zu der Störungsinformation muss kostenlos sein, ein Erfordernis, das in computerlesbarer Form zu tun gibt es in diesem Fall nicht.
- Die Information per Login zu schützen ist zulässig, sofern ein vom Nutzer nutzbarer Login besteht und der Nutzer der Nutzung des Logins zustimmt.
- Der Zugriff muss aber auch ohne Login möglich sein, z. B. über ein fallweises Access-Token (z. B. in der Form eines Links).
- Das Access-Token muss missbrauch vorbeugen.  D. h. wenn es in einem Forum geteilt wird (Stichwort: In zu kurzer Zeit greifen zu viele verschiedene IPs auf den gleichen Link zu), muss es automatisch gesperrt werden.
- Der Nutzer bekommt bei Sperrung automatisch einen neues Token zugeschickt, aber nur bis zu 3 Mal.  Danach muss er sich an den Support wenden um zu erklären, warum sein Link ständig verbreitet wird.
- Wenn jemand tatsächlich ständig mit wechselnder IP zugreifen will, muss für den Fallback etwas wie ein OTP (wie der Google-Authenticator) den Zugriff ermöglichen.  Es sollen verfahren wie U2F (aka. FIDOkey) verwendet werden, sofern der Nutzer diese Möglichkeit hat.  Auf jeden Fall aber muss es eine Lösung geben, die der Nutzer unmittelbar ohne längere Wartezeit oder kostenpflichtigen Zukauf eines Geräts erhalten kann.  (Es ist zumutbar, dass der Nutzer sich ein solches Token z. B. beim nächstgelegenen T-Punkt zur Öffnungszeit abholt, oder dieses per Postexpress am nächsten Werktag zugesendet wird.  Rückstand/Wartezeit bis Lieferung möglich darf es aber nicht geben.)
- Dies kann z. B. auch über einen Sprachcomputer lösen.  Dieser erkennt die anrufende Telefonnummer und gibt dann, ohne weitere Abfragen, sofort den Störungsstatus per Sprachansage aus.
- Die Sprachansage muss allgemein gehalten werden, darf nicht personalisiert sein (alle Betroffenen erhalten dieselbe Ansage), werbefrei sein und das wichtigste zuerst nennen:
  - Beispiel: "Die Strörung besteht weiterhin.  Die Störung besteht seit XXXX." ggf. gefolgt von einem Verlauf der allgemeinen Störung.
  - Beispiel: "Die Störung ist beseitigt.  Die Störung bestand von XXXX bis YYYYY." ggf. gefolgt von einem Verlauf der allgemeinen Störung.
- Wenn jemand mit mehreren verschiedenen Telefonnummern auf diese Information zugreifen will (Handy, Festnetz vom Arbeitgeber, etc.) ist dies ebenso zu ermöglichen.

Außerdem haben die Telekommunikationsunternehmen den Anschlussinhabern sämtliche geplanten Wartungsarbeiten mitzuteilen, die den Anschluss betreffen könnten, inkl. der entsprechenden Zeiten, wenn der Anschlussihaber dies verlangt.

- Wartungen sind 1 Woche (6 Werktage) vorher anzukündigen.
- Außergewöhnliche Wartungen sind 1 Tag vorher anzukündigen.
- Notfallwartungen sind schnellstmöglich über die bestehenden Wege mitzuteilen.
- Dies kann per Login oder z. B. per Brief geschehen.  Wichtig ist, dass der Anschlussinhaber rechtzeitig von der Wartung erfährt.
- Die Mitteilung ist prinzipiell kostenlos.  Dafür muss es ein kostenloses Verfahren geben, das dem Anschlussmithaber zumutbar ist.  Neben den kostenlosen Verfahren gab es auch andere nichtkostenlose Verfahren (z. B. Brief) geben, die der Anschlussinhaber wählen darf.
- Es muss Anfang und geplantes Ende der Wartung (minutengenau) angegeben werden.
- Es muss die Form und Dauer (sekundengenau, 1h entspricht 3600s) der erwarteten Diensteinschränkung bekanntgegeben werden.  Aussagen wie "bis zu" oder "kürzer als" sind dabei zu vermeiden.
- Die Wartung ist anschließend ins Störungsprotokoll aufzunehmen mit geplantem Anfang/Ende der Wartung inkl. tatsächlichem Anfang/Ende der Wartung.  Letztere Angaben können entfallen, wenn die Wartung nicht früher angefangen und nicht später beendet wurde.  Geht die Wartung über den geplanten Zeitraum hinaus, gilt immer der größtmögliche Zeitraum (Beispiele: 10:00-11:00 Uhr geplant, 12:00 bis 13:30 dann tatsächlich, Wartungsdauer ist 2,5h.  10:00-11:00 Uhr geplant, 10:45-11:30 tatsächlich, Wartungsdauer 1,5h).
- Ist es eine Wartung ohne erwartete Störung (Störungsdauer 0s) und kommt es zu keiner Störung, gilt der Anschluss in dem Zeitraum vollständig verfügbar.
- Ist es eine Wartung mit erwarteter Störung, gilt der Anschluss für den gesamten Wartungszeitraum als nicht verfügbar, da der Nutzer ja davon ausgehen muss, dass er diesen während der Wartung evtl. nicht regulär nutzen kann.
- Tritt bei der Wartung eine unerwartete Störung auf, ist beides einzutragen:  Die Wartung sowie die Störung.  Der Anschluss gilt dann bei der Wartung als nicht verfügbar.  Da die Angaben falsch waren wird aber zusätzlich die Störungszeit ebenso als Nichtverfügbarkeit des Anschlusses gewertet, wobei die Zeit kompensiert wird (theoretisch ist so 200% Nichtverfügbarkeit erreichbar).
- Gleiches gilt, wenn die Störung vor oder nach der Wartung mit erwarteter Störung auftritt.  In diesem Fall gilt die gesamte Wartung als nicht verfügbar, sowie die gesamte Störungszeit.  Dabei kann der Rest der erwarteten Störungszeit von der Gesamtstörungszeit abgezogen werden.  Der "Rest der erwarteten Störungszeit" ist der positive Anteil der erwarteten Störungzeit abzüglich der Zeit, in der die Störung während der Wartung vorlag.  (Beispiele: Wartung 10:00-11:30 Uhr, Erwartete Störung 1h, Störung 11:00-13:00 Uhr.  Das bedeutet, der Rest der erwarteten Störungszeit ist 1h (erwartete Störung) abzüglich 30min (Zeitraum in dem die Störung während der Warung vorlag).  Nicht-Verfügbarkeit des Anschlusses ist also 1,5h(=Wartungszeit) + 2h(=Störungszeit) - 30min (=Rest).  Wartung 10:00-11:30 Uhr, Erwartete Störung 1h, Störung 10:00-14:00 Uhr, Rest der erwarteten Störungszeit wäre -30min, d. h. 0min, man kann also nichts abziehen, Nichtverfügbarkeit ist 1,5h+2h.

Des Weiteren muss für Firmen und interessierte Privatpersonen ein Dienst bereitgestellt werden, über den diese aktuelle Störungen, die ihren Anschluss oder ihre Anschlüsse betrifft, über das Internet maschinenlesbar abrufen können.

- Diese API muss gesichert sein, d. h. Unbefugte bekommen darauf keinen Zugriff.
- Der Zugriff auf die API selbst bis zu einer Query-Rate von 1/min muss kostenlos sein und darf keiner Monatsgebühr unterliegen.
- Eine einmalige Einrichtungsgebühr/Schutzgebühr bis 50 EUR (inkl. MwSt.) ist statthaft.
- Eine einfache Ampel ist ausreichend:  Grün:Verfügbar Rot:Gestört Gelb:laufende Wartung mit möglicher Störung bzw. eine in den nächsten 7 Tagen geplante Wartung
- Neben den Zugangs-Credentials zur API muss der Dienst eine Beschränkung auf IP-Ranges erlauben.
- Die Übertragung muss verschlüsselt erfolgen mit einem Standardverfahren, z. B. SSL.
- Empfohlen wird eine einfache REST-API mit Rückmeldung per JSON oder XML

# Gründe

Seit dem Wegfall von ISDN hat sich die Telekommunikationssituation in Deutschland wesentlich verschlechtert.
Ausfälle sind inzwischen eher die Regel statt eine Ausnahme.
Es ist dem Nutzer von Telekommunikation bei der unübersichtlichen Telefkommunikationslandschaft nicht mehr zuzumuten, auch nur ansatzweise verstehen zu können, was die Unternehmen tun oder nicht tun.

Das einzige, was der Nutzer bemerkt, ist, dass er nicht telefonieren kann.

- Weil die IP-Telefonie gestört ist.
- Weil der Handymast überlastet ist.
- usw.

Häufig kommt es aber zu Störungen, die der Nutzer nicht bemerkt.  Weil das Telefon nicht klingelt wenn es gestört ist.  etc.

Wenn der Nutzer nicht mehr telefonieren kann, ist für ihn nicht erkennbar, ob es sich z. B. um eine Abschaltung handelt (z. B. unbezahlte Rechung) oder um eine allgemeine Netzstörung.

Aus diesem Grund sind transparente Informationen rechtzeitig notwendig, die auch dafür geeignet sind, sich einen objektiven Eindruck über die Leistungsfähigkeit eines Dienstleisters zu verschaffen, ohne ein Telekommunikationsexperte sein zu müssen.

Störungen, die ein Nutzer nicht wahrgenommen hat, sind ebenso Störungen, die auf die garantierte Verfügbarkeit Einfluss haben.
Einige Telekommunikationsunternehmen geben lächerliche Verfügbarkeiten wie 90% an (das entspricht über 1 ganzen Monat Downtime im Jahr!).
Es ist aber unklar, ob sie diese Verfügbarkeit überhaupt schaffen!  Wenn jemand 4 Wochen kein Telefon hat und dann noch regeläßige Wartungsfenster dazukommen, die der Nutzer aber nicht wahrnimmt, kann selbst eine 90%-Verfügbarkeit bereits unterschritten sein.

Dem Nutzer ist nicht zuzumuten, dass er in solch einem Fall die Beweisführung antritt, dass die Vertragsbedinungen nicht eingehalten wurden.
Durch Bereitstellung eines verpflichtenden und vollständigen Störungsprotokolls aber kann dieser Beweis leicht erbracht werden.
Dadurch entsteht aber nicht nur Klarheit, es hilft auch, Streit zu vermeiden da dann klare objektive Daten bereitstehen.

KMUs haben zunehmend das Problem der Erreichbarkeit auf dem Festnetz.  (Bei der Firma, der ich angehöre, verzichten wir z. B. inzwischen auf Festnetzanschlüsse, da die notwendige Erreichbarkeit nicht mehr gegeben ist.)

Kleinunternehmen sind nicht in der Lage, eine mehrfachabstützung in der Telefonie zu bezahlen.

Beim Internet ist das vergleichweise einfach, aber das Management einer eigenen Telefonielösung, die über die mehrfachredundante IP-Verbindung dann einen entsprechenden Gateway ins Festnetz bereitstellt, ist schlichtweg zu aufwendig.

Der einzige Fallback, den solche Unternehmen haben, ist auf POTS (Plain Old Telephone Service, also die analogen Anschlüsse).  Das ist nicht nur lächerlich, es stellt sich die Frage, weil lange dieser Fallback noch zufridenstellen funktioniert, da die Verfügbarkeit von POTS inzwischen auch schon anfängt, zu erodieren.

Früher war die Sache einfach:  Man kaufte sich eine günstige ISDN-Telefonanlage.  Diese war nicht nur extrem selten gestört, sie erkannte Störungen auch zuverlässig selbst (dank D-Kanal), so dass man sofort informiert war.  Dazu dauerten die Störungen meist nur sehr kurz, eher Minuten denn Stunden.

Da die Störungen so selten waren, war das wie höhere Gewalt.  Man konnte mit dem Risiko der Nichterreichbarkeit leben.

Das hat sich geändert.  Unternehmer von heute müssen die Unerreichbarkeit einkalulieren, sonst wird das Risiko untragbar.
Das Problem ist nun, zu beweisen, dass man selbst die Unerreichbarkeit nicht zu vertreten hat.
Genau hier muss den Unternehmen (damit meine ich KMUs) ein Mittel in die Hand geben, Schaden ausgrund von unerwartet schlechter Telefoniequalität von sich abzuwenden.

# Ab Hier: T.B.D.

Konkreter Fall:

Gerade gibt es im Kabelnetz im Augsburger Raum eine Großstörung bei Vodafone.  Diese besteht seit mindestens Freitag (heute ist Sonntag).  Laut Aussagen von Vodafone sind Fernsehen, Telefon und Internet gestört.  Da ich kein Fernsehen habe, kann ich nur bestätigen, dass Telefon und Internet gestört sind, das Modem bekommt keinen Carrier (DOCSIS3.0), also keine IP, weshalb die IP-Telefonie natürlich auch betroffen ist.

Die Störung ist nicht permanent, aber ständig wiederkehrend, und besteht dann mehrere Stunden.  Zuerst gehen die Pakete verlangsamt über die Leitung (RTT von 3s und höher), danach fällt die Kabelnetzverbindung aus.
Manchmal fängt es sich von selbst, oder auch nicht.  Bei mir war mindestens 1 Mal ein Power-Cycle vom Modem notwendig damit es sich wieder verband.

Da ich beruflich auf Internet zwingend angewiesen bin, verfüge ich über eine sekundäre Abstützung über Telekom-VDSL.  Aber normale Verbraucher haben soetwas natürlich nicht.  Bevor VDSL verfügbar war hatte ich ISDN mit DSL-Light, damit war ich wesentlich zufriedener.  Die Störungshäufigkeit von VDSL.  Die Störungshäufigkeit von VDSL veranschlage ich mindestens Faktor 10 bis Faktor 100 höher als mit ISDN.  Bei ISDN kann ich mich an 2 kurze Störungen innerhalb von 15 Jahren erinnern.  Bei VDSL habe ich pro Jahr soviele Störungen, die in der Regel länger anhalten als früher bei ISDN.  Kalkuliere ich das Desaster des Anschlusses meiner Mutter mit ein, der eine Zeit lang ständig gestört war, muss ich das auf 2 Störungen pro Vierteljahr erhöhen (womit wir bei Faktor 60 wären).

Das ist aber immer noch kein Vergleich mit Kabel.  Kabel ist ständig kurz gestört.  Zumindest auf der IP-Konnektivität in die Welt.  Wenn man DS-Lite dazunimmt (also die CGN-Plattform von Kabeldeutschland) müsste man eigentlich von einer dauerhaften Störung sprechen (CGN bei Kabeldeutschland verschluckt so viele Pakete, dass man das nicht mehr als funktionabel bezeichnen kann).  Entsprechend habe ich den Anschluss auf IPv4-Only umstellen lassen, damit wird die Verbindung - wenn sie funktioniert - passabel.

OK, das kann ja mal vorkommen.  Was aber nicht normal ist, dass die Störung nach der SMS, die Störung sei beseitigt, immer wieder auftritt!

Vodafone spricht von einer Großstörung im Raum Augbsurg, kann aber keine Angaben dazu machen, wie lange es dauert, bis die Störung endgültig beseitigt ist.  Der Roboter meldet per SMS zwar immer wieder die Beseitigung (womit das Ticket geschlossen wird), aber das ist ein automatischer Vorgang, der dadurch ausgelöst wird, dass das Kabelmodem (bei mir ist es das des Anbieters) mal kurzzeitig - trotz der Störung - eine Netzwerkverbindung hinbekommt.

Das wirft folgende Fragen auf:

