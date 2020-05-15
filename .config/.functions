chpwd() ls

cgcl() {
        cd ~/.vim
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        cfg submodule add $1 pack/plugins/start/$folder
        1
}

cgrs() {
        cfg submodule deinit .vim/pack/plugins/start/$1
        cfg rm .vim/pack/plugins/start/$1
        rf .vim/pack/plugins/start/$1
}

gamp() {
        gaa
        gcmsg $1
        gp
}

put() {
        touch $1
        v $1
    }

take() {
        mkdir $1
        cd $1
}
