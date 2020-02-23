# bmilcs: linux, etc.

### table of contents

- [linux notes](https://github.com/bmilcs/linux/blob/master/LINUX.md)
- [github & visual studio optimization](https://github.com/bmilcs/linux/blob/master/GITHUB.md)
- [vim guide](https://github.com/bmilcs/linux/blob/master/VIM.md)


### debian

        apt-get install sudo -y && cd /tmp && sudo rm -f debian.sh && wget https://raw.githubusercontent.com/bmilcs/linux/master/debian.sh && sudo chmod +x debian.sh && sudo ./debian.sh

#### OLD: linux vm setup

- _dl repo | clone | make scripts executable_

        cd /tmp && sudo curl -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/bmilcs/linux/contents/install.sh && sudo chmod +x \*.sh && sudo ./install.sh

## **to do**

- [ ] integrate read (user input) into scripts
- [ ] password-less sudo'ers
- [ ] configure network

## links

- [github readme.md markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
