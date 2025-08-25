zoxide init --cmd j fish | source

abbr --erase jd &>/dev/null
alias jd="ji && venv"

abbr --erase jde &>/dev/null
alias jde="ji && venv && nvim"
