export XDG_DATA_HOME = $(HOME)/.local/share

NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim
LOCAL_ZSH = /usr/local/bin/zsh

OS := $(shell [[ "$$OSTYPE" =~ ^darwin ]] && echo macos)
STOW_DIRS := $(shell echo */ | sd '/' '')
IN_TMUX := $(shell [[ -z "$TMUX" ]] || echo _end)

.PHONY: git nvim stow tmux zsh brew

# Installing
install: git $(OS) tmux nvim
uninstall: $(IN_TMUX) un$(OS)

git:
	echo -n "Enter git user name: "; read name; git config --local user.name $$name
	echo -n "Enter git email: "; read mail; git config --local user.email $$mail
	git submodule update --init --recursive

tmux:
	-tmux new-session -d -s base

nvim:
	cd $(XDG_DATA_HOME)/nvim/site/pack/add/start/nvim-telescope.telescope-fzf-native.nvim; make
	nvim --headless +"UpdateRemotePlugins | q" &> /dev/null

## MacOS specific
macos: brew npm stow pip zsh
unmacos: unnpm unpip unzsh unstow unbrew

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file=~/dotfiles/brew/.Brewfile

unbrew:
	brew remove --force --ignore-dependencies $(shell brew list)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

npm:
	npm install -g $$(<$(HOME)/dotfiles/_npm/global_packages.list)
	npm install -g diagnostic-languageserver dockerfile-language-server-nodejs git-cz hjson neovim vim-language-server
	# echo "{}" > package.json
	# npm install --package-lock-only
	# npm audit fix
	# rm package-lock.json package.json

unnpm:
	npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$$/ {print $$NF}' | xargs npm -g rm

stow:
	stow -R $(STOW_DIRS)

unstow:
	stow -D $(STOW_DIRS)

pip:
	python3 -m venv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python3 -m pip install -U pip setuptools wheel pynvim

unpip:
	python3 -m pip list --format freeze | sed 's/==.*//' | sed -E '/^(pip|setuptools)/d' | xargs -n1 python3 -m pip -q uninstall -y
	-deactivate &>/dev/null
	-rm -rf $(XDG_DATA_HOME)/venvs/nvim

zsh:
	[[ ! grep -q $(LOCAL_ZSH) /etc/shells ]] && {sudo $(LOCAL_ZSH) >> /etc/shells; chsh -s $(LOCAL_ZSH);}
	sudo chown -R $$(whoami) /usr/local/share/zsh
	sudo chown -R $$(whoami) /usr/local/share/zsh/site-functions
	sudo chmod g-w /usr/local/share/zsh
	sudo chmod g-w /usr/local/share/zsh/site-functions

unzsh:
	chsh -s /bin/zsh

# Other commands
_end:
	echo "\nKill tmux and try again!\n"
	exit 1

