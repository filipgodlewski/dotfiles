" ALE
nnoremap <silent> <Leader>an :ALENextWrap<CR>
nnoremap <silent> <Leader>ap :ALEPreviousWrap<CR>

" Find and Replace
nnoremap <Leader>fg yiw:silent! grep! "<C-R><C-W>"
nnoremap <Leader>rg :cfdo %s/\(<C-R><C-W>\)//g \| update<S-Left><S-Left><Left><Left><Left>
nnoremap <Leader>rl yiw:%s/\(<C-R><C-W>\)//g<Left><Left>
nnoremap <Leader>rr :%s///g<Left><Left><Left>
xnoremap <Leader>fl "ay/<C-R>a
xnoremap <Leader>rl :s///g<Left><Left><Left>

" FZF
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>

" Misc
nnoremap <silent> <Leader>bd :bp\|bd#<CR>
nnoremap <silent> <Leader>so :w<CR>:so $MYVIMRC<CR>:noh<CR>

" Movements
cnoremap <C-H> <Left>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-L> <Right>
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> S i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w
nnoremap Y y$
nnoremap gy "*y
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap gy "*y

" Pytest
nnoremap <silent> <Leader>t0 :Pytest last<CR>
nnoremap <silent> <Leader>t1 :Pytest first<CR>
nnoremap <silent> <Leader>t? :Pytest projecttestwd<CR>
nnoremap <silent> <Leader>tE :Pytest end<CR>
nnoremap <silent> <Leader>tF :Pytest fails<CR>
nnoremap <silent> <Leader>tN :Pytest next<CR>
nnoremap <silent> <Leader>tP :Pytest previous<CR>
nnoremap <silent> <Leader>tS :Pytest session<CR>
nnoremap <silent> <Leader>tc :Pytest class<CR>
nnoremap <silent> <Leader>tf :Pytest file<CR>
nnoremap <silent> <Leader>tm :Pytest method<CR>
nnoremap <silent> <Leader>tp :Pytest project<CR>

" Signify
nnoremap <silent> <Leader>gd :SignifyHunkDiff<CR>
nnoremap <silent> <Leader>gu :SignifyHunkUndo<CR>

" Terminal
tnoremap <C-W><C-H> <C-\><C-N><C-W><C-H>
tnoremap <C-W><C-J> <C-\><C-N><C-W><C-J>
tnoremap <C-W><C-K> <C-\><C-N><C-W><C-K>
tnoremap <C-W><C-L> <C-\><C-N><C-W><C-L>
tnoremap <C-W><C-W> <C-\><C-N><C-W><C-W>
tnoremap <C-W>h <C-\><C-N><C-W><C-H>
tnoremap <C-W>j <C-\><C-N><C-W><C-J>
tnoremap <C-W>k <C-\><C-N><C-W><C-K>
tnoremap <C-W>l <C-\><C-N><C-W><C-L>
tnoremap <C-[> <C-\><C-N>

" Vimux
nnoremap <silent> <Leader>vf :w<CR>:VimuxRunCommand("clear; python ".bufname("%"))<CR>
nnoremap <silent> <Leader>vl :w<CR>:VimuxRunLastCommand<CR>
nnoremap <silent> <Leader>vo :call VimuxOpenRunner()<CR>
nnoremap <silent> <Leader>vp :w:<CR>:VimuxPromptCommand<CR>
nnoremap <silent> <Leader>vq :VimuxCloseRunner<CR>
