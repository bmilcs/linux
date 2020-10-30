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
echo -e "${PUR}• ${BLU}ssh into FREENAS & create folder: ${PUR}/mnt/bm/data/backup/${YLW}${HOSTNAME} ${NC}\n"
read -e varUSER
if [ "$varUSER" != "$HOSTNAME" ]; then
        echo -e "${BLU}${DIM}----  ${RED}${B}exiting${YLW}: incorrect host name provided  ${BLU}${DIM}-----------------------------------------------------\n"
	exit 1
else
        echo -e "  ${GRN}[√] done.${NC}\n"
fi
# CHECK IF BACKUP USER GROUP EXISTS
echo -e "${PUR}• ${BLU}checking for bmbak group ${NC}\n"
grep bmbak /etc/group 2>&1>/dev/null
if [ $? != 0 ]
then
        echo -e "${RED}  [X] ${B}error     ${YLW}        bmbak is missing\n${NC}\n"
        # CREATE BMBAK GROUP
        echo -e "${PUR}• ${BLU}creating bmbak (1999) ${NC}\n"
        groupadd -g 1999 bmbak
        usermod -a -G bmbak ${LOGNAME}
        usermod -a -G bmbak root
        echo -e "  ${GRN}[√] done.${NC}\n"
        # useradd -g $USERGROUP -d /home/$USERNAME -s /bin/bash -m $USERNAME
fi


mount="/nfs/${HOST}"
if grep -qs "$mount" /proc/mounts; then
        umount "$mount"
fi

echo -e "${PUR}• ${BLU}creating nfs mount w/ perms ${NC}\n"
# CREATE /NFS/HOST | PERMISSIONS
mkdir -p /nfs/${HOSTNAME} && chown bmilcs:bmbak /nfs/${HOSTNAME} && chmod 770 /nfs/${HOSTNAME}
echo -e "  ${GRN}[√] done.${NC}\n"# ADD FSTAB MOUNT
FST='10.9.9.100:/mnt/bm/data/backup/'${HOSTNAME}'   /nfs/'$HOSTNAME'     nfs     auto,defaults,nofail 0 0'
sudo grep -qxF "${FST}" /etc/fstab || sudo echo "${FST}" >> /etc/fstab
# MOUNT FOLDER
echo -e "${PUR}• ${BLU}attempting to mount nfs mount ${NC}\n"
sudo mount -av
echo -e "  ${GRN}[√] done.${NC}\n"


mount "$mount"
if [ $? -eq 0 ]; then
        echo "Mount success!"
else
        echo "Something went wrong with the mount..."
fi



