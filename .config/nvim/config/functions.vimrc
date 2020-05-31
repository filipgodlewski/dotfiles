function TrailingCharacters()
    let l:save=winsaveview()
    keeppatterns %s/\s\+$//e
    if !exists('b:noInsertFinalNewline')
        keeppatterns $s/.\zs$/\r/e
    endif
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

