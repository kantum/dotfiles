zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
PROMPT='%F{099}[%1~]%f '

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

export PATH="$WASMTIME_HOME/bin:$PATH"

export GPG_TTY=$(tty)

export VISUAL=nvim

export EDITOR="$VISUAL"

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

alias hs='home-manager switch'
zprof
