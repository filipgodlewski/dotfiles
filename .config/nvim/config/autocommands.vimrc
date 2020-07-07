au BufWritePre * call TrailingCharacters()
au BufReadPost * call LineReturn()
au FocusGained,BufEnter * :silent! !

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

