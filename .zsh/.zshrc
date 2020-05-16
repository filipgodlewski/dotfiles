HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

source ~/.zsh/.aliases.zsh
source ~/.zsh/.completions.zsh
source ~/.zsh/.exports.zsh
source ~/.zsh/.externals.zsh
source ~/.zsh/.functions.zsh
source ~/.zsh/.antibody.sh


zle -N rationalise-dot
bindkey . rationalise-dot
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history

# Completion
setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt flow_control
setopt menu_complete
setopt no_case_glob
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushdminus

autoload -Uz compinit
for dump in ~/.zsh/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

eval "$(starship init zsh)"
