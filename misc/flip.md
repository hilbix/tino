# Tino flippt aus

Passt in Rants, Jokes oder wo auch immer.  Aber irgendwo muss es ja hin.

## 2023-10-19 falscher Trackingstatus

Das Paket wurde (gestern Nachmittag) beim Nachbarn abgegeben.
Die DPD Sendungsverfolgung (die ich gerade telefonisch abgerufen habe) meldet (heute) ebenfalls, dass das Paket beim Nachbarn abgegeben wurde,

Bei OTTO in der App aber steht (jetzt noch) "Annahme durch eine Person im gleichen Haushalt", was also definitiv falsch ist.

Ich habe deshalb bei OTTO angerufen, dass da irgendwer lügt, und es denen mitgeteilt (da hatte ich noch nicht bei DPD angerufen), weil ich denke, auch solche klitzekleinen Fehlerchen sollte man melden.  Und die meinten halt, ich sollte bei DPD ebenfalls eine Beschwerde einreichen, was ich hiermit mache.

Ich vermute mal, eines der zwischengeschalteten IT-Systeme lügt (entweder auf Seite von DPD oder von OTTO) oder ist zumindest schrecklich ungenau bei der Art und Weise wie der Sendungsstatus geupdatet wird.  Resultat sind Fake-News wie das, was ich bei OTTO sehe.  Wer was und wie da Schuld hat ist mir ziemlich schnuppe, und ich habe auch keine Umstände damit.

Aber das ist ein Bug.  Und so etwas gehört sich einfach nicht.  Immerhin schreiben wir 2023.  Je nach Kalender.

Was ich vermute:  Der erste Sendungsstatus war vielleicht fälschlich "Person im gleichen Haushalt" und wurde dann aktualisiert zu "Beim Nachbarn".  Kommt ja vor, wäre das normalste der Welt, schließlich sind die Austräger Menschen, das muss man einfach akzeptieren.  Als IT.  Und derartige Korrekturen dann richtig weiterverarbeiten.  Und bei DPD hat der Update hingehauen.

Aber entweder hat OTTO das in den falschen Hals gekriegt, dann stellt sich die Frage nach dem Warum.  Oder evtl. hat es der Update nicht ganz zu OTTO geschafft.  Dann stellt sich die Frage, wie konnte das passieren?  Von außen kann ich das nicht beurteilen.

Aber das sollte unbedingt korrigiert werden.  Nicht der Datenfehler den ich sehe, sondern dieser ursächliche Fehler, dass es zu einer falschen Anzeige kommen kann!  Ob DPD die Schuld trägt oder OTTO oder beide oder das Universum (Gammaquant-BitFlip und fehlende ECC) ist dabei egal.  Falsch bleibt falsch und man sollte dem mal nachgehen.

Jetzt nicht mit hoher Prio, aber evtl. ist das ja nur ein Detail eines größeren Bugs und da dräuen größere Probleme.  Könnte sein.  Oder eher nicht.  Hoffe ich mal.

Denn es könnte auf den Verlust von Datensätzen bei der Synchronisierung in der Middleware hindeuten, einer falschen Optimierung oder eine Fehlverarbeitung in der ETL, oder schlimmer eine Race-Condition (der Update auf "Beim Nachbarn" wurde zuerst verarbeitet, die davor geschickte Nachricht dann hinterher, nach dem LIFO-Prinzip oder aufgrund von Parallelverarbeitung, whatever).

Was weiß ich schon, ich habe das Interface zwischen DPD und OTTO schließlich nicht gebaut.  Ist also nicht mein Fehler.  Mein Fehler ist nur, dass ich soetwas melde ;)

Mir geht es jetzt NICHT darum, dass die bei mir fehlerhafte Anzeige korrigiert wird.  Was stört mich ein schlechtes Bit?  Das Paket kam ja bei mir an wie gewünscht (halt nur über den Umweg Nachbar).  Und wäre da nicht der Patzer in der IT würde ich auch nichts sagen.

Warum ich das also melde?

Hey, ich bin aus der IT.  Einer dieser uralten Knochen denen es aus Prinzip weh tut wenn der Computer nicht ordnungsgemäß arbeitet.  Ich mache auch ETL und CRM oder so Sachen wie Backend-Synchronisation.  Und das seit bald 40 Jahren.  Ginge es um eines meiner Systeme, ich würde  gerne wissen wollen, wenn etwas schlief läuft.  Ja, genau auch und gerade bei den klitzekleinen Dingen.

Zuerst ist nur ein Record falsch.  Dann häufeln die sich.  Und irgendwann brennt die Hütte, weil alles in Zeitlupe auseinandergebrochen ist.  Und nur, weil die beiden Seiten sich zu weit auseinandergelebt haben und dadurch die Tabellenbuffer überlaufen.  Wäre nicht das erste Mal dass die Verarbeitungskomplexität urplötzlich explodiert weil ein Domino-Effekt auftritt.

Deshalb melde ich es.  Nur deshalb.  Damit verscheuche ich den Gremlin von meinem Tisch.

Nutzen Sie es, oder ignorieren Sie es.  Ich habe meinen Teil hiermit erfüllt ;)

PS: Und ach ja, weil bei mir Google keine JavaScript darf habe ich das CaptCha zuerst nicht gesehen.  Kein Beinbruch, aber halt wieder so ein elendiger Quirx.
