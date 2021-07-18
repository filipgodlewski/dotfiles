function! ReadOnly()
  return &readonly || !&modifiable ? 'RO ◢' : ''
endfunction

function! GitInfo() abort
  let git = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return git == '' ? '   -- ' : '   '.git.' '
endfunction

hi User1 guifg=#A3BE8C guibg=#3B4252 gui=bold
hi User2 guifg=#BF616A guibg=#3B4252 gui=bold
hi User3 guifg=#2E3440 guibg=#EBCB8B gui=bold
hi User4 guifg=#2E3440 guibg=#BF616A gui=bold
hi User5 guifg=#EBCB8B guibg=#434C5E

set statusline=
set statusline+=%1*%{GitInfo()}           " Git Branch name
set statusline+=%0*\ %<%f\                " file relative
set statusline+=%2*%{ReadOnly()}          " Read Only indicator
set statusline+=%0*%=                     " Space
set statusline+=%0*%3l\/%L,               " Lines / Total Lines
set statusline+=%0*%4c\                   " Columns
