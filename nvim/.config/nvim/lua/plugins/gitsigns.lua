return {
   "lewis6991/gitsigns.nvim",
   opts = function()
      local gitsigns = require "gitsigns"
      return {
         attach_to_untracked = false,
         on_attach = function(bufnr)
            if vim.b.gitsigns_head then
               vim.keymap.set("n", "<leader>h", "", { desc = "Hunks" })
               vim.keymap.set("n", "<leader>hb", gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = "Blame" })
               vim.keymap.set("n", "<leader>hd", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Deleted" })
               vim.keymap.set("n", "<leader>hl", gitsigns.toggle_linehl, { buffer = bufnr, desc = "Lines" })
               vim.keymap.set("n", "<leader>hn", gitsigns.next_hunk, { buffer = bufnr, desc = "Next" })
               vim.keymap.set("n", "<leader>hp", gitsigns.prev_hunk, { buffer = bufnr, desc = "Previous" })
               vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset" })
               vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage" })
               vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage" })
               vim.keymap.set("n", "<leader>d", "<cmd>DiffviewOpen<cr>", { buffer = bufnr, desc = "Diff" })
            end
         end,
      }
   end,
   event = "BufAdd",
}
