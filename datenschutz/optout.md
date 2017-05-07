# Datenschutz
## Opt-Out per HTTP

Ich habe mir Gedanken darüber gemacht, wie ein datenschutzkonformer Opt-Out nach deutschem Recht auszusehen hat.

### Voraussetzung

- Irgendwer hat, z. B. einen Newsletter abonniert.
- Man bekommt eine Mail, in der ist ein Abmeldelink enthalten
- Man kann auf den Abmeldelink klicken, um sich somit auf einfache Weise von den Benachrichtigungen abmelden

Das Datenschutzgesetz schreibt folgendes vor:

- Die für einen Geschäftsprozess zu erhebenden Daten müssen minimal sein.
- Darüber hinausgehende Daten müssen der Freiwilligkeit unterliegen.
- Der Prozess muss einfach sein, in dem Sinne, dass normale Menschen ihn mit ihren Mitteln nachvollziehen können
- und dabei dürfen die normalen Menschen nicht unfreiwillig dazu gezwungen werden, mehr zu übermitteln, als notwendig.

### Daraus entsteht folgender Prozess

#### Teil 1: Der klar ersichtliche Abmeldelink

- In der Mail befindet sich ein Link zu einem URL.
- Der User klickt auf den Link.

#### Teil 2: Die mininmale Abmeldeseite (`GET`)

Zusammenfassung:

- Am Besten befindet sich auf der einfachen cookielosen HTML-Seite nur eine knappe Erklärung, was geschieht wenn man den Bestätigungsbutton drückt, und zwar, dass man sich von allen Newslettern abmeldet.
- Evtl. begleitet mit Checkbox-Optionen, die der Nutzer - dann aber freiwillig - aktivieren kann, z. B. um auf bestimmten Newslettern zu verbleiben.
- Diese Optionen dürfen nicht vorgewählt sein und dem eigentlichen Zweck der Seite selbst nicht engegenstehen, also plötzlich eine Anmeldung statt einer Abmeldung bewirken.
- Besser noch, man lässt alle Optionen weg und verlagert diese auf andere Seiten, auf die man hinweisen kann, wie "wenn Sie sich nicht von allen Newslettern abmelden wollen" usw. etc. pp.
- Solche weiterführenden Links dürfen durch Browser nicht prefetchbar sein, z. B. indem man sie als Textbutton-FORM-Elemente in eigenen getrennten FORMs, hier aber mit `GET`-Method ausführt, damit Browser diesen nicht ausversehen folgen.

Details:

- Dieser erste Request geschieht [RESTful per `GET`](https://de.wikipedia.org/wiki/Representational_State_Transfer#Prinzipien)
  - Der Browser schickt also einen `GET`-Request an die beschriebene URL.
  - Welche Daten sonst mitbekommen, bestimmt der User.  Ein minimaler Request (ohne `Referer`, ohne `Agent` usw.) muss reichen.
- Es kommt eine Seite, die keinerlei weiteren Informationen, auch nicht per JavaScript, nachlädt.
  - Also nur embedded JavaScript, wenn überhaupt
  - Also nur embedded Grafiken, wenn überhaupt
  - Also nur embedded CSS
- Die Serverantwort übermittelt nur die minimalen Daten.
  - Insbesondere sendet der Server in seinem Reply keinerlei Cookies mit, auch dann nicht, wenn der Request Cookies enthielt!
- Auf der Seite befindet sich ein Formular (`<form>`) mit einem Abmeldebutton.
- Das Formular verwendet die `method=POST` sowie dasselbe URL (d. h. im `<form>` wird die `action` weggelassen)
- Befinden sich auf der Seite weitere Links, so müssen diese so geschrieben sein, das die inzwischen in Browsern übliche "auto-follow"-Prefetch-Funktion diese nicht prefetcht.
- Fremdwerbung hat auf dieser Seite nichts verloren.
- Eigenwerbung darf vorhanden sein, muss aber von dem eigentlichen Ziel so gut abgesetzt sein, dass man den Abmeldebutton nicht unmittelbar klar erkennen kann.
- Keine weiteren FORM-Teile außer Checkboxen.
  - Textboxen werden, wenn man sie leer lässt, leer übermittelt.  Das stellt zusätzliche Daten dar, die ein normaler User nicht unterdrücken kann.  Damit werden diese nicht-freiwillig erhoben.
  - Alle anderen Elemente, die wie die Textboxen eine Übermittlung von irgendwelchen Daten verursachen, sind strikt verboten.
- Die einzig neben dem Button vorhandenen FORM-Teile dürfen Checkboxen darstellen.
  - Diese Checkboxen unterliegen der Freiwilligkeit, d. h. es muss freiwillig sein, ob man sie anhakt.
  - Checkboxen werden nur dann nicht übermittelt, wenn sie nicht angehakt sind.
  - Somit darf es keinen Zwang geben, diese anzuhaken, damit der Vorgang wie gewünscht funktioniert.
  - Die Abmeldung funktioniert also genau dann vollständig, wenn man keine der Checkboxen anhakt.
  - Der Default steht immer und ausschließlich auf "alle Newsletter abbestellen" wenn nichts angehakt ist.
  - Hakt man eine Checkbox an und ist man auf die angehakte Newsletter nicht abonniert, wird diese nicht dadurch automatisch abonniert.
  - Die Checkboxen dürfen nicht alle angehakt sein, das wäre für den Nutzer, der die Erklärung abgeben will, dass er alle Newsletter abmelden will, nicht einfach.  Da das Gesetz aber keine Formvorschriften für den Opt-Out erlaubt, muss die Erklärung einfach sein.
  - Die Checkboxen dürfen nicht passend gesetzt sein, also nicht auf die Newsletter hinweisen, die man abonniert hat.  Dadurch werden personenbezogene Daten durch das URL übermittelt, deren Übermittlung der Nutzer nicht vorher zugestimmt hat.
    - Stattdessen kann man einen Link zu einer Seite schalten, auf der der Nutzer erfahren kann, welche Newsletter er abonniert hat.
- Weitere Buttons wären zwar ebenfalls möglich (sie werden nur übermittelt wenn man sie klickt), sind aber zu kompliziert.
  - User mit Lese- oder Sehschwäche bzw. Fremdsprachler können den Button evtl. nicht richtig erkennen oder verstehen.
  - Ein einziger Button mit einem klaren Wort wie "Abmeldung bestätigen" ist unmissverständlich.
  - Wenn man weitere Buttons anbringt, verwendet man sinnvollerweise alternative FORM-Elemente.
  - Diese müssen aber so klar und umissverständlich von dem wichtien Teil der Seite getrennt werden, dass man sie besser gleich ganz weglässt und auf andere Seiten verlagert.
- Man kann nicht davon ausgehen, dass JavaScript eingeschaltet ist.
  - Wenn man die Seite in TABs unterteilt, dann darf das nicht mit JavaScript geschehen, d. h. die anderen TABs müssen unsichtbar sein, bis sie eingeblendet werden.
  - Bitte auch auf Screenreader achten, die auf Seiten nicht zwingend nur sichtbare Elemente vorlesen.
  - Besser, man macht das einfach nicht.  Auch nicht per AJAX.

#### Teil 3: Die Abmeldebestätigung (`POST`)

Schickt der Browser statt wie in Teil 2 einen `GET`-Request einen `POST`-Request and as URL, wird sofort die komplette Abmeldung vorgenommen.
Auch bei dieser Seite handelt es sich um eine einfache cookielose HTML-Seite.

- Dieser zweite cookielose Request geschieht [RESTful per `POST`](https://de.wikipedia.org/wiki/Representational_State_Transfer#Prinzipien)
  - Der Browser schickt also einen `POST`-Request an dieselbe URL, an die er vorher einen `GET` geschickt hat.
  - Welche Daten sonst mitbekommen, bestimmt der User.
    - Ein minimaler Request (ohne `Referer`, ohne `Agent` usw.) muss reichen.
    - Insbesondere darf der übermittelte Button fehlen
    - Insbesondere darf der vorherige `GET`-Request fehlen.  **Ein `POST` direkt auf den in der Mail angegebenen Abmeldelink bewirkt also die vollständige Abmeldung von allen Newslettern etc. die es dort gibt.**
- Es kommt eine Seite, die keinerlei weiteren Informationen, auch nicht per JavaScript, nachlädt.
  - Also nur embedded JavaScript, wenn überhaupt
  - Also nur embedded Grafiken, wenn überhaupt
  - Also nur embedded CSS
  - Also keine Links, die von aktuellen Browsern in der Default-Einstellung automatisch ge-prefetcht werden.
- Keine Cookies.  Dafür wäre eine vorherige Einwilligung des Users notwendig, die man eingeholt haben müsste, was aber dem Zweck des Vorgangs genau entgegensteht (der User will eine Einwilligung widerrufen, und nicht plötzlich weitere implizit erteilen).

Auf dieser Seite darf es dann weitere Informationen geben, z. B. die Frage nach dem "Warum melden Sie sich ab" etc. pp.

Diese weiterfürhenden Informationen dürfen aber nicht irreführend sein, d. h. den User dazu verleiten, durch Irrtum seine Erklärung wieder zurückzunehmen.

Die Rücknahme hat dann - zwingend - per doppeltem Opt-In zu geschiehen, d. h. man kriegt eine bestätigungsmail die man explizit nochmals auf einer ähnlichen Website bestätigen muss.

Nochmals zur Klarheit:

- Es ist zwar nicht zwingend verboten, dass man bei Double-Opt-In dieses schon als vollbracht ansieht, wenn jemand auf den Link in der Mail geklickt hat,
- aber es vollkommen unverständlich, wenn der Abmeldevorgang aus der Sicht des Users komplizierter ist, als der Anmeldevorgang!
- Deshalb tut man gut daran, den Anmeldevorgang nach dem Abmeldevorgang zu konstruieren, d. h. ausgehend von der Mail ist beides ähnlich.
- Wenn man das nicht tut, kann man argumentieren, dass der User annehmen können muss, dass seine Erklärung der Abmeldung bereits angekommen ist, wenn er auf den Abmeldelink klickt, und nicht erst wenn er auf den zusätzlichen Bestätigungsbutton klickt.
- Und diese Annahme sehe ich als vollkommen logisch und zwingend an.
  - Sprich, wenn man die hier beschriebene Buttonlösung verwendet, **muss man den Anmeldevorgang analog gestalten**.
  - **Anderenfalls verstößt man gegen den Datenschutz**, da der User eine gültige Erklärung abgegeben hat, diese aber nicht akzeptiert wurde.
  - Erklärungen des Widerspruchs nicht zu akzeptieren steht aber der Firma nicht frei zu entscheiden.

> Datenschutz ist sehr einfach.  Man kann über ihn nicht diskutieren.
> Wer meint, eine für ihn geltende Rechtfertigung für etwas gefunden zu haben, der wird in der Regel gegen den Datenschutz verstoßen.
> 
> Beim Datenschutz geht es nicht um Rechtfertigung, sondern einzig und alleine um Freiwilligkeit und Zwang.
> Nur wenn ich gezwungen bin, Daten zu erheben, weil es sonst unmöglich umsetzbar ist (auch nicht bei jemand anderem), dann, und nur dann, darf ich die Daten überhaupt erheben, da sie dann nicht der Freiwilligkeit unterliegen.
> Alles andere - ohne jegliche Ausnahme - unterliegt zwingend der Freiwilligkeit.
> Das hat nichts mit technischer Machbarkeit "bei mir" zu tun, sondern mit Möglichkeit, es überhaupt umzusezten.
> Kann man etwas durch Änderung der Technik umsetzen, und dabei etwas weglassen, dann muss es auch so umgesetzt werden.
> - Nur wenn ich sagen kann "anders kann man es unmöglich machen", dann ist es erlaubt.
> - Wenn ich hingegen nur sagen kann "anders kann ich es nicht machen", dann darf man es nicht machen.
>
> Es ist so einfach.

### Gründe
  
- Im `<form>` befindet sich kein `action` bedeutet, dass man das `URL` der Ressource nicht ändert.
  - Man ändert alleine die `METHOD` von `GET` auf `POST`.  Das sieht der HTTP-Standard so vor, das wäre somit datenschutzkonform.
  - Durch den `POST` wird nur das URL wiederverwendet, das man bereit per `GET` an den Server übermittelt hat.  Es handet sich dabei nicht um neue Daten, sondern bereits bekannte Daten.
  - Ändert man das URL, so zwingt man den User dazu, weitere Daten, die unnötig sind, an den Server zu übermitteln, nämlich dieses geänderte URL.
  - Es ist unerheblich dass die Daten dem Server bereits bekannt sind.  Das Datenschutzgesetz macht da keinen Unterschied, ob die personenbezogenen Daten, die jemand übermittelt, nun dem Empfänger bereits bekannt sind oder nicht.  Das Gesetz verbietet hingegen ganz klar die Erhebung dieser Daten!
  - Dass das URL personenbezogen ist ist unstrittig.  Wäre es nicht personenbezogen, könnte der Server (REST!) nicht wissen, wen er abmelden soll.
  - Fazit:  Ich darf das URL nicht wechseln.
- Cookies sind in diesem Fall strikt verboten.
  - Sämtliche notwendigen Informationen sind bereits in der URL enthalten.
  - Cookies würden beim nächsten Request wieder ausgesendet.
  - Man muss von den Defauteinstellungen beim User ausgehen, d. h. der Browser übermittelt Cookies automatisch.
  - Cookies fallweise abzuschalten ist für die meinsten Menschen zu kompliziert.
  - Cookies sind also unnötig, denn sie verkomplizieren den Prozess.
  - Wenn Cookies zum Einsatz kommen, muss der User darauf hingewiesen werden.  Das ist inzwischen allgemein bekannt.
  - Es wäre jetzt unsinn, den Nutzer auf etwas hinzuweisen, wenn er gerade dabei ist, genau das Gegenteil zu erklären.


### Hinweise

- Der hier defnierte Algorithmus funktioiert.
- Er ist minimal, in dem Sinne, dass ich keine Möglichkeit fand, weniger zu übermitteln.
- Evtl. gibt es aber sogar einen minimaleren Algorithmus, der funktioniert.
  - Das bedeutet: Wer sich an meinen Algorithmus hält und trotzdem einen Datenschutzverstoß begeht, ist dafür selbst verantwortlich, ich garantiere nicht dafür, dass der Algorithmus gesetzeskonform ist.
  - **Garantiert verstößt aber jeder gegen das Datenschutzgesetz, der mehr Daten übermittelt, als was ich als "minimal" ermittelt habe!**
- Mir ist kein einziges Opt-Out-System bekannt, das sich an diese hier sichtbaren Rahmenbedingungen einhält.

Man kann argumentieren, dass ein einfacher Klick auf den Abmeldelink bereits abmeldet.

Diese Forderung ist verständlich und erscheint sinnvoll.
Tatsächlich kann man es auch gerne so umsetzen, wenn man will, d. h. der einfache Klick auf den Abmeldelink meldet bereits ab.
Aber das ist technisch der falsche Vorgang.

Das WWW ist ein technisches Web.  Dieses unterliegt gewissen technischen Implikationen und Standards.  An diese Standards hat man sich zu halten und diese Standards sind auch, gesehen aus der Warte des Datenschutzes, vollkommen gültig.

Wer es so implementiert, nämlich dass schon der erste `GET`-Request die Abmeldung vornimmt, derjenig hat sich zwar auch ganz sicher an den Datenschutz gehalten, verstößt dabei aber gegen den HTTP-Standard!  Er bricht also nicht das menschliche Gesetz, aber die technischen Gesetze.  Der Datenschutz erwartet nicht, dass man auch die technischen Gesetze (wie Physik etc.) bricht.

Also ist es vollkommen legitim, sich an die korrekte Implementierung gemäß HTTP zu halten.
So lange es unmöglich ist, einen minimaleren Algorithmus zu definieren, der sich an HTTP hält, ist das vollkommen einwandfrei.

Und genau das ist es.

- Ein Link in einer Mail löst immer einen `GET` aus.
- Ein `GET` ändert, gemäß HTTP, niemals den Zustand eines Resource (REST).
  - Er ist jederzeit wiederholbar und sollte zu immer dem erwarteten Ergebnis führen.
  - Es wäre also vollkommen unerwartet, dass der erste `GET` ein "Sie wurden abgemeldet" und der zweiter `GET` ein "Sie sind bereits abgemeldet" entspricht.
- Der Vorgang, der der Änderung eines Resource entspricht, ist `POST` und nicht `GET`.
- Um mich an HTTP zu halten, muss ich also einen `POST` auslösen, um die Änderung zu bewirken, die meiner Erklärung entspricht.
- Es ist nicht sichergestellt, dass der Mailbrowser auch `FORM`-Elemente anzeigen kann.
  - Es ist sogar sicherheitstechnisch empfehlenswert, wenn er es nicht kann.
- Aus diesem Grund kann man nur davon ausgehen, dass die Mail im reinen Textmodus angezeigt und der Link als einfacher Link gerendert wird.
- Das bedeutet, man bekommt einen `GET`-Request, der eben die gewünschte Änderung noch nicht auslösen darf.
- Ebenso verhält es sich übrigens mit dem Anmeldelink.  Der einfache Klick auf den Link darf die Anmeldung eigentlich nicht vornehmen, da dazu ein Statuswechsel notwendig wäre.  Die Antwort wäre also einmal "Sie wurden angemeldet" und die andere "Sie sind bereits angemeldet".  Genau das sollte so nicht sein, wenn man sich an den HTTP-Standard gem. REST hält.

Sprich, Datenschutz und Technik gehen hier Hand in Hand und geben einem ein sehr einfaches und klares Mittel vor, wie man es implementieren darf.  Eine Abweichung von dem, was ich geschrieben habe, erscheint mir schwer möglich.  Eine Vereinfachung ist zwar möglich, indem man dem REST-Standard eine Absage erteilt, aber das Datenschutzgesetz schreibt nicht vor, dass man andere Regeln brechen muss, wenn man ihn einhalten will.  (Diese Regeln müssen allerdings unabhängig für alle gelten, nicht nur für einen selbst.)

Mag sein, dass jemand eine Möglichkeit findet, es einfacher auf der Basis von HTTP zu gestalten.  Dann wäre ich daran unbedingt interessiert.

## Links

Ich füge gerne hier Links zu Opt-Out-Systemen ein, die die hier dargestellten Bedingungen erfüllen.

Bitte entsprechende Pull-Requests bei GitHub stellen, ich schaue sie mir dann an.
