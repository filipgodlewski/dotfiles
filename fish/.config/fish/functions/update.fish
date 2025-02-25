#!/usr/bin/env fish

set POSSIBILITIES hosts brew fish nvim pipx npm mas

function _update_get_choices
    set opts
    for possibility in $POSSIBILITIES
        if test "$possibility" != hosts && not command -sq $possibility
            continue
        end
        set opts $opts "$possibility"
    end
    set choices (gum filter --no-limit all $opts)

    if contains all $choices
        set choices $opts
    end

    for choice in $choices
        echo "$choice"
    end
end

function update -d "Update all sorts of apps, their contents, and system"
    set choices (_update_get_choices)
    for choice in $choices
        switch $choice
            case hosts
                _update_hosts
            case brew
                _update_brew
            case fish
                _update_fish
            case nvim
                _update_nvim
            case pipx
                _update_pipx
            case npm
                _update_npm
            case mas
                _update_mas
            case '*'
                _update_log error "💀 😫 Can't update $choice. No instructions to follow."
        end
    end
    _update_log info "🚀 🎉 Finished!"
end
