-- Taken from jghauser/mkdir.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
   group = vim.api.nvim_create_augroup("MkdirP", { clear = true }),
   callback = function()
      local dir = vim.fn.expand "<afile>:p:h"
      if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
   end,
})
