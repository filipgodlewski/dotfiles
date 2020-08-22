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

mkproject() {
    empty_string="\nProvided an empty string. Cannot proceed. Aborting."

    echo -n "Provide project name: "
    read project_name
    [ -z $project_name ] && (echo $empty_string; return 1)
    project_name=$(echo $project_name | tr " " "_")

    echo -n "Provide author name: "
    read author_name
    [ -z $author_name ] && (echo $empty_string; return 1)

    echo -n "Provide author email: "
    read author_email
    [ -z $author_email ] && (echo $empty_string; return 1)

    # comma separated
    language_type="python"

    license_type="mit"

    zsh ~/.local/share/mkproject/mkproject.zsh ${project_name:l} $author_name ${author_email:l} ${language_type:l} ${license_type:l}

    echo "\nCreated project with the following properties:"
    echo "Name: ${COLOR_CYAN}${project_name:l}${COLOR_NORMAL}"
    echo "Location: $PWD/${COLOR_MAGENTA}${project_name:l}${COLOR_NORMAL}"
    echo "Author: ${COLOR_CYAN}$author_name ${COLOR_NORMAL}<${COLOR_YELLOW}${author_email:l}${COLOR_NORMAL}>"
    echo "Language type: ${COLOR_MAGENTA}${language_type:l}${COLOR_NORMAL}"
    echo "License type: ${COLOR_MAGENTA}${license_type:u}${COLOR_NORMAL}"
}

wttr() {
    par="$1"
    curl -s "http://wttr.in/$par?MF1ATq"
}
