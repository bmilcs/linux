# archlinux notepad [bmilcs]

## audio

	
	
	pacman -S alsa-utils amixer

	speaker-test -c 2

	sys-devices-pci0000:00-0000:00:08.1-0000:2f:00.3-usb7-7-1-7-1:1.0-sound-card1.device


## time

	pacman -S ntp

	sudo nano /etc/

	sudo echo -e "server 0.pool.ntp.org iburst\nserver 1.pool.ntp.org iburst\nserver 2.pool.ntp.org iburst\nserver 3.pool.ntp.org iburst" >> /etc/ntp.conf

	sudo systemctl enable ntpd.service
	sudo systemctl start ntpd.service