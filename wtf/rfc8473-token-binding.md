https://tools.ietf.org/html/rfc8473

# WTF RFC 8473

Endlich gibt es einen Standard, der Authentikation im Web erlaubt.  Er ist in RFC 8471 niedergelegt und wird mit RFC 8473 auf das Web übertragen.

> Öh, haben wir etwas nicht mitbekommen?  Authentikation im Web macht doch offensichtlich jeder?
>
> Nein, falsch, genau das machen sie (mangels Standard) eben nicht!  [AAA](https://en.wikipedia.org/wiki/AAA_(computer_security)) enthält folgende 3 Teile:
>
> - Authentikation
> - Autorisation
> - Accounting
>
> Die herausragendste Fähigkeit des Menschen ist, sich selbst zu belügen.  Das tut er ständig, und zwar jede Mikrosekunde.  Mindestens.
> Deshalb ist es auch nicht verwunderlich, wenn die Leute annehmen, sie machen Authentikation, obwohl sie genau das nicht tun.
>
> Oder anders gesagt, statt AAA machen sie nur AA.  (AA steht hier ebenfalls dafür, ganz übel abzukacken.)


## Oder auch nicht

Es gibt jetzt [zwar](https://tools.ietf.org/html/rfc8471) [den](https://tools.ietf.org/html/rfc8472) [Standard](https://tools.ietf.org/html/rfc8473),
[nur](https://docs.google.com/document/d/1Ta3GlT_LrqAOLV217Kutn3B2trvifStxB0CThQ_kk78/edit?pli=1#) [niemand](https://bugs.chromium.org/p/chromium/issues/detail?id=467312)
(außer Microsoft Edge) [implementiert](https://www.chromestatus.com/feature/5097603234529280) [ihn](https://bugs.chromium.org/p/chromium/issues/detail?id=596699).

> Sahnehäubchen:  Der Bug ist geheim.  Ich bekomme jedenfalls "Permission Denied" beim letzten Link.

Experimentell gibt es (AFAICS inoffizielle) Module für [NginX](https://github.com/google/ngx_token_binding) und [Apache](https://github.com/zmartzone/mod_token_binding),
aber was nützen die, wenn der Client das nicht unterstützt?

Entsprechend rar sind auch die Beispiele im Web.  Ich konnte nur exakt 0 finden, was doch sehr mager ist.

> Macht ja auch nichts, wozu mit etwas beschäftigen, das unter "WontFix" läuft?


## Warum?

Ja, warum nur?  Warum implementiert das Web keine Authentikation?  Ich habe keine Ahnung!

Scheint aber wirklich ein Problem darzustellen, wie der Umsetzungsstatus von RFC 8473 zeigt.

## Nichtauthentische Autorisation

Was das Web bisher macht, ist reine Autorisation.  Per Cookies usw.  Aber eine Autorisation ist wenig wert, wenn sie nicht authentisch ist.

Und genau das ist das Problem.  Das Web erlaubt zwar schon irgendwie Authentikation, aber die ist entweder so umständlich, dass die niemand haben will,
oder [brandgefährlich implementiert](https://www.heise.de/forum/heise-Security/News-Kommentare/Facebook-Hunderte-Millionen-Passwoerter-im-Klartext-gespeichert/Das-ist-kein-Fehler-von-Facebook-Der-Skandal-ist-im-Browser/posting-34186385/show/)
(wie man aus den Reaktionen entnehmen kann kapieren es einige Leute nicht einmal, wenn man es versucht, ihnen zu erklären,
oder verstehen die eigentliche Problematik nicht die Bohne oder - hoffe ich mal nicht - wollen es nicht verstehen).

- Passwort.  Also Security by obscurity.  Die wohl mieseste Form einer Authentikation die man sich vorstellen kann.
- PKI.  Ist zwar in JavaScript inzwischen eingebaut, aber nur im HTTPS-Kontext.  Entsprechend nimmt die niemand her.  Außerdem fehlt da irgendwie ein sinnvoller Zertifikatssstore.
- TLS.  Nope.  TLS bietet uns - ohne den Standard da oben - überhaupt nichts.
  - Clients Side Certificates sind nicht nur unendlich umständlich, sondern auch nicht wirklich brauchbar, da sie im Klartext übertragen werden.
  - RFC 8473 ist in Chromium WontFix
- FIDO.  Mal abgesehen dass ich bis heute nicht herausgefunden habe, wie man so ein Token im Web nutzen kann, ist das besser als nix.
  - Umständlich!
  - Nur kann man den Standard nicht permanent verwenden, die Leute müssten ständig das Knöpflein drücken
  - Umständlich!
  - Und außerdem ergibt sich mir nicht, wie ich das Ding mit meinem Handy verwenden kann.
  - Umständlich!
  - Ich habe zwar einen NFC-Key (die es manchmal in homöopathischen Dosen für bezahlbares Geld bekommt, und nein, 20€ ist zu teuer!)
    sowie ein NFC-fähiges Handy, aber 0 Dokumentation wie ich das auf meiner eigenen Webseite auf meinem eigenen Webserver nutzen kann.
  - Umständlich!
- Kerberos, RADIUS bzw. GSSAPI.  Das funktioniert zwar, braucht aber eine eigene Infrastruktur und funktioniert deshalb nur im eigenen Verbund.
  - Nicht allgemein verwendbar

RFC 8473 könnte diese Misere endlich weitgehend auflösen.  Server und Client tauschen ein authentisches Secret aus, das man nicht fälschen kann.
Gelöst über ein einfaches Protokoll, das man dazuklinken kann.  Setzt zwar auf HTTPS mit seinen recht willkürlichen Art der Zertifizierung auf,
aber das wäre das erste wirklich sinnvolle Feature bei HTTPS das mich überzeugt, warum HTTPS besser ist als HTTP (Merke: HTTPS leistet genau
nicht das, was ihm immer zugeschrieben wird.  Weil es die Daten nicht autentisiert, sondern nur die Kommunikation zwischen Server und Client.
Also nur den Transport.  Genauso kann ich den ehrlichen Ahmed fragen, ob alles in Ordnung ist.  HTTPS ermöglich eben genau deshalb
keine vertrauliche Kommunikation, weil es die Existenz von BlueCoat nicht verhindert.)

Mit RFC 8473 authentisiert man zwar nicht den Nutzer, aber den Browser und, wenn richtig gemacht, damit das verwendete Endgerät (Stichwort TPM, auch wenn die
akuten TPMs nicht als HSM taugen, an dieser Stelle tut sich langsam etwas und hier könnte man ansetzen).  Das ist unendlich mehr als alles, was wir bisher haben.
Vor allem bringt es die Authentisierung runter auf die Ebene von JavaScript.  (JavaScript darf das Serverzertifikat nicht abfragen,
hat also keinerlei Zugriff auf TLS selbst.  Deshalb gibt es für JavaScript keinen Weg, eine Gegenstelle zu authentisieren, was absolut schwach ist.)
Mit Token Bindung ändert sich das durch die Hintertür, denn dann können wir abfragen, ob die Gegenstelle authentisch ist, weil nur dann das Token funktioniert.
Jedenfalls verspricht das das Protokoll, wenn ich es richtig verstanden habe. (**Kann aber sein, dass ich zuviel reinlese!**)

> Zum Verständnis:
>
> Ich denke an ein JavaScript (Neudeutsch: App), das über CORS mit einem Drittserver kommuniziert.
>
> JavaScript hat dabei das URL sowie evtl. weitere Infos zur Verfügung und soll sicherstellen, dass der Server derjenige ist, den es erwartet.
> Am einfachsten wäre, wenn JavaScript sich das Serverzertifikat ansehen und vergleichen könnte.  Nur geht eben genau das nicht.
>
> Out-of-Band sind eigentlich alle Informationen verfügbar, nur klappt das nicht und wir müssen uns umständlich mit einem In-Band-Request behelfen.
> Z. B. einem eigenen PKI.  Das setzt dann HTTPS voraus.  Handelt es sich um ein per HTTP geladenes JavaScript muss es die crypto hingegen selbst implementieren.
> Was vollkommen unlogisch ist, warum sollte ein per HTTP geladenes JavaScript weniger sicher sein als eines mit HTTPS?
> Bei mir ist es in der Regel genau umgekehrt!  Ein lokal per HTTP von 127.0.0.1:80 geladenes JavaScript ist deutlich sicherer,
> als eines, das von einem dubiosen CDN per HTTPS geladenen wurde, von dem man nicht weiß, ob es in den letzten Minuten gehackt wurde oder nicht.
> Andererseits kann ich für 127.0.0.1 kein Zertifikat erhalten, außer ich hacke die ganze PKI-Infrastruktur im Browser (durch ein eigenes
> Root-Zertifikat, welches dann wiederum weitere Gefahrenpotentiale birgt.  Erhöhen der Sicherheit durch Senken der Sicherheit?  Was soll das bitte darstellen?).
>
> Wäre also schön, wenn JavaScript einfach die Out-of-Band-Information nutzen könnte.  Das wäre mal endlich das erste valide Argument für HTTPS!
> Das Token wird das vermutlich leisten, da es ja automatisch invalidiert werden müsste, wenn der Server seine Identität wechselt
> (also die Domain verlorengeht und von einem Cybersquatter gekapert wird).  Anderenfalls wäre es fehlkonstruiert.  Wäre ja nicht das erste Mal.

Wichtig ist hierbei, dass die Authentikation bei jedem Request passiert, man also die Autorisation auf authentisierte Informationen stützen kann.
Im Gegensatz zu den derzeit verwendeten Cookies/Sessions, die auf einer obskuren Vergangenheit,
aus der dann ein minderwertiges Token hervorgegangen ist.

Dann, nur dann, hätten wir nicht nur Autorisation (z. B. durch ein Session-Cookie) sondern echte Authentikation.
Stimmt, nur die Authentikation des jeweiligen Clients und Servers, aber genau darum geht es doch hier in 99% der Fälle.
Nur sehr selten brauchen wir eine höherwertige Authentikation des Nutzers selbst.


## Das Passwort hat zu gehen

Es gibt eigentlich nichts schlimmeres als das Passwort.

Aber mangels Alternativen, was soll man machen?  Wie authentifiziert sich ein Nutzer?  Henne und Ei.

Dabei könnte die Welt so einfach sein:

- Authentische Client-ID sowie Mailadresse
- Dazu muss die Client-ID aber wirklich authentisch sein.
  - Sprich, die Client-ID darf nicht - auch nicht aus Versehen und erst Recht nicht per Diebstahl - in falsche Hände geraten.

Die Registrierung funktioniert wie folgt:

- Der Nutzer geht auf die Seite
- Er gibt seine Mailadresse an
- Er erhält per Mail den Registrierungslink
- Er ruft den Registrierungslink auf
- Er bestätigt die Registrierung indem er dem Ganzen einen Namen gibt
- Es wird das Token angelegt
- Ab hier kann er arbeiten
- Wenn er will, kann er das Token noch - optional - mit weiteren Faktoren schützen
  - Ein möglicher Faktor ist ein TOTP wie der Google Authenticator
  - Oder ein Passwort
  - Oder eine Kombination davon

Wenn der Nutzer die Client-ID verloren hat (Client kaputt, Browser neu installiert, etc.):

- Der Nutzer geht auf die Seite
- Er gibt seine Mailadresse an
- Er erhält per Mail den Registerierungslink
- Er ruft den Registrierungslink auf
- Er bestätigt die Registrierung indem er dem Ganzen einen weiteren Namen gibt
  - Ggf. muss er das mit seinen weiteren Faktoren bestätigen
- Es wird ein weiteres Token angelegt
- Er wird automatisch auf die Seite mit den registrierten Token geleitet
  - Hier kann er die kaputte Maschine entfernen

Phishing:

- Der Nutzer klickt auf einen Phishing-Link
- Der Phisher baut eine Verbindung zur Seite auf und holt sich deren Output
- Da das Token von der Webseite abhängt steht es dabei nicht zur Verfügung
- Sprich, wir haben hier den Fall "Client-ID verloren"
- Der Nutzer checkt gerade gar nichts und tippt hirntot seine Mailadresse ein
- Der Phisher hat nun die Mailadresse
- Fall: Der Phisher löst die Registrierung über die Seite aus.
  - Dann kommt per Mail der Registrierungslink der Seite den der Nutzer anklickt.  Er ist außerhalb der Kontrolle des Phishers.
- Fall: Der Phisher löst die Registrierung über die Seite aus und verlangt vom Nutzer, dass dieser den Registrierungslink rauskopiert und ihm schickt.
  - Wenn die Mail im HTML-Format ist, werden 90% der Nutzer das nicht richtig hinkriegen.
  - Ein entsprechender deutlicher Hinweis in der Mail kann außerdem verhindern.
  - Sprich so etwas wie:  
    "Der Link ist bis XX:XX Uhr gültig.  Geben Sie diesen Link niemals weiter!"
    "Leiten Sie diese Mail niemals weiter und kopieren Sie nichts aus dieser Mail!"  
    "Mitarbeitern und Dritten ist es verboten, diesen Link oder den Inhalt dieser Mail zu erfragen."  
    "Melden Sie uns bitte jeden derartigen Vorfall, es handelt sich wahrscheinlich um einen Betrugsversuch."  
    "Um einen Supportfall zu eröffnen können Sie wie folgt vorgehen:"  
    "Gehen Sie auf support.example.com und geben Sie die Support-ID XXX ein."  
    "Oder warten Sie bis nach XX:XX Uhr und antworten Sie erst dann auf diese Mail."
- Fall: Der Phisher schickt eine Mail mit seinem eigenen Registrierungslink
  - Das bringt uns nicht weiter, der Phisher muss irgendwie an den wirklichen Registrierungslink gelangen.

Drittzugang:

- Man ist im Cybercafe und sitzt an einer Kiste, die man nicht kennt
- Man will aber trotzdem zugreifen
- Der Nutzer geht auf die Seite
- Er gibt seine Mailadresse an
- Er erhält per Mail den Registerierungslink
- Er ruft den Registrierungslink auf
- Es wählt aus, dass es sich nur um einen temporären Zugang handelt
- Er erhält an seine Mailadresse einen weiteren Link
- Über diesen Link aktiviert er den Zugang für 15 Minuten
- Er erhält eine Mail mit einem Verlängerungslink den er anklicken kann wenn das benötigt wird
- An die Mailadresse geht außerdem ein Aktivitätsprotokoll, was auf der Seite abgerufen wurde

Diese Variante dient auch dazu, Dritten vorübergehend eine Zugang zu gewähren oder wenn die zusätzlichen Faktoren vergessen wurden.

Temporärer Zugang:

- Man ist im Cybercafe und sitzt an einer Kiste, die man nicht kennt
- Man will aber trotzdem zugreifen
- Der Nutzer geht auf die Seite
- Er gibt seine Mailadresse an
- Er wählt dabei Temporären Zugang aus
- Er gibt dafür weitere Faktoren (Passwort, 2nd Factor) an
- Der Zugang wird für 15 Minuten aktiviert
- Er erhält eine Mail mit einem Verlängerungslink den er anklicken kann wenn das benötigt wird
- An die Mailadresse geht außerdem ein Aktivitätsprotokoll, was auf der Seite abgerufen wurde

In diesem Fall ist der Login in die Mail nicht notwendig.

Mail (Henne-Ei-Problem):

Wenn der Zugang gleichzeitig Mailzugang ist, kann man über den temporären Zugang einen dauerhaften Zugang erzeugen:

- Man führt im Browser die Registrierung durch
- Um an die Mail zu kommen öffnet man einen temporären Zugang im privaten Fenster

Das alles setzt ein sicheres und authentisches Token voraus.

Alternativ kann man das Token nur sehr schwach absichern, z. B. an die IP binden etc.
Das Problem ist aber, wenn man einem das Token einmal "ausgekommen" ist (gestohlen wurde), ist es sehr schwer einzufangen.
Das kann nur mit einem "gebundenen" Token Geschichte werden.


## Noch etwas

Es ist sinnvoll, mehrere verschiedene Sicherheitsebenen anzubieten, in die man (ggf. zeitgebunden) wechseln kann.

Um meine Mail zu checken brauche ich nicht vollen administrativen Zugang zu meinem Mailkonto.  Da reicht es, wenn ich die Mails sehe und ggf. beantworten kann.

Entsprechend sollte der Zugang gesteuert sein.  Wenn ich mehr machen will, wie z. B. die Mail-Settings oder meinen Namen ändern will,
müsste eine Reautorisierung auf diesen höheren Level erfolgen.

In keinem der der Zugangssysteme habe ich soetwas bisher gesehen.  Einige erfragen zwar nochmals das Passwort, haben aber keine grundsätzlich zusätzliche Hürde.

Warum?  Eigentlich ist es doch einfach:  Ein Token hat eine aktuelle und eine maximale Erlaubnisstufe.

- Wird die aktuelle verändert, geschieht das mit einem Hinweis an die Mail.
- Wird dabei die maximale überschritten, muss eine Reauthentikation erfolgen.
- Beides (die erhöhten Rechte sowie die maximale Stufe) können dabei zeitlich beschränkt werden.

Dadurch wäre auch die feindliche Übernahme einer Session (Übernahme des PCs per Baseballschäger gegen den Kopf des Nutzers)
in diesem Sinne harmlos, dass es nicht ungesehen passieren kann (z. B. Hinweis der Nutzung der erhöhten Rechte nach Tod des eigentlichen Nutzers).

Es gehört nicht viel dazu, Dinge sicherer zu machen.  Man muss es nur wollen.

> Irgendwie habe ich nur den Eindruck, der wirkliche Wille dazu fehlt allenortens.


# Ach ja, einen habe ich noch

- https://www.sjoerdlangkemper.nl/2017/07/05/prevent-session-hijacking-with-token-binding/ und
- https://hanszandbelt.wordpress.com/2018/10/09/token-binding-specs-are-rfc-deploy-now-with-mod_token_binding/  Was steht da so schön?

> Update 10/18/2018: Google Chrome actually removed Token Binding support in version 70 so you’ll have to be on an older version to see this work in action, or use MS Edge

Alles klar!

## War auch viel zu einfach

```
$tokenBindingID = apache_getenv('Sec-Provided-Token-Binding-ID');
if (isset($tokenBindingID)) {
  $_SESSION['TokenBindingID'] = $tokenBindingID;
}
```

und

```
if (array_key_exists('TokenBindingID', $_SESSION)) {
  $tokenBindingID = apache_getenv('Sec-Provided-Token-Binding-ID');
  if ($_SESSION['TokenBindingID'] != tokenBindingID) {
    session_abort();
  }
}
```

> Quelle: https://hanszandbelt.wordpress.com/2018/10/09/token-binding-specs-are-rfc-deploy-now-with-mod_token_binding/

Neneneneneeeee, so was simples auch, wie kann man auch nur daran denken, das Web auf einen derart einfachen Weg um Längen sicherer zu machen?
Dafür kann es niemals nicht einen Konsens geben, denn:

- Das funzt ja ganz direkt zwischen Browser und Server, also auch bei abgeschaltetem JavaScript ohne so JavaScript Monster wie für FIDO
- Es wäre die erste tatsächliche Rechtfertigung dafür, HTTPS zu verwenden
- Es verhindert, richtig eingesetzt, Passwort-Leaks und somit wie HaveIBeenPwned
- Es verhindert Phishing, und zwar absolut und effektiv
- MiddleBoxen wie BlueCoat bekommen ein Problem
  - Das Problem ist RFC 8743 Sektion 5.3.
  - BlueCoat muss zwischen TP und TC sitzen und gegenüber TP und TC transparent als Client und gegenüber dem Client transparent als TP und TC auftreten
  - Dabei muss, im Gegensatz zur TLS-Interception, auch das Protokoll selbst verarbeitet werden
  - Dabei fällt State-Information an, sprich, die MiddleBox muss sich etwas permanent merken um nich zu schnell aufzufallen
  - In einem größeren Verbund von Middleboxen (Roaming) muss diese Information an alle Middleboxen synchronisiert werden
  - Da die MiddleBox aber nicht immer wissen kann, wann der Client die Informationen verwirft, kommt es zur Desynchronisation zwischen Client und MiddleBox
  - **Das wichtigste erscheint mir aber, was ich oben schrieb:  JavaScript kommt per RFC8473 dann an Informationen zum SSL-Layer heran.**
    Sprich, wenn eine Middlebox dazugeklinkt wird, bemerkt das JavaScript.  Derzeit ist das nicht der Fall, da alles die Browser unter Kontrolle haben.
 
Sprich, hat ein Tool wie Lavabit ein permanentes Token gesetzt, ähnlich eines [Warrant Canary](https://en.wikipedia.org/wiki/Warrant_canary),
wird dieses Token instant invalidiert, sobald ein Middlebox dazukommt und versucht den SSL-Pfad zu stehlen.

Da die MiddleBox als Client auftreten muss aber nicht im Besitz des geheimen Schlüssels ist kann sie das Token gegenüber TC nicht validieren und fliegt auf.

Das, denke ich, wird wohl der Grund sein, warum Browser RFC 8743 nicht implementieren und der Bug geheim ist.

Während das WWW vom Cern stammt kommen alle Browser (FF, Chrome, Edge) aus den USA.

- [Dort gibt es die NSL](https://en.wikipedia.org/wiki/National_security_letter)
- Unterliegt man einer NSL, darf man nicht darüber sprechen.  Das könnte der Grund für die Geheimhaltung des Bugs sein.
- Eine NSL kann niemanden zwingen, etwas bestimmtes zu tun.  Deshalb gehe ich davon aus, die Browser sind nicht trojanisiert.
  - Warum?  Weil irgendwer das herausfinden würde.
  - Sobald der erste es melden würde ist es für andere einfach, die Korrektheit der Aussage mit mathematischer Präzision zu verifizieren.
  - Da greifen einfach keinerlei Möglichkeiten jemanden zu diskreditieren bevor die Informationen öffentlich werden.
  - Und solch ein Skandal wäre selbst für Größen wie Google vermutlich der instante weltweite Untergang.
- Eine NSL kann aber jeden, also auch Google, dazu zwingen, etwas zu unterlassen.
  - So passiert im [Fall Lavabit](https://en.wikipedia.org/wiki/Lavabit).
  - Diese Unterlassung geschieht indirekt, indem derjenige per NSL gezwungen wird, Informationen auszuhändigen.
  - Diese Informationen müssen selbstverständlich im Original, also unverschlüsselt übergeben werden.
  - Will er das nicht, und davon gehe ich einfach mal aus, muss derjenige also sicherstellen, dass er diese Informationen nicht hat.
- Außerdem unterliegt Verschlüsselung, auch heute noch, dem Kriegswaffenexportverbot (nicht nur in den USA)
- Es gibt also gleich mehrere mögliche Ansatzpunkte, wie Amerika amerikanischen Unternehmen eine derartige Technik wie RFC 8743 im Browser untersagen könnte.

Zu behaupten, es wäre so, wäre eine Verschwörungstheorie, solch eine will ich hier nicht starten.  Die Tatsachen aber bleiben:

- RFC 8743 kann MiddleBoxen relativ simpel enttarnen, und das, ohne dass der Nutzer etwas tun oder davon vorher wissen muss.
  - Das betrifft Hersteller von MiddleBoxen wie BlueCoat, die allesamt in Amerika zu sitzen scheinen
- Alle effektiv genutzten Browser kommen aus den USA
  - Es ist keine Verschwörungstheorie zu behaupten, dass es im Interesse von Amerika ist, dass das für immer so bleibt.
- RFC 8743 wird in den Browser anscheinend nicht umgesetzt.
  - Obwohl es sofort global äußerst bedeutsame Dinge wie Phishing unmöglich machen würde
- Auf den Bug, warum RFC 8743 nicht im Browser umgesetzt wird, erhalten normale Leute wie ich keinen Zugriff.
  - Das kann sehr viele Gründe haben.
  - Vielleicht bekäme ich ja Zugriff wenn ich wüsste, wie.
  - Aber warum gibt es dieses Zugriffsproblem?  Täte Google nicht gut daran, derart wichtige Informationen zu veröffentlichen?
  - **Vielleicht sind die Informationen, die man braucht, um den Grund zu verifizieren öffentlich, ich habe sie nur nicht gefunden.**

[Die einzige Quelle, die ich gefunden habe, erklärt sich mir nicht](https://groups.google.com/u/1/a/chromium.org/g/blink-dev/c/OkdLUyYmY1E), Zitat:

> After weighing the security benefit of Token Binding against the engineering costs, maintenance costs, web compatibility risk, and adoption, it does not make sense to ship this feature.

Angesichts des immensen weltweiten Aufwands gegen Phishing erscheint mir dieser Erkkärung vollkommener Bödsinn zu sein.  Die Begründing ist nicht stichhaltig.

- Das erscheint mir, als ob man, statt ein Kind zu Baden, aufgrund des Aufwands ein Bad einzulassen dieses lieber tötet um ein anderes Kind zu machen.
- In jedem Browser stecken so viel unendlich komplizierte und teils sogar vollkommen widersinnige Komponenten, dass ein einfaches (und bereits funktionierendes!) grundsätzlich standardisiertes Verfahren zusätzlich zu maintainen ein Klacks erscheint.
- Insbesondere da die Community das sicher gerne machen würde.
- Und ganz besonders aufgrund des Aspekts, dass man so [Volkswirtschaftlichen Schaden in Millionenhöhe](https://de.statista.com/statistik/daten/studie/38681/umfrage/finanzieller-schaden-durch-phishing/) sofort vermeiden könnte.
- Außerdem könnte das das typische [tägliche Übel von Passwortlecks](https://www.heise.de/news/Neue-Leaks-Have-I-Been-Pwned-um-17-5-Millionen-Nutzerdatensaetze-erweitert-4855485.html) deutlich einschränken
- Da implementiert Google also lieber eine obskure, fragile Krücke wie HaveIBeenPwned in den Browser (bei mir meldet Chrome, wenn ein Passwort dort auftaucht!),
  anstatt ein (bereits funktionierendes!) Verfahren zu implementieren, das genau diese Krücke überflüssig machen könnte
  (jedes Passwort könnte mit wirklich fast keinem Aufwand immer nur zusammen mit einem 2nd Factor funktionieren,
  so dass das Auskommen des Passworts so gut wie keinen Schaden mehr erzeugen könnte).

Sounds legit?

Zitat weiter:

> Depending on the use case that a site operator had for Token Binding, there are other technologies that can be used. For protecting cookies against XSS, the HttpOnly flag can be used. For providing a cryptographic assertion that both peers are on the same connections, TLS client certificates can be used. Some use cases might be able to use WebCrypto.

Das erscheint nur auf den ersten Blick logisch.

- Tatsächlich gibt es zu RFC 8473 eben keinerlei Alternative.
  - RFC 8743 hat mit XSS soviel zu tun wie die Kuh mit Sonntag (als Sonntagsbraten)
- Der Browser könnte - wo verfügbar - das Token sogar durch ein HSM (ist IMHO Teil der TPM-Spec v2) schützen.
  - Dann ist es ultimativ an den Besitz der Hardware gekoppelt, das macht zusätzliche Hardware-Token wie die von RSA, YubiKey und FIDO unnötig
- TLS Client Certificates sind keinerlei Ersatz für RFC 8743, denn sie werden außerhalb des TLS-Layers übertragen.
  - JavaScript hat außerdem darauf keinerlei Einfluss.  Sprich sie sind so umständlich, dass man sie nicht sinnvoll einsetzen kann.
- WebCrypto ist JavaScript
  - RFC 8473 würde ganz ohne JavaScript auch im Textbrowser Lynx funktionieren!
  - Außerdem ist WebCrypto unter HTTP nicht verfügbar.  **Warum haben Browser eigentlich unter HTTP keine gesicherten Cryptoroutinen** sondern müssen die mit einem Shim nachladen (womit es einen Kompromittierungsansatz gibt)?  
    Der Punkt hier ist: Traue ich der Gegenseite (also traust Du mir dass ich alles richtig gemacht habe)?  Weil WebCrypto unter HTTP nicht verfügbar ist, musst Du also nicht nur Dir, dem Computer und dem Browser vertrauen, sondern auch noch mir.  Irgendwie widersinnig weil vollkommen unnötig.
  - Richtig, RFC 8473 funktioniert auch nur mit TLS.  Aber genau das ist ja der Punkt!  TLS leistet nämlich genau das nicht, was immer kolportiert wird.  
    (Der ubiquitäre Einsatz von TLS macht das Web eben nicht automatisch sicherer, das genaue Gegenteil ist der Fall, die Phisher haben sich ultraschnell angepasst und die Nutzer kapieren es aufgrund des Gewöhnungseffekts noch weniger als vorher!  Früher konnte ich beim Training auf das Schlosssymbol verweisen und was dann zu tun ist.  Dieser Hinweis ist inzwischen wegerodiert!  Mir wurde also nur eine Möglichkeit genommen und nichts im Gegenzug gegeben um die Nutzer zu sensibilisieren und sensibilisiert zu halten!)  
    Ich kann außerdem alles, was SSL tut, ebenso unter HTTP mit JavaScript implementieren (Subresource-Integrity schützt das gegen Missbrauch), der Vorteil wäre, dass ich dann sogar in JavaScript die Integrität der Verbindung prüfen könnte (was ich bei TLS eben nicht kann.  Warum ist das unter HTTPS nicht implementiert?).     Der einzige Vorteil von SSL ist, dass es Out-Of-The-Box existiert und dabei das Transport-Layer gegen recht unbedarfte Angreifer schützt ohne dass ich tiefer darüber nachdenken muss (genau das IST ein guter Grund für seine Existenz).  Es anonymisiert aber eben genau nicht (sollte es das tun müssten Client-Certs verschlüsselt übertragen werden) was einige immer wieder behaupten, genau das ist eben nicht sein Einsatzzweck!  
    RFC 8473 brächte das TLS-Layer aber auf einen neuen Level, den man nicht selbst nachimplementieren könnte, weil der Browser ggf. Schutzmaßnahmen bereitstellt (TPM), die man nicht per JavaScript emulieren kann (nur simulieren, das ist aber nicht genug).

Zitat weiter:

> Client malware seems to be the most-often cited example in Token Binding discussions, yet this is outside the scope of Chrome's threat model.  
> [..]  
> Rogue extensions is an interesting issue that gets into broader interactions between Token Binding and the web platform.  
> [..]  
> A rogue extension would also be able to make use of the modified APIs to continue to exercise the tokens it would have stolen, meaning that in all likelihood the problem of token theft via rogue extensions isn't best solved by Token Binding,

- Auch das überzeugt mich nicht.  Denn Malware geht ja von Chrome aus!  Dass es dabei um die Sicherheit geht und Sicherheit niemals zum 0-Tarif zu kriegen ist, sollte allseits bekannt sein.  Dass Dinge wie Developer-Tools angepasst werden müssen und die API sicher gestaltet werden muss, so dass Extensions zwar Token-Binding nutzen können aber nicht infiltrieren ist eine Selbstverständlichkeit.  Dass dann ältere Extensions vielleicht Probleme bekommen, oh, könnte es sein, dass diese sowieso gefährlich waren?
  - Token-Binding ist ein Mittel, um bestimmte Token genen Missbrauch zu schützen und die Identität des Geräts sicherzustellen.
  - Extensions müssen an dieser Stelle eigenetlich gar nicht eingreifen!  Sie können das Verfahren nutzen oder nicht.
  - Wenn sie es nicht nutzen, gibt es kein Problem, dann läuft alles wie gehabt mit allen Gegenstellen, die ebenso diese höhere Sicherheit nicht fordern.
  - Es ist nicht anzunehmen, dass diese Sicherheit wie eine Seuche um sich greift, da eine Nutzerinteraktion notwendig sein muss um Token-Binding zu nutzen.
  - Warum?  Sonst wird jeder Werbetreibende diese Methode verwenden, um den Nutzer zu tracken.  Ist ok wenn sie das versuchen, man muss einer Extension wie UBLOCK nur die Möglichkeit geben, das Token-Binding zu unterbinden oder zu erzwingen.  Per-Site.  Eine tiefere Interaktion ist nicht notwendig!  Wenn das ein Problem darstellt, weiß ich nimmer, worüber wir überhaupt reden.
- Angesichts des Falls von The Great Suspender kann diese Aussage nur noch als extrem zynisch und falsch aufgefasst werden:
  - https://www.zdnet.com/article/google-kills-the-great-suspender-heres-what-you-should-do-next/
  - Sprich: **Die Google-Entwickler sehen es nicht als Argument an, Google-Chrome-Nutzer gegen Malware zu schützen, die sie selbst verbreiten.**
  - Wie behämmert ist das?
- Ja, RFC 8743 hätte den massenhaften missbrauch von Accounts durch die Trojanisierung von The Great Suspender mit ziemlicher Sicherheit verhindern können.
  - Aber in diesem Fall hätte der Missbrauch immer über den kompromittierten Browser selbst durchgeführt werden müssen.  So aber konnte er anschließend von überall in der Welt vorgenommen werden.
  - **Mit der Herausnahme von Token Binding nahm Google nahm den Nutzern von Chrome keinerlei Chance, sich gegen diesen Angriff zu verteidigen.**
- Also nochmals zur Erklärung:
  - Ich logge mich mit einem kompromittierten Browser bei Instagram ein (nein, nicht ich, ich habe kein Insta, aber egal).
  - Dann greift ein Trojander die Zugangsdaten ab
  - Er verhindert, dass ich mich auslogge und die Cookies nutze
  - Danach hat er volle Kontrolle über Instagram
  - Mit RFC 8743 gibt es zwei Szenarien, die das verhindern
- Erstes: Ich verwende auf unsicheren Geräten RFC 8743 nicht.  Dann lässt mich Insta z. B. nur in einen reduzierten Account rein, der nichts kaputtmachen kann.
  - Tut Insta nicht?  Fehler von Insta!
  - Könnte Insta heute auch schon implementieren?
  - Ja, dazu braucht es aber einen 2nd Factor.  **2nd Factor ist gut aber unbequem!**  Die Leute schalten das ab, weil es zu umständlich ist!  Außerdem haben sie eben nicht immer ihren 2nd Factor dabei, und irgendwann erodiert das dann zurück auf "zu kompliziert".
  - RFC 8743 kann das ändern.  Könnte.  Aber so nicht.  Denn so gibt es keinen Grund für Insta die Sache zu verbessen.
  - **Denn wir können nicht den entsprechenden Druck aufbauen, dass die Leute endlich anfangen, vernünftige Loginsysteme aufzubauen*.
  - Wieso sollten sie das ohne Benefit, wenn die Browser sie im Stich lassen?  Ich habe nur die Wahl zwischen Pest und Cholera da das Vacczin Token-Binding ja nicht bereitgestellt wird.
- Zweitens: Ich verwende RFC 8743.  Dann ist das Gerät dummerweise autorisiert und der Trojaner kann so lange wüten wie er will.
  - Ja, aber dazu braucht er immer noch das Gerät.  Das ist schonmal eine ziemliche Hürde die viele Trojaner nicht einfach mal so nehmen können.
  - Aber dieser Angriff ist selbstverständlichj einer, dem es zu begegnen gilt.
  - Und Google hat genau dagegen eine sehr gute Verteidigung:
  - Sobald ich ein Gerät als Vertrauenswürdig hinzufügge, bekomme ich einen Push auf's Handy, und kann - mit einem Klick - diesen Spuk beenden.  Retroaktiv.
  - Genau das leistet RFC 8743 ebenfalls.
  - Richtig, man kann - fast - dasselbe heute schon ohne Token-Binding erreichen.  Aber mit welchem Aufwand?
  - Wenn ich ein Konzern wie Google bin, der weltweit Datacenter betreibt und das halbe Internet dominiert, dann kann ich selbstverständlich zwischen Spreu und Weizen unterscheinden, also entdecken, dass das als Token missbrauchte Cookie plötzlich ganz woanders missbraucht wird, also statt in München von einem Hacker in Hamburg.  Auch wenn ich jemand wie Cloudfront, also Amazon, bin kann ich das.  Ja, solche Giganten können das natürlich.
  - Aber wo bleibt der einzelne kleine Web-Developer?  Wie soll ich, der kleine Webseitenbetreiber, dassekbe tun, ohne eine Hilfe wie Token-Binding?  Einen solchen Mehrwert selber aufzubauen, also meine Nutzer zu schützen, übersteigt einfach die eigenen finanziellen und technischen Möglichkeiten!
  - **Token-Binding und somit ein Mittel der Netzneutralität!**  Durch die Entscheidung gegen Token-Binding verschaffen sich die großen einen nicht unwesentlichen Vorteil gegenüber den Kleinen und verzerren somit mit der Zeit die Netzneutralität immer weiter zu ihren Gunsten!

> Token binding provides little value to the browser and is transparent to the user, but does provide increased security that isn't comparably available otherwise.

Exakt meine Rede

> Disabling token binding for the origin of their web properties during development/debugging

Genau

> I'm a bit confused by the scenario described here.  

Offensichtlich.  So blöd ist der Chrome-Entwickler eben nicht, sondern arbeitet hier hart daran, den Gegenüber misszuverstehen, damit das stichhaltige Argument nimmer sticht.  Well Done.  Da steckt offensichtlich eine böse Absicht dahinter, sorry, aber anders kann ich es nicht ausdrücken.  (Die Böswilligkeit kann einfach der Unwill sein, das Feature loswerden zu wollen, und zwar zu jedem Preis.)

> It seems to me like protecting against server-side theft of tokens can be done server-side with other mechanisms than Token Binding. 

Stimmt.  Wenn man Dinge wie ein HSM hat, oder **wenn man Google oder Cloudfront heißt ist das einfach**.  Für den kleinen Betreiber für den selbst ein CX11 von Hetzner viel Geld bedeutet (Merke: 1$/Tag ist die Armutsgrenze, aber auch arme haben ein Recht darauf Webserver zu betreiben) ist das eben alles andere als einfach und bedeutet mehr als nur **doppelten Aufwand für kleine Webseitenbetreiber ohne Token-Binding!  Dazu kommt noch der zusätzliche Aufwand um die Clientseite zu schützen!**

> Sometimes things break in the name of advancing security at large.

Gut gesprochen.  Das ist auch notwendig.  Gute Sicherheit erreicht man nicht durch gesteigerte Komplexität, sondern ausschließlich durch Abschneiden von unsicheren Zöpfen sowie Fallenlassen der falschen sicherheitstechnischen Vorgehensweise!  Falsche Vorgehensweisen müssen durch sichere Vorgehensweisen ersetzt werden.  Und ein Grundstein dafür wäre Token-Binding.  Nein, schlimmer, **Token-Binding ist eigentlich der Anfang** an dem man beginnen müsste.

(Nein, TLS ist es nicht.  TLS ist eine ziemlich schlecht gemachte Krücke und kein Anfang.  Am Anfang steht so etwas wie ein TPM, und Token-Binding kann genau das bereitstellen.)

> Token Binding will continue without Chrome if it needs to, but it will be unfortunate.

"unfortunate" ist weichgewaschen.  Es wird in Wirklichkeit unerträglich nachhaltig behindert!  Aber die neue Political Correctness macht solches Weichwaschen leider notwendig.  Man kann ja schlecht sagen **Euch (den Google-Entwicklern) hat man offensichtlich ins Hirn geschissen!**  Nein, das kann man einfach nimmer sagen in der heutigen Zeit!

Außerdem sehr interessant, dass dieses Statement von Yubico kommt.  **Das ist eine echte Empfehlung für Yubikey!**  Den das Fehlen von Token-Binding spielt Yubico in die Hände, sprich Yubico müsste eigentlich begeistert davon sein, dass Google ihnen nicht die Butter vom Brot nimmt!  Aber offensichtlich sitzen hier wirklich Leute, denen die Sicherheit im Web ein echtes Bedürfnis ist, und sie deshalb nicht nur ihren eigenen kommerziellen Erfolg im Auge haben.  **Vielen Dank dafür!**

(FYI:  Token-Binding macht Devices wie den Yubikey oder FIDO nicht überflüssig, aber senkt den Druck diese zu nutzen.  Sprich, es nimmt auf Dauer deutlich Absatzmarkt weg, weil die Leute etwas wie den Yubikey nicht mehr benötigen.  Warum?  Weil jeder, der von einem Fall betroffen wurde der durch ein Hardwaretoken verhindert hätte werden können, eine Lernerfahrung durchmacht, und so zum Hardwaretoken getrieben wird, auch wenn es unbequem ist - jedenfall ohne Token-Binding -.  Wenn diese Lernerfahrung aber nur noch in homöopathischen Dosen daherkommt, weil Token-Binding den Missbrauch wie Phishing größten Teils beendet, dann gibt es wesentlich weniger Gründe für Menschen, ein solches Hardwaretoken für sich anzuschaffen.  Der Absatzmarkt bleibt natürlich trotzdem riesig, und der Sicherheitsgewinn durch Token-Binding ist gewaltig, da dies das Handling von Hardware-Token wesentlich vereinfachen kann - man muss es seltener nutzen, hat dann aber gleichzeitig, wenn man es einsetzt, ein vereinfachtes Handling gegenüber dem Fehlen eines Hardware-Tokens -, aber insgesamt dürfte der mögliche Zugewinn an Absatz auf Dauer eher sinken.  Oder anders gesagt:  Wenn man eine Krankheit heilt, kann man das Medikament nur einmal verkaufen.  Wenn man hingegen dafür sorgt, dass das Medikament die Krankheit nicht ganz heilt, kann man es ständig wieder neu verkaufen.  **Während Yubico gerne heilen würde, will Google nicht einmal einmal das existierende Medikament auf den Markt bringen!**)

**Interessant auch, dass Leute der FODO-Alliance ins selbe Horn tuten wie Yubico.**  Das hätte ich nicht erwartet.

(Grund: WebAuthN ist der letzte Scheiß.  Viel komplexer kann man etwas eientlich wohl nimmer gestalten.  **Komplexität ist der Tod der Sicherheit.**)

> Channel ID is indeed being removed

Das wird ja besser und besser.  Um nicht zu sagen schlimmer und schlimmer.  Channel ID hat Probleme und wird fallen gelassen, weil es etwas besseres gibt.
Und das wäre?  Na, Token-Binding natürlich!  Und dann lässt man Token-Binding mit vollkommen sinnfreien Argumenten fallen, man schafft einfach Tatsachen ohne wirklich zu erklären, warum.  Ein Schelm der dann böses denkt?

> TOKEN BINDING SUPPORT HAVE BEEN REMOVED FROM CHROME.

Und zwar ohne jeden weiteren Kommentar.  Es wurde angekündigt, nicht verteidigt und dann einfach umgesetzt.  Getreu dem Motto "friss und stirb"!

> https://tcwiki.azurewebsites.net/index.php?title=Bearer_Tokens_Considered_Harmful#Introduction

Zitat von dort: "Banned: This paper was rejected by the IDPro organization".  Ja klar doch.  Die bösen anderen ;)

Web considered harmful.  Denken considered harmful.  Und ich setze noch einen drauf:  http://dhmo.org/

Zurück zur Realität:

**Kerberos ist ein Bearer Token.**  Kerberos ist Realität.  Und Kerberos ist sehr erfolgreich darin, Dinge zu schützen.
Natürlich ist Kerberos keine Magie, die einfach so mal alles sicher machen kann.  Denn auch und gerade Kerberos kann man falsch einsetzen.
Und viele machen es falsch.  Das bedeutet aber nicht, dass es schadet oder dass Bearer Token falsch sind.

Was für ein Schlonz, da musste sich jemand wichtig machen.  Hat er nicht.  Der Typ ist ein offensichtlicher Idiot
(und ja, das werde ich ggf. vor Gericht verteidigen das ist eine wahre Tatsachenbehauptung!)

> I still do not understand how the people behind Token binding an be so silent about this stupid decision.

Genau.  Stille.  Warum spricht nur niemand darüber?

Indes kann ich das sehr gut verstehen.  Was soll man schon groß sagen, wenn es keine Gegenargumente gibt?

> token binding, and earlier channel binding, are flawed security ideas.

Ach?  Wieso?

> The basic idea seems to be that since we are not competent to create security at the application layer, we will hitchhike on security at lower layers in the communication stack.

OMFG, geht es noch dümmer?

Es ist eine (wissenschaftlich erwiesene) Grundlage, dass man auf OSI Layer 7 die hier erforderliche Sicherheit erschaffen kann, sondern dafür ein niedrigeres Layer, genauer wird OSI Layer 1 benötigt.  Das genau ist ja der Ansatz von Hardware-Token.  Das Web geschieht auf Layer 7, und dieses Layer ist aus gutem Grund  gegenüber Layer 1 ultimativ abgeschirmt.  Es ist also unmöglich, ohne die Hilfe niedrigerer Layer die notwendige Sicherheit zu erschaffen.

**Inkompetent ist nur derjenige, der das nicht einsieht!**

> Can we also get rid of TLS while we're at it please? It is very annoying and we can solve it better at the application level... :-\

Obwohl ich denke, er meint das ironisch, hat er damit Recht.  **Mit Token-Binding und Subresource-Integrity können wir auf Layer 7 die Sicherheit vollständig selbst implementieren und sind nicht mehr auf Krüken wie das TLS-Layer angewiesen!**

Was fehlt?  Ach so, ja, Token-Binding.  Nein, falsch, das fehlt nur zur Sicherheit.  Denn TLS könnten wir schon heute auf dem Applikationslayer ersetzen.
Ohne dabei Sicherheit zu verlieren.

Ja, der Angreifer sieht dann unseren TLS-Stack im Klartext.  Oh, und?  Dass wir TLS verwenden sieht er ja schon heute und der von uns verwendete TLS-Implementierung ist ebenso - meistens - im Klartext verfügbar.  Das ist also überhaupt kein Argument!  Das Argument ist, dass das Applikationslayer komplexer wird.  Derart von jedem verwendete Komponenten - AKA Standards - sollten deshalb nicht im Applikationslayer, sondern in den entsprechenden anderen Layern verankert werden.  Dafür sind Layer da.  Wenn wir das aufgeben, warum dann überhaupt noch Layer?  Wir brauchen Layer 1 und Layer 7, die Layer dazwischen lassen wir blank.  Oder was ist das Argument nochmal?

> Face it, token binding and channel bindings are hacks.

Meine Antwort wäre: "If OSI Layer 7 is so good, please get rid of your OSI Layer 1 and try again".  Sprich: Geh sterben!

## Fazit

Vermutlich gibt es einen wirklich guten Grund warum Google die wirklichen Gründe nicht veröffentlichen will.
Sofern jemand etwas herausfindet (Wichtig!  Das man aus frei zugänglichen Quellen verifizieren kann),
bitte ich darum, mir den Hinweis per "Issue" hier bei GitHub zu melden.

Dafür sind die Issues da.  Danke!
