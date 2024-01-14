for file in $ZDOTDIR/config.*.zsh; do source $file; done

eval "$(starship init zsh)"
eval "$(zoxide init --cmd j --hook pwd zsh)"
