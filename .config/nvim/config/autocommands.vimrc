au BufRead,BufNewFile *.snippets set filetype=snippets
au BufRead,BufNewFile *.zsh set filetype=zsh
au BufReadPost * call LineReturn()
au BufWritePre * call TrailingCharacters()
au FileType json syntax match Comment +\/\/.\+$+
au FocusGained,BufEnter * :silent! !
au VimLeave * call VimuxCloseRunner()

augroup autosave
    autocmd!
    autocmd BufRead * if &filetype == "" | setlocal ft=text | endif
    autocmd FileType * autocmd FocusLost,BufLeave
        \ (<buffer> if &readonly == 0 || <buffer> if &filetype != fzf)
        \ | silent write
        \ | endif
augroup END

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
