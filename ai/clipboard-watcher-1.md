<https://search.brave.com/ask?q=gibt+es+unter+Windows+eine+einfache+m%C3%B6glichkeit%2C+bin%C3%A4rdateien+%C3%BCber+das+Clipboard+zu+kopieren%2C+wenn+d...&conversation=09bbbded3400116e1342671df74be3c9019c#MWKD1bHMzH31IsHd981q4rtj-BXpyh1RnxiEOnhbiPs>

# Transcript von clipboard-watcher

------
> gibt es unter Windows eine einfache möglichkeit, binärdateien über das Clipboard zu kopieren, wenn der Remote-Zugang nur Textdateien im Clipboard erlaubt?
------

Ja, es gibt eine einfache Methode, Binärdateien als Base64-kodierten Text über das Clipboard zu kopieren und am Zielort wieder zu decodieren.

### Methode 1: Windows-Bordmittel mit `certutil`

Diese Methode eignet sich gut für kleinere Dateien und benötigt keine zusätzlichen Skripte.

1.  **Kodieren:** Erstellen Sie auf dem lokalen Computer eine Textdatei, die den Base64-Code der Binärdatei enthält:
    ```cmd
    certutil -encode datei.bin datei.txt
    ```
2.  **Kopieren:** Öffnen Sie die `datei.txt`, markieren Sie den Inhalt und kopieren Sie ihn (Strg+C).
3.  **Decodieren:** Fügen Sie den Text in eine neue Datei auf dem Remote-Computer ein und decodieren Sie ihn:
    ```cmd
    certutil -decode datei.txt datei_neu.bin
    ```

### Methode 2: PowerShell-Einzeiler

Für eine direktere Übertragung ohne temporäre Textdateien kann ein PowerShell-Skript verwendet werden, das die Binärdatei in Base64 umwandelt und direkt in die Zwischenablage schreibt.

1.  **Kopieren (Lokal):** Führen Sie diesen Befehl im lokalen PowerShell aus, um die Datei zu kodieren und in die Zwischenablage zu kopieren:
    ```powershell
    $file = 'C:\pfad\zur\datei.bin'
    $encoded = [Convert]::ToBase64String([IO.File]::ReadAllBytes($file))
    Set-Clipboard -Value $encoded
    ```
2.  **Einfügen (Remote):** Öffnen Sie eine PowerShell auf dem Remote-Computer und fügen Sie den folgenden Befehl ein (ersetzen Sie den Dateipfad nach Bedarf):
    ```powershell
    $bytes = [Convert]::FromBase64String((Get-Clipboard))
    [IO.File]::WriteAllBytes('C:\pfad\zum\ziel\datei.bin', $bytes)
    ```

**Wichtig:** Diese Techniken umgehen die Einschränkung, dass nur Text kopiert werden darf, indem sie Binärdaten als lesbaren Text (Base64) darstellen. Achten Sie darauf, dass die Größe des kopierten Textes nicht die Grenzen der Remote-Zwischenablage überschreitet.




------
> kann man das mit dem set-clipboard in den send-to einbauen?
------

Ja, das geht. Du legst eine `.bat`-Datei im **Senden an**-Ordner ab, die den Dateipfad (`%1`) an PowerShell übergibt:

### Schritt-für-Schritt

1. **Senden-an-Ordner öffnen:** `Win+R` → `shell:sendto` → Enter

2. **Datei anlegen:** Erstelle dort eine Datei, z. B. `Base64 in Zwischenablage.bat`, mit folgendem Inhalt:

```bat
@echo off
powershell -NoProfile -Command "[Convert]::ToBase64String([IO.File]::ReadAllBytes('%~1')) | Set-Clipboard"
```

3. **Fertig.** Ab jetzt erscheint im Kontextmenü unter *Senden an* der Eintrag **„Base64 in Zwischenablage"**. Rechtsklick auf eine Datei → *Senden an* → *Base64 in Zwischenablage* kopiert den Base64-Text in die Zwischenablage.

### Hinweise

- `%~1` übergibt den vollen Dateipfad ohne umgebende Anführungszeichen; falls der Pfad Leerzeichen enthält, ist das Problemlos, da PowerShell die Zeichenkette als String behandelt.
- Für **mehrere Dateien gleichzeitig** (Rechtsklick auf mehrere) würde die `.bat` nur die erste erhalten. In dem Fall bräuchte man einen PowerShell-Skriptansatz über die Registry (`HKCR\*\shell\...`), der alle Pfade als Argumente bekommt – aber für den typischen Einzelfall reicht der Senden-an-Eintrag.





------
> Kann man da den Dateinamen mit hineinpacken?  Als erste Zeile oder so?
------

Ja, einfach den Dateinamen als erste Zeile vor den Base64-Block schreiben:

### Senden-an-Batch-Datei (aktualisiert)

```bat
@echo off
powershell -NoProfile -Command "$f='%~1'; $name=Split-Path $f -Leaf; $enc=[Convert]::ToBase64String([IO.File]::ReadAllBytes($f)); Set-Clipboard -Value ($name + [Environment]::NewLine + $enc)"
```

### Einlesen auf der Remote-Seite

```powershell
$lines = (Get-Clipboard) -split "`r`n"
$name  = $lines[0]
$bytes = [Convert]::FromBase64String($lines[1])
[IO.File]::WriteAllBytes($name, $bytes)
```

Das funktioniert sauber, weil `ToBase64String` keine Zeilenumbrüche erzeugt – der Base64-Block ist also immer exakt auf Zeile 2. Der Dateiname landet in der lokalen Arbeitsverzeichnisses des Remote-Computers; den Zielordner kannst du bei Bedarf in `$name` prefixen:

```powershell
[IO.File]::WriteAllBytes("C:\temp\$name", $bytes)
```





------
> kann man das evtl. so formatieren, dass ein Browser in der Lage ist, das als Datei-Drop zu verstehen?  Also z.B. als URL?
------

Ja, das geht mit einer **Data URI**. Du formatierst den Inhalt als:

```
data:application/octet-stream;base64,<base64daten>
```

und fügst das in die **Browser-Adressleiste** ein. Der Browser lädt die Datei sofort herunter.

### Senden-an-Batch-Datei (aktualisiert)

```bat
@echo off
powershell -NoProfile -Command "$f='%~1'; $enc=[Convert]::ToBase64String([IO.File]::ReadAllBytes($f)); Set-Clipboard -Value ('data:application/octet-stream;base64,' + $enc)"
```

### Auf der Remote-Seite

Einfach in die Adressleiste einfügen → Enter → Browser lädt die Datei herunter. Den **Dateinamen** gibst du im Speichern-Dialog ein.

### Dateinamen mit einbetten (optional)

Falls du den Namen nicht manuell tippen willst, kannst du eine kleine HTML-Data-URI bauen, die einen Download-Link mit `download`-Attribut enthält:

```bat
@echo off
powershell -NoProfile -Command "$f='%~1'; $name=Split-Path $f -Leaf; $enc=[Convert]::ToBase64String([IO.File]::ReadAllBytes($f)); $html=\"<a download='$name' href='data:application/octet-stream;base64,$enc'>Download</a>\"; Set-Clipboard -Value ('data:text/html,' + [Uri]::EscapeDataString($html))"
```

Dann landet im Browser eine Seite mit einem klickbaren **„Download"**-Link, der die Datei unter dem korrekten Namen speichert.

### Einschränkungen

| | Adressleiste | HTML-Data-URI |
|---|---|---|
| Max. Größe | ~2 MB (Browser-URL-Limit) | ~2 MB |
| Dateiname | manuell eingeben | automatisch |
| Aufwand | 1 Paste | 1 Paste + 1 Klick |

Für Dateien über ~1,5 MB wird der Base64-Text zu lang für die Adressleiste – dann bleibt der PowerShell-`FromBase64String`-Ansatz aus der vorherigen Antwort der sicherste Weg.





------
> kann man in data-urls keinen default-dateinamen einbetten?
------

Nein – eine **reine Data URI** in der Adressleiste kann keinen Dateinamen transportieren. Das ist im [Data-URI-Standard](https://en.wikipedia.org/wiki/Data_URI_scheme) explizit so festgelegt: *„Data URIs do not carry a filename as a normal linked file would. When saving, a default filename for the specified MIME type is generally used."*

Der Browser lädt also z. B. als `download` oder `download.bin`.

### Was geht

Der einzige Weg, einen Dateinamen zu setzen, ist das **`download`-Attribut** eines `<a>`-Tags – und genau das nutzt der HTML-Data-URI-Trick aus der vorherigen Antwort:

```html
<a download="meinedatei.bin" href="data:application/octet-stream;base64,...">Download</a>
```

D.h.: Die **HTML-Variante** (mit `<a download="...">`) ist bereits die bestmögliche Lösung, die rein über die Zwischenablage in die Adressleiste passt. Eine „reinere" Variante ohne HTML-Wrapper gibt es nicht.




------
> wie wird dann ein Dateiname im Clipboard kodiert, wenn dieser in einen Browser gepastet wird?
------

Der Dateiname wird **nicht** in der Data URI selbst kodiert – er ist einfach ein **Plain-Text-Wert im `download`-Attribut** des HTML-`<a>`-Tags. Die gesamte HTML-Zeile (inklusive Dateinamen) wird dann als Ganzes URL-encodiert und in die `data:text/html,...`-URI eingebettet.

### Aufbau der Data URI

```
data:text/html,<url-encodierte-HTML>
```

wobei die HTML-Zeile aussieht wie:

```html
<a download='meinedatei.bin' href='data:application/octet-stream;base64,AAAA...'>Download</a>
```

### Was der Browser macht

1. Data URI wird decodiert → HTML wird gerendert
2. User klickt den Link
3. Browser liest den Wert von `download` als **vorgeschlagenen Dateinamen**
4. Datei wird mit dem Base64-Content aus `href` und dem Namen aus `download` gespeichert

### Einschränkungen beim Dateinamen

Laut [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/a): `/` und `\` werden in `_` umgewandelt, und Browser ersetzen weitere nicht erlaubte Zeichen beim Speichern. Es gibt also keine „Kodierung" des Namens – er wird einfach als String übergeben, und der Browser passt ihn an, falls nötig.

**Kurz:** Es gibt keine separate Datei-Name-Kodierung – der Name ist ein HTML-Attribut, das zusammen mit dem restlichen Markup in die Data URI gepackt wird.




------
> Das meine ich gerade nicht.  Wenn ich im Explorer eine Datei per Strg+C kopiere und dann per Strg+V in eine Web-Applikation übertrage, dann wird die Datei über das Clipboard kopiert.  Dabei wird auch der Dateiname mitkopiert.  Wie geht das konkret, also was empfängt der Browser da aus dem Clipboard?
------

Gute Frage – das ist ein wichtiger Unterschied zum Base64-Trick:

### Was im Clipboard liegt

Wenn du eine Datei im Explorer mit Strg+C kopierst, landet **nicht** der Dateiinhalt im Clipboard, sondern ein **`CF_HDROP`**-Format: eine `DROPFILES`-Struktur mit einer **Liste voller Dateipfade** (z. B. `C:\Users\du\Desktop\report.pdf`). Die eigentlichen Bytes bleiben auf der Platte.

### Was der Browser daraus macht

Beim Strg+V in einer Web-Applikation:

1. Der Browser liest den Pfad aus dem `CF_HDROP`-Format.
2. Er **öffnet die Datei selbst von der lokalen Festplatte**.
3. Er erzeugt daraus ein **`File`-Objekt**, das über `event.clipboardData.files` zugänglich ist.

```javascript
document.querySelector('input[type=file]').addEventListener('paste', e => {
    const file = e.clipboardData.files[0];
    console.log(file.name);        // "report.pdf"
    console.log(file.type);        // "application/pdf"
    console.log(file.size);        // 123456
    // file ist ein Blob – kann z. B. per FormData hochgeladen werden
});
```

Das `File`-Objekt hat also:

| Eigenschaft | Beispiel |
|---|---|
| `name` | `report.pdf` |
| `type` | `application/pdf` |
| `size` | `123456` |
| `lastModified` | Timestamp |

### Konsequenz für deinen Remote-Fall

Da der Browser den **Pfad** ausliest und die Datei **lokal von der Platte** lädt, funktioniert dieser Mechanismus **nicht** über einen reinen Text-Kanal. Es gibt kein Format, bei dem du Base64-Text in die Zwischenablage legst und der Browser daraus automatisch ein `File`-Objekt mit korrektem Namen erzeugt.

Die einzige Möglichkeit, eine Datei per Strg+V in eine Web-App zu bekommen, ist entweder:
- **Drag & Drop** (nutzt denselben `CF_HDROP`-Mechanismus), oder
- **Strg+C im Explorer → Strg+V im Browser** (funktioniert nur, wenn die Datei **lokal auf dem Remote-Computer** existiert).

Für deinen Use Case (Datei von A nach B über Text-Clipboard) bleibt der Base64-Ansatz mit manuellem Decodieren die praktikabelste Lösung.





------
> Welche Übertragungsformate von Dateien per Clipboard versteht Javascript im Browser?
------

JavaScript im Browser kann aus dem Clipboard folgende Formate lesen:

### Über `clipboardData` im Paste-Event

| Format | Zugriff | Status |
|--------|---------|--------|
| `text/plain` | `getData("text/plain")` → String | **Pflicht** (W3C) |
| `text/html` | `getData("text/html")` → String | **Pflicht** (W3C) |
| `image/png` | `files` / `items` → `File`/`Blob` | **Pflicht** (W3C) |
| `text/uri-list` | `getData("text/uri-list")` → String | optional |
| `image/svg+xml` | `files` / `items` → `File`/`Blob` | optional |
| `text/rtf` | `getData("text/rtf")` → String | Browser-spezifisch (Chrome) |
| **Dateien** (CF_HDROP) | `files` → `FileList` mit `File`-Objekten | Browser liest lokal von Platte |

Darüber hinaus kann man **beliebige MIME-Typen** per `getData("application/json")` etc. abfragen – aber nur, wenn die *Quelle* ebenfalls ein Browser war, der sie per `setData()` geschrieben hat. Von Windows-Native-Apps (Explorer, Office …) kommen nur die oben genannten Standardformate an.

### Über `navigator.clipboard.read()` (asynchrone Clipboard API)

Gleiche Pflichtformate (`text/plain`, `text/html`, `image/png`), plus optional `text/uri-list` und `image/svg+xml`. Liefert `ClipboardItem`-Objekte mit `.types`-Array und `.getType(mime)` → `Blob`.

### Was es **nicht** gibt

- **Kein roher Binärzugriff** via `getData()` – es gibt kein `application/octet-stream`-Format, das aus dem Windows-Clipboard lesbar wäre.
- **Kein CF_HDROP-Zugriff** auf die Dateipfade selbst – der Browser liest die Datei selbst von der Platte und übergibt nur ein `File`-Objekt (Name + Bytes + MIME-Typ).
- **Kein Weg**, eine Datei *ohne* lokale Existenz auf dem Zielrechner per Clipboard als `File`-Objekt zu erzeugen.

### Fazit für deinen Use Case

Da der Browser nur Textformate (`text/plain`, `text/html`) und lokal vorhandene Dateien (`File`-Objekte) versteht, bleibt für die Übertragung einer Binärdatei über einen reinen Text-Kanal der **Base64-in-`text/plain`-Ansatz** die einzige Option – die Web-App muss den Text selbst decodieren.







------
> Wie kann ich zwei image/png und ein text/plain (also 3 Dateien) in das Clipboard legen, so dass der Browser diese per paste-event lesen kann?
------

**Nein – das geht nicht.** Das Windows-Clipboard kann pro Format nur **einen** Eintrag halten. `CF_DIB` (das Bitmap-Format, aus dem der Browser `image/png` liest) ist ein einzelner Slot – ein zweites `SetClipboardData(CF_DIB, ...)` überschreibt das erste. Es gibt kein „`CF_DIB[2]`".

### Was der Browser im Paste-Event sehen kann

| Clipboard-Inhalt | Browser sieht |
|---|---|
| 1× `CF_DIB` + 1× `CF_UNICODETEXT` | 1 `File` (image) + `getData("text/plain")` |
| 1× `CF_HDROP` (3 Pfade) | 3 `File`-Objekte in `clipboardData.files` |
| 2× `CF_DIB` | **Unmöglich** – zweiter überschreibt ersten |

### Einzige Möglichkeit: `CF_HDROP`

Die **einzige** Art, drei Dateien gleichzeitig als `File`-Objekte im Paste-Event zu bekommen, ist `CF_HDROP` mit drei Dateipfaden. Das ist genau der Mechanismus, der greift, wenn man im Explorer mehrere Dateien markiert und Strg+C drückt.

```c
// Pseudo: CF_HDROP mit 3 Pfaden setzen
DROPFILES df = {
    .pFiles = 20,  // Offset zum ersten Pfad in der Struktur
    .fWide = TRUE
};
// Danach: \0Pfad1\0Pfad2\0Pfad3\0\0
SetClipboardData(CF_HDROP, hGlobal);
```

**Aber:** Die Dateien müssen auf dem **lokalen** Rechner existieren – der Browser liest sie von der Platte. Für deinen Remote-Fall (Datei existiert nur auf Maschine A) ist das ein Ausschlusskriterium.

### Praktischer Workaround für den Remote-Fall

Alles in **einen** `text/plain`-Block packen, z. B. als JSON oder HTML:

```json
{
  "files": [
    { "name": "img1.png", "type": "image/png", "data": "<base64>" },
    { "name": "img2.png", "type": "image/png", "data": "<base64>" },
    { "name": "notes.txt", "type": "text/plain", "data": "<base64>" }
  ]
}
```

Die Web-App liest dann `getData("text/plain")`, parst das JSON und erzeugt daraus `File`-Objekte:

```javascript
document.addEventListener('paste', (e) => {
    const text = e.clipboardData.getData('text/plain');
    const parsed = JSON.parse(text);
    const files = parsed.files.map(f =>
        new File(
            [Uint8Array.from(atob(f.data), c => c.charCodeAt(0))],
            f.name,
            { type: f.type }
        )
    );
    // files[0], files[1], files[2] sind jetzt File-Objekte
});
```

Das ist der einzige Weg, **mehrere** Dateien (inkl. Bilder) über ein rein textbasiertes Clipboard in eine Web-App zu bringen.







------
> OK dann eben nur der erste Fall von 1× CF_DIB + 1× CF_UNICODETEXT.  Was genau muss ich in das Clipboard packen?
------

### Was genau ins Clipboard muss

Das Windows-Clipboard hält **mehrere Formate gleichzeitig**. Du musst zwei `GMEM_MOVEABLE`-Handles setzen:

| Format | Inhalt |
|--------|--------|
| **CF_DIB** (8) | `BITMAPINFOHEADER` (40 Bytes) + rohe Pixel (ohne `BITMAPFILEHEADER`) |
| **CF_UNICODETEXT** (13) | UTF-16LE-String, null-terminiert |

Windows synthetisiert automatisch daraus `CF_BITMAP`, `CF_DIBV5`, `CF_TEXT`, `CF_OEMTEXT`, `CF_LOCALE` – die musst du nicht selbst setzen.

### CF_DIB im Detail

```
┌─────────────────────────────────────────────────┐
│ BITMAPINFOHEADER (40 Bytes)                     │
│   biSize         = 40                           │
│   biWidth        = Breite in Pixeln             │
│   biHeight       = -Höhe (top-down)             │
│   biPlanes       = 1                            │
│   biBitCount     = 32 (BGRA)                    │
│   biCompression  = 0 (BI_RGB)                   │
│   biSizeImage    = 0                            │
│   biXPelsPerMeter= 0                            │
│   biYPelsPerMeter= 0                            │
│   biClrUsed      = 0                            │
│   biClrImportant = 0                            │
├─────────────────────────────────────────────────┤
│ Pixel-Data: Width × Height × 4 Bytes (BGRA)     │
│ (Top-Down, da biHeight negativ)                 │
└─────────────────────────────────────────────────┘
```

**Wichtig:** Kein `BITMAPFILEHEADER` (die 14 Bytes `BM...`), nur der DIB-Teil. Ein PNG muss also erst in rohe BGRA-Pixel konvertiert werden.

### PowerShell-Beispiel

```powershell
param(
    [string]$ImagePath,
    [string]$Text
)

Add-Type -AssemblyName System.Drawing

# --- 1. PNG laden und nach BGRA konvertieren ---
$bmp = [System.Drawing.Bitmap]::new($ImagePath)
$rect = [System.Drawing.Rectangle]::new(0, 0, $bmp.Width, $bmp.Height)
$data = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

$bytesPerRow = $data.Stride
$pixelBytes = [byte[]]::new($bytesPerRow * $bmp.Height)
[System.Runtime.InteropServices.Marshal]::Copy($data.Scan0, $pixelBytes, 0, $pixelBytes.Length)
$bmp.UnlockBits($data)
$bmp.Dispose()

# --- 2. BITMAPINFOHEADER bauen ---
$header = [byte[]]::new(40)
[BitConverter]::GetBytes([int]40)        | Copy-To -Destination $header -DestinationIndex 0   # biSize
[BitConverter]::GetBytes([int]$bmp.Width) | Copy-To -Destination $header -DestinationIndex 4  # biWidth
[BitConverter]::GetBytes([int](-$bmp.Height)) | Copy-To -Destination $header -DestinationIndex 8 # biHeight (top-down)
[BitConverter]::GetBytes([int]1)         | Copy-To -Destination $header -DestinationIndex 12  # biPlanes
[BitConverter]::GetBytes([int]32)        | Copy-To -Destination $header -DestinationIndex 14  # biBitCount
[BitConverter]::GetBytes([int]0)         | Copy-To -Destination $header -DestinationIndex 16  # biCompression
# biSizeImage, biXPelsPerMeter, biYPelsPerMeter, biClrUsed, biClrImportant = 0 (schon init)

$dib = [byte[]]::new($header.Length + $pixelBytes.Length)
[Array]::Copy($header, 0, $dib, 0, $header.Length)
[Array]::Copy($pixelBytes, 0, $dib, $header.Length, $pixelBytes.Length)

# --- 3. P/Invoke für Clipboard ---
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Clip {
    [DllImport("user32.dll")] public static extern bool OpenClipboard(IntPtr hWndNewOwner);
    [DllImport("user32.dll")] public static extern bool EmptyClipboard();
    [DllImport("user32.dll")] public static extern bool CloseClipboard();
    [DllImport("user32.dll")] public static extern IntPtr SetClipboardData(uint uFormat, IntPtr hMem);
    [DllImport("kernel32.dll")] public static extern IntPtr GlobalAlloc(uint uFlags, UIntPtr dwBytes);
    [DllImport("kernel32.dll")] public static extern IntPtr GlobalLock(IntPtr hMem);
    [DllImport("kernel32.dll")] public static extern bool GlobalUnlock(IntPtr hMem);
    [DllImport("kernel32.dll")] public static extern IntPtr GlobalFree(IntPtr hMem);
}
"@

[void][Clip]::OpenClipboard([IntPtr]::Zero)
[void][Clip]::EmptyClipboard()

# CF_DIB setzen
$hDib = [Clip]::GlobalAlloc(0x0002, [UIntPtr]::new($dib.Length))  # GMEM_MOVEABLE
$pDib = [Clip]::GlobalLock($hDib)
[System.Runtime.InteropServices.Marshal]::Copy($dib, 0, $pDib, $dib.Length)
[void][Clip]::GlobalUnlock($hDib)
[void][Clip]::SetClipboardData(8, $hDib)  # CF_DIB = 8

# CF_UNICODETEXT setzen (UTF-16LE + null terminator)
$utf16 = [System.Text.Encoding]::Unicode.GetBytes($Text + [char]0)
$hText = [Clip]::GlobalAlloc(0x0002, [UIntPtr]::new($utf16.Length))
$pText = [Clip]::GlobalLock($hText)
[System.Runtime.InteropServices.Marshal]::Copy($utf16, 0, $pText, $utf16.Length)
[void][Clip]::GlobalUnlock($hText)
[void][Clip]::SetClipboardData(13, $hText)  # CF_UNICODETEXT = 13

[void][Clip]::CloseClipboard()
Write-Host "Clipboard gesetzt: CF_DIB ($($bmp.Width)×$($bmp.Height)) + CF_UNICODETEXT"
```

### Browser-Seite (Paste-Event)

```javascript
document.addEventListener('paste', (e) => {
    // Text aus CF_UNICODETEXT
    const text = e.clipboardData.getData('text/plain');
    console.log('Text:', text);

    // Bild aus CF_DIB → Browser präsentiert es als image/png
    const items = e.clipboardData.items;
    for (const item of items) {
        if (item.type === 'image/png') {
            const blob = item.getBlob();
            console.log('Bild:', blob.size, 'Bytes');
            // z.B. als File hochladen:
            const file = new File([blob], 'image.png', { type: 'image/png' });
        }
    }
});
```

### Zusammenfassung

| Was du setzt | Was der Browser sieht |
|---|---|
| `CF_DIB` (BITMAPINFOHEADER + BGRA-Pixel) | `clipboardData.items[i].type === 'image/png'` → `Blob` |
| `CF_UNICODETEXT` (UTF-16LE + `\0`) | `clipboardData.getData('text/plain')` → String |

Beides ist **simultan** verfügbar – der Browser kann beides im selben Paste-Event lesen.
