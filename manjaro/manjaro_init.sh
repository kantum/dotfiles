#!/bin/bash

# Applications repository path
REPOSITORY=$HOME/depots

# Make depots folder
mkdir -p $REPOSITORY

# Dotfiles path
DOTFILES=$REPOSITORY/dotfiles

# Pacman command
PACMAN="pacman --noconfirm --needed -S"

echo "\e[32m\n### PASSWORD ###\n\e[0m"
sudo -v
# Update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "\e[32m\n### GIT CLONE ###\n\e[0m"
# Download dotfiles
git clone https://github.com/kantum/dotfiles $DOTFILES 2> /dev/null

# Enable TRIM for ssd
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Disable terminal bip
xset -b

echo "\e[32m\n### UPDATE EXISTING ###\n\e[0m"
# Update installed packages
sudo pacman -Syu --noconfirm --needed

echo "\e[32m\n### INSTALL OFFICIAL ###\n\e[0m"
# Install official supported packages
echo "Install official packages"
sudo $PACMAN - < $DOTFILES/applications/official.list

echo "\e[32m\n### ENABLE FIREWALL ###\n\e[0m"
# Enable firewall
sudo systemctl enable ufw
sudo ufw enable

echo "\e[32m\n### INSTALL AUR ###\n\e[0m"
# Install AUR Packages
echo "Install AUR packages"
yay -S --needed --noconfirm - < $DOTFILES/applications/aur.list

echo "\e[32m\n### DEFAULT SHELL ###\n\e[0m"
# Use zsh as default shell
sudo chsh -s /bin/zsh $USER

# Add user to the uucp group
sudo usermod -a -G uucp $USER

echo "\e[32m\n### STOW DOTFILES ###\n\e[0m"
rm  -rf \
$HOME/.i3/config \
$HOME/.zshrc \
$HOME/.vim* \
$HOME/.tmux.conf \
$HOME/.Xmodmap \
$HOME/.config/vlc \
$HOME/.config/redshift.conf \
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

echo "\e[32m\n### INSTALL VIM ###\n\e[0m"
# Install vim-plug and plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim '+PlugInstall --sync' +qa &> /dev/null

# Install youcompleteme
cd ~/.vim/plugged/youcompleteme/
python install.py

# Install tmp plugin for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null
