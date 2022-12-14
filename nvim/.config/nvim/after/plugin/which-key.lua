local which_key = require "which-key"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local my_helpers = require "my.helpers"

which_key.setup {
   key_labels = {
      ["<space>"] = "␣",
      ["<cr>"] = "",
      ["<tab>"] = "",
      ["<M-Bslash>"] = [[<M-\>]],
      ["<leader>"] = "⌘",
   },
   layout = {
      height = { min = 1, max = 25 },
      width = { min = 5, max = 50 },
      align = "center",
   },
   icons = {
      separator = "ﰲ",
      group = " ",
   },
}

which_key.register({
   name = "Leader",
   F = { my_helpers.change_alacritty_font_size, "Font" },
   W = { telescope.extensions.workspaces.workspaces, "Work" },
   w = { function() require("hop").hint_words { multi_windows = true } end, "Hop" },
   c = { name = "Quickfix", s = { my_helpers.search, "Search" } },
   ["<space>"] = { function() builtin.find_files { hidden = true } end, "Files" },
   [","] = { builtin.buffers, "Buffers" },
   ["."] = { builtin.resume, "Last " },
   h = {
      name = "Help",
      h = { builtin.help_tags, "Vim" },
      m = { function() my_helpers.put_cmd "messages" end, "Messages" },
      n = { function() my_helpers.put_cmd "Notifications" end, "Notifications" },
   },
}, { prefix = "<leader>" })

which_key.register {
   ["<ESC>"] = { ":noh<CR>:silent LuaSnipUnlinkCurrent<CR>", "Escape" },
}
