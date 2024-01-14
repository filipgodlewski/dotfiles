#!/usr/bin/env zsh

export _SYS_UPDATE_OPTIONS=("hosts" "brew" "npm" "pipx" "zsh")

function strong() {
    gum style --foreground $1 --italic --bold $2
}

function err() {
    gum log -l error "Failed to $1."
}

function update() {
    function updating() {
        local name=$1; shift;
        gum spin --title "Updating $(strong $YELLOW $name)..." --timeout 5m -- $@
    }

    (( $# )) || {gum log -l error "Required exactly 1 positional argument."; return}
    (( $_SYS_UPDATE_OPTIONS[(Ie)$1] )) || {gum log -l error "Wrong value. Possible values: $(strong $GREEN ${(f)_SYS_UPDATE_OPTIONS})"; return}

    case "$1" in
        neovim)
            updating "lazy" nvim --headless -c "Lazy! sync" -c "qa"
            updating "mason" nvim --headless -c "autocmd User MasonToolsUpdateCompleted quitall" -c "MasonToolsUpdate"
            updating "treesitter" nvim --headless -c "TSUpdateSync" -c "q"
            ;;
        brew)
            updating $1 brew update
            updating "brew apps" brew upgrade
            ;;
        pipx)
            updating $1 pipx upgrade-all
            if (( $? )); then
                err "upgrade pipx. Attempting to reinstall all"
                updating $1 pipx reinstall-all
            fi
            ;;
        npm)
            updating $1 npm update --global
            gum spin --title "Cleaning up $(strong $YELLOW npm)..." -- npm cache clean --force
            ;;
        zsh)
            updating $1 zsh $XDG_DATA_HOME/antidote/functions/antidote-update
            ;;
        hosts)
            local hosts_url="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
            updating $1 sudo curl $hosts_url -o /etc/hosts
            local line
            for line in $(<$ZDOTDIR/whitelist_pages); do
                updating "$1 whitelist: '$line'" sudo sed -i -e "/ $line/d" /etc/hosts
            done
            ;;
    esac
}

function u() {
    local choices=($(gum filter --no-limit all ${(@)_SYS_UPDATE_OPTIONS}))
    if [[ $(grep "all" <<< $choices) ]]; then
        choices=($_SYS_UPDATE_OPTIONS)
    fi

    local omit_hosts
    if (( ${choices[(Ie)hosts]} )); then
        gum log -l info "$(strong $CYAN hosts) on the update list, it is required to unlock sudo."
        local s=$(strong $RED sudo)
        sudo true 2> /dev/null
        if (( $? )); then
            err "access $s"
            gum format -t emoji ":watermelon: hosts can't be updated."
            omit_hosts=true
        else
            gum format -t emoji -- ":strawberry: $s accessed."
        fi
    fi

    local choice
    for choice in ${(@)choices}; do
        [[ $omit_hosts == true ]] && continue
        update $choice
        if (( $? )); then
            err "update $choice"
        else
            gum format -t emoji -- ":banana: Successfully updated $(strong $GREEN $choice)"
        fi
    done
    gum format -t emoji -- ":hot_pepper: Ready for $(strong $RED 'ACTION! ')"
}
