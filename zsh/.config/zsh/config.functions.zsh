#!/bin/zsh


function edit() {
  local bookmarks=$XDG_CACHE_HOME/bookmarks
  mkdir -p $bookmarks ~/personal ~/learning ~/projects ~/dotfiles
  [[ -f $bookmarks/list.txt ]] || echo bookmarks > $bookmarks/list.txt

  local projects=(
    "${(@f)$(cat $bookmarks/list.txt)}"
    "${(@f)$(fd -c never -t d -H --base-directory ~ -g \.git personal learning projects dotfiles | awk '{sub(/\/.git\//, "");print}')}"
  )

  local selected=$(echo ${(F)projects} \
  | fzf \
    --cycle \
    --header-first \
    --header 'Open project in neovim' \
    --height 100% \
    --border \
    --preview 'bat --color always --wrap auto --style plain $HOME/{}/README.*' \
    --preview-window down,80%
  )

  [[ -z $selected ]] && return 127
  pushd $HOME/$selected
  nvim
  popd
}

function update() {
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
  nvim --headless +"UpdateRemotePlugins | q" &> /dev/null
  nvim --headless +"autocmd User PackerComplete quitall" +"PackerSync" &> /dev/null

  echo "🔥 Upgrade hosts"
  sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts -o /etc/hosts --silent
  sudo nvim --clean --headless +"g/ \(www\.\)\?linkedin.com/d" +"wq" /etc/hosts &> /dev/null

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
