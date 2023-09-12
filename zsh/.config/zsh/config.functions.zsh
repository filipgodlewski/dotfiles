#!/bin/zsh

function update() {
  if (( $SHLVL != 1 )); then
    echo "💔 First close nvim"
    return 1
  fi

  [[ -d $XDG_CACHE_HOME/local_update ]] || mkdir -p $XDG_CACHE_HOME/local_update
  local log_file=$XDG_CACHE_HOME/local_update/update_$(date +"%Y-%m-%d_%T").log

  touch $log_file

  local function log_info() {
    echo "$1"
    echo "\n\n$1" >> $log_file
  }

  local function log_find() {
    local LAST_SIG=$?
    echo
    echo "View the log file using:"
    echo "$EDITOR $log_file"
    return $?
  }

  local function abort() {
    echo "\nAborted." | tee -a $log_file
    log_find
  }

  trap "abort; return 1" INT

  log_info "🔥 Upgrade hosts"
  local hosts_url="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
  ssudo -S curl $hosts_url -o /etc/hosts &>> $log_file

  local line
  for line in $(<$ZDOTDIR/whitelist_pages); do
    sudo nvim --clean --headless +"g/ $line$/d" +"wq" /etc/hosts &>> $log_file
  done

  log_info "🔥 Upgrade brew packages"
  brew update &>> $log_file
  brew bundle --file=~/.Brewfile &>> $log_file
  brew upgrade &>> $log_file

  log_info "🔥 Upgrade npm packages"
  npm update --global &>> $log_file
  npm cache clean --force &>> $log_file

  log_info "🔥 Upgrade pipx packages"
  pipx upgrade-all &>> $log_file
  [[ $? == 0 ]] || pipx reinstall-all &>> $log_file

  log_info "🔥 Upgrade nvim"
  nvim --headless -c "Lazy! sync" -c "qa" &>> $log_file
  nvim --headless -c "autocmd User MasonToolsUpdateCompleted quitall" -c "MasonToolsUpdate" &>> $log_file
  nvim --headless -c "TSUpdateSync" -c "q" &>> $log_file

  log_info "🔥 Upgrade nvim venv"
  local py=$XDG_DATA_HOME/venvs/nvim/bin/python
  $py -m pip list --format freeze --no-index | sed 's/==.*//' | xargs -n1 $py -m pip install --upgrade &>> $log_file

  log_info "🔥 Upgrade zsh packages"
  antidote update &>> $log_file

  log_find
}

function aic() {
  export OPENAI_KEY=$(op read 'op://Dev/OpenAI API Key/key')
  aicommits $@
}
