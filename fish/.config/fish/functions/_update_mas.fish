function _update_mas
    set -l emoji 🐙

    # Check if there's anything to update...
    set outdated_apps (mas outdated)
    if test -z "$outdated_apps"
        _update_nothing "$emoji" mas
        return
    end

    # Prepare pattern for identifier group, all types of spaces, then name group
    set pattern '^(?<identifier>\d+)[\p{Zs}\p{Cf}]+(?<name>[\w \-_]+) \('

    # Then for each outdated app, upgrade it...
    for app in $outdated_apps
        # Get identifier and name...
        string match -rgq "$pattern" "$app"

        # Kill the app gracefully
        osascript -e "quit app '$name'"

        # Update the app...
        set -l message (_update_std_message "$emoji 🫨 Upgrading %s..." "$name")
        gum spin --title "$message" --timeout 5m --show-error -- mas upgrade "$identifier"
        _update_status "$emoji" "$name ($identifier)" upgraded
    end
end
