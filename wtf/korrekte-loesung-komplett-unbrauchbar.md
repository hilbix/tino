# Das WTF des WTF

> Für jedes große Probleme findet sich mit ausreichend Zeit fast immer eine
> gut verständliche, hervorragend umsetzbare, vollkommen praktikable und einleuchtende Lösung,
> der Jedermann sofort ohne Vorbehalte zustimmen kann da sie zweifellos vollkommen korrekt ist,
> die nur leider vollkommen falsch ist.

Das ist, hier mal in Form gebracht, einer meiner Lieblingssprüche.

Zwar hätte ich gerne mal Unrecht, aber leider ist der nur allzu wahr.

## Beispiele

### 20180923 Mergesort für Linked Lists

Ich brauchte einen Stable Sort für eine Double-Linked-List.
Die naive Implemetierung von Mergesort, die mir dafür sofort in den Sinn kommt,
verwendet mehrere Komponenten der Komplexität `O(n)` in einer Rekursionskomplexität von `O(log n)`
(so dass halt insgesamt das `O(n log n)` vom Mergesort rauskommt).

Ich dachte mir, da muss es doch im Internet sicher etwas clevereres geben,
als das, was ich da schnell mal zusammengebastelt habe.

Etwas, das vor allem die Anzahl der `O(n)`-Komponenten deutlich drückt,
indem es beim durchloopen mehrere Fliegen mit einer Klappe schlägt,
und vor allem auch die Caches der CPU besser nutzt.

Der erste prominente Hit bei Google bei der Suche nach "sort linear list" war dann:

https://www.geeksforgeeks.org/merge-sort-for-linked-list/

Reingeguckt und vor Lachen fast den Stuhl ruiniert.
Was ich da zu sehen bekam war nicht nur naiv,
das war selbst als Beispiel vollkommen unbrauchbar.

- Na, bemerkt wo der WTF in dem Algorithmus steckt?  Nicht?  Aber das ist doch so unheimlich offensichtlich!
- Irgendwie hat mich der Code dann an das erinnert, was ich so von indischem Outsourcing her kenne.  
  Leute, die bei Algorithmen grundsätzlich alles falschrum machen die kenne ich vor allem aus Indien.  
  Und siehe da, ROTFLMAO, der Typ, der das da verbrochen hat, der ist tatsächlich Inder!
  Er stammt sogar von einem renommierten staatlichen Technologiezentrum, das mit seiner besonders hohen Qualität wirbt.    
  Ja, genau, diese fast unübertroffen (*hust* Parkistan *hust*) typische indische "hohe Codequalität",
  die wir alle so schätzen und lieben!  
- Das ist sogar ein WTF³:
  - Erstens, würde ich Typen, die derartiges verbrechen und sich dabei nicht in Grund und Boden schämen,
    nicht einmal mit vorgehaltener Waffe einstellen.
    Weil wenn ich so jemanden einstelle bin ich tot, da ich mit solch einem unverantwortlichen Handlung niemals leben könnte!
  - Zweitens, stammt der von einem offensichtlich rennomierten Institut,
    das solchen Leuten tatsächlich einen akademischen Grad verleiht.
    Das ist ein ziemlicher Schlag ins Gesicht eines jeden ordentlichen Informatikers/Geeks.
  - Drittens steht so etwas auch noch auf einem Portal das den First-Hit von Google vertritt.
    Sprich, dieser Müll da wird noch Generationen unbedarfter Programmierer verseuchen!
- Wow, das ist der Beweis:  Auch wenn wir es nicht wahrhaben wollen, wir haben schon verloren, und zwar auf ganzer Linie!  
  Wird Zeit dass die KIs übernehmen.  Die hätten den (Upps, **Spoileralarm**) Stackoverflow nämlich sofort bemerkt.

Weitere Beispiele sobald ich drüber stolpere und nicht mehr an mich halten kann.
