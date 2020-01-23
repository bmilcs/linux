#linux
vm deployment & general linux configuration

manual commands to start:

cd /tmp
git clone https://github.com/bmilcs/linux.git bmilcs
cd bmilcs
git filter-branch -f --prune-empty --index-filter 'git rm --cached --ignore-unmatch $(git ls-files | grep -v "1_setup_git.sh")'
chmod +x 1_setup_git.sh
sudo ./1_setup_git.sh
