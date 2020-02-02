# bmilcs: linux notes

## fundamentals
	apt-get update 				* always UPDATE before apt upgrade / dist-upgrade
		updates package lists
			newest versions for packages and their dependencies
			"re-synchronize the package index files"
	apt-get upgrade 
		downloads latest versions of installed packages (via apt-get update list)
			"from the sources enumerated in /etc/apt/sources.list(5)"
			* never removes installed packages
			* ONLY packages that are currently on system 
			* if package upgrade requires a package not already installed on system
				UPGRADE will not perform on it
	apt-get dist-upgrade
		performs "apt-get upgrade" AND intelligently handles the dependencies
			MAY remove obsolete packages or add new ones
		apt-get has a "smart" conflict resolution system
		attempt to upgrade the most important packages at the expense of less important ones (if necessary)
		
		> /etc/apt/sources.list(5) = list of locations for package files
		> apt_preferences(5) - overriding the general settings for individual packages.
	apt-get
		-h This help text.
		-q Loggable output - no progress indicator
		-qq No output except for errors
		-d Download only - do NOT install or unpack archives
		-s No-act. Perform ordering simulation
		-y Assume Yes to all queries and do not prompt
		-f Attempt to correct a system with broken dependencies in place
		-m Attempt to continue if archives are unlocatable
		-u Show a list of upgraded packages as well
		-b Build the source package after fetching it
		-V Show verbose version numbers
		-c=? Read this configuration file
		-o=? Set an arbitrary configuration option, eg -o dir::cache=/tmp



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

### xrdp.ini

      sudo vi etc/xrdp/xrdp.ini

#### cleanup

      # comment the following:

      #[Xorg]
      #[vnc-any]
      #[sesman-any]
      #[rdp-any]
      #[neutrinordp-any]




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
