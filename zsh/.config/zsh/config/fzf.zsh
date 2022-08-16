export FZF_DEFAULT_OPTS='--layout reverse --info inline'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

[[ $- == *i* ]] && {
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
}
