let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'
let g:far#enable_undo=1
let g:fzf_preview_window = 'right:60%'
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_winsize=-50
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background=1
let g:nord_uniform_status_lines = 1

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

