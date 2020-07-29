This is about the [Debian version of minica](https://github.com/paultag/minica) (Apache License),
not the [first hit on GitHub](https://github.com/jsha/minica) (MIT license).

# MiniCA

Lacking documentation of MiniCA?  Here is a short HowTo.

    apt install minica

Then

    mkdir myca
    cd myca
    minica server.example.com
    minica client@host.example.com
    ls -al

Gives

    -rw-rw-r--   1 tino tino  1074 Jul 29 13:23 cacert.crt
    -rw-------   1 tino tino  1675 Jul 29 13:23 cakey.key
    -rw-rw-r--   1 tino tino  1143 Jul 29 13:24 client@host.example.com.crt
    -rw-------   1 tino tino  1679 Jul 29 13:24 client@host.example.com.key
    -rw-rw-r--   1 tino tino  1192 Jul 29 13:23 server.example.com.crt
    -rw-------   1 tino tino  1679 Jul 29 13:23 server.example.com.key

Then

    cat      server.example.com.crt      server.example.com.key > server.pem
    cat client@host.example.com.crt client@host.example.com.key > client.pem
    
Copy `cacert.crt` along with `server.pem`/`client.pem` to your machines.

[Properly done](haproxy.md) these will mutually verify each other based on `cacert.crt`.

That's usually everything you need to get started quickly.


## About

MiniCA has options.  Forget them.  Just stick to a hostname for server certificates and something looking like an eMail address (with a `@`) for client ones.
Then you have to think about nothing.

> MiniCA is very well done.  It does one thing and, AFAICS, does it right as of today.

```
openssl x509 -in cacert.crt -text
```
```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            7e:31:69:56:c3:dd:d4:39:79:a0:b1:fe:9f:f9:e5:84
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: O = Example Organization
        Validity
            Not Before: Jul 29 11:18:00 2020 GMT
            Not After : Jul 14 11:18:00 2023 GMT
        Subject: O = Example Organization
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
[..]
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Key Agreement, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
    Signature Algorithm: sha256WithRSAEncryption
[..]
```
```
openssl x509 -in server.example.com.crt -text
```
```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            fc:8f:16:04:46:41:2f:c3:e2:6f:b5:88:8d:50:ec:6c
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: O = Example Organization
        Validity
            Not Before: Jul 29 11:18:00 2020 GMT
            Not After : Jul 14 11:18:00 2023 GMT
        Subject: O = Example Organization, CN = server.example.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
[..]
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Key Agreement
            X509v3 Extended Key Usage: 
                TLS Web Client Authentication, TLS Web Server Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Alternative Name: 
                DNS:server.example.com
    Signature Algorithm: sha256WithRSAEncryption
[..]
```

> Lifetime of a bit more than 2 years is hardcoded on MiniCA!

Do you think RSA 2048 is insecure?  Well, [actually no](https://www.keylength.com/en/4/)?

- RSA 1024 is equivalent to 80 bits of security.  This is no more enough today.  Do not use.
- RSA 2048 is equivalent to 112 bits of security.  This is enough today and will be enough at least until 2030.
- RSA 3072 is equivalent to 128 bits of security but takes DOUBLE the time of RSA 2048.  128 bit is taken as enough even for the forseeable future.
- RSA 7680 is equivalent to 192 bits of security, but is 50 times slower than RSA 2048.  Note that 192 bits probably is enough.

But my predicition is that RSA is probably broken much faster than 128 bits of security is reached.  Hence 4096 bits buys you no more security than 2048 today.
Hence MiniCA does it right.  BUT BEWARE, I AM NOT A CIPHERPUNK.

But if you extend the lifetime beyond 10 years, you should go for 3072 bits of RSA.  Or ECC (but AFAICS this is not supported by MiniCA).


## When to use MiniCA?

> This is my recommendation, not a clarification.  I am not liable if things break!

- For development
- In your middleware which is not exposed to the public.
  - That can mean you have some open port which is exposed to the public but secured with some SSL using MiniCA.

## When not MiniCA?

- B2C.  If you do B2C, use something more reasonable.
- Highly secure applications

## What is missing

Well, a good recommended SSL CA setup is:

- Main CA Certificate (long term, Key is air-gapped or better in a real Safe)
- Chain Certificate (mid term, Key lies on heavily secured server for signing purpose)
- Client and Server Certificates (short term, Key must be considered unsecured)

MiniCA does not offer this.  It is not meant to.


## Double Key with Double rotation

My recommendation is not to just update the CERTs, do a full key rotation.

- MiniCA should bot be used in a public facing production frontend.  Because there you need a proper CA setup.
- In your infrastructure, you usually have clients and servers under full control, so you can do a full key rotation.

That means:

- Completely re-create the CA from scratch and deploy everyting, so a fresh `cacert.crt`, `*.key` and `*.crt`.
- Perhaps have a fallback setup, such that the client and server can talk to the prevous keys in prallel.
  - Then double the replacement schedule

Shit happens!  Hence think of following:

- If you cannot make sure that things work out really, use a very long lifetime of the keys.  10 years or more.
- But beware the Y2038 problem - perhaps do not extend the lifetime until 2038 today.
- Always use a fallback scenario.  That is, have 2 sets of keys ready which both work.
  - Then you can replace one of you like.

Note that HaProxy makes it easy to do so.  You can use 2 server listeners with 2 separate certificates and give clients 2 certificates to the 2 different links each (this makes 2 `bind` lines and 4 `server` lines).

Then deploy first client/server pair.  This can be asynchronous on both sides.

When things have stabilized, deploy the other pair.

This is 0 downtime and 0 issue.

## Automate!

Compare LetysEncrypt, this process should be automated and run each 2-3 months.

Why?

- Because this is often enough so that it does not erode away too long.
- Also this urges you to implement some neccessary monitoring.
- With nearly 3 years you should have enough time to fix automation if something breaks the rotation schedule.

> I currently have not set up such an automation yet.
