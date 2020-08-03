au BufWritePre * call TrailingCharacters()
au BufWritePost *.py call FixerPython()
au BufReadPost * call LineReturn()
au FocusGained,BufEnter * :silent! !
au FileType json syntax match Comment +\/\/.\+$+

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
