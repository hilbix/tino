# Gerade unter https://support.google.com/mail/?p=IPv6AuthError als Feedback gepostet

> So verarbeite ich Frust.  Und nein, ich überlege mir kein Stück, was ich da fasle.  Wozu auch?  In Deutschland herrscht Meinungsfreiheit!

Das was hier steht ((Anmerkung: Gemeint ist, was unter https://support.google.com/mail/?p=IPv6AuthError zu sehen ist)) erklärt nicht, warum beim Testen bereits die 1. Mail(!) mit IPv6-Transport mit https://support.google.com/mail/?p=IPv6AuthError abgelehnt wird.

Das System hat 16h davor eine Nachricht an 2 Googlemailaccounts geschickt, dann 1 Testnachricht von mir an meinen Account, dann 150s später eine 2 Testnachricht von mir an meinen Account -> Die wurde geblockt.  Unter "Massenmails" dürfte das wohl eher nicht fallen .. (Evtl. ist ja die Kategorie dieser Seite falsch und das ist ein IPv6-Ding und hat nix mit Massenmails zu tun.  Dann sollte das aber uach nicht unter Massenmails stehen!)

Message-IDs:

    20180719023010.0424C6339F@subproject.org -> OK (v6)
    20180719193244.16F6C6339F@subproject.org -> OK (v4)
    20180719193518.3203C6339F@subproject.org -> Block (v6)
    20180719194318.771E3633A5@subproject.org -> OK (v4)

Irgendwie kein Wunder warum IPv6 nicht so recht auf die Reihe kommt, wenn die MTAs anfangen, Mails zurückzuweisen, nur weil sie per IPv6 verschickt werden und da irgendetwas im DNS durcheinanderkam - dieses Blocken geschieht aus überhaupt keinem guten Grund!  -> Aber die Lösung ist ja einfach:  So lange bei IPv4 bleiben, wie es nur geht, weil da bleibt man vor solchen Nebenstörungen ja glücklicherweise verschont.

Äh .. ehrlich?  Wollen wir das?  Wollen wir das wirklich?  Wenn nicht, warum sorgt Google dann dafür, dass für IPv6 komplexere Regeln gelten als für IPv4?

Das ist ja gerade so wie bei Crypto.  Cryptonerds meinen "Hey, SSLv3 ist schlecht, also raus damit aus dem Browser".  Bei den Leuten kommt dann an: "Mist, der Browser tut nimmer mit meiner WLAN-Glühbirne" (weil die noch kein TLS kann).  Und das Resultat?  Nö, die werfen die Glühbirne nicht weg.  Und nö, sie denken nicht "oh, ich muss etwas ändern", die denken nur "Scheiß Browser!".  Die Leute bleiben also entweder beim veralteten Browser (und fangen sich Würmer ein, dafür sind sie NATÜRLICH NICHT Schuld, sie wurden ja gezwungen) oder sie schalten die Verschlüsselung ganz ab und surfen fürderhin komplett ohne Crypto zu ihrer Birne - Problem solved.  ==> Und das alles nur wegen ein paar Idioten (die, die ich Crypto-Nazis nenne, weil sie unwerte Algorithmen das Recht auf Leben aberkennen - die Parallelen halte ich NICHT für zufällig - '33 ist nimmer weit, davor warne ich schon seit über 10 Jahren).

Irgendwelche Fragen, warum Crypto bisher nie eine Chance hatte und ebenso weiterhin keine Chancen haben wird?  Weil man müsste mal aufhören, die Nutzer zu gängeln.  Aber dafür interessiert sich ja absolut niemand.

Wundert IRGENDWEN tatsächlich, warum Innovation auf so vielen Gebieten keine Chance hat und z. B. einge größere ISPs immer noch bestehen können, obwohl es dort immer noch keine einzige IPv6 gibt?

Ach ja, ich habe mal vor, bei einem IPv6-Spielsystem die IP an die Jiffies zu koppeln (sobald ich den Reverse delegiert bekomme).  Jede Millisekunde wird dann die IP gewechselt (da System kann ja, transparent, alle IPs gleichzeitig verwenden, 0 Problemo).  Einfach weil man das - dank IPv6 - kann und soetwas sau viel Spaß macht.

Klar doch, der Reverse wird dann eingerichtet sein.

(Nebenbei:  Damit kann man eine B32-Adresse von I2P oder eine .onion-Adresse vielleicht einfach in das System direkt transparent mappen.  Nur so ein Gedanke.)

Aber wie geht das jetzt mit dem Forward?  Ich denke nicht, dass irgendwelche Resolver glücklich werden, wenn ich denen die IPs, der letzten, sagen wir mal, 30 Minuten mitteile.  Das sind ja nur knapp 2 Mio IPs oder knapp eine Query-Response von 40 MB.

Super Idee diese Vorwärtsauflösung mit dem MTA zu verlangen, wirklich.  Wie glücklich ist wohl der Google-MTA, wenn er die 40 MB-Answer verarbeiten muss um die richtige IP rauszufischen?

Und ganz besonders gut kommt das dann mit DNSSEC ;)

Leute, leute, leute, was ist das für ein Quatsch den ihr da treibt?  Für mich ist das Internet seit über 30 Jahren eine akademische Spielwiese und wird es bis zu meinem Tode so bleiben.  Nur so macht's Spaß!

Aber der Spaß hört spätestens dann auf, wenn Google der Wissenschaft schadet, indem alles Mögliche aus irgendwelchen nicht mehr nachvollziehbaren Gründen (weil sie die technische Entwicklung abwürgen) torpediert wird.  Und ja, die Probleme bei Mails liegen daran, dass SMTP ein AKADEMISCHES Protokoll ist, und die kommerziellen Firmen versäumt haben, etwas eigenes, sinnvolles zu entwickeln.  Das ist aber kein Fehler von SMTP und darf auch kein Fehler der Forschung sein, sondern ist halt ein "Selber Schuld" weil die Firmen einfach zu stinkfaul waren es selbst richtig zu machen.

Nur so nebenbei:

Dieses Blocken trifft vor allem die Spammer NICHT.  Deren MTAs verwenden vermutlich bereits Milliarden IPs, aber alle sind brav perfekt gemäß der IPv6-Regeln von Google aufgesetzt.  Wäre ja noch schöner wenn die ihren SPAM nicht loskriegen.  Dagegen gehen aber Milliarden legitime Mails verloren.  Aber Hauptsache der Spam wird nicht geblockt, weil genau so eine Maßnahme eben nicht greift.

TL;DR

Leute, hört bitte mit dem Blocken auf.  Packt empfangene Mails meinetwegen in SPAM (dann kann ich mit der "Kein SPAM"-Regel das korrigieren).  Aber hört bitte mit dem Blocken auf.  Das nervt nicht nur, das ist technisches Bullshit-Bingo auf der geistig niedrigsten Stufe, da es den Spammer so gut wie nicht schadet, aber allen anderen sehr deutlich.

HTH
-Tino
