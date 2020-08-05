#!/bin/zsh

zle -N rationalise-dot
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
