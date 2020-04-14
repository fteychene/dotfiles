#!/bin/bash
#Grepping out the PID of spotify
spotifyid=$(ps -ef | grep '[/]opt/spotify/spotify' | awk '{print $2}' | head -1)

#echo $spotifyid;

#If no PID is found, exit with the warning.
if [ -z "$spotifyid" ]; then
	echo 'Spotify not running! PID not found.';
	exit 1;
fi;

#Trapping CTRL+C
onexit()
{
	rm -f /tmp/currentsong.txt;
	echo 'OK, exiting and deleting Songfile!';
	exit 1;
}
trap onexit SIGINT;

echo -e 'SpotCurrent v1.0.1 by flymia\n';

#User enters the desired interval
#echo -n 'Enter your preferred check-interval (Press ENTER for default 5 seconds): ';

#read interval;

if [[ -n ${interval//[0-9]/} ]]; then
	echo "Contains letters! Exiting..."
	exit 1;
fi

#If nothing was read, using the default interval;
if [ -z "$interval" ]; then
	interval=5;
fi

#If another instance is running, exit.
if [ -e /tmp/currentsong.txt ]
	then
		echo 'Another instance is running! Exiting!';
		exit 1;
	else
		echo 'To abort press CTRL+C';		
		echo -e 'Starting song check...\n';
		#Create the currentsong file
		touch /tmp/currentsong.txt
		
		#Main loop of the script
		while true; do
			#Get the current song by listing all windows and grepping the matching window with the PID
			currentsong=$(wmctrl -l -p | grep $spotifyid | sed -n 's/.*'$HOSTNAME'//p');
			
			if [ "$(echo $currentsong)" == 'Spotify Premium' ]; then
					currentsong=' ';
			fi
			
			echo -n 'Current song: ';
			echo $currentsong;
			echo -n "$currentsong" > /tmp/currentsong.txt
			sleep $interval;
		done
		echo 'Exiting and deleting songfile';
		rm -f /tmp/currentsong.txt
		exit 0;
fi
