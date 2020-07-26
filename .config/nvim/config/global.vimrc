set nocompatible

filetype plugin indent on
let $EDITOR="nvr -l"
let $GIT_EDITOR="nvr -cc split --remote-wait +'setlocal bufhidden=delete'"
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:python3_host_prog=expand("~/.pyenv/shims/python")
set rtp+=/usr/local/opt/fzf
set rtp+=~/.config/nvim/colors
set rtp+=~/.local/share/nvim/site/pack/plugins/start/neoterm
syntax on
