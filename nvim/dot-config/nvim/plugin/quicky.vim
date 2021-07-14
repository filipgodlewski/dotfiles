nnoremap <silent> <Leader>cc :call quicky#parse()<CR>
nnoremap <Leader>fg :call quicky#search()<CR>
nnoremap <Leader>rg :call quicky#replace_global(g:quickfix_search)<CR>
nnoremap <Leader>r% :call quicky#replace_local("%")<CR>
nnoremap <Leader>r. :call quicky#replace_local(".")<CR>

