<https://search.brave.com/ask?q=gibt+es+unter+Windows+eine+einfache+m%C3%B6glichkeit%2C+bin%C3%A4rdateien+%C3%BCber+das+Clipboard+zu+kopieren%2C+wenn+d...&conversation=09bbf943a1fab6ef806cb583dbba7815e58f#MWKD1bHMzH31IsHd981q4rtj-BXpyh1RnxiEOnhbiPs>


-----------
> gibt es unter Windows eine einfache möglichkeit, binärdateien über das Clipboard zu kopieren, wenn der Remote-Zugang nur Textdateien im Clipboard erlaubt?
-----------

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











-----------
> kann man das mit dem set-clipboard in den send-to einbauen?
-----------

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











-----------
> Kann man da den Dateinamen mit hineinpacken?  Als erste Zeile oder so?
-----------

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











-----------
> kann man das evtl. so formatieren, dass ein Browser in der Lage ist, das als Datei-Drop zu verstehen?  Also z.B. als URL?
-----------

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











-----------
> kann man in data-urls keinen default-dateinamen einbetten?
-----------

Nein – eine **reine Data URI** in der Adressleiste kann keinen Dateinamen transportieren. Das ist im [Data-URI-Standard](https://en.wikipedia.org/wiki/Data_URI_scheme) explizit so festgelegt: *„Data URIs do not carry a filename as a normal linked file would. When saving, a default filename for the specified MIME type is generally used."*

Der Browser lädt also z. B. als `download` oder `download.bin`.

### Was geht

Der einzige Weg, einen Dateinamen zu setzen, ist das **`download`-Attribut** eines `<a>`-Tags – und genau das nutzt der HTML-Data-URI-Trick aus der vorherigen Antwort:

```html
<a download="meinedatei.bin" href="data:application/octet-stream;base64,...">Download</a>
```

D.h.: Die **HTML-Variante** (mit `<a download="...">`) ist bereits die bestmögliche Lösung, die rein über die Zwischenablage in die Adressleiste passt. Eine „reinere" Variante ohne HTML-Wrapper gibt es nicht.











-----------
> wie wird dann ein Dateiname im Clipboard kodiert, wenn dieser in einen Browser gepastet wird?
-----------

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











-----------
> Das meine ich gerade nicht.  Wenn ich im Explorer eine Datei per Strg+C kopiere und dann per Strg+V in eine Web-Applikation übertrage, dann wird die Datei über das Clipboard kopiert.  Dabei wird auch der Dateiname mitkopiert.  Wie geht das konkret, also was empfängt der Browser da aus dem Clipboard?
-----------

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











-----------
> Welche Übertragungsformate von Dateien per Clipboard versteht Javascript im Browser?
-----------

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











-----------
> Wie kann ich zwei image/png und ein text/plain (also 3 Dateien) in das Clipboard legen, so dass der Browser diese per paste-event lesen kann?
-----------

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











-----------
> OK dann eben nur der erste Fall von 1× CF_DIB + 1× CF_UNICODETEXT.  Was genau muss ich in das Clipboard packen?
-----------

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











-----------
> Da ich die Browser-Seite nicht ändern kann (ist ein anderes System extern), das eine Datei im Clipboard verlangt, ich aber diese Struktur im Clipboard nicht erzeugen kann, braucht es einen Zwischenschritt.  Oben ging es per Download.  Der Weg wäre also:  Send-To, Paste in einen Browser, Download und dann Datei im Explorer kopieren und in das Ziel einfügen.  Kann der Browser die Datei stattdessen nicht direkt in das Clipboard legen?
-----------

**Nein.** Der Browser kann eine Datei **nicht** als `CF_HDROP` in das Windows-Clipboard schreiben. Die Web Clipboard API (`navigator.clipboard.write()`) unterstützt nur:

| Format | Ergebnis im Windows-Clipboard |
|--------|-------------------------------|
| `text/plain` | `CF_UNICODETEXT` |
| `text/html` | `CF_HTML` |
| `image/png` | `CF_DIB` |

Es gibt kein `CF_HDROP`-Äquivalent – der Browser kann keine Dateipfade ins Clipboard legen. (Der [Raw Clipboard Access](https://github.com/WICG/raw-clipboard-access) Vorschlag würde das theoretisch erlauben, ist aber in keinem Browser implementiert.)

### Deine Workflow-Optionen

**Dein Vorschlag** (Send-To → Browser → Download → Explorer-Copy → Paste) ist im Grunde der kürzeste Weg. Ein kleiner Optimierungsvorschlag für Schritt 3:

Statt die Datei manuell im Explorer zu markieren und Strg+C zu drücken, kannst du sie per PowerShell direkt als `CF_HDROP` ins Clipboard legen:

```powershell
# Download-Ordner bekannt, z. B. C:\Users\du\Downloads\meinedatei.bin
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Clipboard]::SetFileDropList(@("C:\Users\du\Downloads\meinedatei.bin"))
```

Das ist ein Einzeiler, der genau das macht, was Strg+C im Explorer tut. Du könntest das als kleine `.bat` im Senden-an-Ordner ablegen („In Zwischenablage als Datei kopieren"), dann wäre der Gesamt-Flow:

1. **Senden an** → „Base64 in Zwischenablage"
2. **Strg+V** im Browser → Download
3. **Senden an** → „In Zwischenablage als Datei kopieren" (auf die heruntergeladene Datei)
4. **Strg+V** im Ziel

Das spart den Explorer-Klick in Schritt 3, aber grundsätzlich bleibt der Umweg über den Download – der Browser kann das nicht ersetzen.











-----------
> Kann man statt [IO.File]::WriteAllBytes($name, $bytes) die Datei nicht sofort ins Clipboard legen?
-----------

**Nein** – `CF_HDROP` ist rein eine **Liste von Dateipfaden**. Es gibt kein Format, in dem man rohe Bytes als „Datei" ins Clipboard legt, ohne dass die Datei auf der Platte existiert. Die Datei muss also zwangsläufig kurzzeitig auf Disk.

### Aber: alles in einem Schritt kombinieren

Du kannst Decode + `SetFileDropList` in **einen** PowerShell-Einzeiler packen, der direkt aus dem Clipboard liest:

```powershell
$b=[Convert]::FromBase64String((Get-Clipboard -Raw)); $t=[IO.Path]::GetTempFileName(); [IO.File]::WriteAllBytes($t,$b); [System.Windows.Forms.Clipboard]::SetFileDropList(@($t))
```

Das kann man z. B. als PowerShell-Snippet in eine `.bat` im **Senden-an**-Ordner legen oder einfach in eine PowerShell-Konsole einfügen. Der Workflow wird dann:

1. **Senden an** → „Base64 in Zwischenablage" (auf Maschine A)
2. **Strg+V** im Browser → Download (auf Maschine B)
3. **Obigen Einzeiler** in PowerShell ausführen (liest den Base64-Text vom Clipboard, schreibt Temp-Datei, legt sie sofort als `CF_HDROP` ins Clipboard)
4. **Strg+V** im Ziel

Schritt 3 ersetzt den manuellen Explorer-Klick – die Datei existiert nur für einen Augenblick in `%TEMP%`.











-----------
> Kann man den 3. Schritt nicht automatisieren?  Also ein Powershell-Script schreiben, das auf Änderungen im Clipboard wartet, und wenn dort ein entsprechender Inhalt auftaucht, diesen direkt über das gezeigte Script in eine Datei umwandeln?
-----------

Ja, das geht mit einem einfachen Polling-Loop:

```powershell
Add-Type -AssemblyName System.Windows.Forms

$lastText = ""

while ($true) {
    try {
        $text = Get-Clipboard -Raw
    } catch {
        $text = ""
    }

    # Nur weiterverarbeiten, wenn sich der Text geändert hat
    if ($text -and $text -ne $lastText) {
        $lastText = $text

        $lines = $text -split "`r`n"

        # Erwartetes Format: Zeile 1 = Dateiname, Zeile 2 = Base64
        if ($lines.Count -eq 2 -and $lines[1] -match '^[A-Za-z0-9+/=]+) {
            $name  = $lines[0]
            $bytes = [Convert]::FromBase64String($lines[1])

            $tmp = [IO.Path]::Combine([IO.Path]::GetTempPath(), $name)
            [IO.File]::WriteAllBytes($tmp, $bytes)

            [System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
            Write-Host "[$(Get-Date -f HH:mm:ss)] $name → Clipboard (CF_HDROP)"
        }
    }

    Start-Sleep -Milliseconds 500
}
```

### Verhalten

| Clipboard-Inhalt | Reaktion |
|---|---|
| Base64-Block (Zeile 1 = Name, Zeile 2 = Base64) | Decode → Temp-Datei → `CF_HDROP` |
| `CF_HDROP` (nach `SetFileDropList`) | `Get-Clipboard -Raw` liefert leer → kein Trigger |
| Anderer Text | Ignoriert |

### Starten

Am einfachsten als `.ps1` im Autostart (`shell:startup`) oder manuell in einer PowerShell-Konsole:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\clip-watcher.ps1"
```

Danach ist der gesamte Workflow auf Maschine B nur noch:

1. **Strg+V** im Browser → Download (oder direkt in die Adressleiste)
2. **Strg+V** im Ziel – fertig, der Watcher hat das Clipboard bereits auf `CF_HDROP` umgestellt.

Falls du den Watcher nicht dauerhaft laufen lassen willst, kannst du den Trigger auch auf ein bestimmtes Präfix im Dateinamen beschränken, z. B. `__CLIP__report.pdf`, um Kollisionen mit normalem Text zu vermeiden.










-----------
> Es gibt keinen Event, der herausfindet, dass sich das Clipboard geändert hat?  Oder einen blockenden Read, der erst nach Änderung vom Clipboard zurückkommt?
-----------

Ja – es gibt genau dafür **`AddClipboardFormatListener`** + **`WM_CLIPBOARDUPDATE`** (0x031D). Ein Fenster wird registriert und Windows *postet* ihm die Nachricht, sobald sich das Clipboard ändert. Kein Polling.

Es gibt aber **keinen blockierenden Read** – es ist ein asynchrones Window-Message. In PowerShell lässt sich das trotzdem sauber als blockierender Aufruf verpacken:

```powershell
Add-Type @"
using System;
using System.Threading;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public class ClipboardWatcher : IDisposable
{
    private NativeWindow _nativeWindow;
    private ManualResetEventSlim _event = new ManualResetEventSlim(false);

    public void Start()
    {
        _nativeWindow = new NativeWindow();
        _nativeWindow.CreateHandle(new CreateParams { Parent = HWND_MESSAGE });
        _nativeWindow.AddHook(new MessageLoopHook());
        AddClipboardFormatListener(_nativeWindow.Handle);
    }

    public void WaitForChange()
    {
        _event.Reset();
        _event.Wait();
    }

    public void Dispose()
    {
        if (_nativeWindow != null)
        {
            RemoveClipboardFormatListener(_nativeWindow.Handle);
            _nativeWindow.DestroyHandle();
        }
    }

    private void OnClipboardUpdate()
    {
        _event.Set();
    }

    private class MessageLoopHook : NativeWindow.Callback
    {
        // Handled via WndProc override below
    }

    private class NativeWindow : System.Windows.Forms.NativeWindow
    {
        private Action _onUpdate;
        public void AddHook(Action onUpdate) { _onUpdate = onUpdate; }

        protected override void WndProc(ref Message m)
        {
            if (m.Msg == 0x031D) // WM_CLIPBOARDUPDATE
                _onUpdate?.Invoke();
            base.WndProc(ref m);
        }
    }

    private static readonly IntPtr HWND_MESSAGE = new IntPtr(-3);

    [DllImport("user32.dll")]
    private static extern bool AddClipboardFormatListener(IntPtr hwnd);

    [DllImport("user32.dll")]
    private static extern bool RemoveClipboardFormatListener(IntPtr hwnd);
}
"@

$watcher = [ClipboardWatcher]::new()
$watcher.Start()

while ($true) {
    $watcher.WaitForChange()   # blockiert, bis WM_CLIPBOARDUPDATE eintrifft

    try {
        $text = Get-Clipboard -Raw
    } catch {
        $text = ""
    }

    if ($text) {
        $lines = $text -split "`r`n"
        if ($lines.Count -eq 2 -and $lines[1] -match '^[A-Za-z0-9+/=]+$') {
            $name  = $lines[0]
            $bytes = [Convert]::FromBase64String($lines[1])
            $tmp   = [IO.Path]::Combine([IO.Path]::GetTempPath(), $name)
            [IO.File]::WriteAllBytes($tmp, $bytes)
            [System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
            Write-Host "[$(Get-Date -f HH:mm:ss)] $name → CF_HDROP"
        }
    }
}
```

### Vergleich Polling vs. Event

| | Polling (`Start-Sleep 500`) | `AddClipboardFormatListener` |
|---|---|---|
| Latenz | bis 500 ms | **sofort** (Windows postet die Nachricht) |
| CPU-Last | konstant (wenn auch gering) | **null** (blockiert auf `Wait()`) |
| Komplexität | trivial | etwas mehr (hidden window + P/Invoke) |

### Wichtige Details

- **`HWND_MESSAGE`** (−3): Das Fenster ist ein *message-only window* – es wird nie sichtbar und hat keinen Parent.
- **`ManualResetEventSlim`**: Der `WndProc`-Thread setzt das Event; der Haupt-Thread blockiert auf `Wait()`. Kein `Thread.Sleep` nötig.
- **`SetFileDropList`** löst selbst ein `WM_CLIPBOARDUPDATE` aus → der Watcher würde sofort wieder wach. Das ist hier unkritisch, weil der Base64-Regex dann nicht matcht (das Clipboard enthält jetzt `CF_HDROP`, kein Text). Falls es doch stört, kann man eine Guard-Variable setzen:

```powershell
$suppress = $true
[System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
$suppress = $false
```

und im `WndProc`-Handler das Event nur setzen, wenn `$suppress` nicht aktiv ist.











-----------
> Kann man in dem Fenster noch einen Start-Stopp-Button einbauen, so dass man diese automatische Konvertierung anhalten kann?  Außerdem bitte ein kurzes Log, in dem das Fenster anzeigt, welche Dateien in welcher Größe empfangen und konvertiert wurden.
-----------

Ja – mit einem kleinen WinForms-Fenster:

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public class ClipListener : NativeWindow
{
    private Action _onUpdate;
    public ClipListener(Action onUpdate) { _onUpdate = onUpdate; }

    protected override void WndProc(ref Message m)
    {
        if (m.Msg == 0x031D) _onUpdate?.Invoke();
        base.WndProc(ref m);
    }

    [DllImport("user32.dll")] private static extern bool AddClipboardFormatListener(IntPtr hwnd);
    [DllImport("user32.dll")] private static extern bool RemoveClipboardFormatListener(IntPtr hwnd);

    public void Register()
    {
        CreateHandle(new CreateParams { Parent = new IntPtr(-3) });
        AddClipboardFormatListener(Handle);
    }

    public void Unregister()
    {
        RemoveClipboardFormatListener(Handle);
        DestroyHandle();
    }
}
"@

# --- UI ---
$form = [Windows.Forms.Form]::new()
$form.Text = "Clipboard Watcher"
$form.Size = [System.Drawing.Size]::new(420, 300)
$form.StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen

$btn = [Windows.Forms.Button]::new()
$btn.Text = "Start"
$btn.Location = [System.Drawing.Point]::new(10, 10)
$btn.Size = [System.Drawing.Size]::new(80, 28)

$log = [Windows.Forms.TextBox]::new()
$log.Location = [System.Drawing.Point]::new(10, 45)
$log.Size = [System.Drawing.Size]::new(390, 230)
$log.Multiline = $true
$log.ReadOnly = $true
$log.ScrollBars = [Windows.Forms.ScrollBars]::Vertical
$log.Font = [System.Drawing.Font]::new("Consolas", 9)

$form.Controls.Add($btn)
$form.Controls.Add($log)

# --- State ---
$running = $false
$listener = $null
$suppress = $false

function Add-Log {
    param([string]$msg)
    $log.AppendText("[$(Get-Date -f 'HH:mm:ss')] $msg`r`n")
    $log.SelectionStart = $log.TextLength
    $log.ScrollToCaret()
}

$btn.Add_Click({
    if (-not $running) {
        $running = $true
        $btn.Text = "Stop"
        $listener = [ClipListener]::new({
            if ($suppress) { return }
            $form.BeginInvoke({
                try { $text = Get-Clipboard -Raw } catch { $text = "" }
                if (-not $text) { return }
                $lines = $text -split "`r`n"
                if ($lines.Count -eq 2 -and $lines[1] -match '^[A-Za-z0-9+/=]+$') {
                    $name  = $lines[0]
                    $bytes = [Convert]::FromBase64String($lines[1])
                    $tmp   = [IO.Path]::Combine([IO.Path]::GetTempPath(), $name)
                    [IO.File]::WriteAllBytes($tmp, $bytes)
                    $suppress = $true
                    [System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
                    $suppress = $false
                    Add-Log "$name  ($([math]::Round($bytes.Length/1KB,1)) KB) → CF_HDROP"
                }
            })
        })
        $listener.Register()
        Add-Log "Gestartet"
    } else {
        $running = $false
        $btn.Text = "Start"
        $listener.Unregister()
        $listener = $null
        Add-Log "Gestoppt"
    }
})

$form.Add_FormClosed({ $listener?.Unregister(); $form.Dispose() })
[System.Windows.Forms.Application]::Run($form)
```

### Verhalten

| Aktion | Ergebnis |
|--------|----------|
| **Start** klicken | Listener aktiv, Clipboard wird überwacht |
| Base64-Text im Clipboard | Datei wird dekodiert, als `CF_HDROP` gesetzt, Log-Eintrag erscheint |
| **Stop** klicken | Listener deaktiviert, kein automatisches Umwandeln mehr |
| Fenster schließen | Listener wird sauber entfernt |

### Log-Beispiel

```
[14:32:01] Gestartet
[14:32:15] report.pdf  (245.3 KB) → CF_HDROP
[14:33:02] photo.png  (1.2 MB) → CF_HDROP
[14:35:10] Gestoppt
```

Der `Suppress`-Flag verhindert, dass `SetFileDropList` selbst (das ein neues `WM_CLIPBOARDUPDATE` auslöst) die Schleife erneut triggert.











-----------
> ich bekomme einige fehler beim ausführen des neuesten scripts mit powershell.  Ich gehe sie nun eins nach dem anderen durch:
>
> Der Typ- oder Namespacename 'Forms' ist im Namespace
> 'System.Windows' nicht vorhanden. (Fehlt ein Assemblyverweis?)
-----------

Der Fehler liegt daran, dass `Add-Type` mit inline C#-Code (`@"..."@`) den **C#-Compiler** aufruft, der die Assembly als **Kompilierzeit-Referenz** braucht – nicht nur als geladene Assembly in der PowerShell-Sitzung. `Add-Type -AssemblyName` lädt sie nur zur Laufzeit.

### Fix: `-ReferencedAssemblies` ergänzen

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public class ClipListener : NativeWindow
{
    private Action _onUpdate;
    public ClipListener(Action onUpdate) { _onUpdate = onUpdate; }

    protected override void WndProc(ref Message m)
    {
        if (m.Msg == 0x031D) _onUpdate?.Invoke();
        base.WndProc(ref m);
    }

    [DllImport("user32.dll")] private static extern bool AddClipboardFormatListener(IntPtr hwnd);
    [DllImport("user32.dll")] private static extern bool RemoveClipboardFormatListener(IntPtr hwnd);

    public void Register()
    {
        CreateHandle(new CreateParams { Parent = new IntPtr(-3) });
        AddClipboardFormatListener(Handle);
    }

    public void Unregister()
    {
        RemoveClipboardFormatListener(Handle);
        DestroyHandle();
    }
}"@ -ReferencedAssemblies @("System.Windows.Forms", "System.Drawing")
```

Der einzige Unterschied zur vorherigen Version ist die letzte Zeile:

```
"@ -ReferencedAssemblies @("System.Windows.Forms", "System.Drawing")
```

Das sagt dem Compiler: „Suche `NativeWindow` in `System.Windows.Forms` und `Size`/`Point` in `System.Drawing`."

### Warum `Add-Type -AssemblyName` allein nicht reicht

| Aufruf | Wirkung |
|--------|---------|
| `Add-Type -AssemblyName X` | Lädt die Assembly in die PowerShell-Sitzung → `[X.Type]` funktioniert |
| `Add-Type -TypeDefinition "..."` | Compiliert C# → braucht **explizite** `-ReferencedAssemblies` |

Beides zusammen ist nötig: Die Assembly muss geladen sein (für den Rest des Scripts) **und** referenziert (für den Compiler).











-----------
> Nächster Fehler: Für "BeginInvoke" und die folgende Argumenteanzahl kann keine Überladung gefunden werden: "1".
-----------

PowerShell kann einen nackten Scriptblock `{ ... }` nicht automatisch in den richtigen Delegate-Typ für `BeginInvoke` umwandeln. Du musst ihn explizit als `[Action]` casten:

```powershell
# Falsch – PowerShell weiß nicht, welche Überladung gemeint ist
$form.BeginInvoke({
    # ...
})

# Richtig – expliziter Cast auf Action
$form.BeginInvoke([Action]{
    # ...
})
```

### Im Kontext deines Scripts

Die betroffene Stelle in der `ClipListener`-Callback-Definition:

```powershell
$listener = [ClipListener]::new({
    if ($suppress) { return }
    $form.BeginInvoke([Action]{   # ← [Action] davor
        try { $text = Get-Clipboard -Raw } catch { $text = "" }
        if (-not $text) { return }
        $lines = $text -split "`r`n"
        if ($lines.Count -eq 2 -and $lines[1] -match '^[A-Za-z0-9+/=]+$') {
            $name  = $lines[0]
            $bytes = [Convert]::FromBase64String($lines[1])
            $tmp   = [IO.Path]::Combine([IO.Path]::GetTempPath(), $name)
            [IO.File]::WriteAllBytes($tmp, $bytes)
            $suppress = $true
            [System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
            $suppress = $false
            Add-Log "$name  ($([math]::Round($bytes.Length/1KB,1)) KB) → CF_HDROP"
        }
    })
})
```

### Warum?

`Control.BeginInvoke` hat zwei Überladungen:
- `BeginInvoke(Delegate method)`
- `BeginInvoke(EventHandler handler, object state)`

Ein nackter Scriptblock ist für PowerShell ein `System.Management.Automation.ScriptBlock` – das passt zu keiner der beiden. Der Cast `[Action]{ ... }` erzeugt einen `System.Action`, der als `Delegate` akzeptiert wird.











-----------
> Es funktioniert schon fast wie gewünscht. In der Zeile
>
> if (m.Msg == 0x031D) _onUpdate?.Invoke();
>
> gibt es einen Fehler, der verschwindet, wenn ich das ? entferne.  Ist das so richtig oder müssen wir _onUpdate evtl. auf NULL testen?
-----------

Das ist kein Logik-Fehler, sondern ein **Compiler-Fehler**: Windows PowerShell 5.x verwendet den **C# 5.0**-Compiler, und der Null-Conditional-Operator `?.` wurde erst in **C# 6.0** eingeführt.

### Fix

Einfach einen expliziten Null-Test verwenden:

```csharp
if (m.Msg == 0x031D && _onUpdate != null) _onUpdate();
```

In deinem Fall ist der Test zwar überflüssig (der Callback wird im Konstruktor gesetzt und nie auf `null` zurückgesetzt), aber er kostet nichts und macht den Code für den C# 5-Compiler akzeptabel.

### Kurzer Überblick: was C# 5 nicht kann

| Syntax | C# 6+ | C# 5 (PS 5.x) |
|--------|-------|---------------|
| `?.` (null-conditional) | ✅ | ❌ |
| `??` (null-coalescing) | ✅ | ✅ |
| String-Interpolation `$"..."` | ✅ | ❌ |
| `nameof()` | ✅ | ❌ |
| Expression-bodied members `=>` | ✅ | ❌ |

Falls du auf **PowerShell 7** (`pwsh`) umsteigst, wird der C#-Compiler neuer und `?.` funktioniert wieder.











-----------
> Ich brauche noch ein paar Kleinigkeiten.  Wenn man das Script aufruft soll es sofort starten und sofort das Clipboard konvertieren bis man es stoppt.  Außerdem hätte ich im Log noch gerne einen Timestamp.
-----------

Kein Web-Search nötig – zwei kleine Änderungen am Script:

1. **Sofort starten:** Listener direkt bei `Form`-Load registrieren, Button auf „Stop" setzen.
2. **Timestamp mit Datum:** Format von `HH:mm:ss` auf `yyyy-MM-dd HH:mm:ss` erweitern.

### Geändertes Script

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public class ClipListener : NativeWindow
{
    private Action _onUpdate;
    public ClipListener(Action onUpdate) { _onUpdate = onUpdate; }

    protected override void WndProc(ref Message m)
    {
        if (m.Msg == 0x031D && _onUpdate != null) _onUpdate();
        base.WndProc(ref m);
    }

    [DllImport("user32.dll")] private static extern bool AddClipboardFormatListener(IntPtr hwnd);
    [DllImport("user32.dll")] private static extern bool RemoveClipboardFormatListener(IntPtr hwnd);

    public void Register()
    {
        CreateHandle(new CreateParams { Parent = new IntPtr(-3) });
        AddClipboardFormatListener(Handle);
    }

    public void Unregister()
    {
        RemoveClipboardFormatListener(Handle);
        DestroyHandle();
    }
}"@ -ReferencedAssemblies @("System.Windows.Forms", "System.Drawing")

# --- UI ---
$form = [Windows.Forms.Form]::new()
$form.Text = "Clipboard Watcher"
$form.Size = [System.Drawing.Size]::new(420, 300)
$form.StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen

$btn = [Windows.Forms.Button]::new()
$btn.Text = "Stop"
$btn.Location = [System.Drawing.Point]::new(10, 10)
$btn.Size = [System.Drawing.Size]::new(80, 28)

$log = [Windows.Forms.TextBox]::new()
$log.Location = [System.Drawing.Point]::new(10, 45)
$log.Size = [System.Drawing.Size]::new(390, 230)
$log.Multiline = $true
$log.ReadOnly = $true
$log.ScrollBars = [Windows.Forms.ScrollBars]::Vertical
$log.Font = [System.Drawing.Font]::new("Consolas", 9)

$form.Controls.Add($btn)
$form.Controls.Add($log)

# --- State ---
$running = $true
$listener = $null
$suppress = $false

function Add-Log {
    param([string]$msg)
    $log.AppendText("[$(Get-Date -f 'yyyy-MM-dd HH:mm:ss')] $msg`r`n")
    $log.SelectionStart = $log.TextLength
    $log.ScrollToCaret()
}

function Convert-Clipboard {
    if ($suppress) { return }
    try { $text = Get-Clipboard -Raw } catch { $text = "" }
    if (-not $text) { return }
    $lines = $text -split "`r`n"
    if ($lines.Count -eq 2 -and $lines[1] -match '^[A-Za-z0-9+/=]+$') {
        $name  = $lines[0]
        $bytes = [Convert]::FromBase64String($lines[1])
        $tmp   = [IO.Path]::Combine([IO.Path]::GetTempPath(), $name)
        [IO.File]::WriteAllBytes($tmp, $bytes)
        $suppress = $true
        [System.Windows.Forms.Clipboard]::SetFileDropList(@($tmp))
        $suppress = $false
        Add-Log "$name  ($([math]::Round($bytes.Length/1KB,1)) KB) → CF_HDROP"
    }
}

# --- Listener-Callback ---
$listener = [ClipListener]::new({
    $form.BeginInvoke([Action]{ Convert-Clipboard })
})

# --- Button ---
$btn.Add_Click({
    if ($running) {
        $running = $false
        $btn.Text = "Start"
        $listener.Unregister()
        $listener = $null
        Add-Log "Gestoppt"
    } else {
        $running = $true
        $btn.Text = "Stop"
        $listener = [ClipListener]::new({
            $form.BeginInvoke([Action]{ Convert-Clipboard })
        })
        $listener.Register()
        Add-Log "Gestartet"
        Convert-Clipboard
    }
})

# --- Sofort starten ---
$listener.Register()
Add-Log "Gestartet"
Convert-Clipboard

$form.Add_FormClosed({
    if ($listener) { $listener.Unregister() }
    $form.Dispose()
})

[System.Windows.Forms.Application]::Run($form)
```

### Was sich geändert hat

| Änderung | Vorher | Jetzt |
|----------|--------|-------|
| Startzustand | Button „Start", Listener inaktiv | Button „Stop", Listener **sofort aktiv** |
| Erst-Check | erst nach Klick | `Convert-Clipboard` wird direkt nach `Register()` aufgerufen |
| Timestamp | `HH:mm:ss` | `yyyy-MM-dd HH:mm:ss` |
| Logik | inline im Button-Click | extrahiert in `Convert-Clipboard` (wird beim Start **und** nach jedem Restart aufgerufen) |

