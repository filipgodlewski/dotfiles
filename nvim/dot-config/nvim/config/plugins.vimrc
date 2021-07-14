" ALE
let g:ale_echo_cursor = 0
let g:ale_echo_msg_format = "%linter% - %severity%% (code)%: %s"
let g:ale_fixers = {
\     "*": ["trim_whitespace", "remove_trailing_lines"],
\     "java": [],
\     "json": ["jq"],
\     "python": ["yapf"],
\ }
let g:ale_json_jq_options = "-S"
let g:ale_linters = {
\     "java": ["javac"],
\     "javascript": ["eslint"],
\     "json": ["jsonlint"],
\     "python": ["bandit", "flake8", "pyright", "pydocstyle"]
\ }
let python_directory = "~/.local/share/venvs/nvim/"
let g:ale_python_flake8_executable = expand(python_directory."bin/flake8")
let g:ale_python_flake8_options = "--ignore=W503"
let g:ale_python_pydocstyle_executable = expand(python_directory."bin/pydocstyle")
let g:ale_python_pydocstyle_options = "--ignore=D100 --convention=pep257"
let g:ale_set_signs = 0
let g:ale_virtualtext_cursor = 1

" DEOPLETE
let g:deoplete#enable_at_startup = 1
au Filetype * call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
au Filetype * call deoplete#custom#source('ale', 'rank', 110)
au Filetype python call deoplete#custom#source('jedi', 'rank', 999)
let g:deoplete#sources#jedi#ignore_private_members = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#statement_length = 100
au Filetype * call deoplete#custom#option({
\     'ignore_sources': {
\         '_': ['buffer'],
\         'python': ['buffer', 'around']
\     },
\     'auto_complete_delay': 200
\ })
au InsertLeave * silent! pclose!

" ECHODOC
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "virtual"

" FLOAT-PREVIEW
let g:float_preview#docked = 0
let g:float_preview#winhl = 'Normal:User5,NormalNC:User5'
let g:float_preview#max_width = 128

" FZF
let g:fzf_colors = {
\ "fg":      ["fg", "Normal"],
\ "bg":      ["bg", "Normal"],
\ "hl":      ["fg", "Comment"],
\ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
\ "bg+":     ["bg", "CursorLine", "CursorColumn"],
\ "hl+":     ["fg", "Statement"],
\ "info":    ["fg", "PreProc"],
\ "border":  ["fg", "Ignore"],
\ "prompt":  ["fg", "Conditional"],
\ "pointer": ["fg", "Exception"],
\ "marker":  ["fg", "Keyword"],
\ "spinner": ["fg", "Label"],
\ "header":  ["fg", "Comment"]
\ }
let g:fzf_layout = {"up":"~90%", "window":{"width":0.8, "height":0.8,"yoffset":0.5,"xoffset":0.5, "highlight":"Todo", "border":"sharp"}}
let g:fzf_preview_window = "right:60%"
let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline --bind ctrl-a:select-all"

" JEDI-VIM
let g:jedi#completions_enabled = 0

" NORD COLORSCHEME
let g:nord_cursor_line_number_background = 1

" VIMWIKI
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
  \ 'path': '$HOME/Documents/vimwiki',
  \ 'syntax': 'markdown',
  \ 'ext':'.md',
\}]

" TASKWIKI
let g:taskwiki_taskrc_location = "~/.config/taskwarrior/.taskrc"
let g:taskwiki_data_location = "~/.local/share/taskwarrior/.task"
