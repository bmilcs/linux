#!/bin/bash
echo ===================================================================================================
echo ===  bmilcs: git setup started  ===================================================================
echo ===================================================================================================
echo
echo --- configuring directories -----------------------------------------------------------------------
echo
rm -rv ~/_scripts
mkdir -p ~/_scripts
cd ~/_scripts
echo '/home/user/scripts' folder created
echo
echo --- apt-update ------------------------------------------------------------------------------------
echo
sudo apt-get update
echo
echo --- clone repo ------------------------------------------------------------------------------------
echo
git -version
git config --global user.name "bmilcs"
git config --global user.email "bmilcs@yahoo.com"
git clone https://github.com/bmilcs/linux.git ~/_scripts
echo
echo --- git status ------------------------------------------------------------------------------------
git status
echo
echo --- make scripts executable -----------------------------------------------------------------------
echo
chmod +x ~/_scripts/*.sh -v
echo
cd ~/_scripts/
echo ===================================================================================================
echo ===  git setup completed  =========================================================================
echo ===================================================================================================
