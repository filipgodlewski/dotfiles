#!/bin/zsh

cheat() {
        curl cheat.sh/$1
}

chpwd() ls

cgcl() {
        cd ~/.vim
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        cfg submodule add $1 pack/plugins/start/$folder
        1
}

cgrs() {
        cfg submodule deinit -f .vim/pack/plugins/start/$1
        cfg rm .vim/pack/plugins/start/$1
        rf .vim/pack/plugins/start/$1
}

gamp() {
        gaa
        gcmsg $1
        gp
}

gdiffs() {
        preview="git diff $@ --color=always -- {-1}"
        git diff $@ --name-only | fzf -m --ansi --preview $preview
}

put() {
        touch $1
        v $1
}

rationalise-dot() {
        if [[ $LBUFFER = *.. ]]; then
          LBUFFER+=/..
        else
          LBUFFER+=.
        fi
}

take() {
        mkdir $1
        cd $1
}

