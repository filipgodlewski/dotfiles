for file in $(fd -- .plugin.zsh ${ZPLUGINSDIR}); do
  source ${file}
done
