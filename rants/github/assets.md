# GitHub

Ich habe so meine Probleme mit GitHub ..

## Gefährliche GitHub-Assets

Der GitHub-Editor packt leider Uploads nicht ins Repo - was ich eigentlich erwartet hätte - sondern packt das alles irgendwo in einen Space, den man weder sehen noch kontrollieren noch auf einfache Weise downloaden kann.  Es reicht also nicht, ein Repo zu klonen, man muss auch noch zusätzliche nach diesen seltsamen GitHub-Assets fahnden, um sie abrufen und passend zwischenlagern zu können.

> Gibt es dafür passende Standardtools, irgendwo?  Ich meine nicht irgendeinen proprietären Privatschlonz
> den sich so jemand wie ich zusammengebastelt hat, sondern die z.B. ein Teil vom offiziellen Debian sind?
>
> Leute, ich denke hier immer grundsätzlich an Dinge wie eine Offline Lab Situation,
> also die vollständige(!) Mitnahme eines Repos per USB-Stick etc.

Folgendes schrieb ich dazu in mein README hier, inzwischen habe ich das durch einen Link auf diese Seite ersetzt:

-----------------

Kann mich bitte mal jemand aufklären, wie man den GitHub-Editor korrekt anwenden kann?  Danke!  
Denn wenn obiges einen Fehler angezeigt, dann habe ich es mal wieder gehörig verbockt, vermutlich dank dieses Editors!

Statt meine unermüdliche Faulheit zu überwinden habe ich dann wahrscheinlich den GitHub-Editor verwendet,
und dabei mal wieder eine der unendlichsten aller Dummheiten begangen:

Nämlich in dem Editor eine Grafik per Copy&amp;Paste hochzuladen!

Das landet dann nicht in der Git-Historie, sondern irgendwo außerhalb meines Begreifens!

> Ich weiß selbstredend, was GitHub-Assets sind, denn ich würde diesen Schlonz gerne global sperren!
>
> Dass ich das weiß ändert aber kein Stück an meiner Meinung.
> Im Gegenteil, es verhärtet meinen Standpunkt auf unveränderlich!
> GitHub heißt nun einmal GitHub und nicht AssetHub.
>
> Aber selbst wenn, würde ich immer noch erwarten, dass hinter den Assets eine komplette Versionskontrolle steckt.
> Wir sind schließlich nicht mehr im Mittelalter sondern schreiben schon das 3. Jahrtausend.
> Nur scheinen da halt noch nicht alle angekommen zu sein.
>
> (FWIW [nutze ich Versionskontrolle schon länger als es Linux gibt](https://www.ibiblio.org/pub/Linux/apps/graphics/capture/ppic0.5.lsm))

-----------------

Übrigens scheint es da verschiedene Varianten zu geben.  Mein [erster Ansatz war ein `grep` nach `/hilbix/tino/assets/`](https://github.com/hilbix/tino/blob/adbbecb275bc60d3b76f87bc8b12a499a798ef4d/.cirrus.yml), aber anscheinend ist das inzwischen geändert worden zu `/user-attachments/assets/`

### StackOverflow

Da gibt es auch eine (demnächst wohl geschlossene) [Frage auf StackOverflow](https://stackoverflow.com/a/33215776/490291) wie man Assets wieder loswird.

Antwort:  Geht.Net.  Man hat schlicht keinen Zugriff darauf und keinerlei Kontrolle über diese Assets!

Ein Kommentar fasst das IMHO ziemlich gut zusammen:

> This is the greatest free image hosting service I've seen. Unlimited quota for everything you need!

Dem kann ich nicht viel hinzufügen, außer das, was ein anderer zu Bedenken gibt:

> I'm wondering how both GitHub and GitLab are getting away with this in 2019, since GDPR is a thing... 

Allerdings trifft das IMHO weniger, denn wenn eine entsprechende Anfrage bei GitHub aufschlägt wird GitHub/Microsoft wohl das Richtige tun.

Die Frage, die sich mir stellt ist aber, warum bürdet sich Microsoft dieses Problem eigentlich auf?

Man kann da also wunderprächtig Binary-Blobs hochladen soviel man will und somit GitHub als Data-Exchange-Node verwenden.
Wenn die Daten mit einem guten One-Time-Password (AES256) verschlüsselt sind, wer kann die entschlüsseln?

Und was mich noch viel stärker wundert ist, dass das Zeug nicht auf Azure sondern auf Amamzon gehostet wird:

Ein `curl` auf eines meiner Assets ergibt (das URL ist so seltsam geschrieben damit mein [checker script](../../.cirrus.yml) nicht anschlägt:

```
curl -s -D- 'https://github.com/user-attachments/ass''ets/14f72c9f-6f5d-4162-b53c-662e350b9286' | grep ^location
location: https://github-production-user-asset-6210df.s3.amazonaws.com/994093/362249671-14f72c9f-6f5d-4162-b53c-662e350b9286.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20240828%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240828T130504Z&X-Amz-Expires=300&X-Amz-Signature=6bc5df04d30b8e8bd2a261431d65f42a2ad07d550e69212e056815a5c1f10af7&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=90519800
```

> Keine Panik!  Auch wenn da irgenwelche Credentials drinnenstecken, das habe ich anonym per `curl -D` abgerufen.


## Versuch einer semiautomatischen Reparatur

Akut [baue ich mir ein Script](https://github.com/hilbix/tino/blob/master/.x), welches das Problem hoffentlich semiautomatisch lösen kann.  Die Idee ist wie folgt:

- Es werden alle Links zu Assets außerhelb des Repos gesucht
- Sie werden in ein Unterverzeichnis geladen
- Dann werden die Links korrigiert damit sie auf diese lokalen Dateien verweisen

Das kann ich dann manuell überprüfen und committen.

Vermutlich kann man das dann auch irgendwie in eine GitHub-Action ummünzen.
Hat bei mir aber vorerst noch ein Geschmäckle, weil dann ein CI Vollzugriff auf das Repo nehmen kann.

Und wir wissen ja "[To err is human; To really foul things up requires a computer](https://quoteinvestigator.com/2010/12/07/foul-computer/)" ([Backup](https://github.com/user-attachments/files/16796295/To.Err.is.Human.To.Really.Foul.Things.Up.Requires.a.Computer.Quote.Investigator.pdf))

> Warum dieser Backup hier?  Weil ich keine Zeit habe, gebrochenen Links nachzugehe und [QI die WayBack verbietet](https://web.archive.org/web/20240000000000*/https://quoteinvestigator.com/2010/12/07/foul-computer/).  Es ist ein Oxymoron, Informationen zu verbreiten und zeitgleich deren Verbreitung zu verbieten.  Das PDF ist ein Ausdruck der Darstellung meines Browsers mit einem ordentlichen Verweis auf deren Original.  Was für wissenschaftliche Arbeiten gilt (bei diesen muss man eine zitatfähige Referenz beilegen, bei Webseiten bedeutet das eine Kopie), muss auch für den Bereich der freien Meinungsäußerung gelten.  Ohne verfügbare Quellen zitieren zu dürfen (ich zitiere ja nur einen Ausschnitt von denen) ist ein ordentlicher demokratischer Diskurs IMHO unmöglich, insbesondere da man sonst ja nicht sehen kann, worauf ich mich wirklich beziehe (da alles im Internet einem stetigen Wandel unterliegt).  Deshalb ist auch gerade der exakte Point-In-Time wichtig.  Ergo der Backup.  Und warum verwende ich QI?  Weil ich etwas gegen Fake-News habe!  Dies war die bisher beste Quelle die ich finden konnte und die mir gerade sinnvoll erscheint.  YMMV, aber ich jedenfalls habe dieses Zitat bisher immer [OEDO 808](https://www.imdb.com/title/tt0220218/) zugeordnet (dort habe ich es das erste Mal gehört), was offensichtlich aber eben nicht die Quelle zu sein scheint.

Der Backup (ich habe ihn per Drag-and-Drop hochgeladen während ich das hier schreibe) ist ein guter Crash-Test-Dummy für mein Repairscript.

Da es sich um kein Image handelt, muss ich mir einen gangbaren Automatismus überlegen,
wie und wohin ich die Assets automatisch ablege.  Folgende Varianten kommen mir in den Sinn:

- `/assets/` in der Root vom Repo.
  - Finde ich schlecht, es ist schwer darauf relativ zu linken
- `./assets/` im jeweiligen Verzeichnis
  - Finde ich irgendwie doof
- `./.assets/` im jeweiligen Verzeichnis
  - Finde ich irgendwie noch schlimmer
  - Ja, Windows unterstützt das irgendwie inzwischen, aber trotzdem finde ich das schlecht
- `./img/` und es wird auch für anderes verwendet
  - Ein wirklich schlechter Kompromiss, aber wäre kompatibel zu dem, was ich bereits habe

Wir werden sehen, wo ich am Ende lande.  Vermutlich kann mich nichts vollumfänglich zufriedenstellen ..


### Anmerkung

Ich kenne die Actions noch nicht gut genug.

Sofern die sowieso Vollzugriff haben und keinen gesonderten Deployment-Key benötigen, wäre es mir egal, ob der Fix bei GitHub abläuft oder bei mir lokal.  Die Action hätte den Vorteil, dass es sich dann selbsttätig vollautomatisch repariert.
>
> Da ich aber derzeit noch mit diesen Actions nicht umgehen kann - ich bin bisher am Versuch gescheitert, die Doku von GitHub zu verstehen - bastle ich das erst einmal lokal.  Dann sehen wir weiter.
>
> Ggf. kann ich mir außerdem auch einen eigenen Hook basteln, der das Repo repariert.  Also etwas, das weder auf CirrusCI noch Actions abläuft, denn ein Automat bekommt von mir aus Prinzip keinen direkten Vollzugriff auf die Repos.
>
> - Wenn die GitHub Actions von Haus aus uneingeschränkt sind, brauchen sie ja keine zusätzlichen Zugriff.
> - Und mit PRs habe ich auch keinerlei Thema.
>   - Mir ist nur (bisher) nicht klar, wie man das ohne einen [(verbotenen) zweiten Account bei GitHub](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service#b-account-terms)) realisieren kann.
>   - Vielleicht können GitHub-Actions das ja irgendwie.
>   - Vielleicht kann man Deployment-Keys ja irgendwie auf einen speziellen Branch einschränken, so dass sie nur PRs machen können
> - Ich habe bisher schlicht keine Ahnung, wie sich GitHub das ohne Zweitaccount vorstellt.

