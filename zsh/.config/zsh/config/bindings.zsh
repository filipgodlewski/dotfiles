#!/bin/zsh

function rationalise-dot() { [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=. }
zle -N rationalise-dot 
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey -v
bindkey -v '^?' backward-delete-char
bindkey -s '^o' 'nvim $(fzf)^M'

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
