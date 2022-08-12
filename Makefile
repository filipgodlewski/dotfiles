export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_DATA_HOME = $(HOME)/.local/share

BREW = /usr/local/bin/brew
CASK = brew list --casks $(1) > /dev/null 2>&1 || brew install --cask $(1)
DOTFILES_DIR = $(HOME)/dotfiles
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim/bin/python3
PACKAGE = brew list --versions $(1) > /dev/null || brew install $(1) $(2)
PIP_INSTALL = $(1) -m pip install -U pip setuptools; $(1) -m pip install -U -r _pip/$(2)_packages.list
PYTHON = /Library/Frameworks/Python.framework/Versions/Current/bin/python3
SHELL = /bin/zsh
SHELLS = /etc/shells
ZSH = /usr/local/bin/zsh
NUSHELL = /usr/local/bin/nu

OS := $(shell [[ "$$OSTYPE" =~ ^darwin ]] && echo macos)
IN_TMUX := $(shell [[ -n $TMUX ]] && echo _end || echo _uninstall-proceed)

.PHONY: git nvim stow tmux zsh

# Installing

install: git $(OS) submodules nvim tmux

git:
	@echo "\ngit: Setting up username and email\n"
	@echo -n "Enter git user name: "; \
		read name; \
		git config --local user.name $$name
	@echo -n "Enter git email: "; \
		read mail; \
		git config --local user.email $$mail

submodules:
	@echo "\ngit: Initialize submodules recursively\n"
	@git submodule update --init --recursive

nvim:
	@echo "\nnvim: Update neovim\n"
	@nvim -c "UpdateRemotePlugins | q"
	# @echo "\nnvim: Setup lua lsp\n"
	# @cd $(XDG_DATA_HOME)/other/lua-language-server/3rd/luamake; ./compile/install.sh
	# @cd ${XDG_DATA_HOME}/other/lua-language-server; ./3rd/luamake/luamake rebuild
	@echo "\nnvim: Build telescope-fzf-native\n"
	@cd $(XDG_DATA_HOME)/nvim/site/pack/plugins/start/telescope-fzf-native.nvim; make


tmux:
	@echo "\ntmux: Create new base session\n"
	@-tmux new-session -d -s base

macos: core-macos stow pip zsh

core-macos: brew_taps brew_packages brew_casks npm brew_clean

$(BREW):
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew: | $(BREW)
	@echo "\nbrew: update brew\n"
	brew update

brew_taps: | brew
	@echo "\nbrew: Open taps\n"
	brew tap homebrew/cask
	brew tap homebrew/cask-fonts
	brew tap homebrew/cask-versions
	brew tap homebrew/core
	brew tap homebrew/services

brew_packages: | brew
	@echo "\nbrew: Install basic packages\n"
	$(call PACKAGE,bat)
	$(call PACKAGE,cmake)
	$(call PACKAGE,exa)
	$(call PACKAGE,fd)
	$(call PACKAGE,fzf)
	$(call PACKAGE,gh)
	$(call PACKAGE,git)
	$(call PACKAGE,git-delta)
	$(call PACKAGE,grex)
	$(call PACKAGE,less)
	$(call PACKAGE,mas)
	$(call PACKAGE,neovim)
	$(call PACKAGE,ripgrep)
	$(call PACKAGE,sd)
	$(call PACKAGE,stow)
	$(call PACKAGE,tmux)
	$(call PACKAGE,tokei)
	$(call PACKAGE,tree-sitter)
	$(call PACKAGE,vivid)
	$(call PACKAGE,zsh)
	@echo "\nbrew: Install python development packages\n"
	$(call PACKAGE,yapf)
	@echo "\nbrew: Install javascript development packages\n"
	$(call PACKAGE,jq)
	$(call PACKAGE,node)
	@echo "\nbrew: Install lua development packages\n"
	$(call PACKAGE,ninja)
	$(call PACKAGE,lua-language-server)

brew_casks: | brew
	@echo "\nbrew: Install basic casks\n"
	$(call CASK,alacritty)
	$(call CASK,hammerspoon)
	$(call CASK,librewolf)
	$(call CASK,rocket)
	$(call CASK,pine)
	$(call CASK,airpass)
	@echo "\nbrew: Install fonts\n"
	$(call CASK,font-fira-code-nerd-font)
	$(call CASK,font-victor-mono)

npm:
	@echo "\nnpm: Update and install global requirements\n"
	@for file in $$(<$(DOTFILES_DIR)/_npm/global_packages.list); do npm install -g $$file; done
	@echo {} > package.json
	@npm install --package-lock-only
	@npm audit fix
	@rm package-lock.json package.json

brew_clean:
	@echo "\nbrew: clean packages\n"
	@brew cleanup --prune=all

stow:
	@echo "\nstow: link files\n"
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow $$directory; done

pip:
	@echo "\npip: Update and install global python requirements\n"
	@$(call PIP_INSTALL,$(PYTHON),global)
	@echo "\npip: Create nvim virtual environment\n"
	@python3 -m venv $(XDG_DATA_HOME)/venvs/nvim
	@echo "\npip: Install packages for nvim virtual environment\n"
	$(call PIP_INSTALL,$(NVIM_VENV),nvim)

zsh:
	@echo "\nzsh: Set as default\n"
	@if ! grep -q $(ZSH) $(SHELLS); then sudo $(ZSH) >> $(SHELLS); chsh -s $(ZSH); fi
	@echo "\nzsh: Resolving potential conflicts\n"
	@sudo chown -R $$(whoami) /usr/local/share/zsh
	@sudo chown -R $$(whoami) /usr/local/share/zsh/site-functions
	@sudo chmod g-w /usr/local/share/zsh
	@sudo chmod g-w /usr/local/share/zsh/site-functions

# Uninstalling

uninstall: $(IN_TMUX)

_uninstall-proceed: unnpm unzsh unpip unstow unbrew

unnpm:
	@npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$$/ {print $$NF}' | xargs npm -g rm

unzsh:
	@chsh -s /bin/zsh

unpip:
	@echo "\npip: Delete global packages\n"
	@$(PYTHON) -m pip list --format freeze | sed 's/==.*//' | sed -E '/^(pip|setuptools)/d' | xargs -n1 $(PYTHON) -m pip -q uninstall -y
	@echo "\npip: Delete nvim virtual environment\n"
	@-deactivate &>/dev/null
	@-rm -rf $(XDG_DATA_HOME)/venvs/nvim

unstow:
	@echo "\nstow: unlink files\n"
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done

unbrew:
	@brew remove --force --ignore-dependencies $(shell brew list)
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Other commands

repip: unpip pip

list:
	@echo "\nTaps:\n"
	@brew tap
	@echo "\nPackages:\n"
	@brew leaves --installed-on-request
	@echo "\nCasks:\n"
	@brew list --casks -1

_end:
	@echo "\nKill tmux and try again!\n"
	@exit 1

