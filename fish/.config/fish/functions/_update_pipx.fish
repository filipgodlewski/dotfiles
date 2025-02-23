function _update_pipx
    set -l emoji 🐍

    # First check if any pipx package is outdated, through pip...
    set all_venvs (command ls -1 ~/.local/pipx/venvs)
    set outdated_apps

    for venv in $all_venvs
        set -l message (_update_std_message "$emoji 🫨 Checkig if %s is outdated..." "$venv")
        gum spin --title "$message" --timeout 5m --show-error -- pipx runpip "$venv" list --outdated | tail -n +3 | string match -rgq "^($venv).*\$"

        if test $status = 0
            set outdated_apps $outdated_apps $venv
        end
    end

    if test -z "$outdated_apps"
        _update_nothing "$emoji" pipx
        return
    end

    # Then for each outdated app, reinstall it (safer than updating!)...
    for app in $outdated_apps
        set -l message (_update_std_message "$emoji 🫨 Reinstalling %s..." "$app")
        gum spin --title "$message" --timeout 5m --show-error -- pipx reinstall $app
        _update_status "$emoji" "$app" reinstalled
    end
end
