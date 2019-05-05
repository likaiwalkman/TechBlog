##On Linux and OSX you can achieve this by running tcpdump over ssh and having wireshark listen on the pipe.

###1、Create a named pipe:
  ```shell
  $ mkfifo /tmp/remote
  ```

###2、Start wireshark from the command line
```shell
#$ wireshark -k -i /tmp/remote
```
###3、Run tcpdump over ssh on your remote machine and redirect the packets to the named pipe:
```shell
$ ssh root@firewall "tcpdump -s 0 -U -n -w - -i eth0 not port 22" > /tmp/remote
```

###Tips: to avoid sudo input password, follow below steps:
```shell
echo password | sudo -S your_command
```
