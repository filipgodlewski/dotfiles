function paths --description 'show \$PATH split by ":", line-by-line'
    echo $PATH | string split ':'
end
