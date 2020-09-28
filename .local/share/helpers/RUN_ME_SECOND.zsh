#!/bin/zsh

echo "\n>>> install base pip packages <<<\n"
pyenv virtualenv $(pyenv global) base
pip install -U pip setuptools wheel
pyenv activate base
pip install -U pip setuptools wheel
pip install -r $XDG_DATA_HOME/helpers/pip_list
pyenv deactivate

echo "\n>>> initialize git submodules <<<\n"
cfg submodule update --init --recursive

echo "\n>>> setup local git (cfg) config <<<\n"
echo -n "Git local user name: "
read cfg_username
echo -n "Git local user email: "
read cfg_email
cfg config --local user.name "$cfg_username"
cfg config --local user.email "$cfg_email"

echo "\n>>> DONE. Reexecuting zsh <<<\n"
exec zsh
