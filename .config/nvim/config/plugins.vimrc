let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_layout = {'up':'~90%', 'window':{'width':0.8, 'height':0.8,'yoffset':0.5,'xoffset':0.5, 'highlight':'Todo', 'border':'sharp'}}
let g:fzf_preview_window = 'right:60%'
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --bind ctrl-a:select-all'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
