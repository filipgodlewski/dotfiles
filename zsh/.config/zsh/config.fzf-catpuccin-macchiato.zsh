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
--cycle
--keep-right
--layout reverse
--border none
--padding 2,5
--info inline
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

export _ZO_FZF_OPTS="
$FZF_DEFAULT_OPTS
--exact
--no-sort
--bind=ctrl-z:ignore,btab:up,tab:down
--tabstop 1
--exit-0
--select-1
--preview='eza -1 --color always --icons always --all --group-directories-first --git-ignore {2..}'
"
