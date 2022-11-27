local neotest = require "neotest"

local adapters = {
   python = require "neotest-python",
}

neotest.setup {
   adapters = vim.tbl_values(adapters),
   output = { open_on_run = false },
   status = { virtual_text = false },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = vim.api.nvim_create_augroup("NeotestKeymap", { clear = true }),
   callback = function()
      local ok, which_key = pcall(require, "which-key")
      if ok == false then return end
      if vim.tbl_contains(vim.tbl_keys(adapters), vim.api.nvim_buf_get_option(0, "filetype")) then
         which_key.register({ u = { neotest.summary.toggle "Neotest" } }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})
