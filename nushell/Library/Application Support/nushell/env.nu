def create_left_prompt [] {
    let it = ($env.PWD | str replace $"($env.HOME)" "~")
    if ($it | str length) > 1 {
        let base = ($env.PWD | path basename);
        $it
        | path split
        | drop
        | each {split chars | first}
        | path join $base
    } else {
        $it
    }
}

def create_right_prompt [] {}

let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

let-env PROMPT_INDICATOR = { " > " }
let-env PROMPT_INDICATOR_VI_INSERT = { " : " }
let-env PROMPT_INDICATOR_VI_NORMAL = { " 〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

let-env NU_LIB_DIRS = [($nu.config-path | path dirname | path join 'scripts')]
let-env NU_PLUGIN_DIRS = [($nu.config-path | path dirname | path join 'plugins')]

let-env PATH = (
    $env.PATH
    | prepend '/Library/Frameworks/Python.framework/Versions/Current/bin'
    | prepend '/usr/local/bin'
    | prepend '/Library/Apple/usr/bin'
    | prepend $"($env.HOME)/.local/bin"
)
