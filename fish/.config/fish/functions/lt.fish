function lt --wraps=ls
    if type -sq eza
        ls --tree --level=1 $argv
    else
        echo "`eza` is not installed."
    end
end
