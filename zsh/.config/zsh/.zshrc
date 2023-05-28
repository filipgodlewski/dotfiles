export WORDCHARS=${WORDCHARS/\/}
source $HOME/.cargo/env
export PATH=$XDG_CONFIG_HOME/git/commands:$PATH
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/curl/bin:$HOMEBREW_PREFIX/opt/fzf/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

export LS_COLORS="$(vivid generate catppuccin-macchiato)"

for file in $ZDOTDIR/config.*.zsh; do source $file; done

ANTIDOTE_DIR=$XDG_DATA_HOME/antidote
ANTIDOTE_PLUGINS=$ZDOTDIR/zsh_plugins.txt
ANTIDOTE_STATIC_FILE=$ZDOTDIR/zsh_plugins.zsh
[[ -e $ANTIDOTE_DIR ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
source $ANTIDOTE_DIR/antidote.zsh
antidote bundle < $ANTIDOTE_PLUGINS > $ANTIDOTE_STATIC_FILE
autoload -Uz $ANTIDOTE_DIR/functions/antidote
source $ANTIDOTE_STATIC_FILE
unset ANTIDOTE_DIR ANTIDOTE_PLUGINS ANTIDOTE_STATIC_FILE

eval "$(starship init zsh)"

# source 1password plugins
source $XDG_CONFIG_HOME/op/plugins.sh

function _fzf_zvm_init() {
  [[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
}
zvm_after_init_commands+=(_fzf_zvm_init)
