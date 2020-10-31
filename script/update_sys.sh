#!/bin/bash
set -e
echo -e "${PUR}• ${BLU}sudo apt update -y ${NC}"
sudo apt update -y
echo -e "${PUR}• ${BLU}sudo apt full-upgrade -y ${NC}"
sudo apt full-upgrade -y
echo -e "${PUR}• ${BLU}sudo apt autoremove -y ${NC}"
sudo apt autoremove -y
echo -e "${PUR}• ${BLU}sudo apt clean -y ${NC}"
sudo apt clean -y
echo -e "${PUR}• ${BLU}sudo apt autoclean -y ${NC}"
sudo apt autoclean -y
echo -e "  ${GRN}[√] done.${NC}\n"