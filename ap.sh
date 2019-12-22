#! /bin/sh
set -x
host=$1
parent=$2
host="$host".cfg
if [ $# -ne 2 ];then
	echo "Usage: $0 <host> <parent>"
else
	cd /usr/local/nagios/etc/hosts/
	if [ -w "$host" ];then
		cat "$host" | sed 's/}//g' >> /tmp/"$host".new
		echo "		parents		$parent" >> /tmp/"$host".new
		echo "}" >> /tmp/"$host".new
		mv /tmp/"$host".new /usr/local/nagios/etc/hosts/"$host"
		cat /usr/local/nagios/etc/hosts/"$host"
	else
		echo "You are $USER, and do not have write permission for the file"
	fi
fi


	
