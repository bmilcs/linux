#!/bin/bash
echo -e "${PUR}• ${BLU}add $1 to automated backup? ${NC}"
read -p "      PROCEED? (y/n)  " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
				echo -e "${RED}  [X] ${B}error     ${YLW}cancelled request\n${NC}"
				exit 0
fi        

dirname=${1}
shopt -s extglob           # enable +(...) glob syntax
result=${dirname%%+(/)}    # trim however many trailing slashes exist
result=${result##*/}       # remove everything before the last / that still remains
printf '%s\n' "$result"

grep "$1" /etc/rsnapshot.conf || echo -e "backup\t${1}\t/nfs/${HOSTNAME}" >> /etc/rsnapshot.conf