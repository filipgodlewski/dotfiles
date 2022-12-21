local hop = require "hop"
local hint = require "hop.hint"

local AFTER = hint.HintDirection.AFTER_CURSOR
local BEFORE = hint.HintDirection.BEFORE_CURSOR
local END = hint.HintPosition.END

local keys = "hateludosiwync"

hop.setup { keys = keys }

local set = function(key, fn) vim.keymap.set({ "n", "x", "o" }, key, fn, { remap = true }) end

set("f", function() hop.hint_char1 { direction = AFTER, current_line_only = true } end)
set("F", function() hop.hint_char1 { direction = BEFORE, current_line_only = true } end)
set("T", function() hop.hint_char1 { direction = BEFORE, current_line_only = true, hint_offset = 1 } end)
set("t", function() hop.hint_char1 { direction = AFTER, current_line_only = true, hint_offset = -1 } end)
set("E", function() hop.hint_words { direction = AFTER, hint_position = END } end)
set("gE", function() hop.hint_words { direction = BEFORE, hint_position = END } end)
set("W", hop.hint_words)

local treehopper = require "tsht"
treehopper.config.hint_keys = vim.split(keys, "")
vim.keymap.set({ "x", "o" }, "m", ":<C-U>lua require'tsht'.nodes()<CR>", { remap = true, desc = "Act on TS node" })
vim.keymap.set("n", "<leader>w", function() hop.hint_words { multi_windows = true } end, { remap = true, desc = "Hop" })
