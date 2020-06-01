imap <C-l> <Plug>(coc-snippets-expand)
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap <silent> <C-]> <C-]>zz
nnoremap <silent> <C-P> :FZF -m<CR>
nnoremap <silent> <leader><Enter> :Buffers<CR>
nnoremap <silent> <leader>bd <C-6>:bd#<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
tnoremap <Esc> <C-\><C-n>
vmap <C-j> <Plug>(coc-snippets-select)

