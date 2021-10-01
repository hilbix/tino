# MMC Howto

Sorry, ich kapier's nicht.  Hier die Info die man sich mühsam zusammensuchen muss, weil es nirgendwo sinnvoll dokumentiert ist.

## Lifetime / Wear Leveling

Was wohl am wichtigsten ist:  "Wie lange hält die interne MMC noch bis sie, und damit auch das Gerät, kaputtgeht?"

Die Antwort kann wohl keiner geben, aber man kann (vermutlich, so genau konnte ich das auch nicht rausfinden) abrufen,
wie verbraucht sich das Teil selbst bewertet.

    LC_ALL=C.UTF-8 mmc extcsd read /dev/mmcblk1 | egrep 'Life Time Estimation|EOL information'

Die Angaben bei der Lifetime sind in 10%-Schritten und beginnen bei 10%.

**Sprich eine 0x09 bedeutet, das Ding ist quasi schon kaputt.**

Die EOL-Information muss - soweit ich das überblicke - auf 0x01 stehen.
Wenn nicht, bedeutet das wohl, die eMMC hat nicht mehr korrigierbare Fehler entwickelt und geht gerade (endgültig) kaputt.

Sprich, die EOL-Information entspricht der S.M.A.R.T.-Ausgabe des "Overall Health" (mit ok=0x01).
Der andere der Lifetime, nur umgekehrt zu S.M.A.R.T., also 0x09 entspricht "fast vollständig aufgebraucht".

## T.B.D.

Der Rest interssiert mich erst einmal ganz und gar nicht.

Ähnlich wie bei SSDs, bei denen nur interessiert "ist die schon verbraucht"?

Nur warum das immer so ultra schwer ist, ich verstehe es nicht.

**Was hindert die Hersteller eigentlich daran, dass die Geräte einfach bei 10% ihrer Lifetime in die Sperre gehen,
und einfach Readonly werden?** Dann könnte man das (z. B. durch Abbrechen einer Ecke etc.) weiterbetreiben,
bis sie endgültig versagt.

Ja, ein physikalisches Ding, das jeder mit einem halben Auge sehen kann, und so informiert ist.
Damit die Leute nicht auf die Idee kommen, das noch teuer auf eBay and Dumme zu vertickern,
die sich eben nicht so gut auskennen.  Wenn da aber eine Ecke abgebrochen ist, und man dann googeln kann
"wenn die Ecke bei Geräten mit Speichermedien nimmer intakt ist, sind die am Ende"
ist alles klar.  Wäre einfach, sofort und leicht verständlich usw.

Aber nö.  Nein.  Nix.  Kein Hirn, kein Verstand.

Entweder man konstruiert die Dinge so einfach, dass es geradezu weh tut, oder es es wird einfach nix!  Zukunft ade!
