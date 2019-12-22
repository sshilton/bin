#! /bin/sh
# set -x
## sshilton@outlook.com for mindjet April 4th
if [ $# -eq 0 ];then
	echo "Usage $0 <process to check>"
	exit 3
fi
string=$1
output=`ps -ef | grep "$string"  | grep -v grep  | grep -v "/bin/sh" | awk '{print $8}' | head -n 1`
#echo "$output"
if  [  "$output"  == "" ];then
	echo "Critical, we searched for $string and it is not running, the output was $output"
	exit 2
	else	
	echo "OK: $string is running as $output"
	exit 0
fi
