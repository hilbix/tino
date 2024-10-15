# Rätsel

> Der Decoder kommt noch, moment bitte ;)

## 26.07.2024 HeiseC als Command and ControlCenter

Ich habe [auf Heise ein Rätsel gepostet](https://www.heise.de/forum/heise-online/Kommentare/Malware-Verteilung-ueber-GitHub-Geister-Account-Netzwerk-entdeckt/Gewinnspiel-Wer-findet-die-geheime-Botschaft-in-diesem-Text-von-mir/posting-44247573/show/).

~~Am 1.10.2024 habe ich vor, hier die Auflösung zu präsentieren.~~

Sorry, leider etwas verspätet, aber hier die Auflösung:

Der von mir verwendete Trick ist utlraeinfach, deshalb wundere ich mich, dass es niemand fand.

Hinten an einer Zeile füge ich einfach ein paar Leerzeichen hinzu.  Der Decoder zählt die Leerzeichen und gibt eine entsprechende Zahl für passende Zeilen aus.

So kann man dann problemlos steganographisch kommunizieren.  Und die Leerzechen findet man übrigens auch beim Zitieren.

Mehr dazu, inklusive der dekodierten Botschaft, steht im [README vom Dekoderscript](https://github.com/hilbix/geheis), das setzt nur bash/sed/awk voraus, kann also z.B. mit Git-Shell unter Windows laufen.
