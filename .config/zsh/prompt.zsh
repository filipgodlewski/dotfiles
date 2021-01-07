#!/bin/zsh

autoload -Uz add-zsh-hook vcs_info

setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' git enable
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:git:*' patch-format '%7>>%p%<< (%n applied)'
zstyle ':vcs_info:*' stagedstr '●'
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash git-untracked
zstyle ':vcs_info:git:*' formats '%F{blue}%15>…>%b%<< %F{yellow}%m%F{red}%u%F{green}%c%f'
zstyle ':vcs_info:git:*' actionformats '%F{blue}%a %F{yellow}%m%F{red}%u%F{green}%c%f'

+vi-git-st() {
    local ahead behind
    local -a gitstatus
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "⇡" )
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "⇣" )
    hook_com[misc]+=${(j:/:)gitstatus}
}

+vi-git-stash() {
    [[ -s ${hook_com[base]}/.git/refs/stash ]] && hook_com[misc]+="●"
}

function get-venv-basename {
    [[ -n $VIRTUAL_ENV ]] && echo "${VIRTUAL_ENV##*/} "
}

function get-cwd {
    if [[ "$PWD" == "$HOME" ]]; then
        echo "~"
    else
        echo $(tr "/" "\n" <<< "${${PWD/$HOME/~}%/*}" | cut -c 1 | tr "\n" "/")${PWD##*/}
    fi
}

function zle-line-init zle-keymap-select {
    PROMPT='%B'
    PROMPT+='%F{red}%(?..[%?] )'  # exit code
    PROMPT+='%F{yellow}`get-venv-basename`'  # venv
    PROMPT+='%F{cyan}%(1j.+ .)'  # background jobs
    PROMPT+='%F{magenta}`get-cwd` '  # cwd
    PROMPT+='%F{red}%(!.! .)'  # sudo
    PROMPT+="%f${${KEYMAP/vicmd/|}/(main|viins)/>} "  # vim mapping
    PROMPT+='%b'

    RPROMPT='%B'
    RPROMPT+='${vcs_info_msg_0_}'  # git
    RPROMPT+='%b'

    PROMPT2=$PROMPT

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
