function NordColors()
    hi! link ALEErrorLine       ErrorMsg
    hi! link ALEWarningLine     WarningMsg
    hi! PmenuSel                ctermfg=000 guifg=#3B4252 ctermbg=003 guibg=#EBCB8B
    hi! StatusLine              ctermfg=007 guifg=#E5E9F0 ctermbg=000 guibg=#3B4252
    hi! WildMenu                ctermfg=000 guifg=#3B4252 ctermbg=003 guibg=#EBCB8B
endfunction
au ColorScheme nord call NordColors()
if !exists('g:colors_name')
    colorscheme nord
endif
