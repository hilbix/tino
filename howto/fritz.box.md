> Die FRITZ!Box hat einige sehr hilfreiche Möglichkeiten, die gut versteckt wurden.
> Jedenfalls fand ich diese nur weil ich irgendwo im Internet über einen Link gestolpert bin
> und siehe da, bei extrem genauem Nachforschen sind die Links tatsächlich auch im Menü versteckt!
>
> Warum die so etwas so gut verstecken?  Wirklich.  Keine.  Ahnung.
>
> Aber sei's wie es ist, hier sammle ich all das, damit ich es mir nicht merken muss.

# FRITZ!Box HowTo

## Infos von AVM

AVM veröffentlich eine ganze Menge an PDFs zu den Schnittstellen der FRITZ!Box:

https://avm.de/service/schnittstellen/

Ich habe nicht nachgesehen, ob die Infos aus dem Internet irgendwo ebenfalls in diesen Dokumenten steckt.
Es ist allerdings anzunehmen, dass die Leute das Zeug alles nicht selber herausfinden mussten.

> **Wichtig!** Die so erhaltenen Informationen sind sehr technisch und nützen nur denjenigen,
> die etwas von der Materie verstehen.  Im zweifel also jedem Hacker ..
>
> Und wer an einigen dieser erweiterten Parameter rumschraubt, kann sich damit natürlich auch selbst ins Knie schießen.
>
> Das erklärt aber nicht, warum die Optionen versteckt wurden.  Verstecken und Warnen sind 2 verschiedene Dinge!


## URLs aus dem Internet

> Warum sind die gefährlichen Möglichkeiten davon nicht, wie alle anderen gefährlichen Funktionen in der FRITZ!Box,
> durch einen zusätzlichen Telefoncode geschützt?
>
> Ich würde außerdem erwarten, dass beim Paketdump auf ALLEN Fritz-Phones eine entsprechende Warnung hochpoppen muss,
> wenn solche Funktonen genutzt werden, denn das ist ja extrem datenschutzrelevant.

Die URLs sind auch für jeden Admin aus dem Menü erreichbar, und zwar so:

- Unten links auf "Inhalt" klicken (das ist sehr konstrastschwach)
- Dann unten links im neu erschienenen Kasten "FRITZ!Box Support" anklicken.

http://fritz.box/support.lua

- Hier kann man einige Diagnosen starten und erweiterte Logs z. B. für den AVM-Support runterladen
- Wenn man die "Erweiterte Support-Daten"-Option aktiviert bekommt man einige sehr detaillierte (retroaktive) Logs die bei ziemlich vielen Problemen weiterhelfen dürften, sofern diese akut aufgetreten sind.
- Von hier aus ist auch folgendes URL erreichbar:

http://fritz.box/html/capture.html

- Paket-Trace im PCAP-Format (tcpdump/Wireshark)
- Kernel-Traces per [Dtrace](http://dtrace.org/blogs/about/)
