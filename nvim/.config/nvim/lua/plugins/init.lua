return {
   "nathom/filetype.nvim", -- load ft faster
   { "tpope/vim-abolish", cmd = "S" }, -- better Search & Replace
   "tpope/vim-eunuch", -- UNIX commands
   { "tpope/vim-fugitive", cmd = "G" }, -- Git Integration
   { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true, event = "BufEnter" },
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true, lazy = true },
   { "j-hui/fidget.nvim", config = true }, -- cool spinner for loaders
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },
   { "mbbill/undotree", cmd = "UndotreeToggle" },
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },
   {
      "cshuaimin/ssr.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = true,
      lazy = true,
   },
}
