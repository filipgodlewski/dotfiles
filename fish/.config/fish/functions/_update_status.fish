function _update_status -a emoji what verb
    if test $status != 0
        _update_log warn "$emoji 😵 $(_update_b_i_c "$RED" "$what") is not $verb. It $(_update_b_i_c $RED FAILED)"
    else
        _update_log info "$emoji 🥳 $(_update_b_i_c "$GREEN" "$what") is $verb successfully"
    end
end
