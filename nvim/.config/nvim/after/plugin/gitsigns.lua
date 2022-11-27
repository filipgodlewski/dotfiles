local which_key = require "which-key"
local gitsigns = require "gitsigns"
local my_helpers = require "my.helpers"

gitsigns.setup {
   signcolumn = false,
   on_attach = function(bufnr)
      if vim.b.gitsigns_head == nil then
         my_helpers.deregister({ "c", "n", "o", "p", "r", "s", "t", "u" }, { prefix = "<leader>h" })
         my_helpers.deregister { "<leader>h" }
      else
         which_key.register({
            h = {
               name = "Hunks",
               c = { function() vim.cmd "DiffviewClose" end, "Close diff" },
               n = { gitsigns.next_hunk, "Next hunk" },
               o = { function() vim.cmd "DiffviewOpen" end, "Open diff view" },
               p = { gitsigns.prev_hunk, "Previous hunk" },
               r = { gitsigns.reset_hunk, "Reset hunk" },
               s = { gitsigns.stage_hunk, "Stage hunk" },
               t = { function() vim.cmd "DiffviewToggleFiles" end, "Toggle Files pane" },
               u = { gitsigns.undo_stage_hunk, "Undo staging hunk" },
            },
         }, { prefix = "<leader>", buffer = bufnr })
      end
   end,
}
