syntax on
set hidden
set nobackup
set noswapfile
set nowritebackup
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set path+=**
set laststatus=2
set signcolumn=yes
set updatetime=50

set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=__*__,*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags,tags.*
set wildignore+=*.tar.*,*.zip*

set splitright splitbelow
set lazyredraw
set  number
set confirm
set complete+=kspell
set completeopt=menuone,longest
set diffopt=filler,vertical
set shortmess+=c
set shortmess+=F
set backspace=indent,eol,start
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme nord

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set copyindent
set encoding=utf-8
set fileformat=unix

