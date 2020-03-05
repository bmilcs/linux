#!/bin/bash

echo '====================================================================================================='
echo '====  universal unattended upgrades config  ========================================================='
echo '====================================================================================================='

echo '> configuring unattended-upgrades'
printf 'APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Unattended-Upgrade "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Verbose "1";' > /etc/apt/apt.conf.d/20auto-upgrades
sed -i '/"origin=/c\\t' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/new stable)./c\\t"o=*"' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-New-Unused-Dependencies/c\Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-Unused-Kernel-Packages/c\Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Remove-Unused-Dependencies "/c\Unattended-Upgrade::Remove-Unused-Dependencies "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-WithUsers "/c\Unattended-Upgrade::Automatic-Reboot-WithUsers "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot "/c\Unattended-Upgrade::Automatic-Reboot "true";' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/Unattended-Upgrade::Automatic-Reboot-Time/c\Unattended-Upgrade::Automatic-Reboot-Time "01:00";' /etc/apt/apt.conf.d/50unattended-upgrades