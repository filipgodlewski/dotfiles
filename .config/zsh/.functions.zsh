#!/bin/zsh

cheat() {
        curl cheat.sh/$1
}

chpwd() ls

cgaf() {
        files=$(cgss | rg '^(\s|\S)(M|A|R|C|D|U|!|\?)' | fzf -m)
        files_array=($(echo $files | cut -c4-))
        if [ -z $files ]
        then
            echo "Did not select anything!"
            return 1
        fi
        cfg add $files_array
}

cgcl() {
        cd ~/.local
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        cfg submodule add $1 share/nvim/site/pack/plugins/start/$folder
        1
}

cgrs() {
        cd ~/.local
        file=$(exa share/nvim/site/pack/plugins/start | fzf)
        if [ -z $file ]
        then
            echo "Did not select anything!"
            1
            return 1
        fi
        cfg submodule deinit -f share/nvim/site/pack/plugins/start/$file
        cfg rm -r share/nvim/site/pack/plugins/start/$file
        rf share/nvim/site/pack/plugins/start/$file
        1
}

gdiffs() {
        preview="git diff $@ --color=always -- {-1}"
        git diff $@ --name-only | fzf -m --ansi --preview $preview
}

gaf() {
        preview="git diff $@ --color=always -- {-1}"
        files=$(gss | rg '^(\s|\S)(M|A|R|C|D|U|!|\?)' | fzf -m --ansi --preview $preview)
        files_array=($(echo $files | cut -c4-))
        if [ -z $files ]
        then
            echo "Did not select anything!"
            return 1
        fi
        git add $files_array
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

