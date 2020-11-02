#! /bin/sh
#set -x
count=`sudo iptables -L -nvx | grep "cn Country Drop" | wc -l`
#echo $count
	if [ $count -gt 0 ];then
		echo "OK: iptables has $count rules for blocking China|china=$count"
		exit 0
	else
		echo "CRITICAL: iptables has $count rules for China"
		exit 2
	fi

