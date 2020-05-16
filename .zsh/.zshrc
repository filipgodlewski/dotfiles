HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

export LC_ALL=en_US.UTF-8
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

source ~/.zsh/.zsh_plugins.sh
source ~/.zsh/.aliases.sh
source ~/.zsh/.exports.sh
source ~/.zsh/.externals.sh
source ~/.zsh/.functions.sh

# plugins=(git zsh-syntax-highlighting)

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt no_case_glob

# Completion
setopt auto_menu
setopt always_to_end
setopt complete_in_word
setopt flow_control
setopt menu_complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path  ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Other
setopt prompt_subst

eval "$(starship init zsh)"
