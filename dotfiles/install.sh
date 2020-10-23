#!/bin/bash
NC='\033[0m'
BLK='\033[30m'
BBLK='\033[1;30m'
RED='\033[31m'
BRED='\033[1;31m'
GRN='\033[32m'
BGRN='\033[1;32m'
YLW='\033[33m'
BYLW='\033[1;33m'
BLU='\033[34m'
BBLU='\033[1;34m'
PUR='\033[35m'
BPUR='\033[1;35m'
CYN='\033[36m'
BCYN='\033[1;36m'
WHT='\033[37m'
BWHT='\033[1;37m'

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
# # fix issues w/ dotfiles
# sed -i '/for bmfile in/c\for bmfile in ~/.bm_*' ~/.bashrc
# dircolors import (nord)
sudo grep -qxF '# custom dir colors' ~/.bashrc || printf "\n\n# custom dir colors\neval \"\$(dircolors ~/.dir_colors)\"" >> ~/.bashrc
sed -i '/eval \"\$(dircolors/c\eval "$(dircolors ~/.dir_colors)"' ~/.bashrc
# ls - group dot files
sudo grep -qxF '# ls > group dotfiles together' ~/.bashrc || printf "\n\n# ls > group dotfiles together\nexport LC_COLLATE=\"C\"" >> ~/.bashrc
# let the ppl know
echo -e "${CYN}----  ${BLU}bmilcs.dotfiles installed ${BGRN}successfully${NC}${CYN}  ---------------------------------------------------------${NC}" && echo
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
# echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo

