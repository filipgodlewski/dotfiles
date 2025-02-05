#!/usr/bin/env fish

if not status is-interactive
    exit
end

# FISH SETTINGS

fish_config theme choose "Catppuccin Macchiato"
fish_vi_key_bindings
set fish_cursor_default block blink
set fish_cursor_insert line blink
set -gx fish_greeting
set -gx hydro_fetch true
set -gx hydro_multiline true
set -gx hydro_color_pwd green
set -gx hydro_color_git magenta

# GLOBALS

set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_RUNTIME_DIR (test -w "/run/user/$UID"; and echo "/run/user/$UID"; or echo "/tmp")

set -gx LESSHISTFILE -
set -gx LANG "en_US.UTF-8"

# SYSTEM ABBREVIATIONS

abbr -a -- md 'mkdir -p'
abbr -a -- l1 'ls -1'
abbr -a -- ll 'ls -l'
abbr -a -- lh 'ls -lah'

# APP CONFIGS, ALPHABETICALLY

if command -sq brew
    set -gx HOMEBREW_PREFIX (test (uname -m) = "arm64"; and echo "/opt/homebrew"; or echo "/usr/local")
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_AUTOREMOVE 1
    set -gx HOMEBREW_CASK_OPTS --no-quarantine
    fish_add_path $HOMEBREW_PREFIX/sbin
    fish_add_path $HOMEBREW_PREFIX/bin
    fish_add_path $HOMEBREW_PREFIX/opt/curl/bin
    fish_add_path $HOMEBREW_PREFIX/opt/fzf/bin
end

if command -sq eza
    abbr -a -- lt 'ls --tree --level=1'
end

if command -sq fzf
    set -l interface "--cycle --layout=reverse --keep-right"
    set -l layout "--border=none --padding=2,5 --info=inline --prompt ' ' --pointer ' ' --marker ' '"
    set -l display "
    --color fg:#cad3f5
    --color fg+:#cad3f5
    --color bg:#24273a
    --color bg+:#363a4f
    --color spinner:#f4dbd6
    --color hl:#ed8796
    --color hl+:#ed8796
    --color header:#ed8796
    --color info:#c6a0f6
    --color pointer:#f4dbd6
    --color marker:#f4dbd6
    --color prompt:#c6a0f6
    "

    set -gx FZF_DEFAULT_OPTS (echo -n $interface $layout (echo $display | string trim | string join -n " "))
    set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --glob '!.git'"
end

if command -sq git
    abbr -a -- g git
end

if command -sq go
    set -gx GOPATH "$HOME/dev/go"
    mkdir -p $GOPATH/{bin,src,pkg}
    fish_add_path $GOPATH/bin
end

if command -sq lazygit
    abbr -a -- gg lazygit
end

if command -sq nvim
    set -gx EDITOR nvim
    set -gx MANPAGER "nvim +Man!"
    set -gx PAGER nvim
    abbr -a -- n nvim
end

if command -sq python3
    app_alias python python3
    app_alias pip pip3
    abbr -a -- py python
end

if command -sq rip
    app_alias rm rip
    set -gx GRAVEYARD "$HOME/.Trash"
end

if command -sq zoxide
    set -gx _ZO_DATA_DIR $XDG_DATA_HOME
    set -gx _ZO_RESOLVE_SYMLINKS 1
    if type -sq fzf
        set -l search "--exact --no-sort"
        set -l interface "--bind=ctrl-z:ignore,btab:up,tab:down"
        set -l display "--tabstop=1"
        set -l scripting "--exit-0 --select-1"
        set -l preview "--preview='eza -1 --color always --icons always --all --group-directories-first --git-ignore {2..}'"
        set -gx _ZO_FZF_OPTS (echo -n $FZF_DEFAULT_OPTS $search $interface $display $scripting $preview)
    end
    zoxide init --cmd j fish | source

    if command -sq nvim
        function session --description 'session selector'
            ji && nvim
        end
        abbr -a -- s session
    end
end
