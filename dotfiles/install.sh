#!/bin/bash

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

sed -i '/for bmfile in/c\for bmfile in ~/.bm_*' ~/.bashrc

# dircolors import (arctic)
sudo grep -qxF '# custom dir colors' ~/.bashrc || printf "\n\n# custom dir colors\neval \"\$(dircolors ~/.dir_colors)\"" >> ~/.bashrc

sed -i '/eval \"\$(dircolors/c\eval "$(dircolors ~/.dir_colors)"' ~/.bashrc

# ls - group dot files
sudo grep -qxF '# ls > group dotfiles together' ~/.bashrc || printf "\n\n# ls > group dotfiles together\nexport LC_COLLATE=\"C\"" >> ~/.bashrc

if [ $(id -u) -eq 0 ];
then # ROOT
  PS1="\[\e[1;30;41m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;31;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[31m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;34m\]//\[\e[m\] "
else # normal
  PS1="\[\e[1;30;44m\]    \[\e[1m\]\H  \[\e[m\]\[\e[0;34;40m\]  \u      \[\e[m\]\[\e[1;30m\] \d | \@ | \# | \[\e[34m\]\w\[\e[1;30m\] | \[\e[30m\] \[\e[m\]\n\[\e[1;31m\]//\[\e[m\] "
fi

#clear
echo
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
# echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo
cd ~


