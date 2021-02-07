https://tools.ietf.org/html/rfc8473

# WTF RFC 8473

Endlich gibt es einen Standard, der Authentikation im Web erlaubt.  Er ist in RFC 8471 niedergelegt und wird mit PRF 8473 auf das Web übertragen.

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
(außer Microsoft?) [implementiert](https://www.chromestatus.com/feature/5097603234529280) [ihn](https://bugs.chromium.org/p/chromium/issues/detail?id=596699).

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

RFC 8473 könnte doese Misere endlich weitgehend auflösen.  Server und Client tauschen ein authentisches Secret aus, das man nicht fälschen kann.
Gelöst über ein einfaches Protokoll, das man dazuklinken kann.  Setzt zwar auf HTTPS mit seinen recht willkürlichen Art der Zertifizierung auf,
aber das wäre das erste wirklich sinnvolle Feature bei HTTPS das mich überzeugt, warum HTTPS besser ist als HTTP (Merke: HTTPS leistet genau
nicht das, was ihm immer zugeschrieben wird.  Weil es die Daten nicht autentisiert, sondern nur die Kommunikation zwischen Server und Client.
Also nur den Transport.  Genauso kann ich den ehrlichen Ahmed fragen, ob alles in Ordnung ist.  HTTPS ermöglich eben genau deshalb
keine vertrauliche Kommunikation, weil es die Existenz von BlueCoat nicht verhindert.)

Damit authentisiert man zwar nicht den Nutzer, aber den Browser und, wenn richtig gemacht, damit das verwendete Endgerät (Stichwort TPM, auch wenn die
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
> Wäre also schön, wenn JavaScript einfach die Out-of-Band information nutzen könnte.  Das wäre mal endlich das erste valide Argument für HTTPS!
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
in diesem Sinne harmlos, dass es nicht ungeschehen passieren kann (z. B. Hinweis der Nutzung der erhöhten Rechte nach Tod des eigentlichen Nutzers).

Es gehört nicht viel dazu, Dinge sicherer zu machen.  Man muss es nur wollen.

> Irgendwie habe ich nur den Eindruck, der wirkliche Wille dazu fehlt allenortens.

# Ach ja, einen habe ich noch

https://hanszandbelt.wordpress.com/2018/10/09/token-binding-specs-are-rfc-deploy-now-with-mod_token_binding/  Was steht da so schön?

> Update 10/18/2018: Google Chrome actually removed Token Binding support in version 70 so you’ll have to be on an older version to see this work in action, or use MS Edge

Alles klar!
