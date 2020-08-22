autoload -Uz compinit; compinit

source $ZDOTDIR/completions.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/fzf.zsh
source <(cat $ZDOTDIR/variables/*.zsh)
source <(cat $ZDOTDIR/aliases/*.zsh)
source $ZDOTDIR/plugins.zsh
source <(cat $ZDOTDIR/functions/*.zsh)
source $ZDOTDIR/bindings.zsh

export LC_ALL=en_US.UTF-8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
