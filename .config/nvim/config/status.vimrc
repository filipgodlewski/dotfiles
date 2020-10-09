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
  if &readonly || !&modifiable
    return '[READ-ONLY] '
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return '   '.fugitive#head().' '
  else
    return ''
endfunction

set statusline=
set statusline+=%1*%{GitInfo()}                           " Git Branch name
set statusline+=%0*\ %<%f\                                " file
set statusline+=%2*%{ReadOnly()}
set statusline+=%0*%m\ %w\                                " File+path
set statusline+=%#warningmsg#
set statusline+=%0*
set statusline+=%0*\ %=                                   " Space
set statusline+=%0*\ %y\                                  " FileType
set statusline+=%0*\ %{(&fenc!=''?&fenc:&enc)}\ \[%{&ff}]\  " Encoding & Fileformat
set statusline+=%0*\ %6(%{FileSize()}%)                   " File size
set statusline+=%0*\ D:\ %3p%%                            " Position (%)
set statusline+=%0*\ L:\ %3l\/%L                          " Lines / Total Lines
set statusline+=%0*\ C:\ %3c\                             " Columns

hi User1 guifg=#EBCB8B guibg=#3B4252 gui=bold
hi User2 guifg=#BF616A guibg=#3B4252 gui=bold
