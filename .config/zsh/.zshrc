source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/antibody.sh
source ~/.config/zsh/completions.zsh
source ~/.config/zsh/exports.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/history.zsh

zle -N rationalise-dot
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

autoload -Uz compinit
for dump in ~/.config/zsh/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

eval "$(starship init zsh)"
eval "$(pyenv init -)"
