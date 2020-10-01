#!/bin/zsh

color_green=$(tput setaf 2)
color_normal=$(tput sgr0)

brews=(${(f)"$(cat ${XDG_DATA_HOME}/helpers/brew_list)"})
brew_casks=($(cat ${XDG_DATA_HOME}/helpers/brew_cask_list))
npms=($(cat ${XDG_DATA_HOME}/helpers/npm_list))


echo "\n${color_green}>>>>>> GIT INSTALLATION <<<<<<${color_normal}\n"

echo "\n${color_green}>>> initialize git bare repository <<<${color_normal}\n"
echo ".cfg" >> .gitignore
git clone --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg
rm .gitignore
alias cfg="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
cfg checkout
cfg config --local status.showUntrackedFiles no

echo "\n${color_green}>>> setup local git (cfg) config <<<${color_normal}\n"
echo -n "Git local user name: "
read cfg_username
echo -n "Git local user email: "
read cfg_email
cfg config --local user.name "${cfg_username}"
cfg config --local user.email "${cfg_email}"

echo "\n${color_green}>>> initialize git submodules <<<${color_normal}\n"
cfg submodule update --init --recursive


echo "\n${color_green}>>>>>> BREW INSTALLATION <<<<<<${color_normal}\n"

echo "\n${color_green}>>> open brew taps <<<${color_normal}\n"
brew tap homebrew/cask-fonts

echo "\n${color_green}>>> install core brew programs <<<${color_normal}\n"
for brew in ${brews}; do brew install ${brew}; done
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "\n${color_green}>>> install core brew cask programs <<<${color_normal}\n"
for brew_cask in ${brew_casks}; do brew cask install ${brew_cask}; done

echo "\n${color_green}>>>>>> PYTHON INSTALLATION <<<<<<${color_normal}\n"

echo "\n${color_green}>>> install python version using pyenv <<<${color_normal}\n"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv install -l | rg -v Available\ versions: | fzf | xargs -I{} sh -c "pyenv install {}; pyenv global {}"

echo "\n${color_green}>>> install base pip packages <<<${color_normal}\n"
pyenv virtualenv $(pyenv global) base
pip install -U pip setuptools wheel
pyenv activate base
pip install -U pip setuptools wheel
pip install -r ${XDG_DATA_HOME}/helpers/pip_list
pyenv deactivate

echo "\n${color_green}>>>>>> NPM INSTALLATION <<<<<<${color_normal}\n"

echo "\n${color_green}>>> install npm modules <<<${color_normal}\n"
for npm in ${npms}; do npm install -g ${npm}; done

echo "\n${color_green}>>>>>> ZSH INSTALLATION <<<<<<${color_normal}\n"

echo "\n${color_green}>>> make zsh the default shell <<<${color_normal}\n"
chsh -s /bin/zsh

echo "\n${color_green}>>> resolve compinit issues <<<${color_normal}\n"
sudo chown -R $(whoami) /usr/local/share/zsh
sudo chmod -R 755 /usr/local/share/zsh
sudo chown -R $(whoami) /usr/local/share/zsh/site-functions
sudo chmod -R 755 /usr/local/share/zsh/site-functions

echo "\n${color_green}>>> update remote plugins <<<${color_normal}\n"
nvim -c "UpdateRemotePlugins | q"

echo "\n${color_green}>>>>>> DONE. <<<<<<${color_normal}\n"
exit 0
