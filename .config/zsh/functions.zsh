#!/bin/zsh

ae() {
    deactivate &> /dev/null
    if [ -f ./bin/activate ]; then
        echo "Already in venv directory. Activating."
        source ./bin/activate
        return 0
    fi
    if [ -z "$1" ]; then VENV="venv"; else VENV=$1; fi
    if [ ! -f ./bin/activate ] && [ -d $VENV ]; then
        echo "Found existing venv called: $VENV. Activating"
        source $VENV/bin/activate
        return 0
    else
        echo "Couldn't find '$VENV' directory."
        printf "Do you want to create new venv called: $VENV? [yes/no]: "
        read ANSWER
        case $ANSWER in
            [yY]es|[yY])
                echo "Got it! Creating and activating new venv called: $VENV"
                python -m venv $VENV
                source $VENV/bin/activate
                ;;
            [nN]o|[nN])
                echo "Got it! Aborting."
                return 0
                ;;
            *)
                echo "Wrong answer. Aborting."
                return 1
                ;;
        esac
    fi
}

bip() {
    local inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")

    if [[ $inst ]]; then
        for prog in $(echo $inst)
        do brew install $prog
        done
    fi
}

bup() {
    local uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:clean]'")

    if [[ $uninst ]]; then
        for prog in $(echo $uninst)
        do brew uninstall $prog
        done
    fi
}

cheat() {
    curl cheat.sh/$1
}

chpwd() ls

cgaf() {
    files=$(cfg status --short | rg '^(\s|\S)(M|A|R|C|D|U|!|\?)' | fzf -m)
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
    cfg rm -rf share/nvim/site/pack/plugins/start/$file
    rf share/nvim/site/pack/plugins/start/$file
    1
}

gdf() {
    preview="git diff $@ --color=always -- {-1}"
    git status --short | fzf -m --ansi --preview $preview
}

gaf() {
    preview="git diff $@ --color=always -- {-1}"
    files=$(git status --short | rg '^(\s|\S)(M|A|R|C|D|U|!|\?)' | fzf -m --ansi --preview $preview)
    files_array=($(echo $files | cut -c4-))
    if [ -z $files ]
    then
        echo "Did not select anything!"
        return 1
    fi
    git add $files_array
}

killjn() {
    ports=$(jn list | grep http | cut -d"/" -f3 | cut -d":" -f2)
    for port in $ports
    do
        pid=$(lsof -n -i4TCP:$port | grep LISTEN | cut -d" " -f3)
        kill -9 $pid
    done
}

macho() {
    manual=$(apropos . | \
        grep -v -E '^.+ \(0\)' | \
        sed 's/(/ (/g' | \
        awk '{print $1}' | \
        sort -u | \
        fzf --preview="echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null")

    [ -z "$manual" ] && return 0
    man $manual
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

updateall() {
    deactivate &> /dev/null && echo "\n>>> deactivated venv if any is active <<<\n"
    echo "\n>>> updating coc-extensions <<<\n"
    up-coc
    echo "\n>>> updating pip packages <<<\n"
    up-pip
    echo "\n>>> updating git submodules <<<\n"
    up-sub
    echo "\n>>> updating brew & brew casks <<<\n"
    up-brew
    echo "\n>>> updating antibody <<<\n"
    up-antibody
    echo "\n>>> reloading zsh <<<\n"
    exec zsh
}
