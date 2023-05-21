local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   local repo = "https://github.com/folke/lazy.nvim"
   vim.fn.system { "git", "clone", "--filter=blob:none", "-b", "stable", repo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

vim.g.python3_host_prog = vim.fn.stdpath "data" .. "/venv/bin/python"
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.autowriteall = true
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.complete:append "kspell"
vim.opt.conceallevel = 1
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.diffopt = { "filler", "vertical" }
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --color=never --no-heading --with-filename --line-number --column"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.matchpairs:append "<:>"
vim.opt.mouse = "ar"
vim.opt.nrformats:append "alpha"
vim.opt.number = false
vim.opt.path:append "**"
vim.opt.pumheight = 15
vim.opt.relativenumber = false
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append "sI"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.spell = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.timeoutlen = 100
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 50
vim.opt.wrap = true

local default_config = {
   defaults = { lazy = true },
   install = { colorscheme = { "catppuccin-macchiato" } },
   rtp = {
      disabled_plugins = {
         "2html_plugin",
         "tohtml",
         "getscript",
         "getscriptPlugin",
         "gzip",
         "logipat",
         "netrw",
         "netrwPlugin",
         "netrwSettings",
         "netrwFileHandlers",
         "matchit",
         "tar",
         "tarPlugin",
         "rrhelper",
         "spellfile_plugin",
         "vimball",
         "vimballPlugin",
         "zip",
         "zipPlugin",
         "tutor",
         "rplugin",
         "syntax",
         "synmenu",
         "optwin",
         "compiler",
         "bugreport",
         "ftplugin",
      },
   },
}

require("lazy").setup("plugins", default_config)

vim.notify = require "notify"

require "user.font"
require("user.project-configs").setup()
require "user.aucmds"
vim.cmd.colorscheme "catppuccin"
