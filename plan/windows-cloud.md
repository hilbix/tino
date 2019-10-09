Folgende Anfrage habe ich gerade mal bei einer Firma eingekippt, die Windows-Lizenzen günstig online vertickt:

Hinweis: Tippfehler stehen so original in meiner Anfrage ;)

------

Kopie dieses Textes siehe https://github.com/hilbix/tino/blob/master/plan/windows-cloud.md

Wenn ich die Lizenzem in einem VPS (VM, Cloud, etc.) installiere, was ist zu beachten?

Zum Verständnis:

- Ich will VMs schlüsselfertig konfiguriert und lizenziert bereitstellen können.  Dabei sind alle Parameter (Anzahl CPUs, RAM, Anzahl Platten und deren Größen etc.) frei anpassbar (im Rahmen des sinnvollen).

- Je vorhandener VM wird ein separater Lizenzschlüssel eingesetzt, unabhängig davon ob die VM gestartet ist oder nicht.  Der Lizenzschlüssel bleibt an die VM gebunden, so lange sie irgendwie gestartet werden könnte.

- Sobald eine VM vernichtet wird, muss der Lizenzschlüssel wieder frei werden für die Installation in eine andere VM.  Man kann diese als Nachfolger-VM der vorherigen bezeichnen, welche die vorherige restlos ersetzt.  Allerdings eben mit vollkommen neuen Parametern.

- Sobald eine Lizenz in einer anderen VM wiederverwendet wurde, gilt:  Taucht dann noch irgendwo ein Backup auf, kann aus diesem die vorherige VM nicht wieder hergestellt werden.  So ist ausgeschlossen, dass eine Lizenz mehrfach verwendet wird.

- Wie lange eine VM besteht ist nicht festgelegt.  Die minimale Laufzeit beträgt 1 Minute, die maximale Laufzeit ist unbeschränkt.

- Ich erwarte, dass im laufenden Betrieb pro Lizenz durchschnittlich 5 Installationen (und ebensoviele Deinstallationen) am Tag anfallen können.  Einige Lizenzen haben 0 Neuinstallationen, andere eben deutlich mehr.

- Alles ist on-demand, d. h. es ist vorher weder klar, wie lange eine VM mit ihrer Lizenz laufen wird, noch wie oft sie am Tag neu installiert wird.  Es kann also z. B. jederzeit die Entscheidung getroffen werden, eine angehaltene (gerade nicht laufende) VM zu vernichten, ohne sie kurz weiter laufen zu lassen.  Dadurch hat die VM dann keine Möglichkeit, ihre Aktivierung ggf. wieder zurückzunehmen.  (Mir ist eh keine Möglichkeit bekannt, ein aktiviertes Windows zu deaktivieren.)

- Alles muss vollautomatisch ablaufen.

- Die VMs sind roamingfähig und nicht fest lokalilsierbar.  Sprich, VMs können in verschiedenen Clouds oder auf verschiedenen Kontinenten laufen und auch dazwischen verschoben werden.

- Es müssen verschiedene Betriebssysteme und verschiedene Varianten von Win7/Win10 einsetzbar sein.

Das Ganze ist experimentell und wird verm. zum Großteil Open Source.
Ich würde gerade mal mit 3 Lizenzen (je einer Win7 Pro, Win10 Pro, Win10 Ult) starten.
Sollte das Konzept funktionieren, können es sehr schnell viel mehr werden (eben so viele wie nötig).

Danke
-Tino
