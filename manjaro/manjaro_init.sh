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
git clone https://github.com/kantum/dotfiles $DOTFILES

# Enable firewall
sudo systemctl enable ufw
sudo ufw enable

# Enable TRIM for ssd
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Disable terminal bip
xset -b

# Install basic development tools
sudo $PACMAN base-devel

# Make depots folder
mkdir -p $REPOSITORY

# Add key for Firefox Nightly
gpg --recv-key 0x61B7B526D98F0353

# Install official supported packages
sudo $PACMAN - < $DOTFILES/applications/official.txt

# Install AUR Packages
for i in `cat $DOTFILES/applications/aur.txt`
do
	cd $REPOSITORY
	git clone https://aur.archlinux.org/$i
	cd $i
	makepkg -si --noconfirm
done

# Use zsh as default shell
chsh $USER -s /bin/zsh

# Use dotfiles Xmodmap
rm $HOME/.Xmodmap
ln -s $DOTFILES/xorg/Xmodmap $HOME/.Xmodmap
rm $HOME/.xsession
ln -s $DOTFILES/xorg/xsession $HOME/.xsession

# Update i3 config
rm $HOME/.i3/config
ln -s $DOTFILES/i3/config $HOME/.i3/config

# Update vim config
rm -rf $HOME/.vim*
ln -s $DOTFILES/vim/.vim $HOME
ln -s $DOTFILES/vim/.vimrc $HOME
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Installing vim plugins"
vim '+PlugInstall --sync' +qa &> /dev/null

# Update tmux config
rm -rf $HOME/.tmux
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

# Install tmp plugin for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Update redshift config
ln -s $DOTFILES/redshift/redshift.conf $HOME/.config/redshift.conf

# Install Sway
mkdir -p ~/.config/sway
cp ~/.i3/config ~/.config/sway/config
