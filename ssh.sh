#!/bin/bash
# after deploying fresh linux vm, execute the following:

echo '====================================================================================================='
echo '====  configuring ssh & rsa key  ===================================================================='
echo '====================================================================================================='
echo
echo '---- create authorized_keys file --------------------------------------------------------------------'
echo
sudo mkdir -p ~/.ssh
sudo chmod 0700 ~/.ssh
sudo touch ~/.ssh/authorized_keys
sudo chmod 0644 ~/.ssh/authorized_keys
sudo mkdir -p /home/bmilcs/.ssh
sudo chmod 0700 /home/bmilcs/.ssh
sudo touch /home/bmilcs/.ssh/authorized_keys
sudo chmod 0644 /home/bmilcs/.ssh/authorized_keys
echo ... complete.
echo
echo '---- configure ssh config ---------------------------------------------------------------------------'
echo
grep -qxF 'PermitRootLogin yes' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' ~/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> ~/.ssh/authorized_keys
grep -qxF 'PermitRootLogin yes' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
grep -qxF 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' /home/bmilcs/.ssh/authorized_keys || echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAngRc7vefUjzk2k6noOtBlhAzROXTAxG31mwuMXF2/qM8O795WMBHdPndW/5M7Zxk06waqPDDfsjRNj/Zmhfq62kFdTeUP+4WZlo6SZ6v3xVthhf+WQjEDejsVkRoilZIyyA3dxzbLJZzK0RE/sJ8kbIZ1yb+a8sAI6OSUWvIhhfKyfIilNbATuctXKnZRaQVPKHbsCWhS/BYgpVRJmm6TCtjmEnUZGl1+liio4hvlgaXxsZH5Mi2/+1BcKj/5+OQqq8gM2SNDO/vnfRJLTE9yUrvtvUJUJ6XLWnHVigIjZJK/prdzY/N7dHuUVKVV3NsbdhNgzb4N8hsdzRsiGp7Pw== bmilcs' >> /home/bmilcs/.ssh/authorized_keys
sudo service ssh restart
echo ... complete.
echo
echo '====================================================================================================='
echo '====  ssh complete  ================================================================================='
echo '====================================================================================================='
echo
exit
