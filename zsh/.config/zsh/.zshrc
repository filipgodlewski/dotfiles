for file in $ZDOTDIR/config/*; do source $file; done
export LS_COLORS="$(vivid generate ${XDG_CONFIG_HOME}/vivid/nightfox.yml)"
eval "$(zoxide init zsh)"
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export PAGER=$HOMEBREW_PREFIX/bin/moar
