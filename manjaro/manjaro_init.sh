#!/bin/bash

# Dotfiles path
DOTFILES=$HOME/dotfiles
# Applications repository path
REPOSITORY=$HOME/depots
# Pacman command
PACMAN="pacman --noconfirm --needed -S"

sudo -v
# Update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Download dotfiles
git clone https://github.com/kantum/dotfiles $DOTFILES 2> /dev/null

# Enable firewall
sudo systemctl enable ufw
sudo ufw enable

# Enable TRIM for ssd
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Disable terminal bip
xset -b

# Update installed packages
sudo pacman -Syu --noconfirm --needed

# Install basic development tools
sudo $PACMAN base-devel

# Make depots folder
mkdir -p $REPOSITORY

# Remove old vim
sudo pacman --noconfirm -Rs vim

# Install official supported packages
sudo $PACMAN - < $DOTFILES/applications/official.list

# Install AUR Packages
yay -S --needed --noconfirm - < $DOTFILES/applications/aur.list

# Install Python packages
sudo pip2 install -q -U -r $DOTFILES/applications/pip2.list
sudo pip install -q -U -r $DOTFILES/applications/pip.list

# Use zsh as default shell
sudo chsh -s /bin/zsh $USER

# Add user to the uucp group
sudo usermod -a -G uucp $USER

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

# Install vim-plug and plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim '+PlugInstall --sync' +qa &> /dev/null

# Install youcompleteme
cd ~/.vim/plugged/youcompleteme/
python install.py

# Install tmp plugin for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null
