cnoremap <C-H> <left>
cnoremap <C-L> <right>
imap <C-L> <Plug>(coc-snippets-expand)
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <leader>r :%s///g<left><left><left>
nnoremap <leader>rc :%s///gc<left><left><left><left>
nnoremap <silent> <C-P> :Files<CR>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <leader><Enter> :Buffers<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
tnoremap <Esc> <C-\><C-n>
vmap <C-J> <Plug>(coc-snippets-select)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
xnoremap <leader>f "ay/<C-R>a
xnoremap <leader>r :s///g<left><left><left>
xnoremap <leader>rc :s///gc<left><left><left><left>

