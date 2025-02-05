function app_alias -d "Add quick alias for app name" -a new original
    eval "function $new --wraps=$original --description='alias $new $original'; $original \$argv; end"
end
