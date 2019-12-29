#! /bin/sh
#set -x
email=sean.shilton@hackensackmeridian.org,sshilton@outlook.com
#email=sshilton@outlook.com
alerts="/tmp/alerts.html"
avail="/tmp/avail.html"
wget -q  --user=epic --password=epic -O $avail "http://genpurpose.ddns.net/cgi-bin/icinga/avail.cgi?show_log_entries=&hostgroup=HMHN&timeperiod=last24hours&smon=12&sday=1&syear=2019&shour=0&smin=0&ssec=0&emon=12&eday=28&eyear=2019&ehour=24&emin=0&esec=0&rpttimeperiod=&assumeinitialstates=yes&assumestateretention=yes&assumestatesduringnotrunning=yes&includesoftstates=no&initialassumedhoststate=0&initialassumedservicestate=0&backtrack=4&content_type=html"

wget -q --user=epic --password=epic -O $alerts "http://genpurpose.ddns.net/cgi-bin/icinga/summary.cgi?report=1&displaytype=3&timeperiod=last24hours&hostgroup=HMHN&servicegroup=all&host=all&alerttypes=3&statetypes=3&hoststates=7&servicestates=120&limit=25http://genpurpose.ddns.net/cgi-bin/icinga/summary.cgi?report=1&displaytype=3&timeperiod=last24hours&hostgroup=HMHN&servicegroup=all&host=all&alerttypes=3&statetypes=3&hoststates=7&servicestates=120&limit=25"

cat $avail >> $alerts

mail -a 'Content-Type: text/html' -s "Last 24 Hour Top Alerters & Availibilty Report" $email <$alerts


