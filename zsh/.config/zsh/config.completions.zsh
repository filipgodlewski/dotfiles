#!/usr/bin/env zsh

autoload -Uz compinit; compinit


setopt ALWAYS_TO_END
setopt AUTO_CD
setopt AUTO_PUSHD
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt FLOW_CONTROL
setopt INTERACTIVE_COMMENTS
setopt MENU_COMPLETE
setopt NO_CASE_GLOB
setopt PATH_DIRS
setopt PROMPT_SUBST
setopt PUSHDMINUS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/.zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select=2
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{green}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completio:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' rehash truen
