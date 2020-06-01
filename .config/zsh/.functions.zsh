#!/bin/zsh

cheat() {
        curl cheat.sh/$1
}

chpwd() ls

cgcl() {
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        cfg submodule add $1 ~/.local/share/nvim/site/pack/plugins/start/$folder
}

cgrs() {
        file=$(exa ~/.local/share/nvim/site/pack/plugins/start | fzf)
        if [ -z $file ]
        then
            echo "Did not select anything!"
            return 1
        fi
        cfg submodule deinit -f ~/.local/share/nvim/site/pack/plugins/start/$file
        cfg rm -r ~/.local/share/nvim/site/pack/plugins/start/$file
        rf ~/.local/share/nvim/site/pack/plugins/start/$file
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

