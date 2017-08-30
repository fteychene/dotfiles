#!/bin/env bash

start() {
systemctl start openvpn-client@production.aws.service

if [ $? -ne 0 ]; then
	echo "Error on VPN start"
	exit 128
fi

systemctl start dnsmasq

if [ $? -ne 0 ]; then
        echo "Error on Dnsmasq start"
        exit 128
fi


sed -i '1inameserver 127.0.0.1' /etc/resolv.conf

if [ $? -ne 0 ]; then
        echo "Error whle adding dnsmasq to resolv.con"
        exit 128
fi
}

stop() {
systemctl stop openvpn-client@production.aws.service

if [ $? -ne 0 ]; then
        echo "Error on VPN start"
        exit 128
fi

systemctl stop dnsmasq

if [ $? -ne 0 ]; then
        echo "Error on Dnsmasq start"
        exit 128
fi


sed -i '1d' /etc/resolv.conf

if [ $? -ne 0 ]; then
        echo "Error whle adding dnsmasq to resolv.con"
        exit 128
fi
}

usage() {
	echo "tabmo-vpn.sh <start|stop>"
	echo "..."
	echo .
}

COMMAND=$1
case $COMMAND in
	"start")
		start
		;;
	"stop")
		stop
		;;
	* )
		usage
		;;
esac

exit 0



