# GitHub

Ich habe so meine Probleme mit GitHub ..

## Gefährliche GitHub-Assets

Da gibt es eine (demnächst wohl geschlossene) [Frage auf StackOverflow](https://stackoverflow.com/a/33215776/490291) wie man Assets wieder loswird.

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

T.B.D.
