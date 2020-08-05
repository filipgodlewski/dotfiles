#!/bin/zsh

ae() {
    original_path="$PATH"
    base_site_packages_path=$(eval "echo $(pyenv prefix)/**/base/lib/**/site-packages")
    case $1 in
        "")
            VENV=$(pyenv virtualenvs --skip-aliases | cut -d" " -f3 | fzf)
            if [ ! -z $VENV ]; then pyenv activate $VENV; fi
            export PATH="$VIRTUAL_ENV:$PATH"
            virtual_site_packages_path=$(eval "echo $(pyenv prefix)/lib/**/site-packages")
            python ~/.local/share/helpers/change_venv.py $virtual_site_packages_path False
            return 0
            ;;
        *) VENV=$1;;
    esac
    VENV_ARRAY=($(pyenv virtualenvs --skip-aliases | cut -d" " -f3))
    if [ $VENV_ARRAY ~= $VENV &> /dev/null ]; then
        pyenv activate $VENV
    else
        echo "Did not find venv with the provided name: $VENV"
        echo "Would you like to:"
        echo "\t[C] create and activate it,"
        echo "\t[l] list available ones (if one selected, activate it), or"
        echo "\t[a] abort?"
        printf "Your Answer: "
        read ANSWER; echo
        case $ANSWER in
            [cC]|"")
                echo "Creating and activating venv called: $VENV\n"
                pyenv virtualenv $(pyenv global) $VENV &> /dev/null
                pyenv activate $VENV
                pip -q install --upgrade pip; pip -q install wheel
                ;;
            [lL])
                ANOTHER=$(pyenv virtualenvs --skip-aliases | cut -d" " -f3 | fzf)
                if [ -z $ANOTHER ]; then echo "Didn't choose anything. Aborting."; return 0; fi
                pyenv activate $ANOTHER
                return 0
                ;;
            *) echo "Aborting."; return 0;;
        esac
    fi
    export PATH="$VIRTUAL_ENV:$PATH"
    return 0
}

bip() {
    local inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")
    if [[ $inst ]]; then
        for prog in $(echo $inst); do
            brew install $prog
        done
    fi
}

bup() {
    local uninst=$(brew leaves | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:clean]'")
    if [[ $uninst ]]; then
        for prog in $(echo $uninst); do
            brew uninstall $prog
        done
    fi
}

cgaf() {
    local files=$(cfg status --short | rg '^(\s|\S)(M|A|R|C|D|U|!|\?)' | fzf -m)
    local files_array=($(echo $files | cut -c4-))
    if [ -z $files ]
    then
        echo "Did not select anything!"
        return 1
    fi
    cfg add $files_array
}

cgcl() {
    local current_dir="$PWD"
    local par="$1"; shift
    case $par in
        --zsh|--nvim)
            local address="$1"
            local folder=$(echo $address | rev | cut -c5- | cut -d"/" -f1 | rev)
            ;;
        -h|--help|*)
            echo "Options:"
            echo "cgcl --zsh <github address>"
            echo "cgcl --nvim <github address>"
            return 0
            ;;
    esac
    cd ~/.local
    case $par in
        --nvim) local submodule_base="share/nvim/site/pack/plugins/start";;
        --zsh) local submodule_base="share/zsh/plugins";;
    esac
    cfg submodule add $address $submodule_base/$folder
    cd $current_dir
    return 0
}

cgrs() {
    local current_dir="$PWD"
    local par="$1"
    cd ~/.local
    case $par in
        --zsh) local dir_path="share/zsh/plugins";;
        --nvim) local dir_path="share/nvim/site/pack/plugins/start";;
        -h|--help|*)
            echo "Options:"
            echo "cgrs --zsh"
            echo "cgrs --nvim"
            return 0
            ;;
    esac
    local submodule_name=$(exa $dir_path | fzf)
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

de() {
    pyenv deactivate
    python ~/.local/share/helpers/change_venv.py $base_site_packages_path True
    export PATH="$original_path"
    CURRENT_VIRTUAL_ENV=""
}

dele() {
    pyenv deactivate &> /dev/null
    python ~/.local/share/helpers/change_venv.py $base_site_packages_path True
    local venv=( $(pyenv virtualenvs --skip-aliases | cut -d" " -f3 | fzf -m) )
    for item in $venv; do
        if [ ! -z $item ]; then
            pyenv virtualenv-delete -f $item
            echo "Deleted venv: $item"
        fi
    done
    return 0
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

    echo "\n>>> updating applications from App Store & MacOS itself <<<"
    echo ">>> will require password <<<\n"
    up-mac

    echo "\n>>> reloading zsh <<<\n"
    exec zsh
}

wttr() {
    ARG="$1"
    if [ -z $ARG ]; then
        LOCATION=$(curl -s "ipinfo.io/city")
    else
        LOCATION=$ARG
    fi
    curl -s "http://wttr.in/$LOCATION?MF1ATq"
}
