export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
[[ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]] && XDG_RUNTIME_DIR=/tmp
export XDG_RUNTIME_DIR

function to_path() {
  [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"
  export PATH
}

# git
to_path "$XDG_CONFIG_HOME/git/commands"

# homebrew
if [[ "$(uname)" == "Darwin" ]]; then
  if [[ "$(uname -m)" == "arm64" ]]; then
    tmp_path="/opt/homebrew"
  else
    tmp_path="/usr/local"
  fi
  export HOMEBREW_PREFIX=$tmp_path
  export HOMEBREW_CELLAR=$tmp_path/Cellar
  export HOMEBREW_REPOSITORY=$tmp_path
  unset tmp_path
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_BAT=1
  export HOMEBREW_AUTOREMOVE=1
  export HOMEBREW_CASK_OPTS="--no-quarantine"
  export HOMEBREW_BUNDLE_FILE="$HOME"/.Brewfile

  to_path "$HOMEBREW_PREFIX/bin"
  to_path "$HOMEBREW_PREFIX/sbin"
  to_path "$HOMEBREW_PREFIX/opt/curl/bin"
  to_path "$HOMEBREW_PREFIX/opt/fzf/bin"
fi

# docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# less
export LESSHISTFILE=$XDG_CACHE_HOME/less/history

# zsh
export HISTFILE=$XDG_STATE_HOME/zsh/history
export ZPLUGINSDIR=$XDG_DATA_HOME/zsh/plugins

# ripgrep
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/.ripgreprc

# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm

# rip
if [[ "$(uname)" == "Darwin" ]]; then
  export GRAVEYARD=$HOME/.Trash
fi

# system-wide
export EDITOR=nvim
export LC_ALL=en_US.UTF-8
export WORDCHARS=${WORDCHARS/\/}

# python
export PYFLYBY_PATH="$XDG_CONFIG_HOME/pyflyby:/etc/pyflyby:$HOME/.pyflyby:.../.pyflyby"
# -- pipx
to_path "$HOME/.local/bin"

# rust
export CARGO_HOME=$XDG_CONFIG_HOME/rust/cargo
export RUSTUP_HOME=$XDG_CONFIG_HOME/rust/rustup
to_path "$CARGO_HOME/bin"
[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"

# go
export GOPATH="$HOME/go"
to_path "$GOPATH/bin"
mkdir -p $GOPATH/{bin,src,pkg}

