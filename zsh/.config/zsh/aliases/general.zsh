#!/bin/zsh

alias ctags="`brew --prefix`/bin/ctags"

alias e="$EDITOR"

alias grep="grep --color=always"

alias md="mkdir -p"

exa_std="-I '__pycache__|.pytest_cache' --color=always --group-directories-first"
alias la="exa -al $(eval 'echo $exa_std')"
alias ls="exa $(eval 'echo $exa_std') --git-ignore"
alias lt="exa -T $(eval 'echo $exa_std') --level=4 --git-ignore"
alias lvi="la $XDG_DATA_HOME/nvim/site/pack/plugins/start"

alias update_homebrew="brew update; brew upgrade; brew upgrade --cask; brew cleanup --prune=all"
alias update_npm="npm install -g npm; npm update --global"
