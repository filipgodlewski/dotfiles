function _update_assert_sudo -a what
    _update_log warn "$emoji 🥶 $(_update_b_i_c $YELLOW $what) on the list, it is required to unlock $(_update_b_i_c $RED sudo)"
    if test -z "$(sudo echo true 2>/dev/null)"
        _update_log error "$emoji 😵 $(_update_b_i_c $RED Failed) to access sudo -- $(_update_b_i_c $RED hosts) can't be written"
        return 126
    end
end
