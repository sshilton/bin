#! /bin/sh
# top stop server stop 
# set -x for debug
set -x
id=`id -u`
myid=`id`
if [ $id  -ne "0" ];
then
	echo "you are not root, sorry"
	echo "you are $myid"
else

/usr/bin/X11/google-earth
fi
