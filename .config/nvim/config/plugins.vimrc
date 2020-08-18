let g:ale_fix_on_save=1
let g:ale_fixers={"json": ["jq"], "python": ["black", "isort"]}
let g:ale_json_jq_options="-S"
let g:ale_linters={"javascript": ["eslint"], "json": ["jsonlint"], "python": ["flake8"]}
let g:ale_python_black_executable=expand("~/.pyenv/versions/3.8.3/envs/base/bin/black")
let g:ale_python_flake8_executable=expand("~/.pyenv/versions/3.8.3/envs/base/bin/flake8")
let g:ale_python_isort_executable=expand("~/.pyenv/versions/3.8.3/envs/base/bin/isort")
let g:ale_python_isort_options="--profile black"
let g:ale_sign_error="✖"
let g:ale_sign_info="★"
let g:ale_sign_style_error="☡"
let g:ale_sign_style_warning="⚐"
let g:ale_sign_warning="⚑"

let g:deoplete#enable_at_startup=1
let g:deoplete#sources#jedi#extra_path=expand("~/.pyenv/versions/3.8.3/envs/base/lib/**/site-packages")
let g:deoplete#sources#jedi#ignore_private_members=1
let g:deoplete#sources#jedi#show_docstring=1
let pyenv_venv_path=substitute(system("echo $VIRTUAL_ENV"), "\n", "", "")
if pyenv_venv_path != ""
    let g:deoplete#sources#jedi#python_path=expand(pyenv_venv_path."/bin/python")
else
    let g:deoplete#sources#jedi#python_path=expand("~/.pyenv/versions/3.8.3/envs/base/bin/python")
endif

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

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

let g:gitgutter_sign_added = "▎"
let g:gitgutter_sign_modified = "▎"
let g:gitgutter_sign_modified_removed = "▲"
let g:gitgutter_sign_removed = "▎"
let g:gitgutter_sign_removed_above_and_below = "▶"
let g:gitgutter_sign_removed_first_line = "◥"

let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast_light="hard"
