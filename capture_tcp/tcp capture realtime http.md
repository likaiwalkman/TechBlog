### 查看HTTP GET请求 ###
```shell
tcpdump -s 0 -A 'tcp dst port 80 and tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420'
```
### 查看HTTP POST请求 ###
```shell
tcpdump -s 0 -A 'tcp dst port 80 and (tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354)'
```

### 命令行格式：###
tcpdump [ -adeflnNOpqStvx ] [ -c 数量 ] [ -F 文件名 ][ -i 网络接口 ] [ -r 文件名] [ -s snaplen ][ -T 类型 ] [ -w 文件名 ] [表达式 ]
#### 常用的参数：####
```plaintext
-l 使标准输出变为缓冲行形式；
-n 不把网络地址转换成名字；
-c 在收到指定的包的数目后，tcpdump就会停止；
-i 指定监听的网络接口；(如果没有指定可能在默认网卡上监听，需要指定绑定了特定IP的网卡)
-w 直接将包写入文件中，并不分析和打印出来；
-s 指定记录package的大小，常见 -s 0 ，代表最大值65535，一半linux传输最小单元MTU为1500，足够了
-X 直接输出package data数据，默认不设置，只能通过-w指定文件进行输出
```

#### 常用表达式：####
```plaintext
关于类型的关键字，主要包括host，net，port
传输方向的关键字，主要包括src , dst ,dst or src, dst and src
协议的关键字，主要包括fddi,ip ,arp,rarp,tcp,udp等类型
逻辑运算，取非运算是 'not ' '! ', 与运算是'and','&&';或运算 是'or' ,'||'
其他重要的关键字如下：gateway, broadcast,less,greater
```
