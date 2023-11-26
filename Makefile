export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(HOME)/.local/bin:$(PATH)

BASE_BREW = $(HOME)/dotfiles/.excluded/base
BASE_CASKS = $(HOME)/dotfiles/.excluded/base_casks
BASE_MAS = $(HOME)/dotfiles/.excluded/base_mas
NVIM_VENV = $(XDG_DATA_HOME)/nvim/venv

.PHONY: stow brew npm

# Installing
install: $(OS)
uninstall: un$(OS)

## MacOS specific
macos: base brew npm stow pip settings misc finish
unmacos: unnpm unpip unstow unbrew cleanup finish

base:
	echo 'export ZDOTDIR="$$HOME"/.config/zsh' | sudo tee /etc/zshenv

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	-$(HOMEBREW_PREFIX)/brew tap homebrew/cask-fonts
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; cat $(BASE_BREW) | xargs $(HOMEBREW_PREFIX)/brew install
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; cat $(BASE_CASKS) | xargs $(HOMEBREW_PREFIX)/brew install --cask
	cat $(BASE_MAS) | grep -o '^[0-9]*' | xargs $(HOMEBREW_PREFIX)/mas install

unbrew:
	# mas does not uninstall, so this step has to be done manually.
	-$(HOMEBREW_PREFIX)/brew remove --force --ignore-dependencies $(shell $(HOMEBREW_PREFIX)/brew list)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf $(HOMEBREW_PREFIX)

npm:
	$(HOMEBREW_PREFIX)/npm install -g neovim

unnpm:
	$(HOMEBREW_PREFIX)/npm uninstall -g neovim

stow:
	$(HOMEBREW_PREFIX)/stow -R */

unstow:
	$(HOMEBREW_PREFIX)/stow -D */

pip:
	$(HOMEBREW_PREFIX)/pipx install virtualenv
	$(HOMEBREW_PREFIX)/pipx install auto-optional
	$(HOMEBREW_PREFIX)/pipx install pyflyby
	$(HOME)/.local/bin/virtualenv $(NVIM_VENV)
	$(NVIM_VENV)/bin/python -m pip install pynvim

unpip:
	rm -rf $(NVIM_VENV)
	$(HOMEBREW_PREFIX)/pipx uninstall-all

settings:
	/bin/zsh .excluded/.macos

misc:
	$(HOMEBREW_PREFIX)/bat cache --build

cleanup:
	rm -rf $(HOME)/.config
	rm -rf $(HOME)/.local
	rm .npm .viminfo .zsh_history .zsh_sessions

finish:
	sudo killall Finder
	rm .zsh_history .zsh_sessions
	killall Terminal
