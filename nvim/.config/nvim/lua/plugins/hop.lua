return {
   "phaazon/hop.nvim",
   dependencies = { { "mfussenegger/nvim-treehopper", lazy = true } },
   opts = { keys = "hateludosiwync" },
   config = function(_, opts)
      local hop = require "hop"
      local hint = require "hop.hint"

      hop.setup(opts)
      require("tsht").config.hint_keys = vim.split(opts.keys, "")

      local AFTER = hint.HintDirection.AFTER_CURSOR
      local BEFORE = hint.HintDirection.BEFORE_CURSOR
      local END = hint.HintPosition.END

      local h_set = function(key, fn) vim.keymap.set({ "n", "x", "o" }, key, fn, { remap = true }) end
      local set = vim.keymap.set

      h_set("f", function() hop.hint_char1 { direction = AFTER, current_line_only = true } end)
      h_set("F", function() hop.hint_char1 { direction = BEFORE, current_line_only = true } end)
      h_set("T", function() hop.hint_char1 { direction = BEFORE, current_line_only = true, hint_offset = 1 } end)
      h_set("t", function() hop.hint_char1 { direction = AFTER, current_line_only = true, hint_offset = -1 } end)
      h_set("E", function() hop.hint_words { direction = AFTER, hint_position = END } end)
      h_set("gE", function() hop.hint_words { direction = BEFORE, hint_position = END } end)
      h_set("W", hop.hint_words)
      set({ "x", "o" }, "m", ":<C-U>lua require'tsht'.nodes()<CR>", { remap = true, desc = "Act on TS node" })
      set("n", "<leader>w", function() hop.hint_words { multi_windows = true } end, { remap = true, desc = "Hop" })
   end,
   keys = {
      { "f", mode = { "n", "x", "o" } },
      { "F", mode = { "n", "x", "o" } },
      { "t", mode = { "n", "x", "o" } },
      { "T", mode = { "n", "x", "o" } },
      { "E", mode = { "n", "x", "o" } },
      { "gE", mode = { "n", "x", "o" } },
      { "W" },
      { "m", mode = { "x", "o" } },
      { "<leader>w", desc = "Hop" },
   },
}
