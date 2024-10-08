# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="wedisagree"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#:exe "normal a \<BS>\<Esc>"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LC_ALL=en_IN.UTF-8
export LANG=en_US.UTF-8

# Set locale (Important to avoid tmux bugs)
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias make=gmake
alias top=btm
alias vim=nvim
alias :q="exit"

# Expected behaviour pgrep and pkill
alias pgrep="pgrep -f"
alias pkill="pkill -f"

# Youtube-dl aliases
alias ytmp3="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"

# # Color man pages
# man() {
# 	LESS_TERMCAP_md=$'\e[01;31m' \
# 	LESS_TERMCAP_me=$'\e[0m' \
# 	LESS_TERMCAP_se=$'\e[0m' \
# 	LESS_TERMCAP_so=$'\e[01;44;33m' \
# 	LESS_TERMCAP_ue=$'\e[0m' \
# 	LESS_TERMCAP_us=$'\e[01;32m' \
# 	COLUMNS=80 \
# 	command man "$@"
# }

# make ctrl-u act as usual
bindkey \^U backward-kill-line

PATH="$PATH:$HOME/.cargo/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Gstreamer
# export PKG_CONFIG_PATH="/Library/Frameworks/GStreamer.framework/Versions/1.0/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
# export PATH="/Library/Frameworks/GStreamer.framework/Versions/1.0/bin${PATH:+:$PATH}"
# export DYLD_LIBRARY_PATH=/Library/Frameworks/GStreamer.framework/Versions/1.0/lib/
# export DYLD_FALLBACK_LIBRARY_PATH=/Library/Frameworks/GStreamer.framework/Versions/1.0/lib/

# Gstreamer bash completion
eval "$(curl -s https://raw.githubusercontent.com/drothlis/gstreamer/bash-completion-master/tools/gstreamer-completion)"

# direnv
eval "$(direnv hook zsh)"

# Removes the limits and deduplication of the history file.
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

export GPG_TTY=$(tty)

eval "$(~/.local/bin/rtx activate zsh)"

export SOPS_AGE_KEY_FILE="$HOME/.sops/keys.txt"

export VISUAL=nvim
export EDITOR="$VISUAL"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export PATH="/opt/homebrew/opt/ruby@2.7/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
# export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
# export AWS_REGION=<YOUR_AWS_REGION>
# Go bin
export PATH="$PATH:$HOME/go/bin"
export PATH=$HOME/bin:/usr/local/go/bin:$PATH

# Load fzf key bindings from nix
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
