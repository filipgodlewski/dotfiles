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

   -- Git gutter and more
   {
      "lewis6991/gitsigns.nvim",
      ft = { "gitcommit", "diff" },
      init = function()
         -- taken from NvChad, changed to fit my needs - I have an alias for `git root` that does it better
         vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
               vim.fn.system { "git", "root" }
               if vim.v.shell_error == 0 then
                  vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                  vim.schedule(function() require("lazy").load { plugins = { "gitsigns.nvim" } } end)
                  -- TODO: add keymap for previewing and working on hunks
               end
            end,
         })
      end,
      config = true,
   },

   -- Git conflict helper
   {
      "akinsho/git-conflict.nvim",
      opts = { default_mappings = false },
      config = true,
      event = "BufReadPre",
   },

   -- TODO: Install and configure, then learn nvim-neorg/neorg
}
