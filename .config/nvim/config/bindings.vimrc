" ALE
nnoremap <silent> <Leader>an :ALENextWrap<CR>
nnoremap <silent> <Leader>ap :ALEPreviousWrap<CR>
nnoremap <silent> <Leader>ao :lope<CR>
nnoremap <silent> <Leader>ac :lclo<CR>

" Find and Replace
nnoremap <silent> <Leader>cc :call SaveQuickFix()<CR>
nnoremap <Leader>fg :call SearchForQuickFix()<CR>
nnoremap <Leader>rg :call ReplaceOnQuickFix(g:quickfix_search)<CR>
nnoremap <Leader>rl :call ReplaceLocalList()<CR>

" Open and Close
nnoremap <silent> <Leader>bd :bp\|bd#<CR>
nnoremap <silent> <Leader>co :cope<CR>:set modifiable<CR>
nnoremap <silent> <Leader>wc :clo<CR>

" FZF
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>

" FUGITIVE
nnoremap <silent> <Leader>df :diffget //2<CR>:diffupdate<CR>
nnoremap <silent> <Leader>dj :diffget //3<CR>:diffupdate<CR>
nnoremap <silent> <Leader>du u:diffupdate<CR>

" Misc
nnoremap <silent> <Leader>so :wa<CR>:so $MYVIMRC<CR>:noh<CR>
nmap cib <Plug>ChangeInsideBrackets
nmap ci( <Plug>ChangeInsideBrackets
nmap dib <Plug>DeleteInsideBrackets
nmap di( <Plug>DeleteInsideBrackets

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
nnoremap gY "*Y
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap gy "*y

" Pytest
nnoremap <Leader>pa :Pytest ask<CR>
nnoremap <silent> <Leader>pf :Pytest file<CR>
nnoremap <silent> <Leader>pp :Pytest all<CR>

" Terminal
tnoremap <C-[> <C-\><C-N>

" Vimux
nnoremap <silent> <Leader>vf :wa<CR>:VimuxRunCommand("clear; python ".bufname("%"))<CR>
nnoremap <silent> <Leader>vi :wa<CR>:VimuxRunCommand("clear; python -i ".bufname("%"))<CR>
nnoremap <silent> <Leader>vl :wa<CR>:call VimuxSendKeys("Up")<CR>:call VimuxSendKeys("Enter")<CR>
nnoremap <silent> <Leader>vo :call VimuxOpenRunner()<CR>
nnoremap <silent> <Leader>vc :VimuxCloseRunner<CR>
