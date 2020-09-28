#!/bin/zsh

color_green=$(tput setaf 2)
color_normal=$(tput sgr0)

echo "\n${color_green}>>> install base pip packages <<<${color_normal}\n"
pyenv virtualenv $(pyenv global) base
pip install -U pip setuptools wheel
pyenv activate base
pip install -U pip setuptools wheel
pip install -r ${XDG_DATA_HOME}/helpers/pip_list
pyenv deactivate

echo "\n${color_green}>>> initialize git submodules <<<${color_normal}\n"
cfg submodule update --init --recursive

echo "\n${color_green}>>> setup local git (cfg) config <<<${color_normal}\n"
echo -n "Git local user name: "
read cfg_username
echo -n "Git local user email: "
read cfg_email
cfg config --local user.name "${cfg_username}"
cfg config --local user.email "${cfg_email}"

echo "\n${color_green}>>> DONE. Exiting. <<<${color_normal}\n"
exit 0
