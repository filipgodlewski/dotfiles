require "impatient"

vim.g.mapleader = " "
vim.g.python3_host_prog = os.getenv "XDG_DATA_HOME" .. "/venvs/nvim/bin/python3"

vim.opt.autowriteall = true
vim.opt.complete = vim.opt.complete + "kspell"
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.diffopt = { "filler", "vertical" }
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --case-sensitive --follow --word-regexp"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"
vim.opt.mouse = "ar"
vim.opt.nrformats = vim.opt.nrformats + "alpha"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.path = vim.opt.path + "**"
vim.opt.pumheight = 15
vim.opt.shell = os.getenv "HOMEBREW_PREFIX" .. "/bin/zsh"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "no"
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
vim.opt.wrap = false
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal" }

-- terminal settings
vim.api.nvim_create_augroup("OnTermOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
   group = "OnTermOpen",
   pattern = "*",
   command = "setlocal nonumber norelativenumber",
})
