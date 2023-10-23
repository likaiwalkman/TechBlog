### 下载安装软件无法打开 
- 下载安装软件后提示: 无法打开“XXX”，因为无法验证开发者。macOS无法验证此App不包含恶意软件。
解决办法:
```shell
sudo spctl --master-disable

xattr -r -d com.apple.quarantine <your_app_path>
#<your_app_path>是指你下载的应用程序的路径，一般在/Applications/应用程序名字
```

- 然后重新运行下载的应用程序。
                