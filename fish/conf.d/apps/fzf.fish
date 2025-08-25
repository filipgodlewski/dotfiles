#!/usr/bin/env fish

set -gx FZF_DEFAULT_OPTS_FILE "$XDG_CONFIG_HOME/fzf/config"
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob '!.git'"

fzf --fish | source
