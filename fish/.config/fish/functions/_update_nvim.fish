function _update_lazyvim
    set -l emoji 💤

    # Get outdated apps...
    set -l message (_update_std_message "$emoji 🧐 Looking for outdated %s packages..." "lazyvim")
    set outdated_apps (gum spin --title "$message" --timeout 5m --show-error -- nvim --headless "+Lazy! check" +qa \
    | string replace -ra '\x1B\[[0-9;]*m' '' \
    | string match -rag '\[(.+?)\]\s+log \| [0-9a-f]{7}' \
    | sort -u)

    # Check if there's anything to update...
    if test -z "$outdated_apps"
        _update_nothing "$emoji" lazyvim
        return
    end

    # Then for each outdated app, upgrade it...
    for app in $outdated_apps
        set -l message (_update_std_message "$emoji 🫨 Updating %s..." "$app")
        gum spin --title "$message" --timeout 5m --show-error -- nvim --headless "+Lazy! update $app" +qa
        _update_status "$emoji" "$app" updated
    end
end

function _update_mason
    set -l emoji 🛠️

    # Get outdated apps...
    set -l message (_update_std_message "$emoji 🧐 Looking for outdated %s packages..." "mason")
    set outdated_apps (gum spin --title "$message" --timeout 5m --show-error -- nvim --headless "+lua require('utils').print_outdated_mason_packages()" +qa)

    # Check if there's anything to update...
    if test -z "$outdated_apps"
        _update_nothing "$emoji" mason
        return
    end

    # Then for each outdated app, upgrade it...
    for app in $outdated_apps
        set -l message (_update_std_message "$emoji 🫨 Updating %s..." "$app")
        gum spin --title "$message" --timeout 5m --show-error -- nvim --headless "+lua require('mason').setup()" "+MasonInstall $app" +qa
        _update_status "$emoji" "$app" updated
    end
end

function _update_treesitter
    # TODO: check updates first
    set -l emoji 🌳

    set -l message (_update_std_message "$emoji 🧐 Updating %s..." "treesitter")
    gum spin --title "$message" --timeout 5m --show-error -- nvim --headless +TSUpdateSync +qa
    _update_status "$emoji" treesitter updated
end

function _update_nvim
    _update_lazyvim
    _update_mason
    _update_treesitter
end
