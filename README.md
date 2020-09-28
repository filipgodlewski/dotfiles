# dotfiles

These are Filip Godlewski's dotfiles that use the technique presented here: [best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

## Getting Started

First of all, instructions below are prepared for MacOS, as this is my daily work machine. Follow the instructions if that fits your needs.

### Installing

#### Step 1/7

Install `homebrew` using the official method from [this website](https://brew.sh).

#### Step 2/7

Install git, etc.

```sh
xcode-select --install
```

#### Step 3/7

Clone the repository using the command below. Best if executed line by line.

```sh
echo ".cfg" >> .gitignore
git clone --bare https://github.com/filipgodlewski/dotfiles.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
rm .gitignore
cfg checkout
cfg config --local status.showUntrackedFiles no
```

#### Step 4/7

Restart terminal.

#### Step 5/7

Now, run:

```sh
./.local/share/helpers/RUN_ME_FIRST.zsh
```

#### Step 6/7

Now:

```sh
./.local/share/helpers/RUN_ME_SECOND.zsh
```

#### Step 7/7

Enter nvim and execute the command `:UpdateRemotePlugins`.

You should now be done!

## Licence

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.

## Acknowledgement

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins: [Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading! [webpro dotfiles](https://github.com/webpro/dotfiles)
