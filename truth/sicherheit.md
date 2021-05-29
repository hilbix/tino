> Dies schrieb ich zu https://www.heise.de/news/GitHub-unterstuetzt-Sicherheitsschluessel-fuer-Git-Operationen-ueber-SSH-6043958.html

Hier ist mein Standardproblem.  Das ist so in etwa 99% dessen, wie ich arbeiten muss:

a) Auf meiner Seite läuft natürlich Linux.  Ich hätte zwar auch Windows, aber das ist mir irgendwie zu unbequem.  Unter Linux weiß ich, wie ich alles zu meinem Gefallen hinbiegen kann, dafür reicht ja im Prinzip Unix-Wissen aus den 1980ern aus (shell, C, X0, truss AKA strace, usw.).  Unter Windows wusste ich das zwar auch mal, aber mein Wissen stammt hier halt bestenfalls aus der Zeit von Windows 95, und dieses Wissen ist inzwischen für so gut wie nix mehr gut.  Sorry, nee, ich bleibe bei Unix.  (Kennt hier noch jemand ACE auf VAX?  Oder Sintran?)

b) Ich habe einen Remote-Zugang per VPN mit Token.  Über das Token mit VPN gehe ich online.  Bin also dann im VPN.  Dieses VPN kann ich mit Windows, Linux oder z. B. Android aufbauen.  Ist aber vollkommen egal.  Funktioniert so, wie vom Kunden vorgegeben.

c) Im VPN öffne ich - per Browser - die eigentliche Arbeitsumgebung.  Das Backend auf der anderen Seite wird aber in der Regel durch Windows oder ähnliches bereitgestellt.  Nicht fragen, kommt nicht von mir, kann ich nicht ändern, muss ich so nutzen wie es der Kunde bereitstellt.

d) Über diese Arbeitsumgebung kann ich dann einzelne Dienstapplikationen starten. 
 Z. B. Remote Consolen.

e) Über eine dieser Remote-Console komme ich auf ein SSH-Gateway (Jumphost).

f) Von dieser Remote-Konsole öffne ich dann SSH-Verbindungen auf die Zielsysteme.  Manchmal über Zwischengatweways.

g) Und von diesen Zielsystemen muss ich dann z. B. auf Repositorien zugreifen. Also z. B. Dinge, die aus GitHub stammen.#

f) Selbstverständlich will ich auch pushen können!

Sodele.  Wie bitte kann man in der Situation ein FIDO-USB-Token verwenden?  Ich müsste das in die Arbeitsumgebung einlegen.  Die ist aber eigentlich nur ein Canvas in meine Browser.

Auch so Dinge wie Yubikeys funktionieren da eher grundsätzlich erst einmal nicht.  
Die Tastaturanbindung ist über diese vielen Hops viel zu fragil.  Der Yubikey rotzt die Make/Break-Codes viel zu schnell raus als dass die so an der anderen Seite sauber ankommen.  Also so eher 1 Zeichen pro Sekunde wäre sinnvoller.  Mehr nicht.

Kann ich nicht ändern, ich bin da auf das angewiesen, was das Environment hergibt.  Für Wartung und Produktion reicht das.  Für alles andere:  Fehlanzeige.

Hatte ich oben geschrieben, Windows wäre mir zu umständlich?  Genau deshalb.

Mit Linux weiß ich nämlich, wie ich das scripten muss.  Ich habe mir da selbstredend Scripte gebastelt, die z. B. auf meiner Seite den Output vom Yubikey annehmen (würden) und so rüberpoken würden, dass das auf der anderen Seite ankommt.  Naja, meistens tut das jedenfalls.  Auf diese Weise kann ich arbeiten und damit z. B. Clipboard pasten, ohne dass auf der anderen Seite ständig nur Müll ankommt.

Die armen Windows-Kollegen hingegen müssen da ständig Point-Such-und-Klick machen oder das manuell rübertippen, sprich klicken, aufmerksam abwarten, was passiert, dann weiterklicken, je nachdem ob der erste Klick funktioniert hat oder nicht.  Bei mir macht das das Script für mich.  Aber egal.

Doch das ist halt die typische Welt in der man leben muss, wenn man sich in einem einigermaßen sicheren System bewegt.  An allen Ecken und Enden werden - gezielt - Medienbrüche eingebaut.  Was bei mir lokal geht, das wird DEFINITIV an MEHREREN Stellen unterbrochen, das MUSS SO SEIN, so dass da eben kein direkter Weg von einem häuslichen USB-Anschluss oder WLAN zu der Remote möglich wird.

Resultat:  Bisher funktioniert halt nur so etwas wie ein RSA-Token.  Also etwas wie TOTP, dessen Nummer man abtippen kann um sich zu autorisieren.  Nix da mit USB oder FIDO oder NFC oder anderem Möchtegern-Standard.

Also, wie kriege ich da auf dem Remote-System ein Hardware-Token für GitHub rein?  Oder ein solches für einen Zugriff bei Google?  Oder oder oder?

Ja, auf dem Remote KANN ich sogar oft sowas wie einen Browser starten.  Ich HABE auch durchaus einen grafischen Zugang zur RMC.  Manchmal ist das zur Wartung unabdingbar, um so etwas wie ein BIOS aufzuspielen.  EIGENTLICH sollten das die Hersteller so gelöst haben, dass man da das BIOS über das Netz aktualisieren kann.  Eigentlich.  Aber hey, nope, die Welt ist eben meistens eben nicht in Ordnung!  (Das ist ja genau der Job, alles in Ordnung zu bringen, so dass die höheren Layer von dem Chaos unten nix mitbekommen!)

Meistens muss man sowas immer noch manuell über irgendeine obskure Remote-Prozedur einspielen, dazu muss auch manchmal das BIOS (nein, ich meine nicht BIOS, aber stellt es euch einfach als BIOS vor, ist einfacher) erst einmal irgendwie runtergeladen werden.  Nicht selten ist auch Turnschuhadministration gefragt (aka: Remote Hands), weil man das Ding auf einen USB-Key einspielen und dann in einen speziellen USB-Port vom Gerät anstecken muss.  (Das ist die einfachste Methapher die es umschreibt.)  Egal.  Das ist Sache der Remote-Hands.  Aber für die muss man das alles ja irgendwie vorbereiten.  Und nicht selten braucht man dafür Krücken wie Citrix.

Doch genau das beschreibt mein Standardproblem:

Wie kommt FIDO auf so ein Remote-System, wenn man aus Sicherheitsgründen eben keine USB-Weiterleitung haben kann?

Ich habe hier alles rumliegen:

- FIDO-Keys mit und ohne NFC
- Yubikeys
- Exoten wie OnlyKey (der mir übrigens sehr gut gefällt)
- Google Authentikator
- Token von RSA

Letzteres, das Token, ist vom Kunden.  Alles andere wäre von mir hier lokal.  Doch ALLES was nicht manuell eingegeben werden kann FUNKTIONIERT NICHT.  (Yubikey und Onlykey kommen einer Universallösung zwar schon nahe, das Problem ist aber, das funktioniert eben nicht über NFC sondern braucht USB, was mir eindeutig zu umständlich ist.)

Eine Remote-Lösung die funktionieren könnte, sollte so aussehen:

- Ich stoße etwas Remote an.  Irgendwo auf der Welt.  Oder auf dem Mond, egal wo eben.
- Mein Handy pingt, weil eine Anfrage reinkommt
- Ich halte den NFC-Key ans Handy
- Autorisierung erfolgt

Soweit die Theorie.  In der Praxis habe ich das noch nicht gesehen.  Außerdem stellt sich mir die Frage, was passiert, wenn mal der NFC-Key bricht?  Auch diese Hardware geht ja mal kaputt.

Einen Ersatzkey im Tresor ist keine wirkliche Lösung.  Wer sagt denn, dass das nicht in ein paar Jahren wegerodiert ist?  Und wie verwendet man einen Ersatzkey ohne ihn zu verwenden, weil der ja im Tresor liegt?  Verwendet man ihn aber, wie kontrolliert man seine Verwendung?  Wenn man 2 Keys hat, ist die Wahrscheinlichkeit ja groß, dass man einen aus den Augen verliert.  Sicherheit durch Unsicherheit?  Das KANN nicht gut gehen, so erreicht man nur Scheinsicherheit.

Sicherheit funktioniert nur, wenn sie ständig gelebt wird.  (Das bedeutet, dass ein Ersatzkey in einem Tresor eben genau das Kriterium nicht erfüllt.)

Auf Corporate-Ebene lässt sich so etwas lösen, indem man einen Fallback definiert, wie z. B. ein kaputtes Token ausgetauscht wird.  [b]Aber das lässt sich eben nicht auf einen Dienstleister wie GitHub übertragen![/b]

Nur so einige Dinge am Rande:

Das Handy ist KEIN Sicherheitsdevice.  Sprich, das darf in diesem Fall KEINE ROLLE in der Sicherheitsbetrachtung spielen.  Wenn also eine Kommunikation zwischen NFC-Key und GitHub hergestellt wird, so muss davon ausgegangen werden, dass das verwendete Handy zur FEINDLICHEN UMGEBUNG gehört.  Sprich, ich sitze zuhause in einer komplett überwachten Umgebung, alle Eingaben, die ich mache landen in der China-Cloud, und auch alle Zertifikate oder Übertragungen über das Internet laufen über Middleboxen wie BlueCoat, die also jede SSL-Verschlüsselung aufbrechen und den unverschlüsselten Datenstrom bit-für-bit mitlesen können.

Zertifiziert - also von der Annahme her sicher - ist in diesem Fall lediglich das innere meines Laptops.  (Außerdem gilt die Annahme, dass die Daten, die mein Laptop mit der Gegenstelle austauscht, authentisch sind.  Authentisch, aber nicht unbedingt sicher gegen MitM.)  Alles, was ich im Laptop eingebe, also jeder Tastendruck, kann in dieser Betrachtung sensorisch (akustisch, optisch, wie auch immer) mitgelesen werden, genauso wie alles, was meinen Laptop verlässt.  PIN ist in diese Fall kompromittiert, Passwort natürlich ebenso.  (Wenn ich davon ausgehe, dass das Passwort NICHT kompromittiert ist, brauche ich in der Sicherheitsbetrachtung auch kein 2FA.  2FA erhöht dann lediglich die Sicherheitskomplexität, was absolut kontraproduktiv hinsichtlich Sicherheit wäre.  Ich muss also davon ausgehen, das ist ja genau der Sinn von 2FA, dass das Passwort kompromittiert ist, also dem Angreifer bekannt ist, weshalb eben der 2FA sicher sein muss.)

TOTP ist sicher, weil man hier davon ausgeht, dass niemand außer mir den Code lesen kann.  Mitlesen, wenn ich den Code eingebe, ist in der Sicherheitsbetrachtung zwar möglich, aber es kann kein Fehler passieren, da ja ICH es eingeben muss, also ICH die jeweilige Sache autorisiere.  Der Angreifer kann den Code also nicht erzeugen wenn er das wollte.

Schwach ist hier lediglich noch die fehlende Rückmeldung, d. h. ich hätte gerne nicht einen Output am Bildschirm, wie "Token" in das ich dummdreist dann das Token eintippe.  Ich hätte gerne eine Rückmeldung wie "Kommando XXX soll ausgeführt werden, bitte per NFC-Key autorisieren".  Dann könnte man nämlich noch die Zertifizierung vom Laptop loswerden, sprich, den Laptop selbst ebenfalls zu den feindlichen Geräten zählen.  Dann könnte alles, was ich mache, zwar mitgelesen werden, aber trotzdem wäre die Autorisierung authentisch.

Sprich, dieser NFC-Key selbst bräuchte einen Screen oder einen Audio-Output oder was auch immer um sicherzustellen, dass ich auch das richtige Kommando autorisiere.

Aber das ist ja alles eh nur ein feuchter Wunschtraum.  Derzeit gibt es da gar nix, außer dem Output auf dem Bildschirm, in den ich - hin und wieder - Dinge per TOTP manuell reinradebrechen muss.

DAS ist der Stand der Sicherheit HEUTE.  DAS ist, womit man sich rumschlagen muss.  So lange mein Laptop und das TOTP sicher sind, kann eigentlich nicht viel passieren.  (Stichwort https://xkcd.com/538/)

Aus diesem Grund geht mir WebAUTHn, FIDO2 usw. auch vollkommen am Arsch vorbei.  [b]Vollkommen unbrauchbarer Rotz[/b] der die Dinge nur komplizierter macht anstatt besser.  Dieser Mist überlebt nicht einmal die erste Sekunde eines typischen Alltags in einem abgesicherten Umfeld.  Und ich wüsste nicht einmal, wie man das sinnvoll brauchbar integrieren könnte!

Mal abgesehen von dem, was ich oben schrieb, dem feuchten Wunschtraum.

Ich habe übrigens versucht, das evtl. selber hinzukriegen, also mal eine App zu basteln, die einen NFC-Fido-Key zur Autorisierung verwendet.  Naja, nicht wirklich.  Nachdem ich anfing, die Doku zu lesen, ist mir diese Idee dann restlos vergangen.

-Tino
PS: YMMV, ich habe hier auch nur die Spitze vom Eisberg erzählt.  So dass man es versteht.  Tatsächlich ist der Alltag in einer (einigermaßen) sicheren Umgebung um vieles schlimmer.
