# Tricks zu Win10

wLANs auflisten und Schlüssel im Klartext ausgeben:

    netsh wlan show profile
    netsh wlan show profile "NAME" key=clear

# Update-Probleme

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
  - Keine Ahnung, siehe unten "`sfc` Murx 3a" und "3b".  Mit der Eingabeaufforderung (oder eine PE-Disk) geht es jedenfalls nicht.

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

    C:\>sfc /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Es steht eine Systemreparatur aus, deren Abschluss einen Neustart erfordert.
    Starten Sie Windows neu, und führen Sie "sfc" erneut aus.

- Die Datei `C:\Windows\WinSxS\Pending.xml` ist im Weg.  **DIESE AUF KEINEN FALL LÖSCHEN!**
- Man kann SFC momentan nicht verwenden sondern muss den Rechner einmal **normal starten** damit sie gelöscht wird.
- Der Abgesicherte Modus löscht die Datei nicht!
- Am besten mit abgeschaltetem wLAN und ohne Netzwerk machen, damit nicht sofort wieder ein `Pending.xml` erzeugt wird.

Dann nochmals im Abgesicherten Modus versuchen.

## `sfc` Murx 3a

Wenn man den Rechner in der Eingabeaufforderung startet (Win10: Vor dem Klick auf "Neu starten" die Shift-Taste drücken und gedrückt halten):

> Beachten!  Die Eingabeaufforderung landet auf der Ramdisk `X:`, deshalb braucht man diese beiden zusätzlichen Schalter!
>
> Den richtigen Laufwerksbuchstaben findet man per `bcdedit`:

    X:\Windows\System32>sfc /offbootdir=c:\ /offwindir=c:\windows /scannow

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

Das hilft auch nicht gerade weiter.

Nochmals nachgetestet mit `sfc /verifyonly`.  Tut auch nicht:
   
    X:\Windows\System32>sfc /offbootdir=c:\ /offwindir=c:\windows /verifyonly

    Systemsuche wird gestartet. Dieser Vorgang kann einige Zeit dauern.

    Der Windows-Ressourcenschutz konnte den angeforderten Vorgang nicht ausführen.

## `sfc` Murx 3b

    Vom Windows-Ressourcenschutz wurden Integritätsverletzungen festgestellt.
    Weitere Informationen finden Sie in der Datei "CBS.log" unter "windir\Logs\CBS\CBS.log",
    z.B. "C:\Windows\Logs\CBS\CBS.log".
    Hinweis: Bei der Offlinewartung wird die Protokollierung derzeit nicht unterstützt.

Diese Meldung bedeutet, dass man einen der Schalter `/offbootdir` oder `/offwindir` verwendet hat.
In diesem Fall (siehe "`sfc` Murx 3a") erhält man - natürlich - kein Log.

Wenn's bricht, dann aber gewaltig und ohne irgendeine Spur.  Typisch Microsoft.

Also zurück zur Murx 1, nicht die Eingabeaufforderung verwenden, sondern den abgesicherten Modus
(so dass man die beiden "Oflline"-Schalter nicht nutzen muss).


## `sfc` Murx 4

T.B.D.
