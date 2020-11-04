#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
set -e
upp
echo -e "${BLU}[ ${B}sudo apt update -y ${BLU}]${NC}"
sudo apt update -y
echo -e "  ${GRN}[√] done.${NC}\n"
echo -e "${BLU}${B}${UL}sudo apt full-upgrade -y ${NC}"
sudo apt full-upgrade -y
echo -e "  ${GRN}[√] done.${NC}\n"
echo -e "${BLU}${B}${UL}sudo apt autoremove -y ${NC}"
sudo apt autoremove -y
echo -e "  ${GRN}[√] done.${NC}\n"
echo -e "${BLU}${B}${UL}sudo apt clean -y ${NC}"
sudo apt clean -y
echo -e "  ${GRN}[√] done.${NC}\n"
echo -e "${BLU}${B}${UL}sudo apt autoclean -y ${NC}"
sudo apt autoclean -y
echo -e "  ${GRN}[√] done.${NC}\n"
# update pihole test
if pihole -v PIHOLE &> /dev/null
then
	echo -e "${BLU}${B}${UL}sudo pihole -up ${NC}"
	sudo pihole -up
fi
# docker-compose update test
if docker-compose -v DOCKER-COMPOSE &> /dev/null
then
	 dcr
fi


