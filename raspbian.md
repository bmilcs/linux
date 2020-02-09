# bmilcs: raspbian

## sudo user, no pw
**login as root**

	usermod -aG sudo bmilcs
	sudo vi /etc/sudoers.d/010_pi-nopasswd
	bmilcs ALL=(ALL) PASSWD: ALL

