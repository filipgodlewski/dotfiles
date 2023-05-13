return {
   -- SECTION A: EXPERIENCE IMPROVEMENT

   -- Close buffers without destroying the layout
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },

   -- Super cool Undo history
   { "mbbill/undotree", cmd = "UndotreeToggle" },

   -- load ft faster
   -- "nathom/filetype.nvim",

   -- cool spinner for loaders
   { "j-hui/fidget.nvim", config = true },

   -- SECTION B: REFACTORING & CODE ANALYSIS

   -- better Search & Replace
   { "tpope/vim-abolish", cmd = "S" },

   -- Structural Search and Replace
   {
      "cshuaimin/ssr.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = true,
      lazy = true,
   },

   -- Super cool Quickfix layout
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true, lazy = true },

   -- Colorize `TODO` and other comments
   { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true, event = "BufRead" },

   -- Rust related LSP and other tools
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },

   -- Either jump to definition or reference, using one shortcut
   { "KostkaBrukowa/definition-or-references.nvim", keys = "gd" },

   -- SECTION C: INTEGRATIONS

   -- UNIX commands
   {
      "tpope/vim-eunuch",
      cmd = { "Delete", "Rename", "Copy", "Duplicate", "Move", "Chmod", "Mkdir", "SudoWrite", "SudoEdit" },
   },

   -- Git gutter and more
   { "lewis6991/gitsigns.nvim", config = true, event = "BufRead" },

   -- Git conflict helper
   {
      "akinsho/git-conflict.nvim",
      opts = { default_mappings = false },
      config = true,
      event = "BufReadPre",
   },
}
