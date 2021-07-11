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
set expandtab
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
set shiftwidth=4
set shortmess+=mrwcI
set softtabstop=4
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

" BINDINGS
" ALE
nnoremap <silent> <Leader>af :ALEFix<CR>
nnoremap <silent> <Leader>an :ALENextWrap<CR>
nnoremap <silent> <Leader>ap :ALEPreviousWrap<CR>
nnoremap <silent> <Leader>ao :lope<CR>
nnoremap <silent> <Leader>ac :lclo<CR>

" OPEN AND CLOSE
nnoremap <silent> <Leader>bd :bp\|bd#<CR>
nnoremap <silent> <Leader>co :cope<CR>:set modifiable<CR>
nnoremap <silent> <Leader>wc :clo<CR>

" FZF
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fp :RG<CR>

" MISC
nnoremap <silent> <Leader>so :wa<CR>:so $MYVIMRC<CR>:noh<CR>:echo '"'.expand("$MYVIMRC").'" [write & reload]'<CR>
nnoremap <silent> <Leader>cp :let @+ = expand("%:p")<CR>

" MOVEMENTS
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> S i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w
nnoremap Y y$
nnoremap gy "*y
nnoremap gY "*Y
vnoremap gy "*y
vnoremap > >gv
vnoremap < <gv

" TERMINAL
tnoremap <C-[> <C-\><C-N>

" PYTHON
nnoremap <silent> <Leader>py :w<CR>:!python3 %<CR>

packloadall
silent! helptags ALL
