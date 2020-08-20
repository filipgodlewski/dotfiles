#!/bin/zsh

chpwd() ls

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
