# bmilcs: linux notes

admin user

            usermod -aG sudo bmilcs

sudo without password

            sudo nano /etc/sudoers
            bmilcs    ALL=NOPASSWD: ALL



### **errors**

- #### can't open lock file /var/lib/dpkg/lock-frontend (permission denied)

  ![error](https://i.imgur.com/5Om2naZ.png)

      sudo killall apt apt-get
      sudo rm /var/lib/apt/lists/lock
      sudo rm /var/cache/apt/archives/lock
      sudo rm /var/lib/dpkg/lock*
      sudo dpkg --configure -a
      sudo apt update
