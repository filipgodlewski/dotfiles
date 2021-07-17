# dotfiles

MK1 was my first attempt, highly unorganized. It was soon replaced by:

MK2, which was based on the technique presented here: [best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

**CURRENT**

MK3 - the current one. Including gnu stow, after watching [ThePrimeagen's stow tutorial](https://www.youtube.com/watch?v=tkUllCAGs3c)

## About

First of all, instructions below are prepared for MacOS, as this is my daily work machine. Follow the instructions if that fits your needs.

### Install

```sh
xcode-select --install
git clone https://github.com/filipgodlewski/dotfiles.git
cd ~/dotfiles
make install
```

Finally, restart terminal. You should also gain access to `dotfiles` command. Type `dotfiles -h` to get more information.

### Uninstall

```sh
# Make sure you killed your tmux session first, otherwise it will fail
cd ~/dotfiles
make uninstall
```

### Explanation

#### Sub-directory naming convention

- `*lowercase*` - for packages that have to be installed with `stow`
- leading `_` - for non-stow installation, to be installed with respective programs, e.g. `_pip` for python3 pip

## License

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.

## Inspiration

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins: [Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading! [webpro dotfiles](https://github.com/webpro/dotfiles)

Some things I borrowed are from [idcrook/i-dotfiles](https://github.com/idcrook/i-dotfiles) - try it out!

The idea for `dotfiles` and `packages` applications came from [webpro/dotfiles](https://github.com/webpro/dotfiles).

I also got the idea of `make` command from [Makefile for your dotfiles](https://polothy.github.io/post/2018-10-09-makefile-dotfiles/)
