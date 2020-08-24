# dotfiles

These are Filip Godlewski's dotfiles that use the technique presented here: [best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Getting Started

First of all, instructions below are prepared for MacOS, as this is my daily work machine. Follow the instructions if that fits your needs.

### Installing

#### Step 1/3

Before running the scripts, install `homebrew` along with `git`, using the official method from [this website](https://brew.sh), but first:
```sh
xcode-select --install
```

#### Step 2/3

Clone the repository using the command below.

```sh
echo ".cfg" >> .gitignore
git clone --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
rm .gitignore
cfg checkout
cfg config --local status.showUntrackedFiles no
```

#### Step 3/3

Now, run:

```sh
./.local/share/helpers/RUN_ME_FIRST.zsh
# This script will install default brew, brew cask, fonts and pip3 programs.
# Then it will initialize submodules, and fully prepare coc.nvim
```

And finally, enter nvim and execute the command `:UpdateRemotePlugins`.

You should now be done!

## Licence

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.

## Acknowledgement

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins: [Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading! [webpro dotfiles](https://github.com/webpro/dotfiles)
