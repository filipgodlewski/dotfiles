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

alias cbrew="brew update; brew upgrade; brew cleanup --prune=all"
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

alias cga="cfg add"
alias cgc="cfg commit -v"
alias cgp="cfg push"
alias cgss="cfg status -s"
alias cgsu="cfg submodule update --remote --merge"
alias cguf="cfg reset --"
alias crmd="v ~/README.md"

alias ctags="`brew --prefix`/bin/ctags"

alias emptytrash="sudo rm -rf /Volumes/*/.Trashes; sudo rm -rf ~/.Trash; sudo rm -rf /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

alias fff="fzf --preview 'bat --color=always {}'"
alias fof="v -c Files!"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//' | cut -d' ' -f1"

alias ga="git add"
alias gc="git commit -v"
alias gd="git diff --word-diff"
alias gl="git pull"
alias gp="git push"
alias gsb="git status -sb"
alias gss="git status -s"
alias gsu="git submodule update --remote --merge"

alias grep="grep --color=always"

alias jn="jupyter notebook"
alias jnd="jupyter nbextension disable connector-jupyter --py --sys-prefix"
alias jne="jupyter nbextension enable connector-jupyter --py --sys-prefix"
alias jni="jupyter nbextension install connector-jupyter --py --sys-prefix"

alias md="mkdir -p"
alias mac-mnt="cgsu; cbrew; emptytrash; zload"

alias la="exa -al --color=always --group-directories-first --git"
alias lg="exa -al --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias ls="exa --color=always --group-directories-first --git-ignore"
alias lt="exa -DT --color=always --group-directories-first --level=3 --git-ignore"
alias lti="exa -DT --color=always --group-directories-first --level=3 --git"
alias lvi="la ~/.vim/pack/plugins/start"

alias paths="echo $PATH | tr ':' '\n'"
alias pip="pip3"
alias python="python3"
alias rf="rm -rf"

alias v="nvim"

alias zalias="v ~/.config/zsh/.aliases.zsh"
alias zfunction="v ~/.config/zsh/.functions.zsh"
alias zload="source ~/.config/zsh/.zshrc; antibody bundle < ~/.config/zsh/.antibody.txt > ~/.config/zsh/.antibody.sh"
alias zvi="v ~/.config/nvim/init.vim"
alias zzsh="v ~/.config/zsh/.zshrc"

