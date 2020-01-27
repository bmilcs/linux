theme: jekyll-theme-slate
# **bmilcs linux repo**

### setup github | clone repo

	cd /tmp && sudo curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/bmilcs/linux/contents/install.sh && sudo chmod +x *.sh && sudo ./install.sh

### **todo**
- [ ] inputbox for rsa ssh login
- [ ] password-less sudo'ers
- [ ] configure network

### **errors**


- #### can't open lock file /var/lib/dpkg/lock-frontend (permission denied)
![error](https://i.imgur.com/5Om2naZ.png)    

    sudo killall apt apt-get
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock*
    sudo dpkg --configure -a
    sudo apt update

### references
- [github readme.md markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
