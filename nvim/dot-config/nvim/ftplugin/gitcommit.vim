setlocal nonumber
setlocal spell
highlight Comment cterm=none gui=none font=default
match ErrorMsg /\%1l.\%>51v/
