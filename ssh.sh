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
echo
echo '---- configure ssh config ---------------------------------------------------------------------------'
grep -qxF 'PermitRootLogin yes' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
grep -qxF 'PubkeyAuthentication yes' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
grep -qxF 'AuthorizedKeysFile %h/.ssh/authorized_keys' /etc/ssh/sshd_config || echo 'AuthorizedKeysFile %h/.ssh/authorized_keys' >> /etc/ssh/sshd_config
sudo service ssh restart
echo
echo '====================================================================================================='
echo '====  setup complete: paste rsa-key into ~/.ssh/sshd_config  ========================================'
echo '====================================================================================================='
exit
