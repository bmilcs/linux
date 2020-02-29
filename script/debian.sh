#!/bin/bash
# after deploying fresh linux vm, execute the following:
# apt-get install sudo -y && cd /tmp && sudo rm -f debian.sh && wget https://raw.githubusercontent.com/bmilcs/linux/master/debian.sh && sudo chmod +x debian.sh && sudo ./debian.sh

#ssh-import-id gh:bmilcs

echo '====================================================================================================='
echo '====  bmilcs debian basic configuration setup  ======================================================'
echo '====================================================================================================='
echo
echo '> apt-get update/upgrade'
echo
apt-get update && apt-get upgrade -y && apt-get install sudo
echo
echo '... done.'
echo
echo '> add user to sudoers: bmilcs'
usermod -aG sudo bmilcs
echo
echo '... done.'
echo 
echo '> remove sudo password: bmilcs'
sudo grep -qxF 'bmilcs ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || sudo echo 'bmilcs ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo
echo '... done.'
echo
echo '> installing: vmware tools & unattended-upgrades'
echo
apt install open-vm-tools unattended-upgrades apt-listchanges -y
echo
echo '... done.'
echo
echo '> configuring unattended-upgrades'
echo
printf 'APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Unattended-Upgrade "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Verbose "1";' > /etc/apt/apt.conf.d/20auto-upgrades
sed -i '/"origin=Debian,codename=${distro_codename}-updates";/c\\t"origin=Debian,codename=${distro_codename}-updates";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-Unused-Dependencies "/c\Unattended-Upgrade::Remove-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-WithUsers "/c\Unattended-Upgrade::Automatic-Reboot-WithUsers "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot "/c\Unattended-Upgrade::Automatic-Reboot "true";' /etc/apt/apt.conf.d/50unattended-upgrades
echo
echo '... done.'
echo
echo '> create rsa-ssh keys: root|bmilcs'
echo
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
echo
grep -qxF 'PermitRootLogin no' /etc/ssh/sshd_config || echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
echo '... done.'
echo 
echo '> restarting openssh'
sudo service ssh restart
echo 
echo '... done.'
echo
echo 
echo '====================================================================================================='
echo '====  bmilcs debian configuration complete  ========================================================='
echo '====================================================================================================='
echo 
echo 
echo '>>>> its PUTTY TIME! <<<<'
