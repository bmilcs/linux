#!/bin/bash

cd /
mkdir -p /nas /nas/media/movies /nas/media/tv /nas/media/sports /nas/media/podcasts /nas/media/music /nas/media/audiobooks /nas/media/books /nas/dl /nas/docker
echo '====================================================================================================='
echo '====  unraid media  ================================================================================='
echo '====================================================================================================='
sudo grep -qxF '#bmilcs unraid file shares' /etc/fstab || sudo echo '#bmilcs unraid file shares' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/audio/podcasts   /nas/media/podcasts     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/podcasts   /nas/media/podcasts     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/audio/music   /nas/media/music     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/music   /nas/media/music     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/audio/audiobooks   /nas/media/audiobooks     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/audiobooks   /nas/media/audiobooks     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/literature/books   /nas/media/books     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/literature/books   /nas/media/books     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'freenas:/mnt/security   /nas/security     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'freenas:/mnt/security   /nas/security     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
sudo grep -qxF 'unraid:/mnt/user/storage/video/learning   /nas/media/learning     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/learning   /nas/media/learning     nfs     auto,defaults,nofail 0 0' >> /etc/fstab


echo '----  download location  ------------------------------------------------------------------------------'
sudo grep -qxF 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
# esxi/docker > /nas/docker/
echo '----  backup  -----------------------------------------------------------------------------------------'
sudo grep -qxF 'unraid:/mnt/user/esxi/docker   /nas/backup     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/esxi/docker   /nas/backup     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
echo '====================================================================================================='
echo '====  network shares installed  ====================================================================='
echo '====================================================================================================='
cat /etc/fstab
echo
echo
echo '----  attempting to mount new shares  -----------------------------------------------------------------'
echo
mount -av
echo
echo '----  done  -------------------------------------------------------------------------------------------'
echo