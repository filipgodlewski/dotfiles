export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(HOME)/.local/bin:$(PATH)

ZSH = $(HOMEBREW_PREFIX)/zsh
BREWFILE = $(HOME)/dotfiles/brew/.Brewfile
NVIM_VENV = $(XDG_DATA_HOME)/nvim/venv

.PHONY: stow brew

# Installing
install: $(OS)
uninstall: un$(OS)

## MacOS specific
macos: brew npm stow pip settings
unmacos: unnpm unpip unstow unbrew

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

npm:
	npm install -g git-cz

unnpm:
	npm uninstall -g git-cz

stow:
	stow -R */

unstow:
	stow -D */

pip:
	pipx install virtualenv
	pipx install python-lsp-ruff --include-deps
	$(HOME)/.local/bin/virtualenv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python -m pip install pynvim

unpip:
	rm -rf $(NVIM_VENV)
	pipx uninstall-all

settings:
	zsh .excluded/.macos
