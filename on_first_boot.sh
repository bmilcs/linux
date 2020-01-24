#!/bin/bash
# after deploying fresh linux vm, execute the following:

echo ---- apt-get & distro update/upgrade ----------------------------------------------------------------
echo
sudo apt-get update && apt-get upgrade && sudo apt dist-upgrade
echo
echo ---- setup openssh ----------------------------------------------------------------------------------
echo
sudo mkdir -p ~/.ssh
sudo chmod 0700 ~/.ssh
sudo touch ~/.ssh/authorized_keys
sudo chmod 0644 ~/.ssh/authorized_keys
echo $1 $2 > ~/.ssh/authorized_keys
