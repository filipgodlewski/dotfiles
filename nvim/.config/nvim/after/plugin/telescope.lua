require("telescope").setup({
   extensions = {
      fzf = {
         override_generic_sorter = true,
         override_file_sorter = true,
         case_mode = "smart_case",
      },
      ["ui-select"] = {
         require("telescope.themes").get_dropdown()
      }
   },
   pickers = {
      buffers = {
         theme = "dropdown",
         previewer = false,
         mappings = {
            i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
            n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
         },
      },
   },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("luasnip")
