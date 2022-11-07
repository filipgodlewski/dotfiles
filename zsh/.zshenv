export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

[[ "$(uname -m)" == "arm64" ]] && tmp_path=/opt/homebrew || tmp_path=/usr/local
export HOMEBREW_PREFIX=$tmp_path
export HOMEBREW_CELLAR=$tmp_path/Cellar
export HOMEBREW_REPOSITORY=$tmp_path
unset tmp_path
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BAT=1
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"

export ZPLUGINSDIR=$XDG_DATA_HOME/zsh/plugins
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/.ripgreprc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export GRAVEYARD=$HOME/.Trash

export EDITOR=nvim

export LC_ALL=en_US.UTF-8

export PYFLYBY_PATH="$XDG_CONFIG_HOME/pyflyby:/etc/pyflyby:$HOME/.pyflyby:.../.pyflyby"
