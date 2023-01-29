return {
   "folke/which-key.nvim",
   opts = {
      key_labels = {
         ["<space>"] = "␣",
         ["<cr>"] = "",
         ["<tab>"] = "",
         ["<M-Bslash>"] = [[<M-\>]],
         ["<leader>"] = "⌘",
      },
      layout = {
         height = { min = 1, max = 25 },
         width = { min = 5, max = 50 },
         align = "center",
      },
      icons = {
         separator = "ﰲ",
         group = " ",
      },
   },
   config = function(_, opts)
      local which_key = require "which-key"
      which_key.setup(opts)
      which_key.register {
         ["<esc>"] = { "<cmd>silent LuaSnipUnlinkCurrent<cr>", "Escape", remap = true },
         ["<leader>"] = {
            name = "Leader",
            h = { name = "Hunk" },
            n = { name = "Tree" },
            t = { name = "Search" },
         },
      }
   end,
}
