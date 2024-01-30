### show java cert keystore all certs.
```shell
#password: changeit
keytool -v -list -keystore $JAVA_HOME/jre/lib/security/cacerts #or
keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts

#for example: keytool -v -list -keystore $JAVA_HOME/jre/lib/security/cacerts
```

```shell
openssl x509 -inform PEM -in /Users/victor/Downloads/rootCA.crt -outform DER -out /Users/victor/Downloads/rootCA.cer
keytool -import -trustcacerts -alias LightProxyCA -file /Users/victor/Downloads/rootCA.cer -keystore $JAVA_HOME/jre/lib/security/cacerts
```
