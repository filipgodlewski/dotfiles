_gen_fzf_default_opts() {
  local background='#0f1117'
  local bg3='#29394f'
  local bg4='#39605d'
  local bblack='#575860'
  local foreground='#cdcecf'
  local black='#393b44'
  local red='#c94f6d'
  local green='#81b29a'
  local yellow='#dbc074'
  local blue='#719cd6'
  local magenta='#9d79d6'
  local cyan='#63cdcf'
  local white='#dfdfe0'
  
  export FZF_DEFAULT_OPTS="
    --layout reverse
    --info inline
    --padding 2,5
    --prompt ' '
    --pointer ' '
    --marker ' '
    --color fg:$bblack
    --color fg+:$yellow
    --color bg:$background
    --color bg+:$bg3
    --color gutter:$background
    --color spinner:$green
    --color hl:$magenta
    --color hl+:$magenta
    --color header:$green
    --color info:$yellow
    --color pointer:$yellow
    --color marker:$green
    --color prompt:$yellow
    --color border:$bg4
  "
}

_gen_fzf_default_opts

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

[[ $- == *i* ]] && {
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
}
