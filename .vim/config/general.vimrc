set hidden
set nobackup
set noswapfile
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch
set path+=**

set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*

set splitright splitbelow
set lazyredraw
set number
set confirm
set complete+=kspell
set completeopt=menuone,longest
set diffopt=filler,vertical
set shortmess+=c
set shortmess+=F
set backspace=indent,eol,start
colorscheme nord

syntax on
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

au BufWritePre * %s/\s\+$//e
aug line_return
        au!
        au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \	execute 'normal! g`"zvzz' |
                \ endif
aug END
au BufRead,BufNewFile * let w:m3=matchadd('ErrorMsg', '/^\t\+/', -1)
au BufRead,BufNewFile * let w:m4=matchadd('ErrorMsg', '/\s\+$/', -1)
au BufWinLeave * call clearmatches()

