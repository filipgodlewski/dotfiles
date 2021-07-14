command! -nargs=* -bang RG call ripgrep_fzf#main(<q-args>, <bang>0)

