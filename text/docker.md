## docker group & user setup

	# root user
	sudo groupadd docker
	sudo usermod -aG docker bmilcs

## unraid user share setup
	# template
	# sudo grep -qxF '' /etc/fstab || sudo echo '' >> /etc/fstab

	# fstab title
	sudo grep -qxF '#bmilcs unraid file shares' /etc/fstab || sudo echo '#bmilcs unraid file shares' >> /etc/fstab
	# movies > /nas/movies
	sudo grep -qxF 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/movies   /nas/media/movies     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	#tv > /nas/media/tv
	sudo grep -qxF 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/tv       /nas/media/tv nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# sports > /nas/media/sports
	sudo grep -qxF 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/video/sports   /nas/media/sports     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# audio > /nas/media/audiobooks
	sudo grep -qxF 'unraid:/mnt/user/storage/audio/audiobooks   /nas/media/audiobooks     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/audiobooks   /nas/media/audiobooks     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# audio > /nas/media/music
	sudo grep -qxF 'unraid:/mnt/user/storage/audio/music   /nas/media/music     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/music   /nas/media/music     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# audio > /nas/media/podcasts
	sudo grep -qxF 'unraid:/mnt/user/storage/audio/podcasts   /nas/media/podcasts     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/storage/audio/podcasts   /nas/media/podcasts     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# dl > /nas/media/dl
	sudo grep -qxF 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/dl   /nas/dl     nfs     auto,defaults,nofail 0 0' >> /etc/fstab
	# esxi/docker > /nas/docker/
	sudo grep -qxF 'unraid:/mnt/user/docker   /nas/docker     nfs     auto,defaults,nofail 0 0' /etc/fstab || sudo echo 'unraid:/mnt/user/docker   /nas/docker     nfs     auto,defaults,nofail 0 0' >> /etc/fstab


---
# command line docker installs
# docker installations
## sabnzbd
[linuxserver](https://hub.docker.com/r/linuxserver/sabnzbd/)

	docker create \
		--name=sabnzbd \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-p 8080:8080 \
		-p 9090:9090 \
		-v /nas/docker/sabnzbd/:/config \
		-v /nas/dl:/downloads \
		-v /nas/dl/nzb/temp:/incomplete-downloads `#optional` \
		--restart unless-stopped \
		linuxserver/sabnzbd

## radarr
[linuxserver](https://hub.docker.com/r/linuxserver/radarr/)

	docker create \
		--name=radarr \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-e UMASK_SET=022 `#optional` \
		-p 7878:7878 \
		-v /nas/docker/radarr:/config \
		-v /nas/movies:/movies \
		-v /nas/dl:/downloads \
		--restart unless-stopped \
		linuxserver/radarr

## sonarr
[linuxserver](https://hub.docker.com/r/linuxserver/sonarr/)

	docker create \
		--name=sonarr \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-e UMASK_SET=022 `#optional` \
		-p 8989:8989 \
		-v /nas/docker/sonarr:/config \
		-v /nas/tv:/tv \
		-v /nas/dl:/downloads \
		--restart unless-stopped \
		linuxserver/sonarr



## lidarr
[linuxserver](https://hub.docker.com/r/linuxserver/lidarr)

	docker create \
		--name=lidarr \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-e UMASK_SET=022 `#optional` \
		-p 8686:8686 \
		-v /nas/docker/lidarr:/config \
		-v /nas/audio/music:/music \
		-v /nas/dl:/downloads \
		--restart unless-stopped \
		linuxserver/lidarr

## jackett
[linuxserver](https://hub.docker.com/r/linuxserver/jackett)

	docker create \
		--name=jackett \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-e RUN_OPTS= \
		-p 9117:9117 \
		-v /nas/docker/jackett:/config \
		-v /nas/dl:/downloads \
		--restart unless-stopped \
		linuxserver/jackett

## nzbhydra v2
[linuxserver](https://hub.docker.com/r/linuxserver/hydra2)

	docker create \
		--name=hydra2 \
		-e PUID=1000 \
		-e PGID=1000 \
		-e TZ=Europe/London \
		-p 5076:5076 \
		-v /nas/docker/nzbhydra2:/config \
		-v /nas/dl:/downloads \
		--restart unless-stopped \
		linuxserver/hydra2

## 
[linuxserver]()
## 
[linuxserver]()




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
  
---
#DOCKER COMPOSE MASTER
---
