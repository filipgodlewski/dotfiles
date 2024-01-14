function app_alias -d "Add quick alias for app name" -a new_name app
    if type -sq $app
        alias $new_name $app
    end
end
