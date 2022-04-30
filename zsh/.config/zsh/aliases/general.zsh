#!/bin/zsh

alias ld="exa --only-dirs --all --oneline"
alias ll="exa --icons --all --long --git --header --color-scale --time-style long-iso --group-directories-first"
alias ls="exa --git-ignore"
alias tree="exa --tree --level=3 --git-ignore"

alias update_homebrew="brew update; brew upgrade; brew upgrade --cask; brew cleanup --prune=all"
alias update_npm="npm install -g npm; npm update --global"
