#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"

#PROMPT
echo -e "${PUR}• ${BLU}add $PWD to automated backup? \n${NC}\t\t"
read -p "      PROCEED? (y/n)  " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
				echo -e "${RED}  [X] ${B}error     ${YLW}cancelled request\n${NC}"
				exit 0
fi        
echo -e "\n"
# IF NOT EXIST, ADD HEADER
grep "# bmilcs.backup locations" /etc/rsnapshot.conf || echo -e "\n# bmilcs.backup locations" >> /etc/rsnapshot.conf

# IF NOT EXIST, ADD BACKUP PATH
# bakfolder=$(basename $PWD)
grep $'backup\t\t'$PWD /etc/rsnapshot.conf || echo -e "backup\t\t${PWD}/./\t\t./" >> /etc/rsnapshot.conf

# CHECK IF RSNAPSHOT CONFIG IS VALID
echo -e "\n${PUR}• ${BLU}config test output ${NC}\n"
rsnapshot configtest

echo -e "\n  ${GRN}[√] done.${NC}\n"

# backup          /home/bmilcs/docker/./          ./
# backup  /home/bmilcs/./plex/Library     ./