homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	-export HOMEBREW_CASK_OPTS="--no-quarantine"; brew bundle install --file $(CURDIR)/homebrew/Brewfile

tools:
	[ -s "$(CURDIR)/dependencies/gh-deps" ] && gh extension install $(shell cat $(CURDIR)/dependencies/gh-deps)
	[ -s "$(CURDIR)/dependencies/uv-deps" ] && uv tool install $(shell cat $(CURDIR)/dependencies/uv-deps)
	[ -s "$(CURDIR)/dependencies/bun-deps" ] && bun install --global $(shell cat $(CURDIR)/dependencies/bun-deps)

restow:
	/opt/homebrew/bin/stow --restow .

install: homebrew tools restow
	touch ~/.hushlogin
	ln -s $(CURDIR)/.stowrc ~/.stowrc

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
