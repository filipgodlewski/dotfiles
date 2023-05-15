#!/bin/zsh

function update() {
  if (( $SHLVL != 1 )); then
    echo "💔 First close nvim"
    return 1
  fi
  echo "🔥 Upgrade hosts"
  sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts -o /etc/hosts --silent
  local whitelisted_pages=(\
    "linkedin.com" \
    "www.linkedin.com" \
    "media.licdn.com" \
    "static.licdn.com" \
    "reddit.com" \
    "www.reddit.com" \
  )
  local page
  for page in $whitelisted_pages; do
    sudo nvim --clean --headless +"g/ $page/d" +"wq" /etc/hosts &> /dev/null
  done

  echo "🔥 Upgrade brew packages"
  brew update --quiet
  brew bundle --file=~/.Brewfile &> /dev/null
  brew upgrade --quiet

  echo "🔥 Upgrade npm packages"
  npm update --global --silent
  npm cache clean --force --silent

  echo "🔥 Upgrade pipx packages"
  pipx upgrade-all &> /dev/null

  echo "🔥 Upgrade nvim"
  nvim --headless +"Lazy! sync" +qa &> /dev/null
  nvim --headless +"autocmd User MasonUpdateAllComplete quitall" +"MasonUpdateAll" &> /dev/null
  nvim --headless +"TSUpdateSync" +q &> /dev/null
  nvim --headless +"UpdateRemotePlugins" +q &> /dev/null

  echo "🔥 Upgrade nvim venv"
  local py=$XDG_DATA_HOME/venvs/nvim/bin/python
  $py -m pip list --format freeze --no-index | sed 's/==.*//' | xargs -n1 $py -m pip install --upgrade --quiet

  echo "🔥 Upgrade zsh packages"
  antidote update &> /dev/null

  exec zsh
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
