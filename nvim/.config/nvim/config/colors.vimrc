function NordColors()
    hi! AleError                ctermfg=015  guifg=#D8DEE9 ctermbg=001  guibg=#BF616A gui=NONE   cterm=NONE
    hi! PmenuSel                ctermfg=000  guifg=#3B4252 ctermbg=003  guibg=#EBCB8B
    hi! StatusLine              ctermfg=007  guifg=#E5E9F0 ctermbg=000  guibg=#3B4252
    hi! TSBoolean		ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=bold   cterm=bold
    hi! TSComment               ctermfg=008  guifg=#616E88 ctermbg=NONE guibg=NONE    gui=italic cterm=italic
    hi! TSConstBuiltin          ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=italic cterm=italic
    hi! TSConstant		ctermfg=003  guifg=#EBCB8B ctermbg=NONE guibg=NONE
    hi! TSRef                   ctermfg=NONE guifg=NONE    ctermbg=002  guibg=#A3BE8C gui=NONE cterm=NONE
    hi! TSTypeBuiltin           ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=NONE cterm=NONE
    hi! TSTypeBuiltinError      ctermfg=001  guifg=#BF616A ctermbg=NONE guibg=NONE    gui=italic cterm=italic
    hi! TSTypeBuiltinWarning    ctermfg=003  guifg=#EBCB8B ctermbg=NONE guibg=NONE    gui=italic cterm=italic
    hi! WildMenu                ctermfg=000  guifg=#3B4252 ctermbg=003  guibg=#EBCB8B
endfunction
au ColorScheme nord call NordColors()
if !exists('g:colors_name')
    colorscheme nord
endif
