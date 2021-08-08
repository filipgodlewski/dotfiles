export XDG_CONFIG_HOME = $(HOME)/.config
export XDG_DATA_HOME = $(HOME)/.local/share

BREW = /usr/local/bin/brew
CASK = brew list --casks $(1) > /dev/null 2>&1 || brew install --cask $(1)
DOTFILES_DIR = $(HOME)/dotfiles
MAS = mas install $(1)
NVIM_VENV = $(XDG_DATA_HOME)/venvs/nvim/bin/python3
PACKAGE = brew list --versions $(1) > /dev/null || brew install $(1) $(2)
PIP_INSTALL = $(1) -m pip install -U pip setuptools; $(1) -m pip install -U -r _pip/$(2)_packages.list
PYTHON = /Library/Frameworks/Python.framework/Versions/Current/bin/python3
SHELL = /bin/zsh
SHELLS = /etc/shells
ZSH = /usr/local/bin/zsh

OS := $(shell [[ "$$OSTYPE" =~ ^darwin ]] && echo macos)
IN_TMUX := $(shell [[ -n $TMUX ]] && echo end || echo uninstall-proceed)

.PHONY: alacritty git nvim stow tmux zsh

install: git $(OS) submodules nvim tmux alacritty mas

uninstall: $(IN_TMUX)

uninstall-proceed: unnpm unzsh unalacritty unpip unstow unbrew

end:
	@echo "\nKill tmux and try again!\n"
	@exit 1

macos: core-macos stow pip zsh

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

zsh:
	@echo "\nzsh: Set as default\n"
	@if ! grep -q $(ZSH) $(SHELLS); then sudo $(ZSH) >> $(SHELLS); chsh -s $(ZSH); fi
	@echo "\nzsh: Resolving potential conflicts\n"
	@sudo chown -R $$(whoami) /usr/local/share/zsh
	@sudo chown -R $$(whoami) /usr/local/share/zsh/site-functions
	@sudo chmod g-w /usr/local/share/zsh
	@sudo chmod g-w /usr/local/share/zsh/site-functions
	@echo "\nzsh: Compile terminfo\n"
	@for file in $(XDG_DATA_HOME)/terminfo/capabilities/*; do tic -xe $$file; done

unzsh:
	@chsh -s /bin/zsh

nvim:
	@echo "\nnvim: Update neovim\n"
	@nvim -c "UpdateRemotePlugins | call mkdp#util#install() | q"
	@echo "\nnvim: Setup lua lsp\n"
	@cd $(XDG_DATA_HOME)/other/lua-language-server/3rd/luamake
	@compile/install.sh
	@cd ../..
	@./3rd/luamake/luamake rebuild

core-macos: taps packages casks npm clean

brew: | $(BREW)
	@echo "\nbrew: update brew\n"
	brew update

unbrew:
	@brew remove --force --ignore-dependencies $(shell brew list)
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

$(BREW):
	@/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
	$(call PACKAGE,gh)
	$(call PACKAGE,git)
	$(call PACKAGE,mas)
	$(call PACKAGE,neovim)
	$(call PACKAGE,ripgrep)
	$(call PACKAGE,sd)
	$(call PACKAGE,stow)
	$(call PACKAGE,tmux)
	$(call PACKAGE,tokei)
	$(call PACKAGE,vivid)
	$(call PACKAGE,zoxide)
	$(call PACKAGE,zsh)
	-$(call PACKAGE,universal-ctags/universal-ctags/universal-ctags,--HEAD)
	@echo "\nbrew: Install python development packages\n"
	$(call PACKAGE,yapf)
	@echo "\nbrew: Install javascript development packages\n"
	$(call PACKAGE,jq)
	$(call PACKAGE,deno)
	$(call PACKAGE,node)
	@echo "\nbrew: Install lua development packages\n"
	$(call PACKAGE,ninja)

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
	@$(PYTHON) -m pip list --format freeze | sed 's/==.*//' | sed -E '/^(pip|setuptools)/d' | xargs -n1 $(PYTHON) -m pip -q uninstall -y
	@echo "\npip: Delete nvim virtual environment\n"
	@-deactivate &>/dev/null
	@-rm -rf $(XDG_DATA_HOME)/venvs/nvim

repip: unpip pip

tmux:
	@echo "\ntmux: Create new base session\n"
	@-tmux new-session -d -s base

alacritty:
	@echo "\nalacritty: Update colorscheme\n"
	@cat $(XDG_DATA_HOME)/alacritty/alacritty-aurora/src/aurora.yml $(XDG_CONFIG_HOME)/alacritty/base.yml > $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

unalacritty:
	@echo "\nalacritty: Delete colorscheme\n"
	@-rm -rf $(XDG_CONFIG_HOME)/alacritty/alacritty.yml

mas:
	@$(call $(MAS),497799835)  # Xcode
	@$(call $(MAS),497799835)  # Surfshark
	@$(call $(MAS),409183694)  # Keynote
	@$(call $(MAS),1474276998)  # HP Smart
	@$(call $(MAS),408981434)  # iMovie
	@$(call $(MAS),823766827)  # OneDrive
	@$(call $(MAS),1438243180)  # Dark Reader for Safari
	@$(call $(MAS),409201541)  # Pages
	@$(call $(MAS),1436953057)  # Ghostery Lite
	@$(call $(MAS),682658836)  # GarageBand
	@$(call $(MAS),1482920575)  # DuckDuckGo Privacy Essentials
	@$(call $(MAS),1147396723)  # WhatsApp
	@$(call $(MAS),409203825)  # Numbers
	@$(call $(MAS),1333542190)  # 1Password 7

list:
	@echo "\nTaps:\n"
	@brew tap
	@echo "\nPackages:\n"
	@brew leaves --installed-on-request
	@echo "\nCasks:\n"
	@brew list --casks -1

stow:
	@echo "\nstow: link files\n"
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow $$directory; done

unstow:
	@echo "\nstow: unlink files\n"
	@for directory in $$(fd --ignore-file stow/.stow-global-ignore -d 1 -c never); do stow -D $$directory; done

clean:
	@echo "\nbrew: clean packages\n"
	@brew cleanup --prune=all
