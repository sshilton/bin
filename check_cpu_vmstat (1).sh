#! /bin/sh
#set -x

# Use vmstat to get cpu usage as IOSTAT might not be on all machines
vmstat=/usr/bin/vmstat
awk=/usr/bin/awk
warn=$1
crit=$2

if [ $# -ne 2 ];then  # check for arguments
	echo "Usage:$0 <WARNING> <CRITICAL>, thresholds not setup properly"
	exit 3
fi

if [ "$crit" -le "$warn" ];then 
	echo "Error: critical threshold is set lower than the warning threshold: crit: $crit < warn: $warn"
	exit 3
fi	

if [ -x "$awk" ] &&  [ -x "$vmstat" ]; then  #we good to go 
	idle=`vmstat | awk '(NR==2){for(i=1;i<=NF;i++)if($i=="id"){getline; print $i}}' | tail -1`
	if [ "$idle" -ge "$warn" ]; then
		echo "OK: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%|idle=$idle"
		exit 0
	elif [ "$idle" -ge $warn ] || [ "$idle" -le "$crit" ]; then
		  echo "WARNING: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%|idle=$idle"	
		exit 1
	elif [ "$idle" -ge "$crit" ]; then
		  echo "CRITICAL: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%|idle=$idle"		
		exit 2
	else
		  echo "UNKOWN: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%"		
		exit 3
	fi
fi
