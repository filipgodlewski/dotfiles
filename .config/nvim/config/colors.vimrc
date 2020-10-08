function NordColors()
    hi! link ALEErrorLine       ErrorMsg
    hi! link ALEWarningLine     WarningMsg
    hi! PmenuSel                ctermfg=0  guifg=#3B4252 ctermbg=3  guibg=#EBCB8B
    hi! StatusLine              ctermfg=7  guifg=#E5E9F0 ctermbg=0  guibg=#3B4252
    hi! WildMenu                ctermfg=0  guifg=#3B4252 ctermbg=3  guibg=#EBCB8B
endfunction
function SemshiColors()
    hi! link semshiErrorChar    ErrorMsg
    hi! link semshiErrorSign    ErrorMsg
    hi! semshiSelected          ctermfg=2  guifg=#A3BE8C ctermbg=8  guibg=#4C566A cterm=underline,bold gui=underline,bold
    hi! semshiAttribute         ctermfg=2  guifg=#A3BE8C cterm=bold   gui=bold
    hi! semshiBuiltin           ctermfg=5  guifg=#B48EAD
    hi! semshiFree                         guifg=#D8DEE9 cterm=bold   gui=bold
    hi! semshiGlobal            ctermfg=12 guifg=#5E81AC cterm=bold   gui=bold
    hi! semshiImported          ctermfg=3  guifg=#EBCB8B cterm=bold   gui=bold
    hi! semshiLocal             ctermfg=6  guifg=#88C0D0
    hi! semshiParameter         ctermfg=3  guifg=#EBCB8B
    hi! semshiParameterUnused   ctermfg=1  guifg=#BF616A cterm=bold   gui=bold
    hi! semshiSelf              ctermfg=8  guifg=#4C566A cterm=italic gui=italic
endfunction
au FileType python call SemshiColors()
au ColorScheme nord call NordColors()
colorscheme nord
