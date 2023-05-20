_gen_fzf_default_opts() {
  # Catppuccin Macchiato
  local fg_hl='#CAD3F5'
  local fg_plus='#CAD3F5'
  local bg_hl='#24273A'
  local bg_plus='#363A4F'
  local spinner='#F4DBD6'
  local hl='#ED8796'
  local hl_plus='#ED8796'
  local header='#ED8796'
  local info='#C6A0F6'
  local pointer='#F4DBD6'
  local marker='#F4DBD6'
  local prompt_hl='#C6A0F6'

  export FZF_DEFAULT_OPTS="
    --layout reverse
    --info inline
    --padding 2,5
    --prompt ' '
    --pointer ' '
    --marker ' '
    --color fg:$fg_hl
    --color fg+:$fg_plus
    --color bg:$bg_hl
    --color bg+:$bg_plus
    --color spinner:$spinner
    --color hl:$hl
    --color hl+:$hl_plus
    --color header:$header
    --color info:$info
    --color pointer:$pointer
    --color marker:$marker
    --color prompt:$prompt_hl
  "
}

_gen_fzf_default_opts

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
