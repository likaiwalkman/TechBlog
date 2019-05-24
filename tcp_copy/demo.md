# 资源介绍

测试中用到的3台服务器信息如下：

分组名称  |  代号 |  内网IP |  外网IP
--|---|---|--
线上服务器online server   | centos1-IP|10.211.55.5/24  |214.167.0.8/28
测试服务器test server     | centos2-IP|10.211.55.6/24|214.167.0.13/28
辅助服务器assistant server| centos3-IP|10.211.55.7/24|214.167.1.76/24

```xml
10.211.55.5是线上服务器，10.211.55.6和10.211.55.7是测试环境
我们在10.211.55.5上运行tcpcopy把线上流量拷贝到10.211.55.6
在10.211.55.6上我们通过路由将应答转向10.211.55.7
在10.211.55.7上把应答丢弃
```

# 安装
## 在 online server centos1 上安装并运行tcpcopy daemon:
```shell
# 从github上下载1.0版本的源码包；
wget https://github.com/session-replay-tools/tcpcopy/archive/1.0.0.tar.gz -O tcpcopy-1.0.0.tar.gz
#安装依赖包；
yum -y install libpcap-devel
#解压编译和安装；
tar zxvf tcpcopy-1.0.0.tar.gz
cd tcpcopy-1.0.0
./configure （默认raw socket方式抓包）
make
make install

#最后运行 tcpcopy；
/usr/local/tcpcopy/sbin/tcpcopy -x 80-10.211.55.6:80 -s 10.211.55.7 -c 10.10.10.x -d -n 4 -l /tmp/tcpcopy.log  -P /tmp/tcpcopy.pid


#指令说明：
# -x 80-10.211.55.6:80将本机上80端口的流量复制到10.211.55.6（测试服务器）的80端口
# -s指定intercept进程所在的服务器10.211.55.7。（丢包服务器）
# -c修改请求的host地址为10.10.10.x，以便在230测试服务器上设置路由（设置路由是为了将应答转向#丢219包服务器）
# -n 拷贝4份流量
# -d 以daemon形式运行
# -l 记录日志
# -P 记录pid
# 其他参数可以通过/usr/local/tcpcopy/sbin/tcpcopy -h查看

```

 成功运行后可以观察到的网路连接状态：
```shell
#ss -an|grep 10.211.55.7
ESTAB      0      0                10.211.55.5:49034         10.211.55.7:36524
ESTAB      0      0                10.211.55.5:49035         10.211.55.7:36524
ESTAB      0      0                10.211.55.5:49032         10.211.55.7:36524
ESTAB      0      0                10.211.55.5:49033         10.211.55.7:36524
```
## 在assistant server centos3上安装并运行intercept daemon :
```shell
#从github上下载1.0版本的源码包；
wget https://github.com/session-replay-tools/intercept/archive/1.0.0.tar.gz -O intercept-1.0.0.tar.gz
#安装依赖包；
yum -y install libpcap-devel（CentOS6系统直接yum安装即可1.4版本）
#注意CentOS5系统libpcap-devel版本是libpcap-devel-0.9.4-15.el5，intercept-1.0需要libcap-devel1.4以上版本此时需要源码包安装
yum remove libpcap
wget http://www.tcpdump.org/release/libpcap-1.4.0.tar.gz
tar zxvf libpcap-1.4.0.tar.gz
cd libpcap-1.4.0
./configure
make
make install
#解压编译和安装；
tar zxvf intercept-1.0.0.tar.gz
cd intercept-1.0.0
./configure （默认raw socket方式抓包）
make && make install
#最后运行 intercept；
/usr/local/intercept/sbin/intercept -i eth0 -l intercept.log -P /tmp/intercept.pid -F 'tcp and src port 80' -d


# 指令说明：
# -i 监控网卡接口
# -l 记录日志
# -F 监控的协议和端口
# -P 记录pid
# -d 以daemon形式运行
# 其他参数可以通过/usr/local/intercept/sbin/intercept -h查看
```
成功运行后可以观察到的网路连接状态：
```shell
#ss -an |grep 36524

LISTEN     0      5                         *:36524                    *:*
ESTAB      0      66             10.211.55.7:36524           10.211.55.5:49034
ESTAB      0      0              10.211.55.7:36524           10.211.55.5:49035
ESTAB      0      66             10.211.55.7:36524           10.211.55.5:49032
ESTAB      0      0              10.211.55.7:36524           10.211.55.5:49033
```
## 在test server 10.211.55.6上设置一条路由 :
```shell
[root@bogon ~]# route add -net 10.10.10.0 netmask 255.255.255.0 gw 10.211.55.7
```
成功运行测试时可以观察到的网络连接状态：
```shell
# ss -an |head
State      Recv-Q Send-Q        Local Address:Port          Peer Address:Port
LISTEN     0      0                 127.0.0.1:199                      *:*
LISTEN     512    0                         *:80                       *:*
ESTAB   0      0              10.211.55.6:80           10.10.10.1:62602
ESTAB   0      0              10.211.55.6:80           10.10.10.4:54595
ESTAB   0      0              10.211.55.6:80           10.10.10.3:53566
ESTAB   0      0              10.211.55.6:80           10.10.10.6:49260
ESTAB   0      0              10.211.55.6:80           10.10.10.8:57598
ESTAB   0      0              10.211.55.6:80           10.10.10.7:64454
ESTAB   0      0              10.211.55.6:80           10.10.10.1:63081
```

#### 附录：
##### Centos7关闭防火墙
CentOS 7.0默认使用的是firewall作为防火墙
```shell
#查看防火墙状态
firewall-cmd --state
#停止firewall
systemctl stop firewalld.service
#禁止firewall开机启动
systemctl disable firewalld.service
```

#### 测试要保证assistant server关闭路由模式
```shell
#查看关闭与否： 为0表示没有开启
cat /proc/sys/net/ipv4/ip_forward
#一次性配置：
echo "0">/proc/sys/net/ipv4/ip_forward
#永久性配置：
将/etc/sysctl.conf里面的net.ipv4.ip_forward=1注释
sysctl -p 立即生效
```

```
参考链接：
http://blog.csdn.net/wangbin579/article/details/8949315
http://blog.csdn.net/wangbin579/article/details/8950282
```
