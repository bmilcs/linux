#!/bin/bash
#-----------------------------------------------------------------------------------------------------
# symlink all dotfiles from repo
for file in $(find . -maxdepth 1 -name ".*" -type f -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s $PWD/$file ~/$file
done
# add source loop for new files
sudo grep -qxF '#initialize bmilcs dot files' ~/.bashrc || printf "\n\n#initialize bmilcs dot files\nfor bmfile in ~/.bm*\ndo\n\tsource \"\$bmfile\"\ndone\n" >> ~/.bashrc

#clear
echo
echo '====================================================================================================='
echo '====  bmilcs dotfiles refreshed  ===================================================================='
echo '====================================================================================================='
echo
echo '> ***reboot required for .inputrc refresh!***'
echo 
echo '               PUTTY (post reboot)'
echo 
echo '                 > wait 5-10 sec'
echo '                 > space            (clear error msgbox)'
echo '                 > alt+space        (drop down menu)'
echo '                 > r                (refresh connection)'
echo
echo 
echo 

