#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
echo -e "${PUR}• ${BLU}add $1 to automated backup? ${NC}"
read -p "      PROCEED? (y/n)  " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
				echo -e "${RED}  [X] ${B}error     ${YLW}cancelled request\n${NC}"
				exit 0
fi        

grep "$1" /etc/rsnapshot.conf || echo -e "backup\t${1}\t/nfs/${HOSTNAME}" >> /etc/rsnapshot.conf

rsnapshot configtest

