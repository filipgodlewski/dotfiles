autoload -Uz compinit; compinit

source $ZDOTDIR/completions.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/functions.zsh

zle -N rationalise-dot
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
