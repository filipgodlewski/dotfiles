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

alias emptytrash="sudo rm -rf /Volumes/*/.Trashes; sudo rm -rf ~/.Trash; sudo rm -rf /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

alias fbrew="brew list | fzf -m --preview 'bat <(brew info {1})'"
alias fbrewcask="brew cask list | fzf -m --preview 'bat <(brew cask info {1})'"
alias fff="fzf --preview 'bat --color=always {}'"

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
alias lvi="la ~/.local/share/nvim/site/pack/plugins/start"

alias paths="echo $PATH | tr ':' '\n' | sort"
alias python="python3"

alias rf="rm -rf"

alias up-brew="brew update; brew upgrade; brew cask upgrade; brew cleanup --prune=all"
alias up-mac="up-sub; up-brew; emptytrash; zload"
alias up-sub="cfg submodule foreach git pull"

alias v="nvim"
alias vff="v -c Files!"
alias valias="v ~/.config/zsh/aliases.zsh"
alias vfunction="v ~/.config/zsh/functions.zsh"
alias vvi="v ~/.config/nvim/init.vim"
alias vzsh="v ~/.config/zsh/.zshrc"

alias zload="source ~/.config/zsh/.zshrc; antibody bundle < ~/.config/zsh/antibody.txt > ~/.config/zsh/antibody.sh"

