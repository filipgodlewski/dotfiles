source $ZPLUGINSDIR/filipgodlewski.dot/dot.plugin.zsh

source $ZPLUGINSDIR/filipgodlewski.venv/venv.plugin.zsh

source $ZPLUGINSDIR/zdharma-continuum.fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

source $ZPLUGINSDIR/zsh-users.zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

source $ZPLUGINSDIR/zsh-users.zsh-completions/zsh-completions.plugin.zsh
fpath=($ZPLUGINSDIR/zsh-users.zsh-completions/src $fpath)
rm -f $XDG_CONFIG_HOME/zsh/.zcompdump; compinit

source $ZPLUGINSDIR/zsh-users.zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
