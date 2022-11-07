export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(PATH)

ZSH = $(HOMEBREW_PREFIX)/zsh
BREWFILE = $(HOME)/dotfiles/brew/.Brewfile
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim

.PHONY: git stow brew

# Installing
install: git $(OS)
uninstall: un$(OS)
update: up$(OS)

git:
	# TODO: add default initializer
	git submodule update --init --recursive

## MacOS specific
macos: brew npm stow pip nvim
unmacos: unnpm unpip unstow unbrew
upmacos: upbrew upnpm uppip nvim stow

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# The following will fail on mas, mas does not sign in by itself
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; brew bundle --file=$(BREWFILE)
	cat $(BREWFILE) | grep -E '^mas' | grep -o -E '\d+$$' | xargs mas install
	# TODO: Add missing headless commands: packer, ts, mason
	$(HOMEBREW_PREFIX)/nvim --headless +"UpdateRemotePlugins | q" &> /dev/null

unbrew:
	# mas does not uninstall, so this step has to be done manually.
	-brew remove --force --ignore-dependencies $(shell brew list)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf $(HOMEBREW_PREFIX)
	chsh -s /bin/zsh
	cat /etc/shells | grep -v $(HOMEBREW_PREFIX) | sudo tee /etc/shells
	if [[ ! $$(grep -q $(ZSH) /etc/shells) ]]; then \
		echo $(ZSH) | sudo tee -a /etc/shells \
		chsh -s $(ZSH); \
	fi

upbrew:
	# TODO: update

npm:
	npm install -g git-cz neovim

unnpm:
	npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$$/ {print $$NF}' | xargs npm -g rm

upnpm:
	# TODO: update

stow:
	stow -R $$(echo */ | sd '/' '')

unstow:
	stow -D $$(echo */ | sd '/' '')

pip:
	# TODO: replace with virtualenvwrapper
	# TODO: add pipx
	python3 -m venv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python3 -m pip install -U pip setuptools wheel pynvim

unpip:
	python3 -m pip freeze | sed 's/==.*//' | xargs -n1 python3 -m pip -q uninstall -y
	-deactivate &>/dev/null
	-rm -rf $(XDG_DATA_HOME)/venvs/nvim

uppip:
	# TODO: update
