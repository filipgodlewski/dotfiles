export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
[[ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]] && XDG_RUNTIME_DIR="/tmp"
export XDG_RUNTIME_DIR

# homebrew
if [[ "$(uname -m)" == "arm64" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BAT=1
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"

# zsh
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export ZPLUGINSDIR="$XDG_DATA_HOME/zsh/plugins"
export EDITOR=nvim
export LC_ALL=en_US.UTF-8
export WORDCHARS=${WORDCHARS/\/}
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

export ANTIDOTE_DIR="$XDG_DATA_HOME/antidote"
export ANTIDOTE_PLUGINS="$ZDOTDIR/zsh_plugins.txt"
export ANTIDOTE_STATIC_FILE="$ZDOTDIR/zsh_plugins.zsh"

[[ -e $ANTIDOTE_DIR ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
source $ANTIDOTE_DIR/antidote.zsh
antidote bundle < $ANTIDOTE_PLUGINS > $ANTIDOTE_STATIC_FILE

autoload -Uz "$ANTIDOTE_DIR/functions/antidote"
source $ANTIDOTE_STATIC_FILE

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

# rip
if [[ "$(uname -s)" == "Darwin" ]]; then
  export GRAVEYARD="$HOME/.Trash"
fi

# python
export PYFLYBY_PATH="$XDG_CONFIG_HOME/pyflyby:/etc/pyflyby:$HOME/.pyflyby:.../.pyflyby"

# rust
export CARGO_HOME="$XDG_CONFIG_HOME/rust/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust/rustup"

# go
export GOPATH="$HOME/dev/go"
mkdir -p $GOPATH/{bin,src,pkg}

# 1password
op_plugins="$XDG_CONFIG_HOME/op/plugins.sh"
[[ -f $op_plugins ]] && source $op_plugins

# fzf
function _fzf_zvm_init() {
  [[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
}
zvm_after_init_commands+=(_fzf_zvm_init)

# zoxide
export _ZO_DATA_DIR="$XDG_DATA_HOME"
export _ZO_RESOLVE_SYMLINKS=1
