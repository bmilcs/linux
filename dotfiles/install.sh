#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
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
# crontab -l | grep -qF '* * up' || (crontab -l >> ~/cronny && echo '30 1 * * * up' >> ~/cronny && crontab ~/cronny && rm ~/cronny)
# echo && echo "----  cronjob: auto-update installed  -----------------------------------------------------------------" && echo

# create custom commands 
sudo mv ~/.bmilcs/script/update_sys.sh /usr/local/bin/up
sudo mv ~/.bmilcs/script/update_repo.sh /usr/local/bin/upp
sudo mv ~/.bmilcs/script/docker.sh /usr/local/bin/dcr
