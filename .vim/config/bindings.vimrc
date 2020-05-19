nmap <Leader>vv :edit ~/.vimrc
nnoremap <silent> <leader>bd <C-6>:bd#<CR>
nnoremap <C-J> :norm o<CR>
nnoremap <C-K> :norm O<CR>
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w
inoremap <expr> <C-J> pumvisible() ? "<C-N>" : "<C-J>"
inoremap <expr> <C-K> pumvisible() ? "<C-P>" : "<C-K>"
inoremap <expr> <C-H> pumvisible() ? "<C-E>" : "<C-H>"
inoremap <expr> <C-L> pumvisible() ? "<C-Y>" : "<C-L>"
