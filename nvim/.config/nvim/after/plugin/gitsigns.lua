local which_key = require "which-key"
local gitsigns = require "gitsigns"

gitsigns.setup {
   signcolumn = false,
   on_attach = function(bufnr)
      if vim.b.gitsigns_head ~= nil then
         which_key.register({
            H = {
               name = "Hunks",
               b = { gitsigns.toggle_current_line_blame, "Blame" },
               d = { gitsigns.toggle_deleted, "Deleted" },
               l = { gitsigns.toggle_linehl, "Lines" },
               n = { gitsigns.next_hunk, "Next" },
               p = { gitsigns.prev_hunk, "Previous" },
               r = { gitsigns.reset_hunk, "Reset" },
               s = { gitsigns.stage_hunk, "Stage" },
               u = { gitsigns.undo_stage_hunk, "Undo Stage" },
            },
            D = { function() vim.cmd "DiffviewOpen" end, "Diff" },
         }, { prefix = "<leader>", buffer = bufnr })
      end
   end,
}

vim.api.nvim_create_autocmd("User", {
   pattern = "DiffviewViewOpened",
   callback = function()
      which_key.register(
         { D = { function() vim.cmd "DiffviewClose" end, "Diff Close" } },
         { prefix = "<leader>", buffer = 0 }
      )
   end,
})
