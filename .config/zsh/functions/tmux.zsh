#!/bin/zsh

tn() {
    sessions=($(tmux ls 2>/dev/null | cut -d":" -f1))
    dir_name=$(echo ${PWD##*/} | tr "[:upper:]" "[:lower:]" | tr " " "_")
    echo -n "Provide session name (default: $dir_name): "
    read custom_name
    case ${custom_name} in
        "") session_name=${dir_name};;
        *) session_name=$(echo "${custom_name}" | tr "[:upper:]" "[:lower:]" | tr " " "_");;
    esac
    tmux new -s "${session_name}" -d && echo "Created new tmux session called: ${session_name}"
}

ta() {
    tmux_active=$(echo $TMUX)
    tmux_available=$(tmux ls 2>/dev/null | grep -v "(attached)")
    if [[ -n "${tmux_active}" ]] && [[ -n "${tmux_available}" ]]; then
        session_name=$(tmux ls | grep -v "(attached)" | cut -d":" -f1 | fzf)
        if [[ -z ${session_name} ]]; then
            echo "Didn't select anything!"
            return 1
        else
            tmux switch -t ${session_name}
        fi
    elif [[ -n "${tmux_active}" ]] && [[ -z "${tmux_available}" ]]; then
        echo "Already attached to the session."
        echo "No other session available."
        return 1
    elif [[ -z "${tmux_active}" ]] && [[ -n "${tmux_available}" ]]; then
        session_name=$(tmux ls | cut -d":" -f1 | fzf)
        if [[ -z ${session_name} ]]; then
            echo "Didn't select anything!"
            return 1
        else
            echo "Attached to: ${session_name}"
            tmux attach -t ${session_name}
        fi
    else
        echo "No sessions available."
        return 1
    fi
}

tk() {
    tmux ls &>/dev/null
    if [[ $? -eq 1 ]]; then
        echo "Sessions list is empty."
        return 1
    else
        session_names=($(tmux ls | grep -v "(attached)" | cut -d":" -f1 | fzf -m))
        if [[ ${#session_names[@]} -eq 0 ]]; then
            echo "Didn't select anything!"
            return 1
        fi
        for session in ${session_names}; do
            tmux kill-session -t ${session}
            echo "Killed session: ${session}"
        done
    fi
}
