function ls --wraps=eza
    if type -sq eza
        eza --git --icons --group-directories-first $argv
    else
        command ls $argv
    end
end
