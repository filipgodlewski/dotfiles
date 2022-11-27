local which_key = require "which-key"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local my_helpers = require "my.helpers"

which_key.setup {
   key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
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
   c = { name = "Quickfix", s = { my_helpers.search, "Search" } },

   t = "Terminal",
   z = { telescope.extensions.file_browser.file_browser, "Browse" },
   [","] = { builtin.buffers, "Buffers" },
   ["."] = { builtin.resume, "Last " },
   ["/"] = {
      name = "WTF",
      ["/"] = { builtin.help_tags, "Vim help tags" },
      m = { function() my_helpers.put_cmd "messages" end, "Messages" },
      n = { function() my_helpers.put_cmd "Notifications" end, "Notifications" },
   },
   ["<space>"] = { function() builtin.find_files { hidden = true } end, "Files" },
}, { prefix = "<leader>" })

which_key.register {
   ["<ESC>"] = { ":noh<CR>:silent LuaSnipUnlinkCurrent<CR>", "Escape" },
}
