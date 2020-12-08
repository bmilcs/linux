# bmilcs: archlinux notes

## dotfiles
	### setup bare repo
		git init --bare $HOME/.dotfiles 
		alias gitt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
		gitt config --local status.showUntrackedFiles no
		echo "alias gitt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc # or zsh

	### import
		alias gitt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
		echo "alias gitt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc # or zsh
		git clone --bare https://github.com/bmilcs/dotfiles.git $HOME/.dotfiles
		gitt checkout
	### if unable to checkout, move offending files to backup folder
		mkdir -p .dotfiles-backup && \
		config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
		xargs -I{} mv {} .dotfiles-backup/{}

## audio
remove nvidia hdmi soundcard

	# find pci id
	lspci | grep -i audio

	# find folder
	find /sys/devices -name *01:00.1
	
	# add output to /etc/rc.local
	echo 1 > /sys/devices/pci0000\:00/0000\:00\:03.0/0000\:01\:00.1/remove

packages

- alsa-utils
- amixer
- pulseaudio

alsa

	#list alsa devices
	pacmd list-sources

	


troubleshooting

	speaker-test -c 2

	# soundcards
	cat /proc/asound/cards

	# playback hardware devices
	aplay -l


2i2 device

	sys-devices-pci0000:00-0000:00:08.1-0000:2f:00.3-usb7-7-1-7-1:1.0-sound-card1.device




## time

	pacman -S ntp

	sudo nano /etc/

	sudo echo -e "server 0.pool.ntp.org iburst\nserver 1.pool.ntp.org iburst\nserver 2.pool.ntp.org iburst\nserver 3.pool.ntp.org iburst" >> /etc/ntp.conf

	sudo systemctl enable ntpd.service
	sudo systemctl start ntpd.service