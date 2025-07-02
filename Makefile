install:
	# Apps
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; brew bundle install --file $(CURDIR)/brew/.config/brew/Brewfile
	gh extension install dlvhdr/gh-dash
	# .configs
	touch ~/.hushlogin
	ln -s $(CURDIR)/.stowrc ~/.stowrc
	/opt/homebrew/bin/stow .

restow:
	/opt/homebrew/bin/stow --restow .

uninstall:
	# Delete .configs
	/opt/homebrew/bin/stow --delete .
	# Delete formulae and casks
	# NOTE: mas does not uninstall, so this step has to be done manually.
	-/opt/homebrew/bin/brew remove --force --ignore-dependencies $(shell /opt/homebrew/bin/brew list -1)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	sudo rm -rf /opt/homebrew
	# Clean up XDG folders
	rm -rf $(HOME)/.cache
	rm -rf $(HOME)/.config
	rm -rf $(HOME)/.local
	rm -rf ~/.hushlogin
	rm -rf ~/.stowrc
