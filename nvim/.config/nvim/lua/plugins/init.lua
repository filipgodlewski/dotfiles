return {
   {
      "RRethy/vim-illuminate",
      name = "illuminate",
      opts = {
         min_count_to_highlight = 2,
      },
      config = function(plugin, opts) require(plugin.name).configure(opts) end,
   },

   -- startup improvers
   "nathom/filetype.nvim", -- load ft faster
   "samjwill/nvim-unception", -- when using nvim's terminal, open nvim within this instance
   { "j-hui/fidget.nvim", config = true }, -- cool spinner for loaders

   -- goodies
   { "tpope/vim-abolish", cmd = "S" }, -- better Search & Replace
   { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true, lazy = true },
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },
   { "natecraddock/workspaces.nvim", dependencies = { "natecraddock/sessions.nvim" }, lazy = true },

   -- writing tools
   { "mizlan/iswap.nvim", config = true, lazy = true },
   { "mbbill/undotree", keys = { { "<leader>U", ":UndotreeToggle<cr>", noremap = true, desc = "Undo" } } },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-cmdline",
         { "rcarriga/cmp-dap", lazy = true },
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-nvim-lsp-document-symbol",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-path",
         "saadparwaiz1/cmp_luasnip",
         "lukas-reineke/cmp-under-comparator",
      },
   },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/popup.nvim",
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope-ui-select.nvim",
         "nvim-telescope/telescope-dap.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
         "nvim-telescope/telescope-file-browser.nvim",
      },
   },

   -- debugging / testing / lsp
   "neovim/nvim-lspconfig",
   {
      "mfussenegger/nvim-dap",
      dependencies = {
         "mfussenegger/nvim-dap-python",
         "rcarriga/nvim-dap-ui",
      },
      ft = { "python" },
   },
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },
   {
      "cshuaimin/ssr.nvim",
      keys = { { "<leader>R", function() require("ssr").open() end, mode = { "n", "x" }, desc = "Structural Replace" } },
   },
   {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = function()
         return {
            sync_root_with_cwd = true,
            diagnostics = { enable = true },
            select_prompts = true,
            view = {
               width = 40,
               mappings = {
                  list = {
                     {
                        key = "w",
                        action = "collapse_all_but_open",
                        action_cb = function() require("nvim-tree.api").tree.collapse_all(true) end,
                     },
                  },
               },
            },
            renderer = { full_name = true, highlight_git = true },
            trash = { cmd = "rip" },
         }
      end,
      config = function(_, opts)
         require("nvim-tree").setup(opts)
         local api = require "nvim-tree.api"
         vim.keymap.set("n", "<leader>nt", api.tree.toggle)
         vim.keymap.set("n", "<leader>nc", function() api.tree.toggle { find_file = true, focus = false } end)
         vim.keymap.set("n", "<leader>nf", api.tree.focus, { desc = "Focus Tree" })
      end,
      keys = {
         { "<leader>nt", desc = "Tree" },
         { "<leader>nf", desc = "File in Tree" },
      },
   },
}
