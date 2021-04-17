for file in $ZDOTDIR/config/*; do source $file; done
for file in $ZDOTDIR/variables/*; do source $file; done
for file in $ZDOTDIR/aliases/*; do source $file; done
for file in $ZDOTDIR/functions/*; do autoload -Uz $file; done

export LESSHISTFILE=/dev/null
