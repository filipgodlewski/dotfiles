#!/usr/bin/env fish

set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_RUNTIME_DIR (test -w "/run/user/$UID"; and echo "/run/user/$UID"; or echo "/tmp")

fish_add_path "$HOME/.config/bin"
