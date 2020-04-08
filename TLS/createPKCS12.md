```shell
openssl pkcs12 -export -out keyStore.p12 -inkey key.crt -in merge-cert.crt
```
comments:
  key.crt——private key
  merge-cert.crt——certificate file(with public key)
In the process, a password is in need.
