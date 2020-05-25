function TrailingCharacters()
    let l:save=winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns $s/.\zs$/\r/e
    call winrestview(l:save)
endfunction

function LineReturn()
    if line("'\"") > 0 && line("'\"") <= line("$")
        if exists('b:noLineReturn')
            return
        endif
        execute 'normal! g`"zvzz'
    endif
endfunction

