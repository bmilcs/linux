#=====================================================================================================
#		BMILCS: backup
#			featuring "rsnapshot"
#=====================================================================================================
NC='\033[0m'
B='\033[1m'
DIM='\033[2m'
ITAL='\033[3m'
UL='\033[4m'
BLINK='\033[5m'
INV='\033[7m'
BLK=${NC}'\033[30m' ; RED=${NC}'\033[31m' ; GRN=${NC}'\033[32m' ; YLW=${NC}'\033[33m' ; BLU=${NC}'\033[34m' ; PUR=${NC}'\033[35m' ; CYN=${NC}'\033[36m' ; WHT=${NC}'\033[37m'




echo -e "\n${DIM}${B}----  ${CYN}bmilcs: backup script  --------------------------------------------------------------------------\n"
echo '> root check'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}${B}ERROR:${RED} ${BLINK}This script must be run as root.${NC}" 
   exit 1
else 
	echo -e "${RED}${B}ERROR:${RED} ${BLINK}This script must be run as root.${NC}" 
	echo -e "${GRN}${B}ROOT ${GRN}permission granted.${NC}" 
fi

# sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
