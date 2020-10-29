#!/bin/bash
NC='\033[0m';B='\033[1m';DIM='\033[2m';ITAL='\033[3m';UL='\033[4m';BLINK='\033[5m';INV='\033[7m'; BLK=${NC}'\033[30m';RED=${NC}'\033[31m';GRN=${NC}'\033[32m';YLW=${NC}'\033[33m';BLU=${NC}'\033[34m';PUR=${NC}'\033[35m';CYN=${NC}'\033[36m';WHT=${NC}'\033[37m';TIME="$(date +"%I:%M %P")"
echo -e "${BLU}${DIM}----  ${BLU}${B}bmilcs.repo${BLU} update ${YLW}started  ${BLU}${DIM}----------------------------------------------------------------\n${NC}"
cd ~
rm -rf ~/.bm_* ~/.dir_colors ~/.bm ~/.bmilcs ~/_bmilcs
git clone https://github.com/bmilcs/linux.git ~/.bmilcs && chmod -R +x ~/.bmilcs && (cd ~/.bmilcs/dotfiles ; ./install.sh) && source ~/.bashrc
echo -e "${BLU}${DIM}----  ${BLU}${B}bmilcs.linux github repo updated ${GRN}successfully  ${BLU}${DIM}---------------------------------------------\n${NC}"
cd ~