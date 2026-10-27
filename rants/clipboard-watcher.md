# Clipboard-Watcher Rants

Ich habe mir gerade den <https://github.com/hilbix/clipboard-watcher> gebastelt.  Und der ist Windows-only.  Echt?

## Denn

Ich arbeite hier eigentlich nur mit Linux.  Aber ich habe auch kein Problem mit Windows.  Ist nämlich egal, wo in so einem Fall der Browser läuft.
Außerdem hat mein Windows natürlich WSL, also habe ich alles was ich brauche:  Ein brauchbares Terminal.

Da die Kunden immer noch so bescheuert sind, weiterhin auf Windows zu setzen, muss ich die ja supporten.  Und das geht halt doch am einfachsten mit Windows zu Windows, wie soll ich sonst herausfinden,
ob das, was die KI zusammenschwurbelt, auch wirklich die Lösung ist?  Denn genau dafür zahlen die Kunden, nämlich Lösungen und nicht irgendwelches Geschwafel wie das, was ich hier gerade tippe.

> Und ich habe Glück.  Ich habe mir vor längerem einen Gaming-Laptop mit 8 GB GPU besorgt.  Einfach weil das die einzige verfügbare Kiste mit 32 GB RAM war.
> Weil ich eben Windows fahren können wollte, und keine Lust hatte, da irgendwie durch die RAM-Ineffizienz oder sonstwas ausgebremst zu werden.
> Der Laptop war viel zu teuer, dachte ich.  Aber gegen die heutigen Preise, da war das Ding ein absolutes Schnäppchen!  Denn ja, das Teil kann CUDA und ist supportet.
> Ja, der Akku hält nur 4h unter Hochlast.  Und das Netzteil alleine wiegt mehr als meine Linux-Netbooks.  Aber ich kann damit arbeiten, und nur darauf kommt es an.
>
> Und ich hatte noch mehr Glück.  Ich habe mir eine andere Kiste mit RTX4090 zugelegt.  Damals, als die Karte echt stinkteuer war.
> Zähneknirschend.  Aber ich weiß, wie lange ich Vorlauf brauche um Dinge für mich zu adaptieren.  So auch CUDA und die 4090.
> Nur deshalb habe ich mir das bereits frühzeitiger zugelegt, als ich es wirklich brauchte.  Eigentlich, dachte ich, viel zuviel Geld zum Fenster raus.
> Aber wat mut dat mut.  Und upps, inzwischen kostet die Kiste das dreifache, sprich ich könnte die gebraucht teurer verkaufen als sie gekostet hat.
> Nee, sorry, verkaufen mache ich sicher nicht.  Ich brauche das, wichtiger denn je!  Ein Horrortrip wenn ich mir das heute kaufen müsste.  Ehrlich.


## WTF warum?

Ich bin Admin.  Und ich ~~soll~~ will dokumentieren.  Nur gut, dass ich überhaupt Copy&amp;Paste machen darf, denn inzwischen wird so ziemlich alles abgedreht was man zum Arbeiten braucht.

Eigentlich brauche ich nur SSH.  So wie ich das halt schon seit Jahrzehnten mache.  
Kein Web, keine Maus, kein dummes Rumgeklicke, keine proprietäre Software, keine kommerziell unendlich teuren Lösungen.
Einfach alles Plain Text, und ansonsten lege ich mir die passenden dedizierte Tunnel natürlich selbst.

Aber was bekomme ich stattdessen?  Einen Browser-basierten Zugang zu einem Windows-basierten Jumpserver ohne WSL hinter irgendeiner fremdadministrierten Cloud.
Die natürlich - ist klar bei der unendlichen Reihe an Sicherheitslücken, die man sich so ins Haus holt - ständig weiter und weiter zugeknöpft werden muss!

> Fehlt nur noch, dass man Putty auch noch verliert und stattdessen [mit](https://youtu.be/oJjYfXELrWc?t=318) [einer](https://youtu.be/XetTVNtzTW8?t=28) [KI](https://youtu.be/_zNSmgmCW_Y?t=4278) chatten muss,
> die stets überhaupt nicht versteht worum es geht.

Wenn ich also z.B. die NginX-Config mal schnell ans Ticket anhängen will und in der sich so dumme Dinge wie Softlinks befinden?
Reinen Text, wie Shell-Logs usw., kann ich über das Clipboard transferieren.  Aber wie steht es mit `.tgz`?

Früher durfte man ja vielleicht noch ZIPs transferieren, die dann gescannt wurden ob sich da nicht irgendwelcher Binärmüll verbirgt.  So konnte man die Logs noch ein klitzekleinwenig sinnvoll transferieren.
Aber das ist - natürlich - Geschichte!  Geblieben sind nur noch reine Text-Transfers.  Yay!

Nee, ich nix Windows.  Und nix das zugehörige Powershell.  Aber .. jetzt gibt es ja KI, um sich das mal alles schnell herzuleiten.

Also kein Problem für mich.  Und wenn es DAS nicht ist, sorry, Leute, warum gebt ihr euch eigentlich all diese Mühe?
Was soll das für ein Schutz sein, den man mit ein paar Fragen einer KI leicht umgehen kann?  Nicht weil man kann, sondern muss?

# Oder anders gesagt

Alles Geisterfahrer hier.  Alles, was ihr gerade macht, ist bereits Makulatur, ihr wisst es nur noch nicht.  Warum überlasst ihr es nicht einfach den Leuten, die sich damit auskennen?
Ach ja, stimmt, die werden nicht gefragt.

Nur mal so nebenbei:  Fountain Codes.  Schonmal gehört?  Glaubt hier also irgendwer wirklich daran, dass man Datenabfluss auch nur irgendwie verhindern kann?

Deshalb:

Warum nehmt ihr uns unsere Betriebsmittel weg statt uns einfach nur ungestört unsere Arbeit machen zu lassen?
Statt irgendwelchen kommerziellen Versprechungen von dubiosen Firmen zu vertrauen, warum investiert ihr nicht einfach in eure wichtigste Ressource:
In die Menschen, die für euch Arbeiten!
