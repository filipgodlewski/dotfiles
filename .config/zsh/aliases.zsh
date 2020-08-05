#!/bin/zsh

alias 1="cd -1"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"

alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias ctags="`brew --prefix`/bin/ctags"

alias e="$EDITOR"

alias fbrew="brew list | fzf -m --preview 'bat <(brew info {1})'"
alias fbrewcask="brew cask list | fzf -m --preview 'bat <(brew cask info {1})'"
alias fff="fzf --preview 'bat --color=always {}'"
alias fixall="black . --exclude venv; isort --profile black ."

alias grep="grep --color=always"

alias jn="jupyter notebook"
alias jnd="jupyter nbextension disable connector-jupyter --py --sys-prefix"
alias jne="jupyter nbextension enable connector-jupyter --py --sys-prefix"
alias jni="jupyter nbextension install connector-jupyter --py --sys-prefix"

alias md="mkdir -p"

alias la="exa -al --color=always --group-directories-first --git"
alias lg="exa -al --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias ls="exa --color=always --group-directories-first --git-ignore"
alias lt="exa -T --color=always --group-directories-first --level=3 --git-ignore"
alias lti="exa -T --color=always --group-directories-first --level=3 --git"
alias lvi="la $XDG_DATA_HOME/nvim/site/pack/plugins/start"

alias reload="exec zsh"
alias rf="rm -rf"

alias up-brew="brew update; brew upgrade; brew cask upgrade; brew cleanup --prune=all"
alias up-coc="nvim -c 'CocUpdateSync | q'"
alias up-pip="pyenv activate base; pip list --outdated --format=freeze | grep -v '^\-e' | cut -d= -f1 | xargs -n1 pip install -U; pyenv deactivate"
alias up-sub="cfg submodule foreach git pull"
alias up-mac="mas upgrade; sudo softwareupdate -i -a"
