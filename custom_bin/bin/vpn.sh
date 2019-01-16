#!/bin/env bash


function start_vpn {
	local CONNECTION_NAME=$1
	local TARGET_SERVER=$2
	echo "Start VPN connection to $CONNECTION_NAME"

	CONFIGURATION=$(awk -v pattern="conn $CONNECTION_NAME" '$0 ~ pattern {f=1; next} f==1&& /left=/ {print substr($1, 6) " " NR}' /etc/ipsec.conf)
	CONFIGURED_IP=$(echo $CONFIGURATION | cut -d' ' -f1)
	CONFIGURATION_LINE=$(echo $CONFIGURATION | cut -d' ' -f2)
	echo "Configured IP : $CONFIGURED_IP"
	read -p "Modify it ? [y/n] " modify

	[[ $modify =~ [Yy] ]] && $EDITOR +$CONFIGURATION_LINE /etc/ipsec.conf

	echo "Start services"
	systemctl start openswan
	sleep 2
	systemctl start xl2tpd

	echo "Start tunnel and authentification"
	ipsec auto --up $CONNECTION_NAME
	echo "c vpn-connection" > /var/run/xl2tpd/l2tp-control
	sleep 2

	DESTINATION_IP=$(ifconfig ppp0 | awk '/destination/{print $6}')
	if [ -z "$TARGET_SERVER" ]; then
		echo "Route traffic via $DESTINATION_IP"
		ip route add default via $DESTINATION_IP
	else
		echo "Add route for remote server $TARGET_SERVER via $DESTINATION_IP"
		ip route add $TARGET_SERVER via $DESTINATION_IP
	fi 
}

function stop_vpn {
	local CONNECTION_NAME=$1
	ipsec auto --down $CONNECTION_NAME
	systemctl stop xl2tpd
	systemctl stop openswan
}

usage(){
	echo "Usage: $0 -c connection-name [-t target server ]start/stop"
	exit 1
}

while [[ $# -gt 1 ]]; do
	key="$1"
	case $key in 
		-c|--connection)
		CONNECTION_NAME="$2"
		shift
		;;
		-t|--target)
		TARGET_SERVER="$2"
		shift
		;;
		*)
		;;
	esac
	shift
done

if [ $# -lt 1 ] || [ -z "$CONNECTION_NAME" ] ; then
	usage
fi


case $1 in
	"start" ) start_vpn $CONNECTION_NAME $TARGET_SERVER ;;
	"stop" ) stop_vpn $CONNECTION_NAME ;;
	* ) usage ;;
esac
