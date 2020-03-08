# bmilcs: linux notes

## scripts

      mkdir -p ~/_bmilcs && cd ~/_bmilcs && rm -rf linux && git clone https://github.com/bmilcs/linux.git && cd linux/scripts && chmod +x *.sh && clear && echo && echo '\''---- installed scripts listed below -----------------------------------------------------------------'\'' && echo && l && echo && echo '\''-----------------------------------------------------------------------------------------------------'\''

## dot files

      mkdir -p ~/_bmilcs && rm -f ~/.bm* ~/.inputrc && rm -rf ~/_bmilcs/dotfiles && cd ~/_bmilcs && git clone https://github.com/bmilcs/dotfiles.git && cd dotfiles && chmod +x *.sh && ./install.sh && source ~/.bashrc


## to do

- [] VARKEN 
- [] VPN > TOR
- [x] DOCKER/NAS PERMISSIONS OPTIMIZE

# permissions

### file & folders

- **THREE** TYPES OF PERMISSIONS

READ | WRITE | EXECUTE
---|--|---
OPEN | ADD | RUN FILE
READ |REMOVE|...
LS DIR| RENAME |  ...
...| MOVE | ...

### reading file type & access permissions

      drwxrwxrwx  1 bmilcs   140   69 Mar  5 09:44 dl
      drwxr-xr-x 19 root   root  4096 Mar  6 12:38 docker
      drwxr-xr-x  9 bmilcs   140 4096 Mar  5 11:49 media


***drwxrwxrwx*** *--- becomes ---* **d  ... rwx ... rwx ... rwx**




TYPE | **USER** | **GROUP**  | **PUBLIC** 
:-:|:-:|:-:|:-:
**[d]** *rwxrwxrwx* | *d* [**rwx**] *rwxrwx* | *d* *rwx* [**rwx**] *rwx* | *d* *rwx* *rwx* [**rwx**]

## chown: change owner

      chown username file.zip



## chmod: change permissions

      chmod permissions filename

chmod | rule | ie.
---:|:---:|:--
0	|None	|---
1	|Execute	|--x
2	|Write	|-w-
3	|Write Execute	|-wx
4	|Read|r--
5	|Read Execute	|r-x
6	|Read Write	|rw-
7	|Read Write Execute |rwx

### example

      chmod 764 /path/file

owner   |  group |    all
--:|:--:|:--
7 | 6 | 4
rwx | rw- | r--

> "chmod 764 /path/file" results in: 

      -rwxrw-r--

## puid & pguid

**list puid & pguid**
      
      ls -n

**change user's GID / UID**
      
      usermod -u #PID# bmilcs     #group
      groupmod -g #GID# bmilcs    #group

      ls -l                     #verify changes

> usermod & groupmod **fix /home/bmilcs automatically**

**fix file/folder permissions (outside of /home)**

      find / -group #OLD-GID# -exec chgrp -h bmilcs {} \;
      find / -user #OLD-UID# -exec chown -h bmilcs {} \;

      find / -group 1000 -exec chgrp -h bmilcs {} \; && find / -user 1000 -exec chown -h bmilcs {} \;

      # verify everything
      ls -l /home/bmilcs/
      id -u bmilcs
      id -g bmilcs
      grep bmilcs /etc/passwd
      grep bmilcs /etc/group
      find / -user bmilcs -ls
      find / -group sales -ls

## initial setup

      **** ROOT ****
      apt update && apt upgrade
      apt install sudo

##### custom ssh login script
      # remove bs from ssh login
      touch /home/bmilcs/.hushlogin

      # add banner location to sshd_config
      if grep -Fxq "#Banner none" /etc/ssh/sshd_config 
      then
            echo '> enabled banner option > /etc/banner'
            sed -i '/#Banner/c\Banner /etc/banner' /etc/ssh/sshd_config
      else
            echo '> error: sshd_config already configured.'
      fi

      # import custom banner text
      touch /etc/banner
      echo > /etc/banner
      printf "%s" "-----------------------------------------------------" >> /etc/banner
      printf "\n%s" "  >>>   bmilcs homelab" "   >>   host:   " >> /etc/banner
      echo $HOSTNAME >> /etc/banner
      ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
      eval ip=\$\($ipp\)
      printf "%s" "    >   ip:     " >> /etc/banner
      echo $ip >> /etc/banner
      printf "%s\n\n" "-----------------------------------------------------" >> /etc/banner
      sudo /etc/init.d/ssh restart

      


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
# unattended upgrades

      apt-get install unattended-upgrades apt-listchanges
   
      sudo vi /etc/apt/apt.conf.d/20auto-upgrades
            APT::Periodic::Update-Package-Lists "1";
            APT::Periodic::Unattended-Upgrade "1";
            APT::Periodic::Download-Upgradeable-Packages "1";
            APT::Periodic::AutocleanInterval "7";
            APT::Periodic::Verbose "1";


      sudo vi /etc/apt/apt.conf.d/50unattended-upgrades
            "${distro_id}:${distro_codename}-updates";
            Unattended-Upgrade::Mail "bmilcs@yahoo.com";
            Unattended-Upgrade::Remove-Unused-Dependencies "true";
            Unattended-Upgrade::Automatic-Reboot "true";
            Unattended-Upgrade::Automatic-Reboot-Time "02:00";

## FIND ALTERNATIVE TO MAILX

# unattended upgrades *rpi*

        "o=${distro_id},n=${distro_codename}";
        "o=${distro_id},n=${distro_codename}-updates";
        "o=${distro_id},n=${distro_codename}-proposed-updates";
        "o=${distro_id},n=${distro_codename},l=Debian-Security";

# test config

      sudo unattended-upgrades --dry-run --debug


      
---

# openvpn 
      openvpn –config client.ovpn




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
## misc

replace whole line found in file
      sed -i '/TEXT_TO_BE_REPLACED/c\This line is removed by the admin.' /tmp/foo


---

## apt-get basics

#### always UPDATE before apt upgrade / dist-upgraded

#### update

	apt-get update 				
		updates package lists
	apt-get upgrade 
		downloads latest versions of installed packages (via apt-get update list)
		* "from the sources enumerated in /etc/apt/sources.list(5)"
	apt-get dist-upgrade
		performs "apt-get upgrade" AND intelligently handles the dependencies
		MAY remove obsolete packages or add new ones
	      > /etc/apt/sources.list(5) = list of locations for package files
		> apt_preferences(5) - overriding the general settings for individual packages.

#### maintenance 
      apt-get -f install
            "Fix Broken Packages"
      apt-get autoclean
            removes .deb files no longer installed on system.
      *apt-get autoremove
            removes packages that were installed by other packages and are no longer needed.

#### delete
      apt-get remove X
            removes package
            leaves configuration files intact
      apt-get purge X
            removes package
            removes all config files
      apt-get autoremove X
            deletes package & dependencies

---

# vpn killswitch (current)

      #!/bin/bash
      iptables -F
      iptables -X
      iptables -t nat -F
      iptables -t nat -X
      ip6tables -F
      ip6tables -X
      ip6tables -t nat -F
      ip6tables -t nat -X

      # localhost > accept all
      iptables -A INPUT -i lo -j ACCEPT
      iptables -A OUTPUT -o lo -j ACCEPT
      ip6tables -A INPUT -i lo -j ACCEPT
      ip6tables -A OUTPUT -o lo -j ACCEPT

      # allow ping
      iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

      # lan > accept all
      iptables -A INPUT  -i enp2s0 -s 10.1.1.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.1.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.2.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.2.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.86.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.86.0/24 -j ACCEPT
      iptables -A INPUT  -i enp2s0 -s 10.1.99.0/24 -j ACCEPT
      iptables -A OUTPUT -o enp2s0 -d 10.1.99.0/24 -j ACCEPT

      # allow dns
      iptables -A INPUT  -p udp --sport 53 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 53 -j ACCEPT


      # allow vpn traffic
      iptables -A INPUT  -p udp --sport 1194 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
      iptables -A INPUT  -p udp --sport 1198 -j ACCEPT
      iptables -A OUTPUT -p udp --dport 1198 -j ACCEPT

      # xrdp ports
      ip6tables -I INPUT -p tcp --dport 3350 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p udp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 3389 -m state --state NEW,ESTABLISHED -j ACCEPT
      ip6tables -I INPUT -p tcp --dport 5910 -m state --state NEW,ESTABLISHED -j ACCEPT

      # dns: pia
      iptables -A INPUT  -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.222 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT
      iptables -A OUTPUT -d 209.222.18.218 -j ACCEPT

      # PIA server
      iptables -A INPUT  -p udp -s swiss.privateinternetaccess.comm -j ACCEPT;
      iptables -A OUTPUT -p udp -d swiss.privateinternetaccess.com -j ACCEPT;

      # Accept TUN
      iptables -A INPUT    -i tun+ -j ACCEPT
      iptables -A OUTPUT   -o tun+ -j ACCEPT
      iptables -A FORWARD  -i tun+ -j ACCEPT

      # Drop the rest
      iptables -A INPUT   -j DROP
      iptables -A OUTPUT  -j DROP
      iptables -A FORWARD -j DROP
      ip6tables -A INPUT   -j DROP
      ip6tables -A OUTPUT  -j DROP
      ip6tables -A FORWARD -j DROP

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
