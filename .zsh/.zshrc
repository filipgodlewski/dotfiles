HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

export LC_ALL=en_US.UTF-8
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

source ~/.zsh/.aliases.sh
source ~/.zsh/.exports.sh
source ~/.zsh/.externals.sh
source ~/.zsh/.functions.sh
source ~/.zsh/.zsh_plugins.sh

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history

# Completion
setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt flow_control
setopt menu_complete
setopt no_case_glob
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushdminus

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix


# zstyle ':completion:*:*:*:*:*' menu select
# zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path  ':completion:*' list-colors ''
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zsh/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

eval "$(starship init zsh)"
