-- Backend files
vim.opt.autowriteall = true
vim.opt.confirm = true
vim.opt.path:append "**"
vim.opt.swapfile = false
vim.opt.undofile = true

-- UI behavior
vim.opt.cmdheight = 0
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.mouse = "ar"
vim.opt.shortmess:append "sI"
vim.opt.signcolumn = "yes"

-- line & sign column
vim.opt.nrformats:append "alpha"
vim.opt.spell = true

-- line behavior
vim.opt.breakindent = true
vim.opt.conceallevel = 1
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.matchpairs:append "<:>"
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2

-- split management
vim.opt.diffopt = { "filler", "vertical" }
vim.opt.inccommand = "split"
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true

-- search
vim.opt.grepformat:append "%f:%l:%c:%m"
vim.opt.grepprg = "rg --color=never --no-heading --with-filename --line-number --column"
vim.opt.ignorecase = true
vim.opt.smartcase = true
