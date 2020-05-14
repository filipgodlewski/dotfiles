" General
set nocompatible
filetype plugin indent on
set hidden
set undofile
set autoread
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set path+=**
let g:far#enable_undo=1

" UI
set lazyredraw
set number
set confirm
set complete+=kspell
set completeopt=menuone,longest
set diffopt=filler,vertical
set shortmess+=c
set shortmess+=F
set backspace=indent,eol,start
let g:nord_uniform_diff_background=1
colorscheme nord

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=-50

" Mappings
nnoremap <silent> <leader>f :Farf<cr>
vnoremap <silent> <leader>f :Farf<cr>
nnoremap <silent> <leader>r :Farr<cr>
vnoremap <silent> <leader>r :Farr<cr>
nnoremap <silent> <leader>l :Lex<cr>
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Syntax
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
let g:python_highlight_all = 1
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

" Linting
let g:ale_set_highlights = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
packloadall
silent! helptags ALL
