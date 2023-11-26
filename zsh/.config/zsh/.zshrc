for file in $ZDOTDIR/config.*.zsh; do source $file; done

export LS_COLORS="$(vivid generate catppuccin-macchiato)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd j --hook pwd zsh)"
