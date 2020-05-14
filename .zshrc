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

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfggc="cfg commit -v"
alias cfggp="cfg push"
alias cfggss="cfg status -s"
alias cfggsu="cfg submodule foreach git pull origin master"
alias cfgrmd="v ~/README.md"
alias cfgvrc="v ~/.vimrc"
alias cfgzrc="v ~/.zshrc"
alias cl="clear && ls"
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
alias vd="vim -d"

cfgga() {
    cfg add $1
}

cfggcl() {
        cd ~/.vim
        folder=$(echo $1 | rev | cut -c5- | cut -d"/" -f1 | rev)
        cfg submodule add $1 pack/plugins/start/$folder
        1
}

cfgrs() {
        cfg submodule deinit .vim/pack/plugins/start/$1
        cfg rm .vim/pack/plugins/start/$1
        rf .vim/pack/plugins/start/$1
}

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

eval "$(starship init zsh)"
