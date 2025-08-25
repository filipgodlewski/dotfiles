function venv --description 'try to activate nearest python virtual environment'
    command -q deactivate; and deactivate 2>/dev/null
    test -f .venv/bin/activate.fish; and source .venv/bin/activate.fish 2>/dev/null
    true
end
