au BufWritePre * call TrailingCharacters()
au BufReadPost * call LineReturn()
au CursorHold * silent call CocActionAsync('highlight')
au FocusGained,BufEnter * :silent! !
"au FocusLost,WinLeave * :silent! wa
"au TermOpen * setlocal nonumber

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

