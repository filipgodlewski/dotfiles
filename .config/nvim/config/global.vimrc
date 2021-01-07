let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:loaded_python_provider=0
let g:python3_host_prog=expand("~/.local/share/venvs/nvim/bin/python3")
let mapleader=" "
set rtp+=/usr/local/opt/fzf
if !exists("g:syntax_on")
    syntax enable
    let g:syntax_on = 1
endif
