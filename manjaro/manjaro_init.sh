#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Applications repository path
REPOSITORY=$HOME/depots

# Make depots folder
mkdir -p $REPOSITORY

# Dotfiles path
DOTFILES=$REPOSITORY/dotfiles

# Pacman command
PACMAN="pacman --noconfirm --needed -S"

echo "${green}### PASSWORD ###${reset}"
sudo -v
# Update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "${green}### GIT CLONE ###${reset}"
# Download dotfiles
git clone https://github.com/kantum/dotfiles $DOTFILES 2> /dev/null

# Enable TRIM for ssd
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Disable terminal bip
xset -b

echo "${green}### UPDATE EXISTING ###${reset}"
# Update mirrors
sudo pacman-mirrors -g
# Update installed packages
sudo pacman -Syu --noconfirm --needed

echo "${green}### INSTALL OFFICIAL ###${reset}"
# Install official supported packages
echo "Install official packages"
sudo $PACMAN - < $DOTFILES/applications/official.list

echo "${green}### ENABLE FIREWALL ###${reset}"
# Enable firewall
sudo systemctl enable ufw
sudo ufw enable

echo "${green}### INSTALL AUR ###${reset}"
# Install AUR Packages
echo "Install AUR packages"
yay -S --needed --noconfirm - < $DOTFILES/applications/aur.list

echo "${green}### DEFAULT SHELL ###${reset}"
# Use zsh as default shell
# sudo chsh -s /bin/zsh $USER

# Add user to the uucp group
sudo usermod -a -G uucp $USER

echo "${green}### STOW DOTFILES ###${reset}"
rm  -rf \
$HOME/.i3 \
$HOME/.zshrc \
$HOME/.vim* \
$HOME/.tmux.conf \
$HOME/.Xmodmap \
$HOME/.config/vlc \
$HOME/.config/redshift \
$HOME/.config/zathura \
$HOME/.config/sway \

cd $DOTFILES
stow -t $HOME \
	i3 \
	zsh \
	vim \
	tmux \
	xorg \
	vlc \
	redshift \
	zathura \
	sway

# echo "${green}### INSTALL VIM ###${reset}"
# # Install vim-plug and plugins
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim '+PlugInstall --sync' +qa &> /dev/null

# # Install youcompleteme
# cd ~/.vim/plugged/youcompleteme/
# python install.py

echo "${green}### TMUX PLUGIN ###${reset}"
# Install tmp plugin for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null

echo "${green}### INSTALL RUST ###${reset}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
