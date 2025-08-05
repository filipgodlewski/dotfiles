---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    ---@module 'tokyonight'
    ---@type tokyonight.Config
    opts = {
      style = "night",
      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        local util = require("tokyonight.util")
        highlights.WinSeparator = { fg = colors.blue7 }
        highlights.Comment = { fg = util.lighten(colors.comment, 0.8), italic = true }
      end,
    },
  },

  { "catppuccin", enabled = false },
}
