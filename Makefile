export XDG_DATA_HOME = $(HOME)/.local/share

OS := $(shell if [[ "$$(uname -s)" == "Darwin" ]]; then echo macos; fi)
export HOMEBREW_PREFIX := $(shell if [[ "$$(uname -m)" == "arm64" ]]; then echo /opt/homebrew; else echo /usr/local; fi)/bin
export PATH := $(HOMEBREW_PREFIX):$(HOME)/.local/bin:$(PATH)

BASE_BREW = $(HOME)/dotfiles/.excluded/base
BASE_CASKS = $(HOME)/dotfiles/.excluded/base_casks
BASE_MAS = $(HOME)/dotfiles/.excluded/base_mas

.PHONY: stow brew

# Installing
install: $(OS)
uninstall: un$(OS)

## MacOS specific
macos: base brew stow settings finish
unmacos: unstow unbrew cleanup finish

addshell:
	echo $(HOMEBREW_PREFIX)/fish | sudo tee -a /etc/shells
	chsh -s $(HOMEBREW_PREFIX)/fish

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

stow:
	$(HOMEBREW_PREFIX)/stow -R */

unstow:
	$(HOMEBREW_PREFIX)/stow -D */

settings:
	/bin/zsh .excluded/.macos

cleanup:
	rm -rf $(HOME)/.cache
	rm -rf $(HOME)/.config
	rm -rf $(HOME)/.local

finish:
	sudo killall Finder Dock
	rm -rf $(HOME)/.viminfo $(HOME)/.zsh_history $(HOME)/.zsh_sessions
	-killall Terminal
