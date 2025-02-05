function ls --wraps=eza --description 'alias ls eza --git --icons --group-directories-first'
    if type -sq eza
        eza --git --icons --group-directories-first $argv
    else
        command ls $argv
    end
end
