#!/bin/bash
# after deploying fresh linux vm, execute the following:

echo '---- apt-get & distro update/upgrade ----------------------------------------------------------------'
echo
echo 'testing: sudo apt-get update && apt-get upgrade && sudo apt dist-upgrade'
echo
echo '---- setup openssh ----------------------------------------------------------------------------------'
echo
sudo mkdir -p ~/.ssh
sudo chmod 0700 ~/.ssh
sudo touch ~/.ssh/authorized_keys
sudo chmod 0644 ~/.ssh/authorized_keys
echo
echo '---- allow root ssh ---------------------------------------------------------------------------------'
grep -qxF 'PermitRootLogin yes' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config

/etc/rc.d/rc.sshd restart
sudo service ssh restart
exit
