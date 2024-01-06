---@type LazySpec
return {

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    ---@param opts TSConfig
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "sql" })
    end,
  },
}
