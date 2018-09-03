#! /bin/sh
# script to "auto add" nagios hosts in a barebones config (ping at least)
# sshilton@actiance.com 07-23-2013
# uncomment to debug
set -x
number=$1
network=$2
while [ i < $number ];do
	echo $i
	ip="$network"."$i"
	result=`ping -n 2 $ip`
	if [ "$result" == "" ];then
		echo 'do nothing for "$network"."$i"'
	else
	# get the name
		name=`nslookup $ip | grep name | awk '{print $4}'
		echo "define host{" > "$path"/"$name"."cfg"	
		echo "use 	generic-host" >> "$path"/"$name"."cfg"
		echo "host name		$name" >> "$path"/"$name"."cfg"
		echo "alias		$name" >> "$path"/"$name"."cfg"
		echo "address		$ip" >> "$path"/"$name"."cfg"
		echo "}" >> "$path"/"$name"."cfg"
	fi
number=$number - 1
done

