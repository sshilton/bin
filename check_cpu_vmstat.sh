#! /bin/sh
#set -x

# Use vmstat to get cpu usage as IOSTAT might not be on all machines
vmstat=/usr/bin/vmstat
awk=/usr/bin/awk


print_help()
{
echo "Usage: $0 -w Warning_Threshold -c Critical_Threshold \n Note: An Idle of 0% is bad, 100% is good, remeber (seemingly) the dyslexic logic"
}




# Parse parameters

if [ $# -eq 0 ]; then
	print_help
	exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -h | --help)
            print_help
            exit 0
            ;;
        -w | --warning)
                shift
                warn=$1
                ;;
        -c | --critical)
               shift
                crit=$1
                ;;
        *)  echo "I passed $#: Usage: $0 -w warning -c critical"
            exit 0
            ;;
        esac
shift
done
if [ "$crit" -ge "$warn" ];then 
	echo "Error: critical threshold is set higher(idle) than the warning threshold: crit: $crit < warn: $warn"
	exit 3
fi	

if [ -x "$awk" ] &&  [ -x "$vmstat" ]; then  #we good to go 
	idle=`vmstat | awk '(NR==2){for(i=1;i<=NF;i++)if($i=="id"){getline; print $i}}' | tail -1`
	if [ "$idle" -gt "$warn" ] && [ "$idle" -gt "$crit" ]; then
		echo "OK: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%|idle=$idle"
		exit 0
	elif [ "$idle" -ge "$crit" ] && [ "$idle" -le "$warn" ]; then
		  echo "WARNING: CPU(s) is $idle% idle. This is lower then the warning threshold of $warn%.|idle=$idle"	
		exit 1
	elif [ "$idle" -le "$crit" ]; then
		  echo "CRITICAL: CPU(s) is $idle% idle. This is lower then the critacal threshold of $crit%|idle=$idle"		
		exit 2
	else
		  echo "UNKOWN: CPU(s) is $idle% idle. The warning threshold is $warn% critical threshold is $crit%"		
		exit 3
	fi
fi
