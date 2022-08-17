export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(PATH)

ZSH = $(HOMEBREW_PREFIX)/zsh
BREWFILE = $(HOME)/dotfiles/brew/.Brewfile
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim

.PHONY: git nvim stow tmux zsh brew

# Installing
install: git $(OS)
uninstall: check_is_in_tmux un$(OS)

git:
	echo "Enter git user name:"; read name; git config --local user.name $$name
	echo "Enter git email:"; read mail; git config --local user.email $$mail
	git submodule update --init --recursive

nvim:
	cd $(XDG_DATA_HOME)/nvim/site/pack/add/start/nvim-telescope.telescope-fzf-native.nvim; make
	$(HOMEBREW_PREFIX)/nvim --headless +"UpdateRemotePlugins | q" &> /dev/null

## MacOS specific
macos: sudo brew npm stow pip zsh nvim
unmacos: sudo unnpm unpip unstow unbrew

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# The following will fail on mas, mas does not sign in by itself
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; brew bundle --file=$(BREWFILE)
	cat $(BREWFILE) | grep -E '^mas' | grep -o -E '\d+$$' | xargs mas install

unbrew:
	# mas does not uninstall, so this step has to be done manually.
	-brew remove --force --ignore-dependencies $(shell brew list)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf $(HOMEBREW_PREFIX)
	chsh -s /bin/zsh
	cat /etc/shells | grep -v $(HOMEBREW_PREFIX) | sudo tee /etc/shells

npm:
	npm install -g diagnostic-languageserver dockerfile-language-server-nodejs git-cz hjson neovim vim-language-server

unnpm:
	npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$$/ {print $$NF}' | xargs npm -g rm

stow:
	stow -R $$(echo */ | sd '/' '')

unstow:
	stow -D $$(echo */ | sd '/' '')

pip:
	python3 -m venv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python3 -m pip install -U pip setuptools wheel pynvim

unpip:
	python3 -m pip list --format freeze | sed 's/==.*//' | sed -E '/^(pip|setuptools)/d' | xargs -n1 python3 -m pip -q uninstall -y
	-deactivate &>/dev/null
	-rm -rf $(XDG_DATA_HOME)/venvs/nvim

zsh:
	if [[ ! $$(grep -q $(ZSH) /etc/shells) ]]; then \
		echo $(ZSH) | sudo tee -a /etc/shells \
		chsh -s $(ZSH); \
	fi

# Other commands
check_is_in_tmux:
	if [[ "$$TMUX" ]]; then \
		echo "\nKill tmux and try again!\n"; \
		exit 1; \
	fi
