local utils = require("evernight.utils")
local theme = require("evernight.theme").setup()
local config = require("evernight.config")

theme.base.DiffAdd = { bg = "#263831" }
theme.base.DiffDelete = { bg = "#382626" }
theme.base.DiffChange = { bg = "#383226" }
theme.base.DiffText = { bg = theme.colors.bg, style = config.commentStyle}
theme.base.diffAdd = { bg = "#263831" }
theme.base.diffDelete = { bg = "#382626" }
theme.base.diffChange = { bg = "#383226" }
theme.base.diffText = { bg = theme.colors.b, style = config.commentStyle }

local M = {}

function M.colorscheme()
   utils.load(theme)
end

M.colorscheme()

return M
