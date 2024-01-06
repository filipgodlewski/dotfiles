---@type LazySpec
return {

  { "folke/tokyonight.nvim", enabled = false },

  {
    "catppuccin",
    lazy = false,
    priority = 1000,
    ---@type CatppuccinOptions
    opts = {
      flavour = "macchiato",
      integrations = {
        aerial = false,
        alpha = false,
        barbecue = { dim_dirname = false, bold_basename = false },
        flash = false,
        indent_blankline = { enabled = false },
        leap = false,
        navic = false,
        neogit = false,
        overseer = true,
        telescope = { style = "nvchad" },
        window_picker = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    ---@type LazyVimOptions
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
