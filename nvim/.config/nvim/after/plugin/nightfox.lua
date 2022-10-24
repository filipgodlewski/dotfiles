local nightfox = require("nightfox")
local C = require("nightfox.lib.color")
local spec = require("nightfox.spec").load("nightfox")
local pal = spec.palette

local groups = {
   all = {
      CmpItemAbbr = { fg = "palette.comment" },
      CmpItemAbbrDeprecated = { fg = "palette.red", style = "italic" },
      CmpItemAbbrMatch = { fg = "palette.yellow", style = "bold" },
      CmpItemAbbrMatchFuzzy = { fg = "palette.yellow", style = "bold" },
      VertSplit = { fg = "palette.bg4" },
      LuaSnipChoiceAvailable = { fg = "palette.red", style = "bold" },
      LuaSnipChoiceActive = { fg = "palette.green", style = "bold" },
   }
}

local options = {
   styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
   }
}


local specs = {
   all = {
      diff = {
         change = C(pal.bg1):blend(C(pal.yellow.dim), 0.15):to_css(),
      }
   }
}

nightfox.setup({
   groups = groups,
   options = options,
   specs = specs,
})

vim.cmd("colorscheme nightfox")
