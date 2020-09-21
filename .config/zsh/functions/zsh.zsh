#!/bin/zsh

chpwd() {
    ls
    automata
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
    if [[ -n $TMUX ]]; then
        echo "Tmux active. Do the following:"
        echo "1. SAVE SESSION"
        echo "2. Detach"
        echo "3. Reload"
        echo "4. Attach"
        return 1
    elif [[ -n $VIRTUAL_ENV ]]; then
        echo "Virtual env active."
        echo "Deactivate it first."
        return 1
    fi
    tmux kill-server 2>/dev/null
    exec zsh
}

take() {
    mkdir $1
    cd $1
}

update_system() {
    denv
    echo "\n>>> updating base pip packages <<<\n"
    update_base_venv
    echo -n "Is there an error with jedi and parso? [Y|n]: "
    read answer
    case $answer in
        Y|"")
            pyenv activate base
            pip -q install --use-feature=2020-resolver -U jedi
            pyenv deactivate
            echo "Reinstalled jedi."
            ;;
        *) ;;
    esac
    echo "\n>>> updating npm packages <<<\n"
    update_npm
    echo "\n>>> updating git submodules <<<\n"
    update_submodule
    echo "\n>>> updating brew & brew casks <<<\n"
    update_homebrew
    echo "\n>>> updating applications from App Store & MacOS itself <<<"
    mas upgrade
    echo "\n>>> updating alacritty colorscheme <<<\n"
    cat $XDG_DATA_HOME/misc/nord-alacritty/src/nord.yml $XDG_CONFIG_HOME/alacritty/base.yml > $XDG_CONFIG_HOME/alacritty/alacritty.yml
    echo "\n>>> reloading zsh <<<\n"
    exec zsh
}
