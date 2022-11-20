--require "impatient"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.python3_host_prog = os.getenv "XDG_DATA_HOME" .. "/venvs/nvim/bin/python3"

vim.opt.autowriteall = true
vim.opt.complete:append "kspell"
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.diffopt = { "filler", "vertical" }
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --case-sensitive --follow --word-regexp"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.matchpairs:append "<:>"
vim.opt.mouse = "ar"
vim.opt.nrformats:append "alpha"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.path:append "**"
vim.opt.pumheight = 15
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "auto"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 50
vim.opt.wrap = true
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal" }
-- vim.opt.splitkeep = "screen"  -- uncomment in nvim 0.9

require("my.project_configs").setup()
