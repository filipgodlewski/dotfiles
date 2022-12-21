local nightfox = require "nightfox"
local C = require "nightfox.lib.color"
local spec = require("nightfox.spec").load "nightfox"
local pal = spec.palette

local function dim(color, percentage)
   percentage = percentage or 0.15
   return C(pal.bg1):blend(C(pal[color].dim), percentage):to_css()
end

local groups = {
   all = {
      CmpItemAbbr = { fg = "palette.comment" },
      CmpItemAbbrDeprecated = { fg = "palette.red", style = "italic" },
      CmpItemAbbrMatch = { fg = "palette.yellow", style = "bold" },
      CmpItemAbbrMatchFuzzy = { fg = "palette.yellow", style = "bold" },
      VertSplit = { fg = "palette.bg4" },
      LuaSnipChoiceAvailable = { fg = "palette.red", style = "bold" },
      LuaSnipChoiceActive = { fg = "palette.green", style = "bold" },
      NvimTreeNormal = { fg = "palette.white", bg = "palette.bg1" },
      TelescopePromptTitle = { fg = "palette.yellow" },
      TelescopeResultsTitle = { fg = "palette.yellow" },
      TelescopePreviewTitle = { fg = "palette.yellow" },
      TelescopePromptCounter = { fg = "palette.yellow" },
      TelescopePromptPrefix = { fg = "palette.yellow" },
      TelescopeSelectionCaret = { fg = "palette.yellow", bg = "palette.bg3" },
      TelescopeMultiSelection = { fg = "palette.green", style = "bold" },
      TelescopeMultiIcon = { fg = "palette.green", style = "bold" },
      IndentBlanklineChar = { fg = "palette.bg2", style = "nocombine" },
      IndentBlanklineContextChar = { fg = "palette.yellow.dim", style = "nocombine" },
      IndentBlanklineContextStart = { sp = "palette.yellow.dim", style = "underline" },
      IndentBlanklineSpaceChar = { fg = "palette.bg2", style = "nocombine" },
      IndentBlanklineSpaceCharBlankline = { fg = "palette.bg2", style = "nocombine" },
   },
}

local options = {
   styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
   },
}

local specs = {
   all = {
      diff = { change = dim "yellow" },
   },
}

local palettes = {
   nightfox = {
      bg1 = "#0f1117",
   },
}

nightfox.setup {
   groups = groups,
   options = options,
   specs = specs,
   palettes = palettes,
}

vim.cmd "colorscheme nightfox"
