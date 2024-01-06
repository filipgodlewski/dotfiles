---@type LazySpec
return {

  -- {
  --   "mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "commitlint" })
  --   end,
  -- },

  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       gitcommit = { "commitlint" },
  --     },
  --   },
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    ---@param opts TSConfig
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
      })
    end,
  },
}
