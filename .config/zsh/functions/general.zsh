#!/bin/zsh

bip() {
    inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")
    if [[ $inst ]]; then
        for prog in $(echo $inst); do
            brew install $prog
        done
    fi
}

bup() {
    uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:clean]'")
    if [[ $uninst ]]; then
        for prog in $(echo $uninst); do
            brew uninstall $prog
        done
    fi
}

cheat() {
    curl cheat.sh/$1
}

fixall() {
    ~/.pyenv/versions/base/bin/black ${1:-$PWD} --exclude venv
    ~/.pyenv/versions/base/bin/isort ${1:-$PWD} --profile black
}

killjn() {
    ports=$(jn list | grep http | cut -d"/" -f3 | cut -d":" -f2)
    for port in $ports
    do
        pid=$(lsof -n -i4TCP:$port | grep LISTEN | cut -d" " -f3)
        kill -9 $pid
    done
}

wttr() {
    par="$1"
    curl -s "http://wttr.in/$par?MF1ATq"
}
