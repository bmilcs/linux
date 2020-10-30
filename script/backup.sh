#!/bin/bash

# ===================================================================================================
# ===  bmilcs.git backup script  ====================================================================
# ===================================================================================================
# INIT COLOR-VAR'S
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
# SCRIPT TITLE
echo -e "${BLU}${DIM}----  ${BLU}${B}bmilcs-backup${GRN} started${BLU}${DIM}  ------------------------------------------------------------------------\n"
# ROOT CHECK
echo -e "${PUR}• ${BLU}root check ${NC}\n"

if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}  [X] ${B}error     ${YLW}        root access required\n${NC}\n"
        exit 1
else 
        echo -e "  ${GRN}[√] done.${NC}\n"
fi
#ENSURE FOLDER IS CREATED ON FREENAS
echo -e "${PUR}• ${BLU}ssh into FREENAS & create folder: ${PUR}/mnt/bm/data/backup/${YLW}${HOSTNAME} ${NC}"
read -e varUSER
if [ "$varUSER" != "$HOSTNAME" ]; then
        echo -e "${BLU}${DIM}----  ${RED}${B}exiting${YLW}: incorrect host name provided  ${BLU}${DIM}-----------------------------------------------------\n"
	exit 1
else
        echo -e "${DIM}  ${GRN}[✓]${NC}" 
fi
# CHECK IF BACKUP USER GROUP EXISTS
echo -e "${PUR}• ${BLU}checking for bmbak group ${NC}\n"
grep bmbak /etc/group 2>&1>/dev/null
if [$? != 0]
then
        echo -e "${RED}  [X] ${B}error     ${YLW}        bmbak is missing\n${NC}\n"
        # CREATE BMBAK GROUP
        echo -e "${PUR}• ${BLU}        creating bmbak (1999) ${NC}\n"
        groupadd -g 1999 bmbak
        getent group | grep bmbak
        # useradd -g $USERGROUP -d /home/$USERNAME -s /bin/bash -m $USERNAME
fi

# CREATE /NFS/HOST FOLDER
mkdir -p /nfs/${HOSTNAME}
# ASSIGN PERMISSIONS

# ADD FSTAB MOUNT
FST='10.9.9.100:/mnt/bm/data/backup/'${HOSTNAME}'   /nfs/'$HOSTNAME'     nfs     auto,defaults,nofail 0 0'
sudo grep -qxF "${FST}" /etc/fstab || sudo echo "${FST}" >> /etc/fstab

