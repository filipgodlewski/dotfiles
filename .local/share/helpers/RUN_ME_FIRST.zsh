#!/bin/zsh

brews=(${(f)"$(cat $XDG_DATA_HOME/helpers/brew_list)"})
brew_casks=($(cat $XDG_DATA_HOME/helpers/brew_cask_list))
npms=($(cat $XDG_DATA_HOME/helpers/npm_list))

echo "\n>>> opening taps... <<<\n"
brew tap homebrew/cask-fonts

echo "\n>>> installing core brews... <<<\n"
for brew in $brews; do brew install $brew; done

echo "\n>>> installing brew casks... <<<\n"
for brew_cask in $brew_casks; do brew install --cask $brew_cask; done

echo "\n>>> installing python version using pyenv <<<\n"
pyenv install -l | rg -v Available\ versions: | fzf | xargs -I{} sh -c "pyenv install {}; pyenv global {}"

echo "\n>>> installing poetry <<<\n"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

echo "\n>>> installing programs from pip <<<\n"
pyenv virtualenv $(pyenv global) base
pip install -U pip setuptools wheel
pyenv activate base
pip install -U pip setuptools wheel
pip install -r $XDG_DATA_HOME/helpers/pip_list
pyenv deactivate

echo "\n>>> installing npm modules... <<<\n"
for npm in $npms; do npm install -g $npm; done

echo "\n>>> initialize git submodules\n"
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
