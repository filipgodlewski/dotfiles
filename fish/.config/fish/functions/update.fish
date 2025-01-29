#!/usr/bin/env fish

set __RED 1
set __GREEN 2
set __YELLOW 3

function __strong -a fg text
    gum style --foreground $fg --italic --bold $text
end

function __log -a level msg
    gum log -l $level $msg
end

function __await -a what
    gum spin --title "Updating $(__strong $__YELLOW $what)..." --timeout 5m -- $argv[2..]
end

function __await_subshell -a what
    __await $what fish -c "$argv[2..]"
end

function __log_status -a emoji what
    if test $status != 0
        __log warn "$emoji 💀 $(__strong $__RED Failed) to update $(__strong $__RED $what)"
    else
        __log info "$emoji 😎 $(__strong $__GREEN $what) updated successfully"
    end
end

function __update -a app
    switch $app
        case hosts
            __log warn (__strong $__YELLOW $app)" on the update list, it is required to unlock $(__strong $__RED sudo)"
            test -z "$(sudo echo true 2>/dev/null)"
            and begin
                __log error "Failed to access sudo -- $(__strong $__RED $app) can't be updated"
                return 1
            end
            set -l hosts_url "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
            __await $app sudo curl $hosts_url -o /etc/hosts
            while read -la line
                __await "$app whitelist: '$line'" sudo sed -i -e "/ $line/d" /etc/hosts
            end <~/dotfiles/.excluded/whitelist_hosts
            __log_status 🧭 hosts

        case brew
            __await $app brew update

            set -l outdated_apps (brew outdated --quiet)
            if set -q $outdated_apps[1]
                for outdated_app in $outdated_apps
                    __await $outdated_app brew upgrade $outdated_app
                    __log_status 🍺 $outdated_app
                end
            else
                __log info "🍺 😴 Nothing to update"
            end

        case fish
            __await_subshell $app fisher update
            __log_status 🐠 $app

        case nvim
            # TODO: Doesn't work currently
            __await lazy nvim --headless -c "Lazy! sync" -c qa
            __await mason nvim --headless -c "autocmd User MasonToolsUpdateCompleted quitall" -c MasonToolsUpdate
            __await treesitter nvim --headless -c TSUpdateSync -c q

        case pipx
            # TODO: Doesn't work currently
            __await $app pipx upgrade-all
            if test $status != 0
                __log warn "Upgrade unsuccessful. Attempt to reinstall all"
                __await $app pipx reinstall-all
            end

        case npm
            # TODO: Doesn't work currently
            __await $app npm update --global
            gum spin --title "Cleaning up $(__strong $__YELLOW npm)..." -- npm cache clean --force

        case '*'
            __log error "Can't update $app. No instructions to follow."
    end
end

function update -d "Update system apps"
    set -l opts hosts brew fish
    set -l choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        __update $choice
    end
end
