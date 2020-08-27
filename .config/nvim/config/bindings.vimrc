cnoremap <C-H> <left>
cnoremap <C-J> <down>
cnoremap <C-K> <up>
cnoremap <C-L> <right>
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
map Y y$
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <leader>fg yiw:silent! grep! "<C-R><C-W>"
nnoremap <leader>rg :cfdo %s/<C-R><C-W>//g \| update<S-Left><S-Left><Left><Left><Left>
nnoremap <leader>rl yiw:%s/<C-R><C-W>//g<left><left>
nnoremap <leader>rr :%s///g<left><left><left>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> <leader>TT <C-W>l:vert bo Ttoggle<cr><C-w>l
nnoremap <silent> <leader>bd :bp\|bd#<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fc :Colors<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fh :Helptags<CR>
nnoremap <silent> <leader>re :w<CR>:so $MYVIMRC<CR>:noh<CR>
nnoremap <silent> S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
nnoremap gy "*y
tnoremap <Esc> <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap gy "*y
xnoremap <leader>fl "ay/<C-R>a
xnoremap <leader>rl :s///g<left><left><left>
