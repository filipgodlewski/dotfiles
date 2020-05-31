set nocompatible
filetype plugin indent on
set rtp+=/usr/local/opt/fzf
set rtp+=~/.config/nvim/colors

source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/general.vimrc
source $HOME/.config/nvim/config/functions.vimrc
source $HOME/.config/nvim/config/bindings.vimrc
source $HOME/.config/nvim/config/colors.vimrc
source $HOME/.config/nvim/config/autocommands.vimrc

packloadall
silent! helptags ALL

