#!/usr/bin/env sh

cd ~ || exit
xcode-select --install
git clone --depth 1 https://github.com/filipgodlewski/dotfiles.git
cd ~/dotfiles || exit
make -s install
