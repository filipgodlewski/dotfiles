if [[ ! "${PATH}" == *${XDG_CONFIG_HOME}/git/commands* ]]; then
  export PATH="${XDG_CONFIG_HOME}/git/commands:${PATH}"
fi


