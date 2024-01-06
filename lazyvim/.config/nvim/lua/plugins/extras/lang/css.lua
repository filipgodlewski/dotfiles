---@type LazySpec
return {

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        cssls = {},
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    ---@param opts TSConfig
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "http", "scss" })
    end,
  },
}
