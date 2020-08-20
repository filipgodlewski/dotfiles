#!/bin/zsh

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
