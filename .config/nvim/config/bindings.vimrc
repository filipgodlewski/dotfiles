" ALE
nnoremap <silent> <Leader>af :ALEFix<CR>
nnoremap <silent> <Leader>an :ALENextWrap<CR>
nnoremap <silent> <Leader>ap :ALEPreviousWrap<CR>
nnoremap <silent> <Leader>ao :lope<CR>
nnoremap <silent> <Leader>ac :lclo<CR>

" FIND AND REPLACE
nnoremap <silent> <Leader>cc :call SaveQuickFix()<CR>
nnoremap <Leader>fg :call SearchForQuickFix()<CR>
nnoremap <Leader>rg :call ReplaceOnQuickFix(g:quickfix_search)<CR>
nnoremap <Leader>r% :call ReplaceLocalList("%")<CR>
nnoremap <Leader>r. :call ReplaceLocalList(".")<CR>

" OPEN AND CLOSE
nnoremap <silent> <Leader>bd :bp\|bd#<CR>
nnoremap <silent> <Leader>co :cope<CR>:set modifiable<CR>
nnoremap <silent> <Leader>wc :clo<CR>

" FZF
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fp :RG<CR>

" JAVA
nnoremap <silent> <Leader>jc :Javac<CR>
nnoremap <silent> <Leader>jr :Java<CR>
nnoremap <silent> <Leader>jf :silent! Javac<CR> :Java<CR>

" MISC
nnoremap <silent> <Leader>so :wa<CR>:so $MYVIMRC<CR>:noh<CR>:echo '"'.expand("$MYVIMRC").'" [write & reload]'<CR>
nmap <leader>hi :call GetHighlightGroupNames()<CR>

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

" TERMINAL
tnoremap <C-[> <C-\><C-N>
