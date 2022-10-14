vim.opt_local.foldmethod = "indent"
vim.opt_local.foldenable = false
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

local run_formatter = function (cmd)
   vim.api.nvim_command("silent !" .. cmd .. " " .. vim.api.nvim_buf_get_name(0))
end

vim.api.nvim_create_autocmd(
   "BufWritePost",
   {
      callback = function()
         run_formatter("tidy-imports --quiet --unaligned --replace")
         run_formatter("auto-optional")
         run_formatter("black")
      end,
      group = vim.api.nvim_create_augroup("PyBufWritePost", { clear = true })
   }
)
