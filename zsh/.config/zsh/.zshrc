export WORDCHARS=${WORDCHARS/\/}
source $HOME/.cargo/env
export PATH=$XDG_CONFIG_HOME/git/commands:$PATH
export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/curl/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

for file in $ZDOTDIR/config.*.zsh; do source $file; done

# export LS_COLORS=$(vivid generate ${XDG_CONFIG_HOME}/vivid/nightfox.yml)

antidote_dir=$XDG_DATA_HOME/antidote
plugins_txt=$ZDOTDIR/zsh_plugins.txt
static_file=$ZDOTDIR/zsh_plugins.zsh

# Clone antidote if necessary and generate a static plugin file.
if [[ ! $static_file -nt $plugins_txt ]]; then
  [[ -e $antidote_dir ]] ||
    git clone --depth=1 https://github.com/mattmc3/antidote.git $antidote_dir
  (
    source $antidote_dir/antidote.zsh
    [[ -e $plugins_txt ]] || touch $plugins_txt
    antidote bundle <$plugins_txt >$static_file
  )
fi

# Uncomment this if you want antidote commands like `antidote update` available
# in your interactive shell session:
autoload -Uz $antidote_dir/functions/antidote

# source the static plugins file
source $static_file

# cleanup
unset antidote_dir plugins_txt static_file

fpath=($ZPLUGINSDIR/zsh-users.zsh-completions/src $fpath)
rm -f $XDG_CONFIG_HOME/zsh/.zcompdump; compinit

eval "$(starship init zsh)"

if (( $SHLVL == 1 )); then
  nvim
fi
