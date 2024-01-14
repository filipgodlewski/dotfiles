#!/usr/bin/env fish

if not status is-interactive
    exit
end

# fish settings
fish_config theme choose "Catppuccin Macchiato"
fish_vi_key_bindings
set fish_cursor_default block blink
set fish_cursor_insert line blink
set -U fish_greeting
set -U hydro_fetch true
set -U hydro_multiline true
set -U hydro_color_pwd green
set -U hydro_color_git magenta

# globals
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_RUNTIME_DIR (test -w "/run/user/$UID"; and echo "/run/user/$UID"; or echo "/tmp")

set -gx LESSHISTFILE -
set -gx LANG "en_US.UTF-8"

alias md "mkdir -p"
alias paths "echo $PATH | string split ':'"

if type -sq brew
    set -gx HOMEBREW_PREFIX (test (uname -m) = "arm64"; and echo "/opt/homebrew"; or echo "/usr/local")
    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_AUTOREMOVE 1
    set -gx HOMEBREW_CASK_OPTS --no-quarantine
    fish_add_path $HOMEBREW_PREFIX/sbin
    fish_add_path $HOMEBREW_PREFIX/bin
    fish_add_path $HOMEBREW_PREFIX/opt/curl/bin
    fish_add_path $HOMEBREW_PREFIX/opt/fzf/bin
end

if type -sq git
    fish_add_path $XDG_CONFIG_HOME/git/commands
    alias g git
end

app_alias gg lazygit

if type -sq docker
    set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
end

if type -sq npm
    set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
    set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
    set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
end

if type -sq python3
    alias python3 python3.12
    alias python python3
    set -gx VIRTUAL_ENV_DISABLE_PROMPT true
end

if type -sq nvim
    set -gx EDITOR nvim
    set -gx MANPAGER "nvim +Man!"
    set -gx PAGER nvim
    alias n nvim
end

if type -sq pipx
    fish_add_path $HOME/.local/bin
end

if type -sq rustup
    set -gx RUSTUP_HOME "$XDG_CONFIG_HOME/rust/rustup"
    set -gx CARGO_HOME "$XDG_CONFIG_HOME/rust/cargo"
    fish_add_path $CARGO_HOME/bin
end

if type -sq go
    set -gx GOPATH "$HOME/dev/go"
    mkdir -p $GOPATH/{bin,src,pkg}
    fish_add_path $GOPATH/bin
end

if type -sq rip
    alias rm rip
    set -gx GRAVEYARD "$HOME/.Trash"
end

if type -sq op
    alias sudo "op read 'op://msmtazhnbxxwac3zvak3suuyxa/mini/password' | command sudo -S --prompt=''"
end

if type -sq eza
    alias ls "eza --git --icons --group-directories-first"
    alias tree "ls --tree"
    alias ll "ls -Fahl"
    alias lt "tree --level=2"
    alias llt "tree --level=2 -Fahl"
end
alias l1 "ls -1F"
alias l "ls -Fl"

if type -sq fzf
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

if type -sq zoxide
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
    alias s "ji && nvim"
end
