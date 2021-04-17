#!/bin/zsh

initialize_repo() {
    echo ".cfg" >> .gitignore
    git clone -q --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg || return 1
    rm .gitignore || return 1
    alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
    cfg checkout || return 1
    cfg config --local status.showUntrackedFiles no || return 1
}

config_repo() {
    echo -n "INPUT: Git local user name: "
    read cfg_username
    [[ -z cfg_username ]] && return 1
    echo -n "INPUT: Git local user email: "
    read cfg_email
    [[ -z cfg_email ]] && return 1
    cfg config --local user.name "${cfg_username}"
    cfg config --local user.email "${cfg_email}"
}

install_core() {
    brew tap -q homebrew/cask-fonts || return 1
    brews=(${(f)"$(cat ~/.local/helpers/brew_list)"})
    for brew in ${brews}; do brew -q install ${brew} || return 1; done
    brew install -q --HEAD universal-ctags/universal-ctags/universal-ctags || return 1
    brew install -q --HEAD luajit || return 1
    brew install -q --HEAD neovim || return 1
}

install_cask() {
    brew_casks=($(cat ~/.local/helpers/brew_cask_list))
    for brew_cask in ${brew_casks}; do brew cask install ${brew_cask} || return 1; done
}

install_npm() {
    npms=($(cat ~/.local/helpers/npm_list))
    for npm in ${npms}; do npm install -g ${npm} || return 1; done
}

resolve_conflicts() {
    sudo chown -R $(whoami) /usr/local/share/zsh || return 1
    sudo chmod -R 755 /usr/local/share/zsh || return 1
    sudo chown -R $(whoami) /usr/local/share/zsh/site-functions || return 1
    sudo chmod -R 755 /usr/local/share/zsh/site-functions || return 1
}

compile_term() {
    mkdir ~/.terminfo 2> /dev/null
    for file in ~/.local/share/terminfo/capabilities/*(.); do tic ${file} || return 1; done
}

echo "\nTASK: GIT **********************************************************************\n"
echo "[initialize repo] ..."
initialize_repo || {echo "FAIL"; exit 1}
echo "[initialize repo] ...OK"
echo "[config] ..."
config_repo || {echo "FAIL"; exit 1}
echo "[config] ...OK"
echo "[submodules] ..."
cfg submodule -q update --init --recursive || {echo "FAIL"; exit 1}
echo "[submodules] ...OK"

echo "\nTASK: HOMEBREW *****************************************************************\n"
echo "[core] ..."
install_core || {echo "FAIL"; exit 1}
echo "[core] ...OK"
echo "[cask] ..."
install_cask || {echo "FAIL"; exit 1}
echo "[cask] ...OK"

echo "\nTASK: PYTHON *******************************************************************\n"
python3 -m pip install -U pip setuptools || return 1
python3 -m pip install -r $XDG_DATA_HOME/helpers/pip_base_list || return 1
python3 -m venv $XDG_DATA_HOME/venvs/nvim || return 1
$XDG_DATA_HOME/venvs/nvim/bin/python3 -m pip install -U pip setuptools || return 1
$XDG_DATA_HOME/venvs/nvim/bin/python3 -m pip install -r $XDG_DATA_HOME/helpers/pip_nvim_list || return 1

echo "\nTASK: NPM **********************************************************************\n"
echo "[npm] ..."
install_npm || {echo "FAIL"; exit 1}
echo "[npm] ...OK"

echo "\nTASK: ZSH **********************************************************************\n"
echo "[default] ..."
chsh -s /bin/zsh || {echo "FAIL"; exit 1}
echo "[default] ...OK"
echo "[zsh conflicts] ..."
resolve_conflicts || {echo "FAIL"; exit 1}
echo "[zsh conflicts] ...OK"
echo "[terminfo] ..."
compile_term || {echo "FAIL"; exit 1}
echo "[terminfo] ...OK"

echo "\nTASK: NVIM *********************************************************************\n"
echo "[remote plugins] ..."
nvim -c "UpdateRemotePlugins | q" || {echo "FAIL"; exit 1}
echo "[remote plugins] ...OK"

exit 0
