export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(HOME)/.local/bin:$(PATH)

ZSH = $(HOMEBREW_PREFIX)/zsh
BREWFILE = $(HOME)/dotfiles/brew/.Brewfile
BASE_BREW = $(HOME)/dotfiles/.excluded/base
BASE_CASKS = $(HOME)/dotfiles/.excluded/base_casks
BASE_MAS = $(HOME)/dotfiles/.excluded/base_mas
NVIM_VENV = $(XDG_DATA_HOME)/nvim/venv
KITTY_ICON = https://github.com/DinkDonk/kitty-icon/raw/main/kitty-dark.icns

.PHONY: stow brew

# Installing
install: $(OS)
uninstall: un$(OS)

## MacOS specific
macos: base brew npm stow pip settings misc finish
unmacos: unnpm unpip unstow unbrew finish

base:
	echo 'export ZDOTDIR="$$HOME"/.config/zsh' | sudo tee /etc/zshenv

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; cat $(BASE_BREW) | xargs brew install
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; cat $(BASE_CASKS) | xargs brew --cask install
	cat $(BASE_MAS) | xargs mas install
	curl $(KITTY_ICON) > /Applications/kitty.app/Contents/Resources/kitty.icns

unbrew:
	# mas does not uninstall, so this step has to be done manually.
	-brew remove --force --ignore-dependencies $(shell brew list)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf $(HOMEBREW_PREFIX)

npm:
	npm install -g neovim

unnpm:
	npm uninstall -g neovim

stow:
	stow -R */

unstow:
	stow -D */

pip:
	pipx install virtualenv
	pipx install auto-optional
	pipx install pyflyby
	$(HOME)/.local/bin/virtualenv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python -m pip install pynvim

unpip:
	rm -rf $(NVIM_VENV)
	pipx uninstall-all

settings:
	zsh .excluded/.macos

misc:
	fast-theme XDG:catppuccin-macchiato
	bat cache --build

finish:
	sudo kilall Finder
