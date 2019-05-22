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
sudo pacman -Syu --noconfirm
# Install basic development tools
sudo $PACMAN base-devel

# Make depots folder
mkdir -p $REPOSITORY

# Add key for Firefox Nightly
gpg --recv-key 0x61B7B526D98F0353

# Remove old vim
sudo pacman --noconfirm -Rs vim
# Install official supported packages
sudo $PACMAN - < $DOTFILES/applications/official.txt

# Install pulseaudio
install_pulse

# Install AUR Packages
for i in `cat $DOTFILES/applications/aur.txt`
do
	cd $REPOSITORY
	if git clone https://aur.archlinux.org/$i 2>/dev/null
	then
		cd $i
		makepkg -si --noconfirm
	else
		echo $i allready installed
	fi
done

# Install Python packages
sudo pip2 install -U -r $DOTFILES/applications/pip2.txt
sudo pip install -U -r $DOTFILES/applications/pip.txt

# Use zsh as default shell
sudo chsh -s /bin/zsh $USER

# Add user to the dialout and uucp group
sudo usermod -a -G dialout,uucp $USER

#install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
  echo "Could not install Oh My Zsh" >/dev/stderr
  exit 1
}
mv $HOME/.zshrc $HOME/.zshrc.default #2>/dev/null
ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc

# Use dotfiles Xmodmap
mv $HOME/.Xmodmap $HOME/.Xmodmap.default #2>/dev/null
ln -s $DOTFILES/xorg/Xmodmap $HOME/.Xmodmap
mv $HOME/.xsession $HOME/.xsession.default #2>/dev/null
ln -s $DOTFILES/xorg/xsession $HOME/.xsession

# Update i3 config
mv $HOME/.i3/config $HOME/.i3/config.default #2>/dev/null
ln -s $DOTFILES/i3/config $HOME/.i3/config

# Update vim config
rm -rf $HOME/.vim* 2>/dev/null
ln -s $DOTFILES/vim/vim $HOME/.vim
ln -s $DOTFILES/vim/vimrc $HOME/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Installing vim plugins"
vim '+PlugInstall --sync' +qa &> /dev/null

# Update tmux config
mv $HOME/.tmux.conf $HOME/.tmux.conf.default #2>/dev/null
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

# Install tmp plugin for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null

# Update redshift config
rm $HOME/.config/redshift.conf 2>/dev/null
ln -s $DOTFILES/redshift/redshift.conf $HOME/.config/redshift.conf

# Update zathura config
rm $HOME/.config/zathura/zathurarc 2>/dev/null
ln -s $DOTFILES/zathura/zathurarc $HOME/.config/zathura/zathurarc

# Install Sway
mkdir -p ~/.config/sway
cp ~/.i3/config ~/.config/sway/config
