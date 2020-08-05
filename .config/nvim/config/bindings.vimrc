cnoremap <C-H> <left>
cnoremap <C-J> <down>
cnoremap <C-K> <up>
cnoremap <C-L> <right>
imap <C-L> <Plug>(coc-snippets-expand)
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
inoremap <silent><expr> <c-space> coc#refresh()
map Y y$
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <leader>rc yiw:%s/<C-R><C-W>//gc<left><left><left>
nnoremap <leader>rg :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>rr yiw:%s/<C-R><C-W>//g<left><left>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> <leader>F :Buffers<CR>
nnoremap <silent> <leader>T <C-W>l:vert bo Ttoggle<cr><C-w>l
nnoremap <silent> <leader>bd :bp\|bd#<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>re :w<CR>:so $MYVIMRC<CR>:noh<CR>
nnoremap <silent> <leader>t <C-W>l:bel Ttoggle<cr><C-w>j
nnoremap <silent> S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
nnoremap gy "*y
tnoremap <Esc> <C-\><C-n>
tnoremap <silent> <leader>t <C-\><C-n>:Ttoggle<cr>
vmap <C-J> <Plug>(coc-snippets-select)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap gy "*y
xnoremap <leader>f "ay/<C-R>a
xnoremap <leader>rc :s///gc<left><left><left><left>
xnoremap <leader>rr :s///g<left><left><left>
