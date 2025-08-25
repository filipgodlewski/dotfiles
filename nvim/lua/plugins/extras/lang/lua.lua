---@module 'lazy'
---@type LazySpec
return {

  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "selene" } },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = { lua = { "selene" } } },
  },
}
