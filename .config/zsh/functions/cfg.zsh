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

add_submodule() {
    current_dir="$PWD"
    par="$1"; shift
    case $par in
        --zsh|--nvim|--misc|--tmux)
            address="$1"
            folder=$(echo $address | rev | cut -c5- | cut -d"/" -f1 | rev)
            ;;
        -h|--help|*)
            echo "Options:"
            echo "add_submodule --zsh <github address>"
            echo "add_submodule --nvim <github address>"
            echo "add_submodule --misc <github address>"
            echo "add_submodule --tmux <github address>"
            return 0
            ;;
    esac
    cd ~/.local
    case $par in
        --nvim) submodule_base="share/nvim/site/pack/plugins/start";;
        --zsh) submodule_base="share/zsh/plugins";;
        --misc) submodule_base="share/misc";;
        --tmux) submodule_base="share/tmux";;
    esac
    cfg submodule add $address $submodule_base/$folder
    cd $submodule_base/$folder
    git submodule init
    cd $current_dir
    return 0
}

update_submodule() {
    cfg submodule init
    cfg submodule update
    cfg submodule foreach '\
        git fetch origin; \
        git checkout $(git rev-parse --abbrev-ref HEAD); \
        git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); \
        git submodule update --recursive; \
        git clean -dfx; \
        git submodule init; \
        git pull origin $(git rev-parse --abbrev-ref HEAD)'
}

remove_submodule() {
    current_dir="$PWD"
    par="$1"
    cd ~/.local
    case $par in
        --zsh) dir_path="share/zsh/plugins";;
        --nvim) dir_path="share/nvim/site/pack/plugins/start";;
        --misc) dir_path="share/misc";;
        --tmux) dir_path="share/tmux";;
        -h|--help|*)
            echo "Options:"
            echo "remove_submodule --zsh"
            echo "remove_submodule --nvim"
            echo "remove_submodule --misc"
            echo "remove_submodule --tmux"
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
