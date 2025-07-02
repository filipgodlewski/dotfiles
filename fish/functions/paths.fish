function paths --description 'show \$PATH split by ":", line-by-line'
    string replace ":" "\n" $PATH
end
