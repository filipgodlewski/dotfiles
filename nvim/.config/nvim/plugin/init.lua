local ensure_packer = function()
   local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
   if vim.fn.empty(vim.fn.glob(install_path)) == 0 then return false end

   vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
   vim.api.nvim_command "packadd packer"
   return true
end

if ensure_packer() then require("packer").sync() end

vim.api.nvim_create_autocmd("BufWritePost", {
   pattern = { "plugin/init.lua" },
   command = "source <afile> | PackerSync",
   group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
})

return require("packer").startup {
   function(use)
      -- packages / installers
      use "wbthomason/packer.nvim"
      use {
         "williamboman/mason.nvim",
         requires = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "RubixDev/mason-update-all", config = function() require("mason-update-all").setup() end },
         },
      }
      use "jose-elias-alvarez/null-ls.nvim"

      use {
         "~/personal/zloto.nvim",
         config = function()
            require("zloto").setup()
            vim.cmd "colorscheme zloto"
         end,
      }

      -- startup improvers
      use "lewis6991/impatient.nvim"
      use "nathom/filetype.nvim"
      use "samjwill/nvim-unception"
      use { "j-hui/fidget.nvim", config = function() require("fidget").setup {} end }

      -- goodies
      use {
         "folke/todo-comments.nvim",
         requires = "nvim-lua/plenary.nvim",
         config = function() require("todo-comments").setup {} end,
      }
      use {
         "folke/zen-mode.nvim",
         config = function()
            require("zen-mode").setup {
               window = {
                  options = {
                     signcolumn = "no",
                     number = false,
                     relativenumber = false,
                  },
               },
            }
         end,
      }
      use "EdenEast/nightfox.nvim"
      use "akinsho/nvim-toggleterm.lua"
      use "rcarriga/nvim-notify"
      use "folke/which-key.nvim"
      use {
         "kazhala/close-buffers.nvim",
         config = function() require("close_buffers").setup { preserve_window_layout = { "this" } } end,
      }
      use "lewis6991/gitsigns.nvim"
      use {
         "nvim-treesitter/nvim-treesitter",
         requires = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-context",
            "JoosepAlviste/nvim-ts-context-commentstring",
         },
      }
      use { "natecraddock/workspaces.nvim", requires = "natecraddock/sessions.nvim" }
      use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }

      -- writing tools
      use { "phaazon/hop.nvim", requires = { "mfussenegger/nvim-treehopper" } }
      use { "mizlan/iswap.nvim", config = function() require("iswap").setup {} end }
      use {
         "mbbill/undotree",
         config = function() vim.keymap.set("n", "<leader>U", ":UndotreeToggle<cr>", { noremap = true, desc = "Undo" }) end,
      }
      use {
         "hrsh7th/nvim-cmp",
         requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "rcarriga/cmp-dap",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
         },
      }
      use { "L3MON4D3/LuaSnip", requires = { "filipgodlewski/luasnip-ts-snippets.nvim" } }
      use {
         "nvim-telescope/telescope.nvim",
         requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-dap.nvim",
            {
               "nvim-telescope/telescope-fzf-native.nvim",
               run = "make",
            },
            "nvim-telescope/telescope-file-browser.nvim",
         },
      }
      use "numToStr/Comment.nvim"
      use { "sindrets/diffview.nvim", cmd = "Diffview*" }

      -- debugging / testing / lsp
      use {
         "folke/trouble.nvim",
         requires = { "nvim-tree/nvim-web-devicons" },
         config = function() require("trouble").setup() end,
      }
      use {
         "nvim-neotest/neotest",
         requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
         },
      }
      use "neovim/nvim-lspconfig"
      use {
         "mfussenegger/nvim-dap",
         requires = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
         },
      }
      use { "simrat39/rust-tools.nvim", ft = "rust", config = function() require("rust-tools").setup() end }
   end,
   config = {
      display = {
         open_fn = function() return require("packer.util").float { border = "single" } end,
      },
   },
}
