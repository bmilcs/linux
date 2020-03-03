#!/bin/bash
# fstab title
sudo grep -qxF '#bmilcs unraid file shares' /etc/fstab || sudo echo '#bmilcs unraid file shares' >> /etc/fstab
# movies > /nas/movies
sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
#tv > /nas/media/tv
sudo grep -qxF 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' >> /etc/fstab
# sports > /nas/media/sports
sudo grep -qxF 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
# audio > /nas/media/audio
sudo grep -qxF 'unraid:/mnt/user/storage/audio   /nas/media/audio     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio   /nas/media/audio     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
# dl > /nas/media/dl
sudo grep -qxF 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
# esxi/docker > /nas/docker/
sudo grep -qxF 'unraid:/mnt/user/pirate/docker   /nas/docker     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/pirate/docker   /nas/docker     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
