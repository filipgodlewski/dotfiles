#!/bin/zsh

setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt auto_remove_slash
setopt complete_in_word
setopt flow_control
setopt menu_complete
setopt no_case_glob
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushdminus

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select=2
zstyle ':completion:*' squeeze-slashes true
