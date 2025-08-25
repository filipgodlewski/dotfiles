---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    optional = true,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      scroll = { enabled = false },
      dashboard = { enabled = false },
    },
  },
}
