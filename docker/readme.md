# docker

## docker group & user setup

	# root user
	sudo groupadd docker
	sudo usermod -aG docker bmilcs
	

	# verify it worked
	su bmilcs
	docker run hello-world

