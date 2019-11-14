#! /bin/sh
set -x
country="fn"
count=`sudo iptables -L -nvx | grep "$country Country Drop" | wc -l`
echo $count
	if [ $count -gt 0 ];then
		echo "OK: iptables has $count rules for blocking $country"
		exit 0
	else
		echo "CRITICAL: iptables has $count rules for $country"
		exit 2
	fi

