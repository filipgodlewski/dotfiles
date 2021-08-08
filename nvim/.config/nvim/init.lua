vim.g.mapleader = " "
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/venvs/nvim/bin/python3")
vim.g.colors_name = "aurora_altered"

vim.opt.autowriteall = true
vim.opt.complete = vim.opt.complete + "kspell"
vim.opt.completeopt = {"menuone", "noinsert", "noselect"}
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.diffopt = {"filler", "vertical"}
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --case-sensitive --follow --word-regexp"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.lazyredraw = true
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"
vim.opt.mouse = "i"
vim.opt.nrformats = vim.opt.nrformats + "alpha"
vim.opt.path = vim.opt.path + "**"
vim.opt.pumblend = 30
vim.opt.pumheight = 10
vim.opt.shell = "/usr/local/bin/zsh"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.wildignore = vim.opt.wildignore + {"*.swp", "*.bak"}  -- temporary files
vim.opt.wildignore = vim.opt.wildignore + {"*.tar.*", "*.zip*"}  -- packages
vim.opt.wildignore = vim.opt.wildignore + {"*/.git/**/*", "*/.hg/**/*", "*/.svn/**/*"}  -- VCS
vim.opt.wildignore = vim.opt.wildignore + {"__*__", "*.pyc", "*.egg-info", "*/.pytest_cache/**/*"}  -- python
vim.opt.wildignore = vim.opt.wildignore + {"tags", "tags.*"}  -- ctags
vim.opt.wildignorecase = true
vim.opt.wildmode = {"longest:full", "full"}

vim.cmd("au FocusGained,WinEnter,BufEnter * checktime")
