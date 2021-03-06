开发过程中经常可能遇到网络问题，这时候我们需要抓包来定位问题所在。那么如何用 Wireshark 抓取 iPhone 真机网络请求的数据包呢？
  ```xml
  iOS does not support packet tracing directly. However, if you’re developing for iOS you can take a packet trace of 
  your app in a number of different ways:

  If the problem you’re trying to debug occurs on Wi-Fi, you can put your iOS device on a test Wi-Fi network. 
See Wi-Fi Capture for details.
  If your app uses HTTP, you can configure your iOS device to use a debugging HTTP proxy (such as Charles HTTP Proxy).
  In iOS 5 and later you can use the remote virtual interface facility.
  ```
  
  这里我使用的是第三种方法：remote virtual interface。

iOS 5 added a remote virtual interface (RVI) facility that lets you use OS X packet trace programs to capture traces from an iOS device. The basic strategy is:

1、Connect your iOS device to your Mac via USB.
2、Set up an RVI for that device. This creates a virtual network interface on your Mac that represents the iOS device’s networking stack.
3、Run your OS X packet trace program, and point it at the RVI created in the previous step.

```xml
$ # First get the current list of interfaces.
$ ifconfig -l
lo0 gif0 stf0 en0 en1 p2p0 fw0 ppp0 utun0
$ # Get connected device's UDID follow: Xcode > Window > Devices > Select connected device > identifier
$ # Then run the tool with the UDID of the device.
$ rvictl -s 74bd53c647548234ddcef0ee3abee616005051ed
 
Starting device 74bd53c647548234ddcef0ee3abee616005051ed [SUCCEEDED]
 
$ # Get the list of interfaces again, and you can see the new virtual
$ # network interface, rvi0, added by the previous command.
$ ifconfig -l
lo0 gif0 stf0 en0 en1 p2p0 fw0 ppp0 utun0 rvi0
```


打开 Wireshark, 选择 rvi0 作为待抓包的接口。

Reference
Getting a Packet Trace:<br/>
https://developer.apple.com/documentation/network/recording_a_packet_trace<br/>
Capturing mobile phone traffic on wireshark:<br/>
https://stackoverflow.com/questions/9555403/capturing-mobile-phone-traffic-on-wireshark
