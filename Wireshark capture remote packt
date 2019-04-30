On Linux and OSX you can achieve this by running tcpdump over ssh and having wireshark listen on the pipe.

Create a named pipe:

$ mkfifo /tmp/remote

Start wireshark from the command line

$ wireshark -k -i /tmp/remote

Run tcpdump over ssh on your remote machine and redirect the packets to the named pipe:

$ ssh root@firewall "tcpdump -s 0 -U -n -w - -i eth0 not port 22" > /tmp/remote


#to avoid sudo input password, follow below steps:
echo password | sudo -S your_command

