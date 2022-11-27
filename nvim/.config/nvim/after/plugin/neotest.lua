local neotest = require "neotest"

local adapters = {
   python = require "neotest-python",
}

neotest.setup {
   adapters = vim.tbl_values(adapters),
   diagnostic = { enabled = false },
   output = { open_on_run = false },
   status = { virtual_text = false },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = vim.api.nvim_create_augroup("NeotestKeymap", { clear = true }),
   callback = function()
      local ok, which_key = pcall(require, "which-key")
      if ok == false then return end
      if vim.tbl_contains(vim.tbl_keys(adapters), vim.api.nvim_buf_get_option(0, "filetype")) then
         which_key.register({
            u = { neotest.summary.toggle, "Toggle Neotest Summary" },
            w = {
               function()
                  if vim.tbl_isempty(neotest.run.adapters()) then
                     vim.notify "ﭧ Either no adapters or client didn't start yet"
                     return
                  end
                  if vim.g.test_watcher == nil then
                     vim.g.test_watcher = true
                     neotest.summary.open()
                     vim.notify "ﭧ Started test watcher"
                  else
                     vim.g.test_watcher = nil
                     neotest.summary.close()
                     vim.notify "ﭧ Stopped test watcher"
                  end
               end,
               "Toggle test watcher",
            },
         }, { prefix = "<leader>" })
      else
         require("my.helpers").deregister({ "u", "w" }, { prefix = "<leader>" })
      end
   end,
})
