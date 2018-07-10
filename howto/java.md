# JAVA HowTo

## `java.security.InvalidKeyException: EC parameters error`

See https://docs.oracle.com/cd/E19830-01/819-4712/ablsc/index.html

    wget "https://bouncycastle.org/download/bcprov-ext-jdk15on-158.jar"
    readlink -e /usr/bin/java
    
Now copy it to your JAVA:

    cp bcprov-ext-jdk15on-158.jar /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/ext/
    
Afterwards edit your `java.security` file like this

    vim /etc/java-7-openjdk/security/java.security

Add `security.provider.2=org.bouncycastle.jce.provider.BouncyCastleProvider`

    security.provider.1=sun.security.provider.Sun
    security.provider.2=org.bouncycastle.jce.provider.BouncyCastleProvider
    security.provider.3=..REST..FOLLOWS..HERE..

Renumber all `security.provider`-Entries properly, else you will get into trouble.

Restart your JAVA application.

For the paranoid:

    md5sum bcprov-ext-jdk15on-158.jar; sha1sum bcprov-ext-jdk15on-158.jar
    a7cb0f2ae7767c26a17e8f70555af17f  bcprov-ext-jdk15on-158.jar
    083a9e739d9c718180ba544fe007a67ca3a61cad  bcprov-ext-jdk15on-158.jar

However, this was not enough at my side.  This still needs improvement, as this now changed to:

## `net.i2p.router.JobQueueRunner : Error processing job [Publish Local Router Info] on thread 3: Unknown EC type`

I really have no idea how to fix this
