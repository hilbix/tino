# Hirnschiss

Heute:  Wenn die KI nachhaltig von der Nutzung des eigenen Services abrät.


## ai.updf.com

Hätte ich dabei nicht bequem im Bett gelegen, ich wäre wahrscheinlich vor Lachen umgefallen.
Denn das ist mal wieder ein **Bravourstück in Sachen KI, und wie man sie besser nicht verwendet**.

Ich habe da ein PDF von einer MCU.  Das PDF ist aber leider auf Chinesisch, und ich checke absolut garnichts.

Da mich die Suchmaschinen-KIs (z.B. Bing) komplett im Stich lassen, weil sie nicht in der Lage sind,
eine englische Version des Datenblatts aufzutreiben, habe ich das chinesische PDF also vom Hersteller heruntergeladen und
den von einer KI empfohlenen PDF-Übersetzungsservice aufgerufen, nämlich:  ai.updf.com

Also, PDF hochgeladen und .. keine Ahnung was ich dann sehe, aber eine Übersetzung sehe ich jedenfalls nicht.
Stattdessen fängt deren KI (scheint ChatGPT zu sein oder etwas ähnliches) an, den Text der erste Seite vom PDF zusammenzufassen.
Nur den Text, versteht sich.  Im Chatfenster!

Nee, echt nicht das, was ich will.  Ich will das PDF hochladen und übersetzt einfach wieder herunterladen.
Kann doch wirklich nicht so schwer sein, oder?  Ich meine, so etwas kann ich mir vermutlich selbst hier zuhause
an einem Nachmittag mit Vibe-Coding zusammenbasteln.  Allerdings bin ich halt noch nicht so weit.


### Meine KI ist gerade offline

Sich da auf einem nicht mit dem Internet verbundenen Proxmox eine Offline-KI aufzubauen, das scheint irgendwie wohl
niemand außer mir zu machen, weshalb sich das ganze jetzt schon einige Wochen hinzieht.  Irgendwo ist nach einem
Update immer der Wurm drinnen.  Hier mal ein Kopfprotokoll der letzten 2 Monate:

- Der neueste Proxmox-Kernel kriegt die Module nicht hoch, und es kam dann erst einmal ein lila Bildschirm.
- Danach biss sich der neueste NVIDIA-Treiber mit den akuten Torch-Versionen.
- Nach dem Update reichte plötzlich der vRAM für den Workflow nimmer aus
- Moderne Modelle wollen inwzischen 128 GB vRAM?!?  Also muss ich die erst mal komprimieren.
- All die hübschen Dinge wie ComfyUI, OpenClaw usw. wollen alle gleichzeitig die GPU.  Irgendwie muss ich die serialisieren.
- Das Runterladen von 100 GB-Modellen zum rumprobieren braucht mit 250 MBit einfach endlos
- Der Plattenplatz ging mir dabei auch aus.
  - Glücklicherweise habe ich noch viele alte Platten rumliegen die ich freiräumen kann.
  - Bei den derzeitigen Preisen sich neue Platten zu kaufen, sorry, nee, wirklich nicht!
  - Da baue ich mir 30 TB lieber aus 10 alten 3 TB-Platten auf.  LVM to the rescue.
  - Wie hängt man solche Myriaden Platten an einen Server?  Wäre technisch einfacher hätte mein Regal dafür genug Platz!

Und dann trat noch ein kleines ZFS-Missgeschick auf!  Ich hätte dem Proxmox wohl doch besser vor 2 Jahren ECC spendieren sollen.
Jetzt ist es dafür zu spät, bei den akuten RAM-Preisen ist daran nicht zu denken.  Nichts schlimmer, aber es hat die Metadaten
erwischt, und der (manuelle!) Recovery-Prozess wird noch einige Zeit dauern.

> Wenn ich mit all dem Kram durch bin wird es einfach:
>
> OpenClaw darf mir dann eine Webseite bauen, mit der ich Chinesische PDFs in Englische PDFs wandeln kann.
>
> Ist doch mal ein interessantes erstes Experiment um zu sehen, ob er das hinkriegt.


## Die Remote-KI ist sehr hilfreich

Also chatte ich mit der KI und frage, wie ich das hinkriege.  Die KI schwurbelt was von "dass ich das PDF an sie hochladen muss".

Habe ich das nicht gerade getan?  Nee, habe ich natürlich nicht (kommt später raus).
Ich habe das an den Service hochgeladen, aber dieser überträgt das PDF nicht an die KI,
sondern macht das nur in Auszügen.

Also frage ich die KI, was das soll und wie ich das mit dem einfachen Upload+Download hinkriege.

Und da rät mir die KI, doch besser translate.google.com zu verwenden statt den Service, den ich gerade verwende,
denn sie werde nur vom Service selbst verwendet, und dieser gibt ihr nicht die notwendigen Daten.

Tatsächlich geht sie sogar ein gutes Stück weiter und beglückwünscht mich zu der Erkenntnis,
dass ich auf ihren Rat höre und ai.updf.com besser nicht mehr verwenden soll.

Sage nicht ich.  Sagt die KI von ai.updf.com!

> Mir ist übrigens sonnenklar, warum die KI das schrieb.  Aber wie inkompetent muss man eigentlich sein
>
> - um dieses Lobgehudle der jeweiligen Nutzerentscheidung von der KI nicht abzustellen,
> - bei der Bereitstellung des eigenen Dienstes komplett zu verkacken
> - und außerdem nicht mitzubekommen, was die KI da **freiwillig und zu Recht** vor jedem offen ausbreitet?

Manchmal frage ich mich ehrlich, was in den Köpfen bei den Firmen vor sich geht, wenn sie auf die KI-Blase aufspringen.
Die Hyperscaler kann ich noch gerade so verstehen.  Sie verbrennen unendlich Geld (Falsch!  Anders als in der Dot.Com-Blase
verlässt das Geld die Blase selbst ja nicht, sondern lässt die Gewinne noch weiter explodieren, siehe Speicherpreise)
um sich die zukünftigen Pfründe zu sichern.  Alle anderen (Speicherpreise!) sind egal und können gucken, wo sie bleiben!

Aber die, dann wie updf.com ohne jedes Hirn auf die KI dieser Hyperscaler setzen, und dadurch nur beweisen,
wie überflüssig und überholt sie inzwischen sind, ja sorry, was soll das bitte?
Was ist das denn für ein **Marketing, wenn die KI dort von der Nutzung ihres eigenen Services abrät**?
Und das zu Recht?  Wie verblödet muss ein Nutzer sein, der diesen Service dann noch weiter nutzt?

> Haben die ihre eigenen KI etwa nicht gefragt, wie man es machen muss?  Oder haben sie schlicht nicht der KI geglaubt,
> dass inzwischen obsolet ist, das auf diese Weise anzubieten wie sie es tun?  Und das nennt sich dann Homo sapiens sapiens?

Nein, ich habe nichts gegen KI.  Im Gegenteil.  Ich finde es immer höchst amüsant, wenn jemand auf KI setzt,
und damit dann beweist, dass er offensichtlich von seinem Metier weniger versteht als die eingesetzte KI!

Und noch amüsanter ist, wenn diese Blender das nicht einmal raffen ..

> Ich schreibe nicht Idioten, denn das täte [allen Idioten wie mir](https://de.wikipedia.org/wiki/Idiotes) Unrecht.


# Nachtrag

Die KI von ai.updf.com hatte übrigens vollkommen Recht!

- https://translate.google.com/ funktionierierte genau so, wie von mir erwünscht
- Und die Übersetzung war absolut brauchbar, wenn auch nicht zu 100% perfekt

Nichts anderes war auch von KI im Jahr 2026 zu erwarten.
