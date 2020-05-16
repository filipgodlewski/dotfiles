# dotfiles

These are Filip Godlewski's dotfiles that use the technique presented here: [best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Getting Started

First of all, instructions below are prepared for MacOS, as this is my daily work machine. Follow the instructions.

### Prerequisites



### Installing

The commands below are required to run before you clone this repository. It is required to understand what is going on here so you don't run into problems.

```sh
echo ".cfg" >> .gitignore
git clone --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg checkout
```

If `cfg checkout` fails, simply backup or delete files listed that stop the process, then repeat `cfg checkout` and proceed:

```sh
cfg config --local status.showUntrackedFiles no
```

## Under construction

Below are the 5 latest done tasks and all to dos that I have to finish, because why not!

### To dos

- [ ] add brew requirements
- [ ] remove oh-my-zsh and use antibody instead
- [ ] find a way to store vs code files (especially for extensions). Consider adding settings.json
- [ ] add pip requirements
- [ ] add macos preferences config file [inspired by this file](https://github.com/sobolevn/dotfiles/blob/master/macos)
- [ ] add script to update & upgrade all submodules, brew, npm, yarn etc. and clean the whole mac from trash

### Done

- [x] add vim plugins directory
- [x] delete backups and swaps from vim
- [x] find a way to easily install vim plugin repos

## Licence

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.

## Acknowledgement

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins: [Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading! [webpro dotfiles](https://github.com/webpro/dotfiles)
