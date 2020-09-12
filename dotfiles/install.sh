#!/bin/bash

# backup cur dir
bmDir=$(pwd)

# symlink all dotfiles from repo
cd /etc/bmilcs/dotfiles
# for file in $(find . -maxdepth 1 -name ".*" -type f -printf "%f\n" ); do
#     if [ -e ~/$file ]; then
#         mv -f ~/$file{,.dtbak}
#     fi
#     ln -s $PWD/$file ~/$file
# done
# add source loop for new files
sudo grep -qxF '#initialize bmilcs dot files' /etc/bash.bashrc || printf "\n#initialize bmilcs dot files\nfor bmfile in /etc/bmilcs/dotfiles/.bm*\ndo\n\tsource \"\$bmfile\"\ndone" >> /etc/bash.bashrc

# dircolors import (arctic)


# ls - group dot files
sudo grep -qxF '#group dotfiles' /etc/bash.bashrc || printf "\n#group dotfiles together (ls command)\nexport LC_COLLATE=\"C\"" >> /etc/bash.bashrc
#clear
echo
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
# echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo
cd $bmDir


