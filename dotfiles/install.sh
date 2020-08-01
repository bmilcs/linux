#!/bin/bash
#-----------------------------------------------------------------------------------------------------
# symlink all dotfiles from repo
for file in $(find . -maxdepth 1 -name "~/_bmilcs/dotfiles/.*" -type f -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
done
# add source loop for new files
sudo grep -qxF '#initialize bmilcs dot files' ~/.bashrc || printf "\n\n#initialize bmilcs dot files\nfor bmfile in ~/.bm*\ndo\n\tsource \"\$bmfile\"\ndone\n" >> ~/.bashrc

#clear
echo
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo
cd -

