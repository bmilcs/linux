#!/bin/bash
echo '====================================================================================================='
echo '====  bmilcs: git setup started  ===================================================================='
echo '====================================================================================================='
echo
#echo '---- apt-get update, upgrade & dist-upgrade ---------------------------------------------------------'
#echo
#sudo apt-get update && apt-get upgrade && sudo apt dist-upgrade -y
#echo
echo '---- configuring directories ------------------------------------------------------------------------'
echo
sudo rm -rv ~/scripts > /dev/null
sudo mkdir -p ~/scripts
cd ~/scripts
echo '/home/user/scripts' folder created
echo
echo '---- clone repo -------------------------------------------------------------------------------------'
echo
git config --global user.name "bmilcs"
git config --global user.email "bmilcs@yahoo.com"
git clone https://github.com/bmilcs/linux.git ~/scripts
echo ... complete 
echo
echo '---- make scripts executable ------------------------------------------------------------------------'
echo
sudo chmod +x ~/scripts/*.sh -v
echo
sudo grep -qxF 'bmilcs ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || sudo echo 'bmilcs ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '====================================================================================================='
echo '====  scripts installed: cd ~/scripts  =============================================================='
echo '====================================================================================================='

