#!/usr/bin/env zsh

alias g="git"
alias mkdir="mkdir -p"
alias n="nvim"
alias path='echo ${(@F)path}'
alias python="python3"
alias ssudo="op read 'op://msmtazhnbxxwac3zvak3suuyxa/mini/password' | sudo -S"

[[ "$(command -v bat)" ]] && alias cat="bat"

alias ls="eza --git --icons"
alias l1="eza --git --icons -1F"
alias l="eza --git --icons -Fl"
alias ll="eza --git --icons -Fahl"
alias lt="eza --tree --level=2"
alias llt="eza --tree --level=2 -Fahl"
