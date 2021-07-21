vim.cmd([[
function! ReadOnly()
  return &readonly || !&modifiable ? 'RO ◢' : ''
endfunction

function! GitInfo() abort
  let git = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return git == '' ? '   -- ' : '   '.git.' '
endfunction

set statusline=
set statusline+=%1*%{GitInfo()}           " Git Branch name
set statusline+=%0*\ %<%f\                " file relative
set statusline+=%2*%{ReadOnly()}          " Read Only indicator
set statusline+=%0*%=                     " Space
set statusline+=%0*%3l\/%L,               " Lines / Total Lines
set statusline+=%0*%4c\                   " Columns
]])
