#=====================================================================================================
#		BMILCS: backup
#			featuring "rsnapshot"
#=====================================================================================================

echo && echo "----  bmilcs: backup script  --------------------------------------------------------------------------" && echo
echo '> root check'
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}ERROR: This script must be run as root" 
   exit 1
else 
	echo '... done.' &&	echo
fi

# sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
