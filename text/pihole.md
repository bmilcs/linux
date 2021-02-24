# repair after ip swap

    sudo nano /etc/pihole/setupVars.conf
    sudo nano  /etc/dhcpcd.conf

    sudo reboot


# google safe search
    wget https://raw.githubusercontent.com/jaykepeters/Scripts/Deployment/Pi-hole_SafeSearch.sh
    mv ./Pi-hole_SafeSearch.sh /usr/local/bin/
    chmod a+x /usr/local/bin/Pi-hole_SafeSearch.sh
    Pi-hole_SafeSearch.sh -e OR Pi-hole_SafeSearch.sh --enable