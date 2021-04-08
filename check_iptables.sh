#! /bin/sh
#set -x
# Cheep iptables counter to see how my firewall is doing
country="$1"
# had to add 2>&1 | grep -v iptables-legacy for iptables being a twat and f*cking up the response from STDERR
count=`sudo -n iptables -L -n -w 2>&1 | grep -v iptables-legacy | grep "$country Country Drop" | wc -l`
#echo $count
	if [ $count -gt 0 ];then
		echo "OK: $count rules for blocking $country |$country=$count"
		exit 0
	else
		echo "CRITICAL: iptables has $count rules for $country|$country=$count"
		exit 2
	fi

