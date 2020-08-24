#!/bin/zsh

alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias ctags="`brew --prefix`/bin/ctags"

alias e="$EDITOR"

alias grep="grep --color=always"

alias md="mkdir -p"

alias la="exa -al --color=always --group-directories-first --git"
alias lg="exa -al --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias ls="exa --color=always --group-directories-first --git-ignore"
alias lt="exa -T --color=always --group-directories-first --level=3 --git-ignore"
alias lti="exa -T --color=always --group-directories-first --level=3 --git"
alias lvi="la $XDG_DATA_HOME/nvim/site/pack/plugins/start"

alias rf="rm -rf"

alias up-brew="brew update; brew upgrade; brew cask upgrade; brew cleanup --prune=all"
alias up-base="pyenv activate base; uppip; pyenv deactivate"
alias up-mac="mas upgrade; sudo softwareupdate -i -a"
alias up-npm="npm install -g npm; npm update --global"
