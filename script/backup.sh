#=====================================================================================================
#		BMILCS: backup
#			featuring "rsnapshot"
#=====================================================================================================
NC='\033[0m' ; BLK='\033[30m' ; RED='\033[31m' ; GRN='\033[32m' ; YLW='\033[33m' ; BLU='\033[34m' ; PUR='\033[35m' ; CYN='\033[36m' ; WHT='\033[37m'


B='\033[1m'
DIM='\033[2m'
ITL='\033[3m'
UL='\033[4m'
BLINK='\033[5m'
INV='\033[7m'



echo && echo "----  bmilcs: backup script  --------------------------------------------------------------------------" && echo
echo '> root check'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}${B}ERROR:${N} ${ITAL}This script must be run as root.${NC}" 
   exit 1
else 
	echo '... done.' &&	echo
fi

# sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
