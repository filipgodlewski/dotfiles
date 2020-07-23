#!/bin/zsh

BREWS=(${(f)"$(cat ~/.config/helpers/brew_list)"})
BREW_CASKS=($(cat ~/.config/helpers/brew_cask_list))
COC_EXTENSIONS=($(cat ~/.config/coc/extensions/package.json | grep "    " | cut -d'"' -f2))

echo "\n>>> opening taps... <<<\n"
brew tap homebrew/cask-fonts

echo "\n>>> installing core brews... <<<\n"
for BREW in $BREWS; do brew install $BREW; done
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "\n>>> installing brew casks... <<<\n"
for BREW_CASK in $BREW_CASKS; do brew cask install $BREW_CASK; done

echo "\n>>> installing python version using pyenv <<<\n"
pyenv install -l | rg -v Available\ versions: | fzf | xargs -I{} sh -c "pyenv install {}; pyenv global {}"

echo "\n>>> reload and initialize antibody <<<\n"
source ~/.config/zsh/.zshrc
up-antibody

echo "\n>>> installing programs from pip <<<\n"
up-pip
pip install -r ~/.config/helpers/pip_list

echo "\n>>> initialize git submodules <<<\n"
cfg submodule update --init

echo "\n>>> yarn install on coc.nvim <<<\n"
cd ~/.local/share/nvim/site/pack/plugins/start/coc.nvim
git clean -xfd
yarn install --frozen-lockfile
1

echo "\n>>> install coc.nvim extensions <<<\n"
nvim -c "CocInstall -sync $COC_EXTENSIONS | qa"

echo "\n>>> DONE. Reexecuting zsh <<<\n"
reload
