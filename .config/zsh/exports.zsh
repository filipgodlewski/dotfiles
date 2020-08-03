#!/bin/zsh

export VISUAL="nvim"
export EDITOR=$VISUAL

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export LC_ALL=en_US.UTF-8
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export RIPGREP_CONFIG_PATH=~/.config/.ripgreprc
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$PYENV_ROOT/bin:$PATH"
