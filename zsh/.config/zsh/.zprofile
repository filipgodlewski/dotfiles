function to_path() {
  if [[ "$PATH" != *"$1"* ]]; then 
    PATH="$1${PATH+:$PATH}"
  fi
}

function to_manpath() {
  if [[ "$MANPATH" != *"$1"* ]]; then 
    MANPATH="$1${MANPATH+:$MANPATH}"
  fi
}

function to_infopath() {
  if [[ "$INFOPATH" != *"$1"* ]]; then 
    INFOPATH="$1${INFOPATH+:-}"
  fi
}

to_path "$HOMEBREW_PREFIX/sbin"
to_path "$HOMEBREW_PREFIX/bin"
to_path "$HOMEBREW_PREFIX/opt/curl/bin"
to_path "$HOMEBREW_PREFIX/opt/fzf/bin"
to_path "$XDG_CONFIG_HOME/git/commands"
to_path "$HOME/.local/bin"  # pipx
to_path "$CARGO_HOME/bin"  # rust
to_path "$GOPATH/bin"  # go
export PATH
typeset -U path

to_manpath "$HOMEBREW_PREFIX/share/man"
to_infopath "$HOMEBREW_PREFIX/share/info"
