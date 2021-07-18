vim.cmd([[
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:python3_host_prog=expand("~/.local/share/venvs/nvim/bin/python3")
set rtp+=/usr/local/opt/fzf
if !exists("g:syntax_on")
    syntax enable
    let g:syntax_on = 1
endif

if !&termguicolors
    set termguicolors
endif
]])

local s = vim.opt
local g = vim.g

g.mapleader = " "

s.autowriteall = true
s.completeopt = {"menuone", "noinsert", "noselect"}
s.confirm = true
s.copyindent = true
s.cursorline = true
s.diffopt = {"filler", "vertical"}
s.expandtab = true
s.fileformat = "unix"
s.grepformat = "%f:%l:%c:%m"
s.grepprg = "rg --vimgrep --no-heading --case-sensitive --follow --word-regexp"
s.hidden = true
s.lazyredraw = true
s.mouse = "i"
s.joinspaces = false
s.showmode = false
s.startofline = false
s.swapfile = false
s.pumblend = 20
s.pumheight = 10
s.shell = "/usr/local/bin/zsh"
s.shiftround = true
s.shiftwidth = 2
s.signcolumn = "yes"
s.softtabstop = 2
s.tabstop = 2
s.updatetime = 50
s.wildignorecase = true
s.wildmode = "longest:full,full"


vim.cmd([[
set complete+=kspell
set matchpairs+=<:>
set nrformats+=alpha
set path+=**
set wildignore+=*.tar.*,*.zip*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=__*__,*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=tags,tags.*
set wildignore=*.swp,*.bak
]])

vim.cmd([[
aug hello
    au!
    au FocusGained,BufEnter * :silent! !
aug END

packloadall
silent! helptags ALL
]])
