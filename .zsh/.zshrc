source ~/.zsh/.aliases.zsh
source ~/.zsh/.antibody.sh
source ~/.zsh/.completions.zsh
source ~/.zsh/.exports.zsh
source ~/.zsh/.externals.zsh
source ~/.zsh/.functions.zsh
source ~/.zsh/.fzf.zsh
source ~/.zsh/.history.zsh

zle -N rationalise-dot
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

autoload -Uz compinit
for dump in ~/.zsh/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

eval "$(starship init zsh)"
