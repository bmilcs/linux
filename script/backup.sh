#=====================================================================================================
#		BMILCS: backup
#			featuring "rsnapshot"
#=====================================================================================================
NC='\033[0m' ; BLK='\033[30m' ; BBLK='\033[1;30m' ; RED='\033[31m' ; BRED='\033[1;31m' ; GRN='\033[32m' ; BGRN='\033[1;32m' ; YLW='\033[33m' ; BYLW='\033[1;33m' ; BLU='\033[34m' ; BBLU='\033[1;34m' ; PUR='\033[35m' ; BPUR='\033[1;35m' ; CYN='\033[36m' ; BCYN='\033[1;36m' ; WHT='\033[37m' ; BWHT='\033[1;37m'
echo && echo "----  bmilcs: backup script  --------------------------------------------------------------------------" && echo
echo '> root check'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}ERROR: This script must be run as root" 
   exit 1
else 
	echo '... done.' &&	echo
fi

# sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
