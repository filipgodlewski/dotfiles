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
         },
      }
      use "jose-elias-alvarez/null-ls.nvim"

      -- goodies
      use "EdenEast/nightfox.nvim"
      use "akinsho/nvim-toggleterm.lua"
      use {
         "rcarriga/nvim-notify",
         config = function()
            local notify = require "notify"
            vim.notify = notify
            notify.setup {
               fps = 60,
               render = "minimal",
               timeout = 1000,
               top_down = false,
            }
         end,
      }
      use "folke/which-key.nvim"
      use "kazhala/close-buffers.nvim"
      use { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup { signcolumn = false } end }
      use "lewis6991/impatient.nvim"
      use {
         "nvim-treesitter/nvim-treesitter",
         run = function() require("nvim-treesitter.install").update { with_sync = true } end,
         requires = {
            "nvim-treesitter/playground",
            "JoosepAlviste/nvim-ts-context-commentstring",
         },
      }
      use { "nvim-tree/nvim-web-devicons", config = function() require("nvim-web-devicons").setup {} end }
      use {
         "rmagatti/auto-session",
         config = function()
            require("auto-session").setup {
               auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
            }
         end,
         requires = {
            {
               "rmagatti/session-lens",
               config = function() require("session-lens").setup { prompt_title = "Jump to nvim session" } end,
            },
         },
      }
      use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }

      -- writing tools
      use {
         "hrsh7th/nvim-cmp",
         requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "rcarriga/cmp-dap",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
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
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "benfowler/telescope-luasnip.nvim",
         },
      }
      use { "numToStr/Comment.nvim", config = function() require("Comment").setup {} end }
      use { "sindrets/diffview.nvim", cmd = "Diffview*" }

      -- debugging / testing / lsp
      use { "folke/trouble.nvim", config = function() require("trouble").setup() end }
      use {
         "nvim-neotest/neotest",
         requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-python",
         },
         config = function()
            require("neotest").setup {
               adapters = { require "neotest-python" },
               diagnostic = { enabled = false },
               output = { open_on_run = false },
               status = { virtual_text = false },
            }
         end,
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
