function _update_brew
    set -l emoji 🍺

    # First update brew itself...
    set -l message (_update_std_message "$emoji 🧐 Updating %s itself..." "brew")
    gum spin --title "$message" --timeout 5m --show-error -- brew update

    # Check if there's anything to update...
    set outdated_apps (brew outdated --quiet)
    if test -z "$outdated_apps"
        _update_nothing "$emoji" brew
        return
    end

    # Then for each outdated app, upgrade it...
    for app in $outdated_apps
        # TODO: If santa, get sudo
        set -l message (_update_std_message "$emoji 🫨 Updating %s..." "$app")
        gum spin --title "$message" --timeout 5m --show-error -- brew upgrade $app
        _update_status "$emoji" "$app" upgraded
    end
end
