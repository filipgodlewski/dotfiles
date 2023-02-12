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

  echo "🔥 Upgrade brew"
  echo "📦 Update bundle"
  brew bundle --file=~/.Brewfile --quiet
  echo "🍺 Update brew itself"
  brew update --quiet

  echo "🔥 Upgrade npm"
  local outdated_packages=($(npm outdated --json -g | jq 'keys' -cMr | tr -d '[]' | tr ',' ' '))
  local package
  echo "📦 Update global outdated npm packages"
  for package in $outdated_packages; do
    echo "🚧 Updating $package..."
    npm update -g $package --silent
  done
  npm cache clean --force --silent

  echo "🔥 Upgrade pipx"
  pipx upgrade-all &> /dev/null

  echo "🔥 Upgrade nvim"
  echo "🚧 Updating Lazy..."
  nvim --headless +"Lazy! sync" +qa &> /dev/null
  echo "🚧 Updating Mason..."
  nvim --headless +"autocmd User MasonUpdateAllComplete quitall" +"MasonUpdateAll" &> /dev/null
  echo "🚧 Updating Treesitter..."
  nvim --headless +"TSUpdateSync | q" &> /dev/null
  echo "🚧 Updating Remote plugins..."
  nvim --headless +"UpdateRemotePlugins | q" &> /dev/null

  echo "🔥 Upgrade nvim venv"
  local py=$XDG_DATA_HOME/venvs/nvim/bin/python
  $py -m pip list --format freeze --no-index | sed 's/==.*//' | xargs -n1 $py -m pip install --upgrade --quiet

  echo "🔥 Upgrade antidote (zsh)"
  antidote update > /dev/null

  echo "✅ Done. You might want to restart zsh with: exec zsh"
}

function rationalise-dot() {
  [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=.
}
zle -N rationalise-dot 
bindkey . rationalise-dot

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
