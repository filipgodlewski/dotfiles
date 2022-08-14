export FZF_DEFAULT_OPTS='--layout reverse --info inline'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

source "/usr/local/opt/fzf/shell/key-bindings.zsh"
