#!/bin/bash
echo '====================================================================================================='
echo '====  bmilcs: git setup started  ===================================================================='
echo '====================================================================================================='
echo
echo '---- apt-get update, upgrade & dist-upgrade ---------------------------------------------------------'
echo
sudo apt-get update && apt-get upgrade && sudo apt dist-upgrade -ya
echo
echo '---- configuring directories ------------------------------------------------------------------------'
echo
rm -rv ~/scripts > /dev/null
mkdir -p ~/scripts
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
chmod +x ~/scripts/*.sh -v
echo
echo '====================================================================================================='
echo '====  scripts installed: cd ~/scripts  =============================================================='
echo '====================================================================================================='

