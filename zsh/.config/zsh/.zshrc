source $HOME/.cargo/env
export PATH=$XDG_CONFIG_HOME/git/commands:$PATH
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/curl/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

for file in $ZDOTDIR/config.*.zsh; do source $file; done

export LS_COLORS=$(vivid generate ${XDG_CONFIG_HOME}/vivid/nightfox.yml)

(( $SHLVL == 1 )) && edit || :
