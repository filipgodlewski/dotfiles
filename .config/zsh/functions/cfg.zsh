#!/bin/zsh

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
