#! /bin/sh
# top stop server stop 
# set -x for debug
#set -x
id=`id -u`
myid=`id`
if [ $id -ne "0" ];
then
	echo "you are not root, sorry"
	echo "you are $myid"
else

/etc/init.d/apache2 start
echo $?
/etc/init.d/nagios3 start
echo $?
/etc/init.d/munin start
echo $?
/etc/init.d/munin-node start
echo $?
/etc/init.d/mysql start
echo $?
#/etc/init.d/jetty stop
fi


