au BufRead,BufNewFile *.snippets set filetype=snippets
au BufReadPost * call LineReturn()
au BufWritePre * call TrailingCharacters()
au FileType json syntax match Comment +\/\/.\+$+
au FocusGained,BufEnter * :silent! !

augroup autosave
    autocmd!
    autocmd BufRead * if &filetype == "" | setlocal ft=text | endif
    autocmd FileType * autocmd FocusLost,BufLeave
        \ (<buffer> if &readonly == 0 || <buffer> if &filetype != fzf)
        \ | silent write
        \ | endif
augroup END

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
