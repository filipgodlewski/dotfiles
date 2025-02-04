function sudo --wraps=sudo
    if command -sq op
        op read 'op://msmtazhnbxxwac3zvak3suuyxa/mini/password' | command sudo -S --prompt='' $argv
    else
        command sudo $argv
    end
end
