filetype plugin indent on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:loaded_python_provider=0
let g:python3_host_prog=expand("~/.local/share/venvs/nvim/bin/python3")
let mapleader=" "
set rtp+=/usr/local/opt/fzf
if !exists("g:syntax_on")
    syntax enable
    let g:syntax_on = 1
endif

if !&termguicolors
    set termguicolors
endif
set autowriteall
set complete+=kspell
set completeopt-=preview
set matchpairs+=<:>
set confirm
set copyindent
set cursorline
set diffopt=filler,vertical
set fileformat=unix
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ --no-heading\ --case-sensitive\ --follow\ --word-regexp
set hidden
set lazyredraw
set mouse=i
set nojoinspaces
set noshowmode
set nostartofline
set noswapfile
set nrformats+=alpha
set path+=**
set pumblend=20
set pumheight=10
set shell=/usr/local/bin/zsh
set shiftround
set shortmess+=mrwcI
set signcolumn=yes
set timeoutlen=250
set updatetime=50
set wildignore+=*.tar.*,*.zip*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=__*__,*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=tags,tags.*
set wildignore=*.swp,*.bak
set wildignorecase
set wildmode=longest:full,full

aug hello
    au!
    au FocusGained,BufEnter * :silent! !
aug END

source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/colors.vimrc
source $HOME/.config/nvim/config/status.vimrc
source $HOME/.config/nvim/config/bindings.vimrc

packloadall
silent! helptags ALL
