#!/usr/bin/env zsh

alias g="git"
alias mkdir="mkdir -p"
alias n="nvim"
alias path='echo ${(@F)path}'
alias python3="python3.12"
alias python="python3"

# if [[ "$(command -v op)" ]]; then
#     alias sudo="op read 'op://msmtazhnbxxwac3zvak3suuyxa/mini/password' 2> /dev/null | sudo -S --prompt=''"
# fi

if [[ "$(command -v eza)" ]]; then
    alias ls="eza --git --group-directories-first"
    alias tree="ls --tree"
    alias lt="tree --level=2"
    alias llt="tree --level=2 -Fahl"
fi
alias l1="ls -1F"
alias l="ls -Fl"
alias ll="ls -Fahl"

if [[ "$(command -v bat)" ]]; then
    alias cat="bat"
fi

if [[ "$(command -v zoxide)" ]]; then
    alias s="ji && nvim"
fi

if [[ "$(command -v lazygit)" ]]; then
  alias gg="lazygit"
fi
