for file in $ZDOTDIR/config/*; do source $file; done
export LS_COLORS="$(vivid generate ${XDG_CONFIG_HOME}/vivid/nightfox.yml)"
