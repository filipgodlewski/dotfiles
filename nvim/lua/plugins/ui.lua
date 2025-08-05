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

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        component_separators = "",
      },
      sections = {
        lualine_b = {},
        lualine_c = {
          { "%=" },
          { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {},
        lualine_z = {},
      },
    },
  },
}
