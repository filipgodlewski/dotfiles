#!/bin/zsh

brews=(${(f)"$(cat $XDG_DATA_HOME/helpers/brew_list)"})
brew_casks=($(cat $XDG_DATA_HOME/helpers/brew_cask_list))
npms=($(cat $XDG_DATA_HOME/helpers/npm_list))

echo "\n>>> opening taps... <<<\n"
brew tap homebrew/cask-fonts

echo "\n>>> installing core brews... <<<\n"
for brew in $brews; do brew install $brew; done
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "\n>>> installing brew casks... <<<\n"
for brew_cask in $brew_casks; do brew cask install $brew_cask; done

echo "\n>>> installing python version using pyenv <<<\n"
pyenv install -l | rg -v Available\ versions: | fzf | xargs -I{} sh -c "pyenv install {}; pyenv global {}"

echo "\n>>> installing poetry <<<\n"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

echo "\n>>> installing npm modules... <<<\n"
for npm in $npms; do npm install -g $npm; done

echo "\n>>> DONE. Reexecuting zsh <<<\n"
exec zsh
