function NordColors()
    hi! link ALEErrorLine       ErrorMsg
    hi! link ALEWarningLine     WarningMsg
    hi! PmenuSel                ctermfg=000 guifg=#3B4252 ctermbg=003 guibg=#EBCB8B
    hi! StatusLine              ctermfg=007 guifg=#E5E9F0 ctermbg=000 guibg=#3B4252
    hi! WildMenu                ctermfg=000 guifg=#3B4252 ctermbg=003 guibg=#EBCB8B
endfunction
function SemshiColors()
    hi! link semshiErrorChar    ErrorMsg
    hi! link semshiErrorSign    ErrorMsg
    hi! semshiSelected          ctermfg=002 guifg=#A3BE8C ctermbg=008 guibg=#4C566A cterm=underline,bold gui=underline,bold
    hi! semshiAttribute         ctermfg=002 guifg=#A3BE8C                           cterm=bold           gui=bold
    hi! semshiBuiltin           ctermfg=005 guifg=#B48EAD
    hi! semshiFree                          guifg=#D8DEE9                           cterm=bold           gui=bold
    hi! semshiGlobal            ctermfg=012 guifg=#5E81AC                           cterm=bold           gui=bold
    hi! semshiImported          ctermfg=003 guifg=#EBCB8B                           cterm=bold           gui=bold
    hi! semshiLocal             ctermfg=006 guifg=#88C0D0
    hi! semshiParameter         ctermfg=003 guifg=#EBCB8B
    hi! semshiParameterUnused   ctermfg=001 guifg=#BF616A                           cterm=bold           gui=bold
    hi! semshiSelf              ctermfg=008 guifg=#4C566A                           cterm=italic         gui=italic
endfunction
au FileType python call SemshiColors()
au ColorScheme nord call NordColors()
colorscheme nord
