" ALE
let g:ale_echo_cursor=0
let g:ale_echo_msg_format="%linter% - %severity%% (code)%: %s"
let g:ale_fix_on_save=1
let g:ale_fixers={"json": ["jq"], "python": ["black", "isort"]}
let g:ale_json_jq_options="-S"
let g:ale_linters={"javascript": ["eslint"], "json": ["jsonlint"], "python": ["bandit", "flake8", "pyright"]} "add pydocstyle if ever want to lint docstrings
let g:ale_python_black_executable=expand("~/.pyenv/versions/base/bin/black")
let g:ale_python_flake8_executable=expand("~/.pyenv/versions/base/bin/flake8")
let g:ale_python_isort_executable=expand("~/.pyenv/versions/base/bin/isort")
let g:ale_python_isort_options="--profile black"
let g:ale_python_pydocstyle_executable=expand("~/.pyenv/versions/base/bin/pydocstyle")
let g:ale_set_signs=0
let g:ale_virtualtext_cursor=1

" DEOPLETE
let g:deoplete#enable_at_startup=1
let g:deoplete#sources#jedi#extra_path=expand("~/.pyenv/versions/base/lib/**/site-packages")
let g:deoplete#sources#jedi#ignore_private_members=1
let g:deoplete#sources#jedi#show_docstring=1
let pyenv_venv_path=substitute(system("echo $VIRTUAL_ENV"), "\n", "", "")
if pyenv_venv_path != ""
    let g:deoplete#sources#jedi#python_path=expand(pyenv_venv_path."/bin/python")
else
    let g:deoplete#sources#jedi#python_path=expand("~/.pyenv/versions/base/bin/python")
endif

" ECHODOC
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" FZF
let g:fzf_colors =
\ { "fg":      ["fg", "Normal"],
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
\ "header":  ["fg", "Comment"] }
let g:fzf_layout = {"up":"~90%", "window":{"width":0.8, "height":0.8,"yoffset":0.5,"xoffset":0.5, "highlight":"Todo", "border":"sharp"}}
let g:fzf_preview_window = "right:60%"
let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline --bind ctrl-a:select-all"

" NORD COLORSCHEME
let g:nord_uniform_diff_background = 1

" SIGNIFY
let g:signify_sign_show_count=0
let g:signify_sign_add = "▎"
let g:signify_sign_change = "▎"
let g:signify_sign_delete = "▎"
let g:signify_sign_delete_first_line = "◥"
