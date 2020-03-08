# install
## setup bmilcs git files on host


	sudo apt-get install git -y && rm -rf ~/_bmilcs && mkdir ~/_bmilcs && cd ~/_bmilcs && git clone https://github.com/bmilcs/dotfiles.git && cd dotfiles && chmod +x *.sh && ./install.sh && source ~/.bashrc