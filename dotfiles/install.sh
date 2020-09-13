#!/bin/bash

# backup cur dir
bmDir=$(pwd)

# symlink all dotfiles from repo

cd ~/.bmilcs/dotfiles

case $PWD/ in   */.bmilcs/dotfiles*) echo;;   *) exit 1;; esac


for file in $(find . -maxdepth 1 -name ".*" -type f -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.old}
    fi
    ln -s $PWD/$file ~/$file
done
# add source loop for new files
sudo grep -qxF '# initialize bmilcs dot files' ~/.bashrc || printf "\n\n#=====================================================================================================\n#====  bmilcs customizations  ========================================================================\n#=====================================================================================================\n\n# initialize bmilcs dot files\nfor bmfile in ~/.bm_*\ndo\n\tsource \"\$bmfile\"\ndone" >> ~/.bashrc

sudo grep -qxF 'for bmfile in' ~/.bashrc || printf "for bmfile in ~/.bm_*" >> ~/.bashrc

# dircolors import (arctic)
sudo grep -qxF '# custom dir colors' ~/.bashrc || printf "\n\n# custom dir colors\neval \"\$(dircolors ~/.bmilcs/dotfiles/.dir_colors)\"" >> ~/.bashrc

# ls - group dot files
sudo grep -qxF '# ls > group dotfiles together' ~/.bashrc || printf "\n\n# ls > group dotfiles together\nexport LC_COLLATE=\"C\"" >> ~/.bashrc

#clear
echo
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
# echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo
cd $bmDir


