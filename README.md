# dotfiles

These are Filip Godlewski's dotfiles that use the technique presented here: [best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Getting Started

First of all, instructions below are prepared for MacOS, as this is my daily work machine. Follow the instructions if that fits your needs.

### Prerequisites

This setup will use:

- `curl`: to download some stuff, like homebrew
- `git`: to clone the repo
- `homebrew`: to install all the stuff that I use
- `neovim`: , my main editor
- `zsh`: my main shell

### Installing

#### Step 1/3

Before running the scripts, install `homebrew` along with `git`, using the official method from [this website](https://brew.sh)

#### Step 2/3

Clone the repository using the command below.

```sh
echo ".cfg" >> .gitignore
git clone --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
rm .gitconfig
cfg checkout
cfg config --local status.showUntrackedFiles no
```

#### Step 3/3

Now, run:

```sh
./.config/helpers/RUN_ME_FIRST.zsh
# This script will install default brew, brew cask, fonts and pip3 programs. Then it will initialize submodules, and fully prepare coc.nvim
```

## Under construction

Below are the 5 latest done tasks and all to dos that I have to finish, because why not!

### To dos

- [ ] add macos preferences config file [inspired by this file](https://github.com/sobolevn/dotfiles/blob/master/macos)
- [ ] add fuzzy branch checkout for git
- [ ] add autoload functions to zsh so that I can easily see them [as seen here.](https://scriptingosx.com/2019/07/moving-to-zsh-part-4-aliases-and-functions/)
- [ ] add vscode files (especially for extensions)

### Done

- [x] clean up brew_list, brew_cask_list, pip_list files from the unnecessary stuff.
- [x] add brew requirements
- [x] add pip requirements
- [x] add fonts
- [x] delete ctags

## Licence

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.

## Acknowledgement

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins: [Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading! [webpro dotfiles](https://github.com/webpro/dotfiles)

