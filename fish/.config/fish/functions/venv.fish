function venv --description 'smart venv creation and/or activation'
    set venv_dir (for d in venv .venv; if test -d $d; echo $d; break; end; end)
    if test -n "$venv_dir"
        # @fish-lsp-disable-next-line
        source "$venv_dir/bin/activate.fish"
        return
    end
    echo "🧐 Neither $(_update_b_i_c $YELLOW 'venv/') nor $(_update_b_i_c $YELLOW '.venv/') found."

    echo "🫣 Creating new one under $(_update_b_i_c $GREEN '.venv/')"
    virtualenv .venv
    # @fish-lsp-disable-next-line
    source .venv/bin/activate.fish

    gum spin --spinner dot --title "Attempting to initially install requirements in 3..." -- sleep 1
    gum spin --spinner dot --title "Attempting to initially install requirements in 2..." -- sleep 1
    gum spin --spinner dot --title "Attempting to initially install requirements in 1..." -- sleep 1
    if test -f pyproject.toml
        pip install --require-virtualenv -e . && echo "🥳 Installed from $(_update_b_i_c $GREEN 'pyproject.toml')"
    else if test -f requirements.txt
        pip install --require-virtualenv -e -r requirements.txt && echo "🥳 Installed from $(_update_b_i_c $GREEN 'requirements.txt')"
    else
        echo "🤨 Neither pyproject.toml nor requirements.txt file found. $(_update_b_i_c $RED 'Nothing to install!')"
    end
end
