function _update_npm
    set -l emoji 👾

    _update_log warn "$emoji 🤫 $(_update_b_i_c $YELLOW npm) update not implemented yet..."
    return

    # Update global packages...
    set -l message (_update_std_message "$emoji 🫨 Updating global %s packages..." "npm")
    gum spin --title "$message" --timeout 5m --show-error -- npm update --global
    _update_status "$emoji" npm updated

    # Clean cache...
    set -l message (_update_std_message "$emoji 🫨 Cleaning up %s cache..." "npm")
    gum spin --title "$message" --timeout 5m --show-error -- npm cache clean --force
    _update_status "$emoji" npm updated
end
