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
    current_dir="$PWD"
    par="$1"; shift
    case $par in
        --zsh|--nvim|--misc)
            address="$1"
            folder=$(echo $address | rev | cut -c5- | cut -d"/" -f1 | rev)
            ;;
        -h|--help|*)
            echo "Options:"
            echo "cgcl --zsh <github address>"
            echo "cgcl --nvim <github address>"
            echo "cgcl --misc <github address>"
            return 0
            ;;
    esac
    cd ~/.local
    case $par in
        --nvim) submodule_base="share/nvim/site/pack/plugins/start";;
        --zsh) submodule_base="share/zsh/plugins";;
        --misc) submodule_base="share/misc";;
    esac
    cfg submodule add $address $submodule_base/$folder
    cd $current_dir
    return 0
}

cgrs() {
    current_dir="$PWD"
    par="$1"
    cd ~/.local
    case $par in
        --zsh) dir_path="share/zsh/plugins";;
        --nvim) dir_path="share/nvim/site/pack/plugins/start";;
        --misc) dir_path="share/misc";;
        -h|--help|*)
            echo "Options:"
            echo "cgrs --zsh"
            echo "cgrs --nvim"
            echo "cgrs --misc"
            cd $current_dir
            return 0
            ;;
    esac
    submodule_name=$(exa $dir_path | fzf)
    if [ -z $submodule_name ]
    then
        echo "Did not select anything!"
        cd $current_dir
        return 1
    fi
    cfg submodule deinit -f $dir_path/$submodule_name
    cfg rm -rf $dir_path/$submodule_name
    rf $dir_path/$submodule_name
    cd $current_dir
}

cheat() {
    curl cheat.sh/$1
}

chpwd() ls

fixall() {
    ~/.pyenv/versions/base/bin/black ${1:-$PWD} --exclude venv
    ~/.pyenv/versions/base/bin/isort ${1:-$PWD} --profile black
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

gdf() {
    preview="git diff $@ --color=always -- {-1}"
    git status --short | fzf -m --ansi --preview $preview
}

killjn() {
    ports=$(jn list | grep http | cut -d"/" -f3 | cut -d":" -f2)
    for port in $ports
    do
        pid=$(lsof -n -i4TCP:$port | grep LISTEN | cut -d" " -f3)
        kill -9 $pid
    done
}

put() {
    touch $1
    e $1
}

rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}

reload() {
    on_venv="A virtual env is active, please deactivate it first. Aborting."

    [ ! -z $(echo -n $VIRTUAL_ENV) ] && echo $on_venv && return 1
    exec zsh
}

take() {
    mkdir $1
    cd $1
}

updateall() {
    deactivate &> /dev/null && echo "\n>>> deactivated venv if any is active <<<\n"
    echo "\n>>> updating base pip packages <<<\n"
    up-base
    echo "\n>>> updating npm packages <<<\n"
    up-npm
    echo "\n>>> updating git submodules <<<\n"
    up-sub
    echo "\n>>> updating brew & brew casks <<<\n"
    up-brew
    echo "\n>>> updating applications from App Store & MacOS itself <<<"
    echo ">>> will require password <<<\n"
    up-mac
    echo "\n>>> reloading zsh <<<\n"
    exec zsh
}

wttr() {
    par="$1"
    curl -s "http://wttr.in/$par?MF1ATq"
}
