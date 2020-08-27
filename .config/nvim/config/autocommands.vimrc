au BufRead,BufNewFile *.snippets set filetype=snippets
au BufReadPost * call LineReturn()
au BufWritePre * call TrailingCharacters()
au FileType json syntax match Comment +\/\/.\+$+
au FocusGained,BufEnter * :silent! !

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
