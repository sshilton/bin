#! /bin/sh
set -x
ip=$1
hostnumber=$2
cat /usr/local/nagios/etc/hosts/usscesx05.cfg | sed 's/128/"$ip"/g' > usscesx"$hostnumber".cfg
cat /usr/local/nagios/etc/hosts/usscesx"$hostnumber".cfg | sed 's/05/"$hostnumber"/g' > ussxesx"$hostnumber".cfg
cat /usr/local/nagios/etc/hosts/usscesx"$hostnumber".cfg
