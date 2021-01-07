source $ZDOTDIR/completions.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/fzf.zsh
source <(cat $ZDOTDIR/variables/*.zsh)
source <(cat $ZDOTDIR/aliases/*.zsh)
source $ZDOTDIR/bindings.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/prompt.zsh

for function in $ZDOTDIR/functions/*; do
    autoload -Uz $function
done
