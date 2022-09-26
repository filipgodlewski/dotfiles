for file in $(fd -- .plugin.zsh ${ZPLUGINSDIR}); do
  source ${file}
done

[[ -d $HOME/bin ]] || mkdir $HOME/bin
[[ -f $HOME/bin/you ]] || ln -s $YOU_BASE_DIR/you $HOME/bin/you
