for file in $ZDOTDIR/config/*; do source $file; done
for file in $ZDOTDIR/variables/*; do source $file; done
for file in $ZDOTDIR/aliases/*; do source $file; done
for file in $ZDOTDIR/functions/*; do autoload -Uz $file; done

export LESSHISTFILE=/dev/null
export LS_COLORS="$(vivid generate ${XDG_CONFIG_HOME}/vivid/nord.yml)"

export TASKRC="$XDG_CONFIG_HOME/taskwarrior/.taskrc"
