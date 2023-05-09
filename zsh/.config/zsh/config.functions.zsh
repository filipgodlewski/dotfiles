#!/bin/zsh

function update() {
  echo "🔥 Upgrade brew packages"
  brew update --quiet
  brew bundle --file=~/.Brewfile &> /dev/null
  brew upgrade --quiet

  echo "🔥 Upgrade npm packages"
  npm update --global --silent
  npm cache clean --force --silent

  echo "🔥 Upgrade pipx packages"
  pipx upgrade-all &> /dev/null

  echo "🔥 Upgrade zsh packages"
  antidote update &> /dev/null
}

function rationalise-dot() {
  [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=.
}
zle -N rationalise-dot 
bindkey . rationalise-dot

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

local LFCD="$XDG_CONFIG_HOME/lf/lfcd.sh"
if [[ -f "$LFCD" ]]; then
  source "$LFCD"
  bindkey -s '^o' 'lfcd\n'
fi


if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
