function! get_highlight_group_names#main()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc
