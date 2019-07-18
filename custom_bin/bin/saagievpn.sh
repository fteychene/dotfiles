#!/bin/env bash


function start {
	systemctl --user start ikevpn@saagie
	journalctl --user -f  -u ikevpn@saagie
}

function stop {
	systemctl --user stop ikevpn@saagie
}

function restart {
	stop
	sleep 3
	start
}

function usage {
	echo "Usage: $0 start/stop/restart"
	exhit 1
}

case $1 in
	"start" ) start ;;
	"stop" ) stop ;;
	"restart" ) restart ;;
	* ) usage ;;
esac



