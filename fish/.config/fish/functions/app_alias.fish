function app_alias -d "Add quick alias for app name, if the application is available" -a new_name app
    if command -sq $app
        eval "function $new_name --wraps=$app --description='alias $new_name $app'; $app $argv; end"
    end
end
