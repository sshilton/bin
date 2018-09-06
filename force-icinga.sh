#!/bin/sh
# Modified for Icinga sshilton 9/6/18

hostdir=/etc/icinga/objects
for i in  `ls $hostdir`
do
# check whether hostname has been specified
#if [[ -z $host ]]
#then
#        echo "Enter hostname!"
#        echo "Usage: $0 hostname"
#        exit 2
#fi

# epoch time
NOW=$(date +%s)

# the directory where service configuration files are kept
service_dir="/etc/icinga/objects"

# nagios command file (named pipe)
#cmd_file="/usr/local/nagios/var/rw/nagios.cmd"
cmd_file=/var/lib/icinga/rw/icinga.cmd

# check for existence of service configuration directory
if [[ ! -d $service_dir ]]
then
        echo "Service config directory (set to $service_dir) not found!"
        exit 2
# check for existence of service configuration file
elif [[ ! -e "$service_dir/$host.cfg" ]]
then
        echo "$service_dir/$host.cfg does not exist!"
        exit 2
fi

# check for existence of command file, the named pipe
if [[ ! -e $cmd_file ]]
then
        echo "Command file (set to $cmd_file) not found"
        exit 2
fi

grep -i 'service_description' $service_dir/$host.cfg | \
        sed -e 's/^\s*service_description\s*//g' > /tmp/$NOW

# to handle service names containting spaces, e.g. "Disk Monitor"
OLD_IFS=$IFS
IFS=$'\n'


# schedule an immediate host check
echo "Checking host => $host"
echo "[$NOW] SCHEDULE_HOST_CHECK;$host;$NOW" >> $cmd_file
sleep 1

# schedule service checks one by one
for i in $(cat /tmp/$NOW)
do
        echo "Checking service => $i"
        echo "[$NOW] SCHEDULE_SVC_CHECK;$host;$i;$NOW" >> $cmd_file
        # be nice to nagios :)
        # sleep 1 screw that :)
done

echo "Done!"

rm -f /tmp/$NOW

IFS=$OLD_IFS
done
exit 0
