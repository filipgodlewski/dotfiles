# dotfiles

MK1 was my first attempt, highly unorganized. It was soon replaced by:

MK2, which was based on the technique presented here:
[best way to store dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

MK3 - the **current** one. Including gnu stow,
after watching [ThePrimeagen's stow tutorial](https://www.youtube.com/watch?v=tkUllCAGs3c)

## About

Instructions below are prepared for macOS, as this is my daily work machine.
Follow the instructions if that fits your needs.

### Install

**!!IMPORTANT!!**

Before the script, sign in to *Mac App Store*!

```bash
xcode-select --install
git clone https://github.com/filipgodlewski/dotfiles.git
cd ~/dotfiles
make -s install  # `-s` will suppress all commands from being echoed
```

Finally, **restart terminal**.

### Uninstall

```bash
# Make sure you killed your tmux session first, otherwise it will fail
cd ~/dotfiles
make -s uninstall
```

### Goodies

#### ZSH commands

```bash
edit
```

Fuzzy search in folders for git repositories:

- ~/personal
- ~/projects
- ~/learning
- ~/dotfiles

Jumps into, opens nvim. When nvim is closed, pops directories stack.

Additionally, reads `~/.cache/bookmarks/list.txt` for additional directories.

```bash
update
```

Updates:

- brew (bundle + other)
- npm (global)
- [pipx](https://github.com/pypa/pipx)
- [nvim](https://github.com/neovim/neovim) (
  [packer.nvim](https://github.com/wbthomason/packer.nvim),
  [mason](https://github.com/williamboman/mason.nvim),
  [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim))
- [hosts](https://github.com/StevenBlack/hosts) (custom files)
- nvim venv
- [antidote](https://github.com/mattmc3/antidote) (zsh)

## License

The files and scripts in this repository are licensed under the MIT License,
which is a very permissive license allowing you to use, modify, copy,
distribute, sell, give away, etc. the software.
In other words, do what you want with it.
The only requirement with the MIT License is that the license and
copyright notice must be provided with the software.

## Inspiration

The whole workflow was inspired by this great [YouTube video by DistroTube](https://www.youtube.com/watch?v=tBoLDpTWVOM).

This is how I got into git submodules to handle vim plugins:
[Using the Vim 8 Package Manager](https://dvonrohr.com/2016/12/11/vim-package-manager/)

This dotfile repository has very interesting ideas. Definitely worth some reading!
[webpro dotfiles](https://github.com/webpro/dotfiles)

Some things I borrowed are from
[idcrook/i-dotfiles](https://github.com/idcrook/i-dotfiles) - try it out!

The idea for `dotfiles` and `packages` applications came from [webpro/dotfiles](https://github.com/webpro/dotfiles).

I also got the idea of `make` command from [Makefile for your dotfiles](https://polothy.github.io/post/2018-10-09-makefile-dotfiles/)
