jpid=`jps | grep EchoServer`; jpid=`echo ${jpid% *}`
echo $jpid;
