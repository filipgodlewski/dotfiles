export PATH="${PATH}:${HOME}/Documents/personal_projects/venv/src"  # TODO: just add as plugin
export PATH="${PATH}:${XDG_CONFIG_HOME}/git/commands"
export PATH="${PATH}:${HOME}/.cargo/bin"

[[ "$(uname -m)" == "arm64" ]] && tmp_path=/opt/homebrew || tmp_path=/usr/local
eval "$($tmp_path/bin/brew shellenv)"
unset tmp_path

export BAT_PAGER="less --mouse"
