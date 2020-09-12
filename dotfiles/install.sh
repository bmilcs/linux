#!/bin/bash

# backup cur dir
bmDir=$(pwd)

cd ~/_bmilcs/dotfiles
# symlink all dotfiles from repo
for file in $(find . -maxdepth 1 -name ".*" -type f -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
done
# add source loop for new files
sudo grep -qxF '#initialize bmilcs dot files' ~/etc/.bashrc || printf "\n\n#initialize bmilcs dot files\nfor bmfile in ~/.bm*\ndo\n\tsource \"\$bmfile\"\ndone\n" >> ~/etc/.bashrc

# dircolors import (arctic)


# ls - group dot files
sudo grep -qxF 'export LC_COLLATE="C"' ~/etc/.bashrc || printf "\n\n# group .dotfiles together (ls command)\nexport LC_COLLATE="C"" >> /etc/.bashrc
#clear
echo
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo
crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo

cd $bmDir


