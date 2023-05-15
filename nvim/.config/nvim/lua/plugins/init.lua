local cmd = function(c) return string.format("<cmd>%s<cr>", c) end
local nox = { "n", "o", "x" }

return {
   -- SECTION A: EXPERIENCE IMPROVEMENT

   -- Close buffers without destroying the layout
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },

   -- Super cool Undo history
   {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      keys = { { "<leader>U", cmd "UndotreeToggle", desc = "Toggle undo tree" } },
   },

   -- Cool spinner for loaders
   { "j-hui/fidget.nvim", config = true },

   -- Object pairs and surrounding
   {
      "kylechui/nvim-surround",
      dependencies = {
         "nvim-treesitter/nvim-treesitter",
         "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = true,
      event = "BufRead",
   },

   -- Crawling through word like everyWordEvenClashedTogether
   --                            ^    ^   ^   ^      ^
   {
      "chrisgrieser/nvim-spider",
      keys = {
         { "w", cmd "lua require('spider').motion 'w'", mode = nox, desc = "Next word (SPIDER)" },
         { "e", cmd "lua require('spider').motion 'e'", mode = nox, desc = "Next end of word (SPIDER)" },
         { "b", cmd "lua require('spider').motion 'b'", mode = nox, desc = "Previous word (SPIDER)" },
         { "ge", cmd "lua require('spider').motion 'ge'", mode = nox, desc = "Previous end of word (SPIDER)" },
      },
   },

   -- SECTION B: REFACTORING & CODE ANALYSIS

   -- Better Search & Replace
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
   {
      "folke/todo-comments.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "folke/trouble.nvim",
      },
      config = true,
      event = "BufRead",
      keys = { { "gT", cmd "TodoTrouble", desc = "Check TODO items" } },
   },

   -- Rust related LSP and other tools
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },

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
