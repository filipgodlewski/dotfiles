folders=("config" "variables" "aliases")

for folder in $folders; do
    for file in $ZDOTDIR/$folder/*; do source $file; done
done

for file in $ZDOTDIR/functions/*; do autoload -Uz $file; done
