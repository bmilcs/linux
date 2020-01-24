# **bmilcs linux repo**

### setup github | clone repo

`curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/bmilcs/linux/contents/setup.sh`

## **todo**
- [ ] inputbox for rsa ssh login
- [ ] install network configs

# **common problems**

![error](https://i.imgur.com/5Om2naZ.png)    

    sudo killall apt apt-get
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock*
    sudo dpkg --configure -a
    sudo apt update
