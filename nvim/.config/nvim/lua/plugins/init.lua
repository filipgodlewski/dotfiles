local helpers = require "user.helpers"
local nox = { "n", "o", "x" }

return {
   -- SECTION A: EXPERIENCE IMPROVEMENT

   -- Close buffers without destroying the layout
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } } },

   -- Cool spinner for loaders
   { "j-hui/fidget.nvim", config = true },

   -- Crawling through word like everyWordEvenClashedTogether
   --                            ^    ^   ^   ^      ^
   {
      "chrisgrieser/nvim-spider",
      keys = {
         { "w", helpers.cmd "lua require('spider').motion 'w'", mode = nox, desc = "Next word (SPIDER)" },
         { "e", helpers.cmd "lua require('spider').motion 'e'", mode = nox, desc = "Next end of word (SPIDER)" },
         { "b", helpers.cmd "lua require('spider').motion 'b'", mode = nox, desc = "Previous word (SPIDER)" },
         { "ge", helpers.cmd "lua require('spider').motion 'ge'", mode = nox, desc = "Previous end of word (SPIDER)" },
      },
   },

   {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function(_, opts)
         require("nvim-autopairs").setup(opts)
         require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      end,
   },

   -- SECTION B: REFACTORING & CODE ANALYSIS

   -- Better Search & Replace
   -- Examples:
   -- :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
   -- :%S/facilit{y,ies}/building{,s}/g
   {
      "tpope/vim-abolish",
      cmd = { "S", "Abolish" },
      keys = {
         { "cr", mode = "n", desc = "Coersion" },
         { "crc", mode = "n", desc = "camelCase" },
         { "crp", mode = "n", desc = "PascalCase" },
         { "crs", mode = "n", desc = "snake_case" },
         { "cru", mode = "n", desc = "SNAKE_UPPERCASE" },
         { "crk", mode = "n", desc = "kebab-case (not usually reversible)" },
         { "cr.", mode = "n", desc = "dot.case (not usually reversible)" },
      },
   },

   -- Super cool Quickfix layout
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },

   -- Rust related LSP and other tools
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },

   -- Go related tools
   {
      "olexsmir/gopher.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-treesitter/nvim-treesitter",
      },
      ft = "go",
      config = true,
      build = function() vim.cmd [[silent! GoInstallDeps]] end,
   },

   -- SECTION C: INTEGRATIONS

   -- UNIX commands
   {
      "tpope/vim-eunuch",
      cmd = { "Delete", "Rename", "Copy", "Duplicate", "Move", "Chmod", "Mkdir", "SudoWrite", "SudoEdit" },
   },

   {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      opts = function()
         local diffview = require "diffview"
         return {
            keymaps = {
               view = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
               file_panel = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
               file_history_panel = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
            },
         }
      end,
   },

   {
      "NeogitOrg/neogit",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope.nvim",
         "sindrets/diffview.nvim",
      },
      config = true,
      cmd = { "Neogit" },
   },
}
