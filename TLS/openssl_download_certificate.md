openssl download certificate:
```shell
openssl s_client -connect baidu.com:443 2>&1 |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
```
