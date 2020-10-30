#!/bin/bash

# ===================================================================================================
# ===  bmilcs.git backup script  ====================================================================
# ===================================================================================================
# INIT COLOR-VAR'S
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
# SCRIPT TITLE
echo -e "${BLU}${DIM}----  ${BLU}${B}bmilcs-backup${GRN} started${BLU}${DIM}  ------------------------------------------------------------------------\n"

echo -e "${PUR}• ${BLU}update bmilcs.repo ${NC}\n"
(cd ~/.bmilcs/script ; ./update_repo.sh)
# ROOT CHECK
echo -e "${PUR}• ${BLU}root check ${NC}\n"

if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}  [X] ${B}error     ${YLW}        root access required\n${NC}\n"
        exit 1
else 
        echo -e "  ${GRN}[√] done.${NC}\n"
fi
#ENSURE FOLDER IS CREATED ON FREENAS
echo -e "${PUR}• ${BLU}ssh into FREENAS & create folder: ${PUR}/mnt/bm/data/backup/${HOSTNAME} ${NC}"
# echo -e "${DIM}> ${NC}${BLU}ssh into FREENAS ${GRN}\"../backup/${HOSTNAME}\" ${NC}${BLU}\n  type \"${HOSTNAME}\" once done! Make sure!"
read -e varUSER

if [ "$varUSER" != "$HOSTNAME" ]; then
echo -e "${BLU}${DIM}----  ${RED}${B}exiting${YLW}: incorrect host name provided  ${BLU}${DIM}-----------------------------------------------------\n"
		exit 1
else
        echo -e "${DIM}  ${GRN}[✓]${NC}" 
fi


mkdir -p /nfs/${HOSTNAME}
FST='10.9.9.100:/mnt/bm/data/backup/test/'${HOSTNAME}'   /nas/media/movies     nfs     auto,defaults,nofail 0 0'
sudo grep -qxF "${FST}" /etc/fstab || sudo echo "${FST}" >> /etc/fstab

