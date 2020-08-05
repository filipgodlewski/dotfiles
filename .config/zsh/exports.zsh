#!/bin/zsh

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export LC_ALL=en_US.UTF-8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export RIPGREP_CONFIG_PATH=~/.config/.ripgreprc

export PATH="$PYENV_ROOT/bin:$PATH"
