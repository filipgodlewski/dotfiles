local fb_actions = require "telescope".extensions.file_browser.actions

require("telescope").setup({
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
         "--trim"
      },
      color_devicons = false,
   },
   extensions = {
      ["ui-select"] = {
         require "telescope.themes".get_cursor {}
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
         dir_icon = "",
         mappings = {
            ["i"] = {
               ["<S-CR>"] = false,
               ["<C-CR>"] = fb_actions.create_from_prompt,
            },
         },
      },
   },
   pickers = {
      buffers = {
         theme = "dropdown",
         mappings = {
            i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
            n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
         },
      },
      spell_suggest = {
         theme = "cursor",
      }
   },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("luasnip")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
