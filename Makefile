export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_DATA_HOME = $(HOME)/.local/share

BREW = /usr/local/bin/brew
CASK = brew cask list $(1) > /dev/null 2>&1 || brew cask install $(1)
DOTFILES_DIR = $(HOME)/dotfiles
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim/bin/python3
PACKAGE = brew list --versions $(1) > /dev/null || brew install $(1)$(2)
PIP_INSTALL = $(1) -m pip install -U pip setuptools; $(1) -m pip install -U -r _pip/$(2)_packages.list
SHELLS = /etc/shells
ZSH = /usr/local/bin/zsh

OS := $(shell [[ "$$OSTYPE" =~ ^darwin ]] && echo macos)

install: git_config $(OS) git_submodules update_nvim new_tmux update_alacritty

macos: core-macos link zsh_conflicts

git_config: 
	@echo "\ngit: Setting up username and email\n"
	@git config --local user.name "Filip Godlewski"
	@git config --local user.email "filip.godlewski@outlook.com"

git_submodules:
	@echo "\ngit: Initialize submodules recursively\n"
	@git submodule update --init --recursive

zsh_conflicts:
	@echo "\nzsh: Set as default\n"
	@if ! grep -q $(ZSH) $(SHELLS); then sudo $(ZSH) >> $(SHELLS) && chsh -s $(ZSH); fi
	@echo "\nzsh: Resolving potential conflicts\n"
	@sudo chown -R $$(whoami) /usr/local/share/zsh || return 1
	@sudo chmod -R 755 /usr/local/share/zsh || return 1
	@sudo chown -R $$(whoami) /usr/local/share/zsh/site-functions || return 1
	@sudo chmod -R 755 /usr/local/share/zsh/site-functions || return 1
	@echo "\nzsh: Compile terminfo\n"
	@for file in $${XDG_DATA_HOME}/terminfo/capabilities/*(.); do tic $${file}; done

update_nvim:
	@echo "\nnvim: Update neovim\n"
	@nvim -c "UpdateRemotePlugins | q"

core-macos: taps packages casks npm pip clean

brew: | $(BREW)
	@echo "\nbrew: update brew\n"
	brew update

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
	$(call PACKAGE,zsh)
	$(call PACKAGE,universal-ctags/universal-ctags/universal-ctags, --HEAD)
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
	@for file in _npm/global_packages.list; do npm install -g $${file}; done

pip:
	@echo "\npip: Update and install global requirements\n"
	@$(call PIP_INSTALL,python3,global)
	@echo "\npip: Create nvim virtual environment\n"
	@python3 -m venv $${XDG_DATA_HOME}/venvs/nvim
	@echo "\npip: Install packages for nvim virtual environment\n"
	$(call PIP_INSTALL,$(NVIM_VENV),nvim)

new_tmux:
	@echo "\ntmux: Create new base session\n"
	@tmux new -t base

update_alacritty:
	@echo "\nalacritty: Update colorscheme\n"
	@cat $(XDG_DATA_HOME)/colorschemes/nord-alacritty/src/nord.yml $(XDG_CONFIG_HOME)/alacritty/base.yml > $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

list:
	@echo "\nTaps:\n"
	@brew tap
	@echo "\nPackages:\n"
	@brew leaves --installed-on-request
	@echo "\nCasks:\n"
	@brew list --cask -1

link:
	@echo "\nstow: link files\n"
	@stow -t $(HOME) stow
	@for directory in $$(ls); do stow -t $(HOME) $$directory; done

unlink:
	@echo "\nstow: unlink files\n"
	@for directory in $$(ls); do stow --delete $$directory; done

clean:
	@echo "\nbrew: clean packages\n"
	@brew cleanup
	@brew cask cleanup

uninstall_brew:
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

uninstall_packages:
	@brew remove --force --ignore-dependencies $(shell brew list)
