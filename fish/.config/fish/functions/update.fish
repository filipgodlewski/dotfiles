#!/usr/bin/env fish

# Choices
set POSSIBILITIES hosts brew fish nvim pipx npm mas softwareupdate

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

function _update_run_sync -a raw_message what
    set colored_what (_update_b_i_c $YELLOW "$what")
    set message (printf "$raw_message" "$colored_what")
    gum spin --title "$message" --timeout 5m -- $argv[3..]
end


function _update_sync_cmd -a what
    _update_run_sync "Updating %s..." "$what" $argv[2..]
end


function _update_status -a emoji what
    if test $status != 0
        _update_log warn "$emoji 😵 $(_update_b_i_c $RED Failed) to update $(_update_b_i_c $RED $what)"
    else
        _update_log info "$emoji 🥳 $(_update_b_i_c $GREEN $what) updated successfully"
    end
end


function _update_run_for_each -a elements pattern emoji what -d 'Update all elements, one by one and log the result.'
    # Params:
    #   elements - an array of elements to update
    #   pattern - a PERL-based REGEX pattern in case you want to alter the logging
    #             Notice, either send an empty string if you don't care, OR
    #             send a regex that matches 2 NAMED groups: identifier, and name
    #             in this case, identifier will be used for the update command and name to log.
    #   emoji - an emoji to display when loggin
    #   what - a command to run to update an element.
    #          Notice that the command MUST contain %s
    #          which is a placeholder for the element to be updated.

    if not set -q elements[1]; or test -z "$elements"
        _update_log info "$emoji 😎 $(_update_b_i_c $WHITE $what) has nothing to update"
        return
    end
    set new_elements (echo $elements | string replace -r '[ \n]' ' ' | string split ' ')
    set -e elements

    for element in $new_elements
        set -e cmd_args
        set -e identifier
        set -e name

        if test -n "$pattern"
            set matched (string match -rgq "$pattern" "$element")
        else
            set identifier $element
            set name $element
        end

        for arg in $argv[5..]
            if string match -q -- "*%s*" "$arg"
                set modified_arg (printf "$arg" $identifier)
                set cmd_args $cmd_args $modified_arg
            else
                set cmd_args $cmd_args $arg
            end
        end
        _update_sync_cmd $name $cmd_args
        _update_status $emoji $name
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

function _get_choices
    set opts
    for possibility in $POSSIBILITIES
        if command -sq $possibility
            set opts $opts "$possibility"
        end
    end
    set choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        echo "$choice"
    end
end


function update -d "Update all sorts of apps, their contents, and system"
    set choices (_get_choices)
    for choice in $choices
        switch $choice

            case hosts
                set pattern '# Date: (\d{2} \w+ \d{4})'
                if not test -e $HOSTS_FILE; or not test -s $HOSTS_FILE
                    _update_hosts_download
                    if test $status != 0
                        _update_log info "🏡 🥳 $(_update_b_i_c $GREEN hosts) downloaded successfully"
                    end
                    continue
                end

                set local_file_date (head -n 6 $HOSTS_FILE | string match -rg $pattern; or echo "")
                set remote_file_date (curl --silent $HOSTS_URL | head -n 6 | string match -rg $pattern; or echo "")
                if string match -iq $remote_file_date $local_file_date
                    _update_log info "🏡 😎 $(_update_b_i_c $WHITE hosts) has nothing to update"
                    continue
                end

                _update_hosts_download
                _update_status 🏡 hosts

            case brew
                _update_sync_cmd brew brew update
                _update_run_for_each "$(brew outdated --quiet)" "" 🍺 brew brew upgrade %s

            case fish
                # TODO: check updates first
                _update_sync_cmd fish fish -c "fisher update"
                _update_status 🐠 fish

            case nvim
                set outdated_apps (_update_run_sync "Looking for outdated %s packages..." lazyvim nvim --headless "+Lazy! check" +qa \
                | string collect \
                | string replace -ra '\x1B\[[0-9;]*m' '' \
                | string match -rag '\[(.+?)\]\s+log \| [0-9a-f]{7}' \
                | sort -u)
                _update_run_for_each "$outdated_apps" "" 💤 lazyvim nvim --headless "+Lazy! update %s" +qa

                set outdated_apps (_update_run_sync "Looking for outdated %s packages..." mason nvim --headless "+lua require('utils').print_outdated_mason_packages()" +qa)
                _update_run_for_each "$outdated_apps" "" 🛠️ mason nvim --headless "+MasonUpdate %s" +qa

                # TODO: check updates first
                _update_sync_cmd treesitter nvim --headless +TSUpdateSync +qa
                _update_status 🌳 treesitter

            case pipx
                set all_venvs (command ls -1 ~/.local/pipx/venvs)
                set outdated_apps
                for venv in $all_venvs
                    _update_run_sync "Checking if %s is outdated..." "$venv" pipx runpip "$venv" list --outdated | tail -n +3 | string match -rgq "^($venv).*\$"
                    if test $status = 0
                        set outdated_apps $outdated_apps $venv
                    end
                end
                _update_run_for_each "$outdated_apps" "" 🐍 pipx pipx reinstall %s

            case npm
                _update_log warn "👾 🤫 $(_update_b_i_c $YELLOW npm) update not implemented yet..."
                continue

                _update_sync_cmd npm npm update --global
                _update_run_sync "Cleaning up %s cache..." npm npm cache clean --force

            case mas
                set pattern "^(?<identifier>\d+)\s+(?<name>\w+)"
                _update_run_for_each "$(mas outdated)" "$pattern" 🐙 mas mas upgrade %s

            case softwareupdate
                _update_log warn "💻 🤫 $(_update_b_i_c $YELLOW softwareupdate) update not implemented yet..."
                # TODO: softwareupdate --list; parse
                # TODO: softwareupdate --install <id> --stdinpass <1password>; ...?
                # TODO: ask to restart afterwards if needed
                continue

            case '*'
                _update_log error "💀 😫 Can't update $choice. No instructions to follow."

        end
    end
    _update_log info "🚀 🎉 Finished!"
end
