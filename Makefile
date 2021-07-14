export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_DATA_HOME = $(HOME)/.local/share

BREW = /usr/local/bin/brew
CASK = brew list --casks $(1) > /dev/null 2>&1 || brew install --cask $(1)
DOTFILES_DIR = $(HOME)/dotfiles
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim/bin/python3
PACKAGE = brew list --versions $(1) > /dev/null || brew install $(1)$(2)
PIP_INSTALL = $(1) -m pip install -U pip setuptools; $(1) -m pip install -U -r _pip/$(2)_packages.list
PYTHON = /Library/Frameworks/Python.framework/Versions/Current/bin/python3
SHELLS = /etc/shells
ZSH = /usr/local/bin/zsh

OS := $(shell [[ "$$OSTYPE" =~ ^darwin ]] && echo macos)

.PHONY: alacritty git nvim tmux zsh

install: git $(OS) submodules nvim tmux alacritty

uninstall: unnpm unzsh unalacritty unpip unlink unbrew

macos: core-macos link zsh

git: 
	@echo "\ngit: Setting up username and email\n"
	@git config --local user.name "Filip Godlewski"
	@git config --local user.email "filip.godlewski@outlook.com"

submodules:
	@echo "\ngit: Initialize submodules recursively\n"
	@git submodule update --init --recursive

zsh:
	@echo "\nzsh: Set as default\n"
	@if ! grep -q $(ZSH) $(SHELLS); then sudo $(ZSH) >> $(SHELLS) && chsh -s $(ZSH); fi
	@echo "\nzsh: Resolving potential conflicts\n"
	@sudo chown -R $$(whoami) /usr/local/share/zsh
	@sudo chown -R $$(whoami) /usr/local/share/zsh/site-functions
	@sudo chmod g-w /usr/local/share/zsh
	@sudo chmod g-w /usr/local/share/zsh/site-functions
	@echo "\nzsh: Compile terminfo\n"
	@for file in $(XDG_DATA_HOME)/terminfo/capabilities/*; do tic $$file; done

unzsh:
	@chsh -s /bin/zsh

nvim:
	@echo "\nnvim: Update neovim\n"
	@nvim -c "UpdateRemotePlugins | q"

core-macos: taps packages casks npm pip clean

brew: | $(BREW)
	@echo "\nbrew: update brew\n"
	brew update

unbrew:
	@brew remove --force --ignore-dependencies $(shell brew list)
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

$(BREW):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

taps: | brew
	@echo "\nbrew: Open taps\n"
	brew tap homebrew/cask
	brew tap homebrew/cask-fonts
	brew tap homebrew/cask-versions
	brew tap homebrew/core
	brew tap homebrew/services
	brew tap koekeishiya/formulae
	brew tap universal-ctags/universal-ctags

packages: | brew
	@echo "\nbrew: Install basic packages\n"
	$(call PACKAGE,exa)
	$(call PACKAGE,fd)
	$(call PACKAGE,fzf)
	$(call PACKAGE,git)
	$(call PACKAGE,jq)
	$(call PACKAGE,luajit, --HEAD)
	$(call PACKAGE,neovim, --HEAD)
	$(call PACKAGE,ripgrep)
	$(call PACKAGE,stow)
	$(call PACKAGE,tmux)
	$(call PACKAGE,universal-ctags/universal-ctags/universal-ctags, --HEAD)
	$(call PACKAGE,vivid)
	$(call PACKAGE,zsh)
	@echo "\nbrew: Install python development packages\n"
	$(call PACKAGE,yapf)
	@echo "\nbrew: Install javascript development packages\n"
	$(call PACKAGE,node)

casks: | brew
	@echo "\nbrew: Install basic casks\n"
	$(call CASK,alacritty)
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

unnpm:
	@npm ls -gp --depth=0 | awk -F/ '/node_modules/ && !/\/npm$$/ {print $$NF}' | xargs npm -g rm

pip:
	@echo "\npip: Update and install global requirements\n"
	@$(call PIP_INSTALL,$(PYTHON),global)
	@echo "\npip: Create nvim virtual environment\n"
	@python3 -m venv $(XDG_DATA_HOME)/venvs/nvim
	@echo "\npip: Install packages for nvim virtual environment\n"
	$(call PIP_INSTALL,$(NVIM_VENV),nvim)

unpip:
	@echo "\npip: Delete global packages\n"
	@$(PYTHON) -m pip list --format freeze | sed 's/==.*//' | sed -E '/^(pip|setuptools)/d'
	@echo "\npip: Delete nvim virtual environment\n"
	@deactivate &>/dev/null
	@rm -rf $(XDG_DATA_HOME)/venvs/nvim

tmux:
	@echo "\ntmux: Create new base session\n"
	@tmux new-session -d -s base

alacritty:
	@echo "\nalacritty: Update colorscheme\n"
	@cat $(XDG_DATA_HOME)/alacritty/nord-alacritty/src/nord.yml $(XDG_CONFIG_HOME)/alacritty/base.yml > $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

unalacritty:
	@echo "\nalacritty: Delete colorscheme\n"
	@rm $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

list:
	@echo "\nTaps:\n"
	@brew tap
	@echo "\nPackages:\n"
	@brew leaves --installed-on-request
	@echo "\nCasks:\n"
	@brew list --casks -1

link:
	@echo "\nstow: link files\n"
	@stow stow
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow $$directory; done

unlink:
	@echo "\nstow: unlink files\n"
	@stow -D stow
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done

clean:
	@echo "\nbrew: clean packages\n"
	@brew cleanup --prune=all
