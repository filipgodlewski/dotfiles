local fb_actions = require("telescope").extensions.file_browser.actions
local my_helpers = require "my.helpers"

require("telescope").setup {
   defaults = {
      prompt_prefix = "   ",
      selection_caret = "    ",
      multi_icon = " ",
      entry_prefix = "     ",
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
         "--trim",
      },
      file_ignore_patterns = {
         "dist",
         "target",
         "node_modules",
         "pack/plugins",
      },
      mappings = {
         i = { ["<C-Q>"] = { my_helpers.setup_search, type = "action" } },
      },
   },
   extensions = {
      ["ui-select"] = {
         require("telescope.themes").get_cursor {},
      },
      fzf = {
         override_generic_sorter = true,
         override_file_sorter = true,
         case_mode = "smart_case",
      },
      file_browser = {
         theme = "ivy",
         grouped = true,
         hidden = true,
      },
      ["session-lens"] = {
         winblend = 0,
         prompt_title = "Switch Nvim Session",
         mappings = {
            i = { ["<C-d>"] = fb_actions.remove },
            n = { ["<C-d>"] = fb_actions.remove },
         },
      },
   },
   pickers = {
      buffers = {
         theme = "dropdown",
         mappings = {
            i = { ["<C-d>"] = "delete_buffer" },
            n = { ["<C-d>"] = "delete_buffer" },
         },
      },
      spell_suggest = { theme = "cursor" },
   },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "luasnip"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "ui-select"
require("telescope").load_extension "dap"
