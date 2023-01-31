return {
   "nathom/filetype.nvim", -- load ft faster
   { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true, event = "BufEnter" },
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true, lazy = true },
   { "j-hui/fidget.nvim", config = true }, -- cool spinner for loaders
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },
   { "mbbill/undotree", cmd = "UndotreeToggle" },
   { "mizlan/iswap.nvim", config = true, lazy = true },
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },
   { "tpope/vim-abolish", cmd = "S" }, -- better Search & Replace
   {
      "boltlessengineer/bufterm.nvim",
      config = true,
      keys = {
         { "<leader>T", "<cmd>wincmd s<cr><cmd>terminal<cr>", desc = "Term" },
      },
   },
}
