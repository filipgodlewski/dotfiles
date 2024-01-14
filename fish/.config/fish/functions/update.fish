#!/usr/bin/env fish

function __strong -a fg text
    gum style --foreground $fg --italic --bold $text
end

function __log -a level msg
    gum log -l $level $msg
end

function __await -a what
    gum spin --title "Updating $(__strong 3 $what)..." --timeout 5m -- $argv[2..]
end

function __await_subshell -a what
    __await $what fish -c "$argv[2..]"
end

function __update -a app
    switch $app
        case nvim
            __await lazy nvim --headless -c "Lazy! sync" -c qa
            __await mason nvim --headless -c "autocmd User MasonToolsUpdateCompleted quitall" -c MasonToolsUpdate
            __await treesitter nvim --headless -c TSUpdateSync -c q

        case brew
            __await $app brew update
            __await "brew apps" brew upgrade

        case pipx
            __await $app pipx upgrade-all
            if test $status != 0
                __log warn "Upgrade unsuccessful. Attempt to reinstall all"
                __await $app pipx reinstall-all
            end

        case npm
            __await $app npm update --global
            gum spin --title "Cleaning up $(__strong 3 npm)..." -- npm cache clean --force

        case fish
            __await_subshell $app fisher update

        case hosts
            __log warn (__strong 3 $app)" on the update list, it is required to unlock $(__strong 1 sudo)"
            test -z "$(sudo echo true 2>/dev/null)"
            and begin
                __log error "Failed to access sudo -- $(__strong 1 $app) can't be updated"
                return 1
            end
            set -l hosts_url "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
            __await $app sudo curl $hosts_url -o /etc/hosts
            while read -la line
                __await "$app whitelist: '$line'" sudo sed -i -e "/ $line/d" /etc/hosts
            end <~/dotfiles/.excluded/whitelist_hosts

        case '*'
            __log error "Can't update $app. No instructions to follow."
    end
end

function update -d "Update system apps"
    set -l opts hosts brew fish
    set choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        __update $choice
        if test $status != 0
            __log error "Failed to update $(__strong 2 $choice)"
        else
            __log info "$(__strong 3 $choice) updated successfully"
        end
    end
end
