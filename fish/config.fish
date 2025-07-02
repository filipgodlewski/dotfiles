#!/usr/bin/env fish

status is-interactive || exit

for file in $HOME/.config/fish/conf.d/apps/*.fish
    set app_name (basename $file .fish)
    if command -sq "$app_name"
        source $file
    end
end
