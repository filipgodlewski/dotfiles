#!/bin/zsh

function update() {
  if (( $SHLVL != 1 )); then
    echo "💔 First close nvim"
    return 1
  fi

  [[ -d $XDG_CACHE_HOME/local_update ]] || mkdir -p $XDG_CACHE_HOME/local_update
  local LOG_FILE=$XDG_CACHE_HOME/local_update/update_$(date +"%Y-%m-%d_%T").log

  touch $LOG_FILE

  function log_info() {
    echo "$1" | tee -a $LOG_FILE
  }

  log_info "🔥 Upgrade hosts"
  sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts -o /etc/hosts &>> $LOG_FILE
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
    sudo nvim --clean --headless +"g/ $page/d" +"wq" /etc/hosts &>> $LOG_FILE
  done

  log_info "🔥 Upgrade brew packages"
  brew update &>> $LOG_FILE
  brew bundle --file=~/.Brewfile &>> $LOG_FILE
  brew upgrade &>> $LOG_FILE


  log_info "🔥 Upgrade npm packages"
  npm update --global &>> $LOG_FILE
  npm cache clean --force &>> $LOG_FILE

  log_info "🔥 Upgrade pipx packages"
  pipx upgrade-all &>> $LOG_FILE

  log_info "🔥 Upgrade nvim"
  nvim --headless +"Lazy! sync" +qa &>> $LOG_FILE
  nvim --headless +"autocmd User MasonUpdateAllComplete quitall" +"MasonUpdateAll" &>> $LOG_FILE
  nvim --headless +"TSUpdateSync" +q &>> $LOG_FILE
  nvim --headless +"UpdateRemotePlugins" +q &>> $LOG_FILE

  log_info "🔥 Upgrade nvim venv"
  local py=$XDG_DATA_HOME/venvs/nvim/bin/python
  $py -m pip list --format freeze --no-index | sed 's/==.*//' | xargs -n1 $py -m pip install --upgrade &>> $LOG_FILE

  log_info "🔥 Upgrade zsh packages"
  antidote update &>> $LOG_FILE

  exec zsh
}

function rationalise-dot() {
  [[ $LBUFFER = *.. ]] && LBUFFER+=/.. || LBUFFER+=.
}
zle -N rationalise-dot 
bindkey . rationalise-dot

bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

local LFCD="$XDG_CONFIG_HOME/lf/lfcd.sh"
if [[ -f "$LFCD" ]]; then
  source "$LFCD"
  bindkey -s '^o' 'lfcd\n'
fi


if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
