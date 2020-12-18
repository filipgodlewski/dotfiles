aug hello
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zvzz" | endif
    au FocusGained,BufEnter * :silent! !
aug END

aug autosave
    au!
    au BufRead * if &filetype == "" | setlocal ft=text | endif
    au FileType * au FocusLost,BufLeave
                \ (<buffer> if &readonly == 0 || <buffer> if &filetype != fzf)
                \ | silent write
                \ | endif
aug END
