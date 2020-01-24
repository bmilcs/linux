# E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied)
# E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), are you root?

  sudo killall apt apt-get
  sudo rm /var/lib/apt/lists/lock
  sudo rm /var/cache/apt/archives/lock
  sudo rm /var/lib/dpkg/lock*
  sudo dpkg --configure -a
  sudo apt update
