local neotest = require "neotest"

local adapters = {
   python = require "neotest-python" { dap = { justMyCode = false } },
}

neotest.setup {
   adapters = vim.tbl_values(adapters),
   output = { open_on_run = false },
   status = { virtual_text = false },
   log_level = vim.log.levels.INFO,
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = vim.api.nvim_create_augroup("NeotestKeymap", { clear = true }),
   callback = function()
      if vim.tbl_contains(vim.tbl_keys(adapters), vim.api.nvim_buf_get_option(0, "filetype")) then
         vim.keymap.set("n", "<leader>u", neotest.summary.toggle, { remap = true, buffer = true, desc = "Neotest" })
      end
   end,
})
