local ensure_packer = function()
   local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
   if vim.fn.empty(vim.fn.glob(install_path)) == 0 then return false end

   vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
   vim.api.nvim_command "packadd packer.nvim"
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
      use "wbthomason/packer.nvim"

      use "akinsho/nvim-toggleterm.lua"
      use "EdenEast/nightfox.nvim"
      use "folke/trouble.nvim"
      use "folke/which-key.nvim"
      use {
         "hrsh7th/nvim-cmp",
         requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
         },
      }
      use "kazhala/close-buffers.nvim"
      use { "L3MON4D3/LuaSnip", requires = { "filipgodlewski/luasnip-ts-snippets.nvim" } }
      use { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup { signcolumn = false } end }
      use "lewis6991/impatient.nvim"
      use "mfussenegger/nvim-dap"
      use "neovim/nvim-lspconfig"
      use {
         "nvim-telescope/telescope.nvim",
         requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "benfowler/telescope-luasnip.nvim",
         },
      }
      use {
         "nvim-treesitter/nvim-treesitter",
         run = function() require("nvim-treesitter.install").update { with_sync = true } end,
         requires = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/playground",
            "JoosepAlviste/nvim-ts-context-commentstring",
         },
      }
      use { "numToStr/Comment.nvim", config = function() require("Comment").setup {} end }
      use { "rmagatti/auto-session", config = function() require("auto-session").setup {} end }
      use {
         "simrat39/rust-tools.nvim",
         ft = "rust",
         config = function() require("rust-tools").setup() end,
      } -- TODO: replace with rus-analyzer
      use { "sindrets/diffview.nvim", cmd = "Diffview*" }
      use {
         "williamboman/mason.nvim",
         requires = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
         },
      }
      use "jose-elias-alvarez/null-ls.nvim"
   end,
   config = {
      display = {
         open_fn = function() return require("packer.util").float { border = "single" } end,
      },
   },
}
