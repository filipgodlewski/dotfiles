export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8

DISABLE_LS_COLORS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

chpwd() ls

alias cl="clear && ls"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ctags="`brew --prefix`/bin/ctags"
alias jn="jupyter notebook"
alias jnd="jupyter nbextension disable connector-jupyter --py --sys-prefix"
alias jne="jupyter nbextension enable connector-jupyter --py --sys-prefix"
alias jni="jupyter nbextension install connector-jupyter --py --sys-prefix"
alias ls="ls -F"
alias python="python3"
alias reload='source ~/.zshrc'
alias rf='rm -rf'
alias v="vim"
alias vcfg="v ~/.vimrc"
alias vd="vim -d"
alias zshcfg="v ~/.zshrc"

gamp() {
        gaa
        gcmsg $1
        gp
}

put() {
        touch $1
        v $1
    }

take() {
        mkdir $1
        cd $1
}

cfg-gc() {
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        config submodule add --depth=1 $1 ~/.vim/pack/plugins/start/$folder
}

cfg-gl() {
        config submodule update --remote --merge
}

cfg-rs() {
        config submodule deinit .vim/pack/plugins/start/$1
        config rm .vim/pack/plugins/start/$1
        rf .vim/pack/plugins/start/$1
}

eval "$(starship init zsh)"
