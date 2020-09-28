#!/bin/zsh

brews=(${(f)"$(cat $XDG_DATA_HOME/helpers/brew_list)"})
brew_casks=($(cat $XDG_DATA_HOME/helpers/brew_cask_list))
npms=($(cat $XDG_DATA_HOME/helpers/npm_list))

echo "\n>>> open brew taps <<<\n"
brew tap homebrew/cask-fonts

echo "\n>>> install core brew programs <<<\n"
for brew in $brews; do brew install $brew; done
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "\n>>> install core brew cask programs <<<\n"
for brew_cask in $brew_casks; do brew cask install $brew_cask; done

echo "\n>>> install python version using pyenv <<<\n"
pyenv install -l | rg -v Available\ versions: | fzf | xargs -I{} sh -c "pyenv install {}; pyenv global {}"

echo "\n>>> install npm modules <<<\n"
for npm in $npms; do npm install -g $npm; done

echo "\n>>> make zsh the default shell <<<\n"
chsh -s /bin/zsh

echo "\n>>> DONE. Reexecuting zsh <<<\n"
exec zsh
