#!/usr/bin/env fish

# Colors:
set RED 1
set GREEN 2
set YELLOW 3
set WHITE 7

# Other
set HOSTS_FILE /etc/hosts
set HOSTS_URL "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"


function _update_b_i_c -a fg text -d 'make text bold, italic, and coloured'
    gum style --foreground $fg --italic --bold $text
end


function _update_log -a level message -d 'log a message on a specific level'
    gum log -l $level $message
end


function _update_sync_cmd -a what
    gum spin --title "Updating $(_update_b_i_c $YELLOW $what)..." --timeout 5m -- $argv[2..]
end


function _update_sync_child_cmd -a what
    _update_sync_cmd $what fish -c "$argv[2..]"
end


function _update_status -a emoji what
    if test $status != 0
        _update_log warn "$emoji 😵 $(_update_b_i_c $RED Failed) to update $(_update_b_i_c $RED $what)"
    else
        _update_log info "$emoji 🥳 $(_update_b_i_c $GREEN $what) updated successfully"
    end
end


function _update_run_for_each -a elements emoji what
    if not set -q elements[1]; or test -z "$elements"
        _update_log info "$emoji 😎 $(_update_b_i_c $WHITE $what) has nothing to update"
        return
    end
    set new_elements (echo $elements | string replace -r '[ \n]' ' ' | string split ' ')
    set -e elements

    for element in $new_elements
        set -e cmd_args
        for arg in $argv[4..]
            if string match -q -- "*%s*" "$arg"
                set modified_arg (printf "$arg" $element)
                set cmd_args $cmd_args $modified_arg
            else
                set cmd_args $cmd_args $arg
            end
        end
        _update_sync_cmd $element $cmd_args
        _update_status $emoji $element
    end
end


function _update_hosts_download
    _update_log warn "🏡 🥶 $(_update_b_i_c $YELLOW hosts) on the list, it is required to unlock $(_update_b_i_c $RED sudo)"
    if test -z "$(sudo echo true 2>/dev/null)"
        _update_log error "🏡 😵 $(_update_b_i_c $RED Failed) to access sudo -- $(_update_b_i_c $RED hosts) can't be written"
        return 126
    end
    _update_sync_cmd hosts sudo curl $HOSTS_URL -o $HOSTS_FILE
    while read -la line
        _update_sync_cmd "hosts whitelist: '$line'" sudo nvim --clean --headless "+g/$line/d" +x $HOSTS_FILE
    end <~/dotfiles/.excluded/whitelist_hosts
end


function update -d "Update all sorts of apps, their contents, and system"
    set opts hosts brew fish nvim pipx npm macos
    set choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        switch $choice
            case hosts
                set pattern '# Date: (\d{2} \w+ \d{4})'
                if not test -e $HOSTS_FILE; or not test -s $HOSTS_FILE
                    _update_hosts_download
                    if test $status != 0
                        _update_log info "🏡 🥳 $(_update_b_i_c $GREEN hosts) downloaded successfully"
                    end
                    return
                end

                set local_file_date (head -n 6 $HOSTS_FILE | string match -rg $pattern; or echo "")
                set remote_file_date (curl --silent $HOSTS_URL | head -n 6 | string match -rg $pattern; or echo "")
                if string match -iq $remote_file_date $local_file_date
                    _update_log info "🏡 😎 $(_update_b_i_c $WHITE hosts) has nothing to update"
                    return
                end

                _update_hosts_download
                _update_status 🏡 hosts
            case brew
                _update_sync_cmd brew brew update
                _update_run_for_each "$(brew outdated --quiet)" 🍺 brew brew upgrade %s
            case fish
                # TODO: check updates first
                _update_sync_child_cmd fish "fisher update"
                _update_status 🐠 fish
            case nvim
                set outdated_apps (_update_sync_cmd lazyvim nvim --headless "+Lazy! check" +qa \
                | string collect \
                | string replace -ra '\x1B\[[0-9;]*m' '' \
                | string match -rag '\[(.+?)\]\s+log \| [0-9a-f]{7}' \
                | sort -u)
                _update_run_for_each "$outdated_apps" 💤 lazyvim nvim --headless "+Lazy! update %s" +qa

                set lua_cmd "lua \
                for _, pkg in ipairs(require'mason-registry'.get_installed_packages()) do \
                  pkg:check_new_version(function(is_new) \
                    if is_new then vim.print(pkg.name) end \
                  end) \
                end"
                set mason_news_cmd "$(echo $lua_cmd | string replace -ra '\s+' ' ')"
                set outdated_apps (_update_sync_cmd mason nvim --headless "+$mason_news_cmd" +qa)
                _update_run_for_each "$outdated_apps" 🛠️ mason nvim --headless "+MasonUpdate %s" +qa

                # TODO: check updates first
                _update_sync_cmd treesitter nvim --headless +TSUpdateSync +qa
                _update_status 🌳 treesitter
            case pipx
                _update_log warn "🐍 🤫 $(_update_b_i_c $YELLOW pipx) update not implemented yet..."
                continue
                _update_sync_cmd pipx pipx upgrade-all
                if test $status != 0
                    _update_log warn "Upgrade unsuccessful. Attempt to reinstall all"
                    _update_sync_cmd pipx pipx reinstall-all
                end
            case npm
                _update_log warn "👾 🤫 $(_update_b_i_c $YELLOW npm) update not implemented yet..."
                continue
                _update_sync_cmd npm npm update --global
                gum spin --title "Cleaning up $(_update_b_i_c $YELLOW npm)..." -- npm cache clean --force
            case macos
                _update_log warn "💻 🤫 $(_update_b_i_c $YELLOW macos) update not implemented yet..."
                continue
                # TODO: mas outdated
                # TODO: mas upgrade <name>
                # softwareupdate --list; parse
                # softwareupdate --install <id> --stdinpass <1password>; ...?
                # TODO: ask to restart afterwards if needed
            case '*'
                _update_log error "Can't update $choice. No instructions to follow."
        end
    end
end
