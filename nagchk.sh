#! /bin/sh
 if [ -x /usr/local/nagios/bin/nagios ] && [ -r /usr/local/nagios/etc/nagios.cfg ]; then
	/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
	else
	echo "You do not have execute permisions on nagios or readable access to the nagios.cfg, you need to be in group nagios, you are `id`"
fi
