if [[ ! "${PATH}" == *${XDG_CONFIG_HOME}/git/commands* ]]; then
  export PATH="${XDG_CONFIG_HOME}/git/commands:${PATH}"
fi
export PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/Documents/personal_projects/venv/src:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"

export BAT_PAGER="less --mouse"
