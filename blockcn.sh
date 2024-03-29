#!/bin/bash
#! /etc/init.d/blockcn
#set -x
### BEGIN INIT INFO
# Provides:          blockcn
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Should-Start:      $network $named $syslog $time cpufrequtils
# Should-Stop:       $network $named $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: manage the blocking of china and russia
# Description:       blocking ru and china
#                    It is a small daemon which collects system information
#                    periodically and provides mechanisms to monitor and store
#                    the values in a variety of ways.
### END INIT INFO


# Purpose: Block all traffic from AFGHANISTAN (af) and CHINA (CN). Use ISO code. #
# See url for more info - http://www.cyberciti.biz/faq/?p=3402
# Author: nixCraft <www.cyberciti.biz> under GPL v.2.0+
# -------------------------------------------------------------------------------
ISO="af cn ru fr tw kr in zz" 
 
### Set PATH ###
tables=`which iptables`
IPT=$tables
WGET=/usr/bin/wget
EGREP=/bin/egrep
 
### No editing below ###
SPAMLIST="countrydrop"
UPDATEROOT="/home/sshilton/blocklist-ipsets/"
ZONEROOT="/home/sshilton/blocklist-ipsets/ip2location_country"
DLROOT="http://www.ipdeny.com/ipblocks/data/countries"
# updating the country zones
if [ ! -d $UPDATEROOT ]; then
	cd ~
	git clone https://github.com/firehol/blocklist-ipsets.git
fi

cd  $UPDATEROOT  # this gets the latest contry zones
git pull

case "$1" in
	start)
cleanOldRules(){
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT
}
 
# create a dir
#[ ! -d $ZONEROOT ] && /bin/mkdir -p $ZONEROOT
 
# clean old rules
cleanOldRules
 
# create a new iptables list
$IPT -N $SPAMLIST
 
for c  in $ISO
do 
	# local zone file
	tDB=$ZONEROOT/ip2location_country_$c.netset
	echo "$c"  
	# get fresh zone file
cd $ZONEROOT
git pull
	# country specific log message
	SPAMDROPMSG="$c Country Drop"
 
	# get 
	BADIPS=$(egrep -v "^#|^$" $tDB)
	for ipblock in $BADIPS
	do
	echo "$ipblock"	-- "$c"
	   sudo $IPT -w -A $SPAMLIST -s $ipblock -j LOG --log-prefix "$SPAMDROPMSG"
	  sudo  $IPT -w -A $SPAMLIST -s $ipblock -j DROP
	done
done
 
# Drop everything 
sudo $IPT -I INPUT -j $SPAMLIST
sudo $IPT -I OUTPUT -j $SPAMLIST
sudo $IPT -I FORWARD -j $SPAMLIST
 
# call your other iptable script
# /path/to/other/iptables.sh
	;;
stop)
echo "Flushing iptables and shutting down"
	sudo iptables -F
	;;
status)
sudo 	iptables -w -L -n | grep -v DROP
	;;
*)
	echo "Usage: $0 (start|stop|status)"
	;;
esac
exit 0
