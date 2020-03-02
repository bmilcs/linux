# docker

## docker group & user setup

	# root user
	sudo groupadd docker
	sudo usermod -aG docker bmilcs

## unraid user share setup
	sudo grep -qxF '#bmilcs unraid file shares' /etc/fstab || sudo echo '#bmilcs unraid file shares' >> /etc/fstab
	sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	sudo grep -qxF 'unraid:/mnt/user/storage/video/tv       /nas/tv nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/tv       /nas/tv nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	sudo grep -qxF 'unraid:/mnt/user/storage/video/sports   /nas/sports     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/sports   /nas/sports     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	#sudo grep -qxF '' /etc/fstab || sudo echo '' >> /etc/fstab
	#sudo grep -qxF '' /etc/fstab || sudo echo '' >> /etc/fstab




# docker installations

## sabnzbd
- [linux-server.io](https://hub.docker.com/r/linuxserver/sabnzbd/)

docker create \
  --name=sabnzbd \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8080:8080 \
  -p 9090:9090 \
  -v path to data:/config \
  -v //unraid/mnt/user/storage/downloads/:/downloads \
  -v path to incomplete downloads:/incomplete-downloads `#optional` \
  --restart unless-stopped \
  linuxserver/sabnzbd


## portainer  
  docker run -d -p 8000:8000 -p 80:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

## pia

docker run --cap-add=NET_ADMIN --name=pia -d \
  --restart=always \
  --dns 209.222.18.222 --dns 209.222.18.218 \
  -e 'REGION=Switzerlan' \
  -e 'USERNAME= xxx ' \
  -e 'PASSWORD= xxx ' \
  itsdaspecialk/pia-openvpn
  
