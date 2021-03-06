#!/bin/bash
# after deploying fresh linux vm, execute the following:
# apt-get install sudo -y && cd /tmp && sudo rm -f debian.sh && wget https://raw.githubusercontent.com/bmilcs/linux/master/debian.sh && sudo chmod +x debian.sh && sudo ./debian.sh

#ssh-import-id gh:bmilcs


echo '====================================================================================================='
echo '====  bmilcs debian basic configuration setup  ======================================================'
echo '====================================================================================================='
echo
echo '> root check'
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
echo '... done.'
echo
echo '====================================================================================================='
echo '====  apt update & dist-upgrade  ===================================================================='
echo '====================================================================================================='
apt-get update && apt-get dist-upgrade -y 
echo
echo '---- done -------------------------------------------------------------------------------------------'
echo
echo '====================================================================================================='
echo '====  install: sudo | dnsutils | unattended | listchanges  =========================================='
echo '====================================================================================================='
apt-get install sudo dnsutils unattended-upgrades apt-listchanges -y
echo
echo '---- done -------------------------------------------------------------------------------------------'
echo
echo '====================================================================================================='
echo '====  configure: user | ssh | apps  ================================================================='
echo '====================================================================================================='
echo
echo '> add user to sudoers: bmilcs'
usermod -aG sudo bmilcs
echo '... done.'
echo 
echo '> remove sudo password: bmilcs'
sudo grep -qxF 'bmilcs ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || sudo echo 'bmilcs ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '... done.'
echo
echo '> configuring unattended-upgrades'
printf 'APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Unattended-Upgrade "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Verbose "1";' > /etc/apt/apt.conf.d/20auto-upgrades
sed -i '/"origin=Debian,codename=${distro_codename}-updates"/c\\t"origin=Raspbian,codename=${distro_codename},label=Raspbian";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/"origin=Debian,codename=${distro_codename}-proposed-updates";/c\\t"origin=Raspberry Pi Foundation,codename=${distro_codename},label=Raspberry Pi Foundation";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-New-Unused-Dependencies/c\Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-Unused-Kernel-Packages/c\Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-Unused-Dependencies "/c\Unattended-Upgrade::Remove-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-WithUsers "/c\Unattended-Upgrade::Automatic-Reboot-WithUsers "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot "/c\Unattended-Upgrade::Automatic-Reboot "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-Time/c\Unattended-Upgrade::Automatic-Reboot-Time "02:00";' /etc/apt/apt.conf.d/50unattended-upgrades
echo '... done.'
echo
echo '> create rsa-ssh keys: root|bmilcs'
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
sudo touch /root/.ssh/authorized_keys
sudo chmod 600 /root/.ssh/authorized_keys
sudo grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' /root/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> /root/.ssh/authorized_keys
sudo -u bmilcs mkdir -p /home/bmilcs/.ssh
sudo -u bmilcs chmod 700 /home/bmilcs/.ssh
sudo -u bmilcs touch /home/bmilcs/.ssh/authorized_keys
sudo -u bmilcs chmod 600 /home/bmilcs/.ssh/authorized_keys
grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' /home/bmilcs/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> /home/bmilcs/.ssh/authorized_keys
echo '... done.'
echo
echo '> add rsa-ssh keys to sshd_config'
grep -qxF 'PermitRootLogin no' /etc/ssh/sshd_config || echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
echo '... done.'
sudo /etc/init.d/ssh restart
echo 
echo '> install: custom login screen'
# remove bs from ssh login
touch /home/bmilcs/.hushlogin
# add banner location to sshd_config
if grep -Fxq "#Banner none" /etc/ssh/sshd_config 
then
	echo '> enabled banner option > /etc/banner'
	sed -i '/#Banner/c\Banner /etc/banner' /etc/ssh/sshd_config
fi
# import custom banner text
touch /etc/banner
echo > /etc/banner
printf "%s" "--- welcome to bmilcs homelab -----------------------" >> /etc/banner
printf "\n%s" "          host:   " >> /etc/banner
echo $HOSTNAME "(.bm.bmilcs.com)" >> /etc/banner
ipp="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
eval ip=\$\($ipp\)
printf "%s" "           lan:   " >> /etc/banner
echo $ip >> /etc/banner
eval wan=\$\(dig @1.1.1.1 ch txt whoami.cloudflare +short\)
wan="${wan%\"}"
wan="${wan#\"}"
printf "%s" "           wan:   " >> /etc/banner
echo $wan >> /etc/banner
printf "%s\n\n" "-----------------------------------------------------" >> /etc/banner
echo '... done.'
echo
echo '====================================================================================================='
echo '====  bmilcs debian configuration complete  ========================================================='
echo '====================================================================================================='
echo 
echo '>       open:    putty.exe'
echo '>    address:    bmilcs@'$HOSTNAME
echo
echo '====================================================================================================='