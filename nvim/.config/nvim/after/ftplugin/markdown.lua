vim.opt_local.wrap = true
vim.opt_local.linebreak = true

require("which-key").register({
   ["<CR>"] = { ":EasyAlign *<Bar><CR>", "Align table" },
}, { mode = "v", buffer = 0 })
