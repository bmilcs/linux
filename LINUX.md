# bmilcs: linux notes


## linux setup

#### 1. **login as root**

      **** ROOT ****
      apt update && apt upgrade
      apt install sudo

#### 2. configure network ####

      sudo vi /etc/network/interfaces

#### /etc/network/interfaces

      auto lo
      iface lo inet loopback

      auto enp2s0
      iface enp2s0 inet static      ### static ip
      iface eth0 inet dhcp          ### or dhcp
            address 10.1.99.2
            netmask 255.255.255.0
            gateway 10.1.99.254
            dns nameservers 209.222.18.222      ### pia
            dns nameservers 209.222.18.218      ### pia 2
            up route add -net 10.1.1.0 netmask 255.255.255.0 gw 10.1.99.254   ### allow lan access 

### sudo user

      usermod -aG sudo bmilcs

### sudo without password

      sudo vi /etc/sudoers
      bmilcs    ALL=NOPASSWD: ALL

### universal ssh: rsa
	**** ROOT ****
	sudo mkdir ~/.ssh
	sudo chmod 0700 ~/.ssh
	sudo touch ~/.ssh/authorized_keys
	sudo chmod 0644 ~/.ssh/authorized_keys
	sudo vi ~/.ssh/authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs

	sudo vi /etc/ssh/sshd_config 
			PermitRootLogin yes
			PubkeyAuthentication yes
			AuthorizedKeysFile %h/.ssh/authorized_keys
	sudo service ssh restart
	OR...
	/etc/rc.d/rc.sshd restart

---

# unraid 

## ssh: rsa
	cd /boot/config/ssh/
	sudo vi authorized_keys
			ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== rsa-NAMEHERE
	sudo vi /boot/config/go
			mkdir /root/.ssh
			chmod 700 /root/.ssh
			cp /boot/config/ssh/authorized_keys /root/.ssh/
			chmod 600 /root/.ssh/authorized_keys


## mount share

### vm gui

      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/vm'/>
      <target dir='share'/>
      </filesystem>
      <filesystem type='mount' accessmode='passthrough'>
      <source dir='/mnt/user/storage/downloads/#torrent/watch'/>
      <target dir='watch'/>
      </filesystem>

### within vm

	sudo mkdir /home/share
	sudo vi /etc/fstab
	share /home/#share       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0
	share /home/#watch       9p      trans=virtio,version=9p2000.L,_netdev,rw        0 0



---




# xrdp


### add lan for access

      sudo route add -net 10.1.1.0/24 gw 10.1.99.254


### list installed apts

	apt list --installed | grep vnc


### restart network

	/etc/init.d/networking restart 

### debian fix

	sudo vi /run/systemd/resolve/resolv.conf
		search bm.bmilcs.com
		nameservers 1.1.1.1
			10.1.99.254
	gsettings set org.gnome.desktop.interface enable-animations false
	xrdp
	max_bpp 128


# clean up | optimize | misc useful commands


### del apps via string

	sudo apt-get remove libreoffice.*

## debugging

### check linux crash logs

	sudo vi /var/crash

---

# **common fixes | errors**

- #### can't open lock file /var/lib/dpkg/lock-frontend (permission denied)

  ![error](https://i.imgur.com/5Om2naZ.png)

      sudo killall apt apt-get
      sudo rm /var/lib/apt/lists/lock
      sudo rm /var/cache/apt/archives/lock
      sudo rm /var/lib/dpkg/lock*
      sudo dpkg --configure -a
      sudo apt update
