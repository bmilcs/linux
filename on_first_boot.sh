#!/bin/bash
# after deploying fresh linux vm, execute the following:

echo ---- apt-get & distro update/upgrade ----------------------------------------------------------------
echo
sudo apt-get update && apt-get upgrade && sudo apt dist-upgrade
echo

