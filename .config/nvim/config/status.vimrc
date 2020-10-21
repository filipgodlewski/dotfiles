function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif
  if bytes <= 0
    return '0'
  endif
  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B  '
  endif
endfunction

function! ReadOnly()
  return &readonly || !&modifiable ? 'RO ◢' : ''
endfunction

function! GitInfo() abort
  let git = fugitive#head()
  return git == '' ? '   -- ' : '   '.git.' '
endfunction

function! ALEErrorCount() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : '  '.all_errors.' '
endfunction

function! ALEWarningCount() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_warnings = l:counts.total - (l:counts.error + l:counts.style_error)
    return l:all_warnings == 0 ? '' : '  '.all_warnings.' '
endfunction

set statusline=
set statusline+=%1*%{GitInfo()}           " Git Branch name
set statusline+=%3*%3{ALEWarningCount()}  " ALE Warnings
set statusline+=%4*%3{ALEErrorCount()}    " ALE Errors
set statusline+=%0*\ %<%f\                " file relative
set statusline+=%2*%{ReadOnly()}          " Read Only indicator
set statusline+=%0*%=                     " Space
set statusline+=%0*%3l\/%L,               " Lines / Total Lines
set statusline+=%0*%4c\                   " Columns
hi User1 guifg=#A3BE8C guibg=#3B4252 gui=bold
hi User2 guifg=#BF616A guibg=#3B4252 gui=bold
hi User3 guifg=#2E3440 guibg=#EBCB8B gui=bold
hi User4 guifg=#2E3440 guibg=#BF616A gui=bold
