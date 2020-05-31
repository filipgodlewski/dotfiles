#!/bin/zsh

export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export LC_ALL=en_US.UTF-8
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
export RIPGREP_CONFIG_PATH=~/.config/.ripgreprc

