local flavor = "macchiato"

return {
   "catppuccin/nvim",
   name = "catppuccin",
   opts = function()
      local get_telescope_borderless = function(palette)
         local cp = require("catppuccin.palettes").get_palette(palette)

         return {
            TelescopeBorder = { fg = cp.surface0, bg = cp.surface0 },
            TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
            TelescopeMatching = { fg = cp.peach },
            TelescopeNormal = { bg = cp.surface0 },
            TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
            TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },

            TelescopeTitle = { fg = cp.crust, bg = cp.green },
            TelescopePreviewTitle = { fg = cp.crust, bg = cp.red },
            TelescopePromptTitle = { fg = cp.crust, bg = cp.mauve },

            TelescopePromptNormal = { fg = cp.flamingo, bg = cp.crust },
            TelescopePromptBorder = { fg = cp.crust, bg = cp.crust },
         }
      end

      return {
         flavour = flavor,
         integrations = {
            alpha = false,
            barbecue = { dim_dirname = false, bold_basename = false },
            dashboard = false,
            fidget = true,
            indent_blankline = { enabled = false },
            lsp_trouble = true,
            mason = true,
            neotest = true,
            notify = true,
            nvimtree = false,
            treesitter_context = true,
            which_key = true,
         },
         highlight_overrides = {
            [flavor] = get_telescope_borderless(flavor),
         },
      }
   end,
   config = true,
}
