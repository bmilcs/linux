#!/bin/bash
#----  unifi firewall set: unifi  ----------------------------------------------------------------------

ports="3478/udp 5514/udp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 6789/tcp 27117/tcp 5656-5699/udp 10001/udp 1900/udp"
for p in $ports
do
	echo "sudo ufw allow " $p
	sudo ufw allow $p
done