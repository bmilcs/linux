#!/bin/bash
#  install rsa-ssh passwordless login
#  sudo rm -rv /tmp/ssh_raspbian.sh && cd /tmp && sudo curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://raw.githubusercontent.com/bmilcs/linux/master/ssh_raspbian.sh && sudo chmod +x *.sh && sudo -u bmilcs ./ssh_raspbian.sh

# exit on error 
set -e
 
echo '====================================================================================================='
echo '====  configuring ssh & rsa key  ===================================================================='
echo '====================================================================================================='
echo
echo '---- create authorized_keys file --------------------------------------------------------------------'
echo
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' ~/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> ~/.ssh/authorized_keys
echo '> authorized_keys imported: root/bmilcs'
echo
echo '---- customize openssh config -----------------------------------------------------------------------'
echo
#ssh root access: NO for PEEAAATTT
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
grep -qxF 'PermitRootLogin no' /etc/ssh/sshd_config || echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
service ssh restart
echo '> password-less login configured & openssh restarted'
echo
echo '====================================================================================================='
echo '====  ssh complete  ================================================================================='
echo '====================================================================================================='
exit
