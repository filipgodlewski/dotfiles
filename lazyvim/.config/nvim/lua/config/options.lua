vim.g.python3_host_prog = vim.fn.stdpath("data") .. "/venv/bin/python"

vim.opt.timeoutlen = 100
vim.opt.autowriteall = true
vim.opt.shortmess:append({ s = true })
vim.opt.nrformats:append("alpha")
vim.opt.matchpairs:append("<:>")
vim.opt.clipboard = ""
