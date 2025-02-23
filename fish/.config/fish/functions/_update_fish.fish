function _update_fish
    set -l emoji 🐠

    # TODO: check updates first
    set -l message (_update_std_message "$emoji 🫨 Updating %s..." "fish")
    gum spin --title "$message" --timeout 5m --show-error -- fish -c "fisher update"
    _update_status "$emoji" fish updated
end
