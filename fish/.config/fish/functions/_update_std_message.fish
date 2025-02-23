function _update_std_message -a fstring replacement
    set colored_replacement (_update_b_i_c $YELLOW "$replacement")
    printf "  $fstring" "$colored_replacement"
end
