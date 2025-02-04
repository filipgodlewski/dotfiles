function s --description 'session selector'
    if not command -sq zoxide; and not command -sq nvim
        echo "In order to at least execute session selector, you must install both `zoxide` and `nvim`"
        return 127
    end
    if not command -sq zoxide; and command -sq nvim
        echo "In order to choose sessions, you need to install `zoxide` first"
        return 127
    end
    if command -sq zoxide; and not command -sq nvim
        echo "In order to open a session, you need to install `nvim` as well"
        return 127
    end

    if type -sq ji
        ji && nvim
    else
        zi && nvim
    end
end
