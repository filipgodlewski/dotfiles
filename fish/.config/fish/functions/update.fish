#!/usr/bin/env fish

# Colors:
set RED 1
set GREEN 2
set YELLOW 3
set WHITE 7

# Other
set HOSTS_FILE /etc/hosts
set HOSTS_URL "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"


function not_implemented_yet -a emoji what
    display_message warn "$emoji 🤫 $(as_bold $YELLOW $what) update not implemented yet..."
end


function as_bold -a fg text
    gum style --foreground $fg --italic --bold $text
end


function display_message -a level msg
    gum log -l $level $msg
end


function wait_until_command_finishes -a what
    gum spin --title "Updating $(as_bold $YELLOW $what)..." --timeout 5m -- $argv[2..]
end


function wait_until_subshell_finishes -a what
    wait_until_command_finishes $what fish -c "$argv[2..]"
end


function display_status -a emoji what
    if test $status != 0
        display_message warn "$emoji 😵 $(as_bold $RED Failed) to update $(as_bold $RED $what)"
    else
        display_message info "$emoji 🥳 $(as_bold $GREEN $what) updated successfully"
    end
end


function try_update_for_each -a elements emoji what
    if not set -q elements[1]; or test -z "$elements"
        display_message info "$emoji 😎 $(as_bold $WHITE $what) has nothing to update"
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
        wait_until_command_finishes $element $cmd_args
        display_status $emoji $element
    end
end


function download_hosts
    display_message warn "🏡 🥶 $(as_bold $YELLOW hosts) on the list, it is required to unlock $(as_bold $RED sudo)"
    if test -z "$(sudo echo true 2>/dev/null)"
        display_message error "🏡 😵 $(as_bold $RED Failed) to access sudo -- $(as_bold $RED hosts) can't be written"
        return 126
    end
    wait_until_command_finishes hosts sudo curl $HOSTS_URL -o $HOSTS_FILE
    while read -la line
        wait_until_command_finishes "hosts whitelist: '$line'" sudo nvim --clean --headless "+g/$line/d" +x $HOSTS_FILE
    end <~/dotfiles/.excluded/whitelist_hosts
end


function update_hosts
    set pattern '# Date: (\d{2} \w+ \d{4})'
    if not test -e $HOSTS_FILE; or not test -s $HOSTS_FILE
        download_hosts
        if test $status != 0
            display_message info "🏡 🥳 $(as_bold $GREEN hosts) downloaded successfully"
        end
        return
    end

    set local_file_date (head -n 6 $HOSTS_FILE | string match -rg $pattern; or echo "")
    set remote_file_date (curl --silent $HOSTS_URL | head -n 6 | string match -rg $pattern; or echo "")
    if string match -iq $remote_file_date $local_file_date
        display_message info "🏡 😎 $(as_bold $WHITE hosts) has nothing to update"
        return
    end

    download_hosts
    display_status 🏡 hosts
end


function update_homebrew
    wait_until_command_finishes brew brew update
    try_update_for_each "$(brew outdated --quiet)" 🍺 brew brew upgrade %s
end


function update_fish
    # TODO: check updates first
    wait_until_subshell_finishes fish "fisher update"
    display_status 🐠 fish
end


function update_lazyvim
    # Quite a long pipe, but here's what happens:
    # - Await until async action is finished
    # - Delete colors
    # - Match pkg names that have a git commit hash
    # - Return only unique values
    set outdated_apps (wait_until_command_finishes lazyvim nvim --headless "+Lazy! check" +qa \
        | string collect \
        | string replace -ra '\x1B\[[0-9;]*m' '' \
        | string match -rag '\[(.+?)\]\s+log \| [0-9a-f]{7}' \
        | sort -u)
    try_update_for_each "$outdated_apps" 💤 lazyvim nvim --headless "+Lazy! update %s" +qa
end


function update_mason
    set lua_cmd "lua \
    for _, pkg in ipairs(require'mason-registry'.get_installed_packages()) do \
      pkg:check_new_version(function(is_new) \
        if is_new then vim.print(pkg.name) end \
      end) \
    end"
    set mason_news_cmd "$(echo $lua_cmd | string replace -ra '\s+' ' ')"
    set outdated_apps (wait_until_command_finishes mason nvim --headless "+$mason_news_cmd" +qa)
    try_update_for_each "$outdated_apps" 🛠️ mason nvim --headless "+MasonUpdate %s" +qa

end


function update_treesitter
    # TODO: check updates first
    wait_until_command_finishes treesitter nvim --headless +TSUpdateSync +qa
    display_status 🌳 treesitter
end


function update_nvim
    update_lazyvim
    update_mason
    update_treesitter
end


function update_pipx
    # TODO: Doesn't work currently
    wait_until_command_finishes pipx pipx upgrade-all
    if test $status != 0
        display_message warn "Upgrade unsuccessful. Attempt to reinstall all"
        wait_until_command_finishes pipx pipx reinstall-all
    end
end


function update_npm
    # TODO: Doesn't work currently
    wait_until_command_finishes npm npm update --global
    gum spin --title "Cleaning up $(as_bold $YELLOW npm)..." -- npm cache clean --force
end


function update_macos
    # TODO: mas outdated
    # TODO: mas upgrade <name>
    # softwareupdate --list; parse
    # softwareupdate --install <id> --stdinpass <1password>; ...?
    # TODO: ask to restart afterwards if needed
end


function update -d "Update system apps"
    set opts hosts brew fish nvim pipx npm macos
    set choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        switch $choice
            case hosts
                update_hosts
            case brew
                update_homebrew
            case fish
                update_fish
            case nvim
                update_nvim
            case pipx
                not_implemented_yet 🐍 pipx
            case npm
                not_implemented_yet 👾 npm
            case macos
                not_implemented_yet 💻 macos
            case '*'
                display_message error "Can't update $choice. No instructions to follow."
        end
    end
end
