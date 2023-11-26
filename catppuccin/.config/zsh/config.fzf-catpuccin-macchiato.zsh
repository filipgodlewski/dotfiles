#!/usr/bin/env zsh

# Catppuccin Macchiato
FZF_FG_HL='#CAD3F5'
FZF_FG_PLUS='#CAD3F5'
FZF_BG_HL='#24273A'
FZF_BG_PLUS='#363A4F'
FZF_SPINNER='#F4DBD6'
FZF_HL='#ED8796'
FZF_HL_PLUS='#ED8796'
FZF_HEADER='#ED8796'
FZF_INFO='#C6A0F6'
FZF_POINTER='#F4DBD6'
FZF_MARKER='#F4DBD6'
FZF_PROMPT_HL='#C6A0F6'

export FZF_DEFAULT_OPTS="
  --layout reverse
  --info inline
  --padding 2,5
  --prompt ' '
  --pointer ' '
  --marker ' '
  --color fg:$FZF_FG_HL
  --color fg+:$FZF_FG_PLUS
  --color bg:$FZF_BG_HL
  --color bg+:$FZF_BG_PLUS
  --color spinner:$FZF_SPINNER
  --color hl:$FZF_HL
  --color hl+:$FZF_HL_PLUS
  --color header:$FZF_HEADER
  --color info:$FZF_INFO
  --color pointer:$FZF_POINTER
  --color marker:$FZF_MARKER
  --color prompt:$FZF_PROMPT_HL
"

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
