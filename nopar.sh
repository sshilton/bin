#! /bin/sh
#set -x
for i in *
	do
	string=`grep parents "$i" | awk '{print $1}'`
 	if [ "$string" != "parents" ]
	then
	echo "$i"
	fi
	
done
