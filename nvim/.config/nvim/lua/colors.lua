vim.cmd([[
function NordColors()
  hi! AleError               ctermfg=015  guifg=#D8DEE9 ctermbg=001  guibg=#BF616A gui=NONE   cterm=NONE
  hi! PmenuSel               ctermfg=000  guifg=#3B4252 ctermbg=003  guibg=#EBCB8B
  hi! StatusLine             ctermfg=007  guifg=#E5E9F0 ctermbg=000  guibg=#3B4252
  hi! TSBoolean              ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=bold   cterm=bold
  hi! TSComment              ctermfg=008  guifg=#616E88 ctermbg=NONE guibg=NONE    gui=italic cterm=italic
  hi! TSConstBuiltin         ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=italic cterm=italic
  hi! TSConstant             ctermfg=003  guifg=#EBCB8B ctermbg=NONE guibg=NONE
  hi! TSRef                  ctermfg=NONE guifg=NONE    ctermbg=002  guibg=#A3BE8C gui=NONE cterm=NONE
  hi! TSTypeBuiltin          ctermfg=005  guifg=#B48EAD ctermbg=NONE guibg=NONE    gui=NONE cterm=NONE
  hi! TSTypeBuiltinError     ctermfg=001  guifg=#BF616A ctermbg=NONE guibg=NONE    gui=italic cterm=italic
  hi! TSTypeBuiltinWarning   ctermfg=003  guifg=#EBCB8B ctermbg=NONE guibg=NONE    gui=italic cterm=italic
  hi! WildMenu               ctermfg=000  guifg=#3B4252 ctermbg=003  guibg=#EBCB8B
  hi! User1 guifg=#A3BE8C guibg=#3B4252 gui=bold
  hi! User2 guifg=#BF616A guibg=#3B4252 gui=bold
  hi! User3 guifg=#2E3440 guibg=#EBCB8B gui=bold
  hi! User4 guifg=#2E3440 guibg=#BF616A gui=bold
  hi! User5 guifg=#EBCB8B guibg=#434C5E
endfunction

function AuroraColors()
  hi! SignColumn                    guifg=NONE    ctermfg=NONE guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! EndOfBuffer                   guifg=#4f425e ctermfg=239  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! LspDiagnosticsSignError       guifg=#D93234 ctermfg=167  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! LspDiagnosticsSignWarning     guifg=#e7dc8c ctermfg=186  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! LspDiagnosticsSignInformation guifg=#7AA6DA ctermfg=110  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! LspDiagnosticsSignHint        guifg=#ffce51 ctermfg=221  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! GitGutterAdd                  guifg=#9dd067 ctermfg=149  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! GitGutterChange               guifg=#4cc7e4 ctermfg=80   guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! GitGutterDelete               guifg=#f05874 ctermfg=204  guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! GitGutterChangeDelete         guifg=#7d2c9d ctermfg=91   guibg=#211c2f ctermbg=234 gui=NONE cterm=NONE
  hi! User1 guifg=#ADDB67 guibg=#30234F gui=bold
  hi! User2 guifg=#FFBBD6 guibg=#30234F gui=bold
  hi! User3 guifg=#211C2F guibg=#ECC48D gui=bold
  hi! User4 guifg=#211C2F guibg=#FFBBD6 gui=bold
  hi! User5 guifg=#EBCB8B guibg=#54CED6
endfunction

au ColorScheme nord call NordColors()
au ColorScheme aurora call AuroraColors()
if !exists('g:colors_name')
  colorscheme aurora
endif
]])
