# Tricks zu Win10

wLANs auflisten und Schlüssel im Klartext ausgeben:

    netsh wlan show profile
    netsh wlan show profile "NAME" key=clear

# Zugriffsprobleme

- Die Datei oder der Ordner lassen sich einfach nicht löschen?
- Das Ändern der Zugriffsrechte funktioniert einfach nicht, weil die Berechtigung zur Änderung der Berechtigung fehlt?
- Folgendes per `cmd.exe` machen, das man mit Administratorberechtigungen gestartet hat

> **Achtung!**  Wenn die Datei verschlüsselt ist, **wird ihr Inhalt dadurch unwiederbringlich zerstört!**

    takeown /f DATEI-ODER-VERZEICHNIS
    
Damit übernimmt man den Besitz der Datei und kann dann die Berechtigung per `explorer.exe` "bequem" anpassen.

- Also "Rechtsklick" auf die Datei
- `Eigenschaften`
- `Sicherheit`
- `Bearbeiten`
- Und dann sich selbst den `Vollzugriff` geben
- Anschließend kann man Löschen etc.

# Update-Probleme

> TL;DR?  Springe zu [SFC Murx 5](#sfc-murx-5)

- https://docs.microsoft.com/de-de/windows-hardware/manufacture/desktop/repair-a-windows-image
  - Lies: `Dism /Online /Cleanup-Image /CheckHealth`
  - Außerdem gibt es eine Diagnosemöglichkeit unter "Update und Sicherheit" - "Problembehandlung" (die bei mir aber nur selten etwas bringt)
- https://www.deskmodder.de/wiki/index.php?title=Welche_Log_Datei_bei_Update_Fehler_auslesen_Windows_10

## `sfc` Murx 1

- https://www.diskpart.com/de/diskpart/sfc-scannow-funktioniert-nicht.html
  - Nummer 1 habe ich gemacht.  Nix.
  - Nummer 2 habe ich auch gemacht.  Fehler.
  - Nummer 2 "Schritt 3. Stellen Sie sicher, dass die Ordner PendingDeletes und PendingRenames auf Ihrem System vorhanden ist."  
    Diese Ordner befinden sich normalerweise in `C:\Windows\WinSxS\Temp\` (nehme ich an, die schreiben es ja nicht hin!)
  - Nummer 3 habe ich gemacht.  Keine Verbesserung.
  - **Und jetzt?**
- Lösung:
  - Keine Ahnung, siehe unten "`sfc` Murx 3".  Mit der Eingabeaufforderung (oder eine PE-Disk) geht es jedenfalls nicht.
  - Weiter geht's mit "`sfc` Murx 4"

Man ruft das natürlich über ein CMD auf das man im Administratormodus laufen hat:

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Überprüfung der Systemsuche wird gestartet.
    Überprüfung 23 % abgeschlossen.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

- Den Rechner in den Abgesicherten Modus versetzen: `msconfig` aufrufen und im abgesicherten Modus neu starten
- Achtung: Wenn ein Update irgendwie da reinspukt (was es bei mir immer tut) tritt der nächste Murx auf.
- Außerdem löst der abgesicherte Modus nicht mein Problem


## `sfc` Murx 2

- https://www.mcseboard.de/topic/217421-es-steht-eine-systemreparatur-aus-deren-abschluss-einen-neustart-erfordert/
  **WARNUNG!** die dort angegebene Lösung die Datei zu löschen ist **EXTREM DESTRUKTIV**.

Und hier im Abgesicherten Modus kann man dann evtl. folgendes erhalten:

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Es steht eine Systemreparatur aus, deren Abschluss einen Neustart erfordert.
    Starten Sie Windows neu, und führen Sie "sfc" erneut aus.

- Die Datei `C:\Windows\WinSxS\Pending.xml` ist im Weg.  **DIESE AUF KEINEN FALL LÖSCHEN!**
- Man kann SFC momentan nicht verwenden sondern muss den Rechner einmal **normal starten** damit sie gelöscht wird.
- Der Abgesicherte Modus löscht die Datei nicht!
- Am besten mit abgeschaltetem wLAN und ohne Netzwerk machen, damit nicht sofort wieder ein `Pending.xml` erzeugt wird.

Dann nochmals im Abgesicherten Modus versuchen.


## `sfc` Murx 3

Wenn man den Rechner in der Eingabeaufforderung startet (Win10: Vor dem Klick auf "Neu starten" die Shift-Taste drücken und gedrückt halten):

> Beachten!  Die Eingabeaufforderung landet auf der Ramdisk `X:`, deshalb braucht man diese beiden zusätzlichen Schalter!
>
> Den richtigen Laufwerksbuchstaben findet man per `bcdedit`.

    X:\Windows\System32>sfc /offbootdir=c:\ /offwindir=c:\windows /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

Das hilft auch nicht gerade weiter.

Nochmals nachgetestet mit `sfc /verifyonly`.  Tut auch nicht:
   
    X:\Windows\System32>sfc /offbootdir=c:\ /offwindir=c:\windows /verifyonly

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.


Also zurück zur Murx 1, nicht die Eingabeaufforderung verwenden, sondern den abgesicherten Modus
(so dass man die beiden "Oflline"-Schalter nicht nutzen muss).


## `sfc` Murx 4

Also nicht über die Eingabeaufforderung, sondern über die Starteinstellungen gemacht.

Man erhält einen Boot-Screen auf dem man so einiges auswählen kann.

Hier muss man SEHR SEHR SEHR SEHR SEHR schnell sein.  Wenn man versucht, den Bildschirm durchzulesen, dann wird der schwarz und der Rechner geht aus.

> Applaus, Applaus, Applaus!

Nach dem Einschalten war ich aber noch im abgesicherten Modus, also was soll's (außer dass Microsoft hier tierisch nervt.  OK, gut wenn das Teil aus geht.
Aber warum schon nach wenigen Sekunden?  Warum nicht 15 Minuten oder 30 Minuten in dem Screen stehen lassen bevor irgendetwas passiert?  Warum immer so ultrakurze Timeouts?  Ich will das Zeit - tatsächlich - lesen, dann - tatsächlich - verstehen und dann darüber nachdenken können bevor ich mich entscheide.)

> Also deshalb hier kein Excerpt was man sieht, ich konnte es nicht so schnell abtippen.

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Überprüfung der Systemsuche wird gestartet.
    Überprüfung 23 % abgeschlossen.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

Tadaaa.  Nichts hat sich verändert.  Neuer Versuch mit einem anderen Schalter, aber dank der Exkursion auf die Offline-Variante sind wir jetzt schon schlauer:

    C:\>sfc /verifyonly

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Überprüfung der Systemsuche wird gestartet.
    Überprüfung 100 % abgeschlossen.

    Vom Windows-Ressourcenschutz wurden Integritätsverletzungen festgestellt.
    Weitere Informationen finden Sie in der Datei "CBS.log" unter "windir\Logs\CBS\CBS.log",
    z.B. "C:\Windows\Logs\CBS\CBS.log".
    Hinweis: Bei der Offlinewartung wird die Protokollierung derzeit nicht unterstützt.

> Das dauert wirklich ewig, und zwar auch auf einer SSD die mehr als 300 MB/s und 10000 TPS kann.

Dieser abschließende Hinweis bedeutet, dass man, falls man einen der Schalter `/offbootdir` oder `/offwindir` verwendet hat,
kein Log erhält.  Nichts.  Das Ding fällt dann komplett (siehe "`sfc` Murx 3") wortlos auseinander,
ohne auch nur ansatzweise zu erklären, warum.  Super Sache, nicht?  Deshalb kann man auch den Offline-Modus für nix verwenden,
außer wenn alles wirklich vollständig glatt geht (was es wohl nicht tut, sonst wären wir nicht hier).

> Warum das verwirrenderweise auch dann erscheint, wenn man den **Offline-Mode gar nicht verwendet** hat, erschließt sich mir nicht.

Und jetzt steht man vor dem Problem, die Datei `C:\Windows\Logs\CBS\CBS.log` zu verstehen.

> Also sie in Notepad++ laden und nach `Error` suchen.  Am besten fängt man dabei hinten an ..


## `sfc` Murx 5

Ich habe das Logfile `C:\Windows\Logs\CBS\CBS.log` filettiert.  Allerdings war das erzeugte Log durch `/verifyonly` unbrauchbar.

Warum?  **Viel zu viele Fehlerstellen**.  Nicht hunderte.  Tausende.  Also nochmals:

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Überprüfung der Systemsuche wird gestartet.
    Überprüfung 23 % abgeschlossen.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

Dann die Datei `C:\Windows\Logs\CBS\CBS.log` mit Notepad++ geöffnet.

Und ..

.. erst einmal nix.  Das Logfile hört nicht mit dem eigentlich Fehler auf, sondern läuft noch ellenlang weiter.
Beim hochscrollen kam aber eine Zeile mit folgender Sequenz auf:

    Cannot repair member file

- In dieser Zeile stand ein Dateiname.  Nur ein Dateiname, kein Pfad oder sowas.
- Darunter dann `STATUS_FILE_IS_A_DIRECTORY`.  Das kommt zwar häufiger vor, aber hier war es im Zusammenhang mit diesem Fehler.

Was habe ich gemacht?

- Ich habe den angegebenen Namen im gesamten Filesystem (unterhalb von `C:\Windows`) gesucht
- Und die Stelle identifiziert, in der es ein Verzeichnis war.
- Dann habe ich das Verzeichnis gelöscht.  (Was nicht so einfach war, es war gegen Modifikationen gut geschützt.)

> Meine Annahme ist, dass da ein Privacy-Tool einen der BigBrother-Services auf die harte Tour abgeschaltet hat.
>
> - Also .EXE löschen, Verzeichnis an seiner Stelle erstelle, und das Verzeichnis gegen jegliche Veränderung immunisieren

Das hat dann wohl der Softwareupdate krummgenommen und ist zusammengebrochen.

> Getreu dem Motto: **Wer auf seine Privatsphäre Wert legt, der nimmt besser kein Microsoft!**
> Denn wenn man das tut, nimmt das einem Microsoft übel!  (Ganz offensichtlich!)


## `sfc` Erfolg

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Überprüfung der Systemsuche wird gestartet.
    Überprüfung 100 % abgeschlossen.

    Von Windows-Ressourcenschutz wurden beschädigte Dateien gefunden und erfolgreich
    repariert. Weitere Informationen finden Sie in der Datei "CBS.log" unter "windir\Logs\CBS\CBS.log",
    z.B. "C:\Windows\Logs\CBS\CBS.log".
    Hinweis: Bei der Offlinewartung wird die Protokollierung derzeit nicht unterstützt.

> Achtung!  Die Datei wird natürlich bei jedem Lauf überschrieben.  Wenn man also wissen will, was passiert ist, muss man die Datei sofort sichern.
