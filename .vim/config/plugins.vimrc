let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_fix_on_save=1
let g:ale_fixers={'python': ['black', 'isort']}
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_text_changed='never'
let g:ale_linters={'python': ['flake8', 'pydocstyle', 'bandit', 'mypy']}
let g:ale_set_highlights=0
let g:far#enable_undo=1
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_winsize=-50
let g:nord_uniform_diff_background=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

