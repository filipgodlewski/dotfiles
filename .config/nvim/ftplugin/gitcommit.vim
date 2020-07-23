setlocal nonumber
setlocal spell
let b:noLineReturn=1
highlight Comment cterm=none gui=none font=default
match ErrorMsg /\%1l.\%>51v/
au FileType gitcommit nnoremap <buffer><silent> <localleader>mCC :call InsertUS()<cr>
